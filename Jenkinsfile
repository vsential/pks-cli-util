def runParallel = true
def testStages

node('docker-build') {
    def dockerImage
	withEnv(['registry=dev/pks-cli-util',
			 'registryUrl=https://harbor.jb.cloud.lab',
			 'harborCredentials=2a0345af-3cba-4af6-90b2-017019f2ffe9',
			 'tag=1.0.${BUILD_NUMBER}']) {
		stage('Preparation') {
			/* Let's make sure we have the repository cloned to our workspace */
			git branch: "${env.BRANCH_NAME}", url: 'https://github.com/vsential/pks-cli-util.git'
		}

		stage('Build') {
			/* This builds the actual image; synonymous to
			 * docker build on the command line */
			dockerImage = docker.build("${env.registry}:${env.tag}")
		}

		for (tests in testStages){
			if (runParallel) {
				parallel(tests)
			} else {
				for (test in tests.values()) {
					test.call()
				}
			}
		}

//		stage('Test') {
			/* Ideally, we would run a test framework against our image.
			   For this example, we're using a Volkswagen-type approach ;-) */
/*			dockerImage.inside {
					sh 'which aws && aws --version'
					sh 'which az && az --version'
					sh 'which bosh && bosh --version'
					sh 'which gcloud && gcloud version'
					sh 'which helm && helm --version'
					sh 'which kubectl && kubectl version --short --client'
					sh 'which om && om --version'
					sh 'which pks && pks --version'
					sh 'which uaac && uaac --version'
					sh 'which vke && vke --version'
			}
		} */

		stage('Push') {
			/* Finally, we'll push the image with two tags:
			 * First, the incremental build number from Jenkins
			 * Second, the 'latest' tag.
			 * Pushing multiple tags is cheap, as all the layers are reused. */
			docker.withRegistry("${env.registryUrl}", "${env.harborCredentials}") {
				if (env.BRANCH_NAME == 'master') {
					dockerImage.push("${tag}")
					dockerImage.push("stable")
				} else {
					dockerImage.push("${tag}-test")
					dockerImage.push("latest")
				}
			}
		}
	}
}

// Create list of test stages to suit
def prepareTestStages() {
	def testList = []

	for (i=1; i<10; i++) {
		def testStages = [:]
		for (name in ['aws','az','bosh','helm','om','pks','uaac','vke']) {
			def n = "Test ${name}"
			testStages.put(n, prepareOneTestStage(n))
		}
		for (name in ['gcloud','kubectl']) {
			def n = "Test ${name}"
			testStages.put(n, prepareOtherTestStage(n))
		}
		testList.add(testStages)
	}
	return testList
}

def prepareOneTestStage(String name) {
	return {
		stage("Test stage:${name}") {
			println("Building ${name}")
			sh(script: "${name} --version", returnStatus:true)
			}
	}
}

def prepareOtherTestStage(String name) {
	return {
		stage("Test stage:${name}") {
			println("Building ${name}")
			sh(script: "${name} --version", returnStatus:true)
			}
	}
}