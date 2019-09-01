node('docker-build') {
    def dockerImage
	withEnv(['registry=dev/pks-cli-util',
			 'registryUrl=https://harbor.jb.cloud.lab',
			 'harborCredentials=2a0345af-3cba-4af6-90b2-017019f2ffe9',
			 'tag=1.0.${BUILD_NUMBER}']) {
		stage('Preparation') {
			/* Let's make sure we have the repository cloned to our workspace */
			git 'https://github.com/vsential/pks-cli-util.git'
		}

		stage('Build') {
			/* This builds the actual image; synonymous to
			 * docker build on the command line */
			dockerImage = docker.build("${env.registry}:${env.tag}")
		}

		stage('Test') {
			/* Ideally, we would run a test framework against our image.
			 * For this example, we're using a Volkswagen-type approach ;-) */
			dockerImage.inside {
				sh 'pks --version && which pks'
			}
		}

		stage('Push') {
			/* Finally, we'll push the image with two tags:
			 * First, the incremental build number from Jenkins
			 * Second, the 'latest' tag.
			 * Pushing multiple tags is cheap, as all the layers are reused. */
			docker.withRegistry("${env.registryUrl}", "${env.harborCredentials}") {
				dockerImage.push("${tag}")
				dockerImage.push("latest")
			}
		}
	}
}
