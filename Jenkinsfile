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

		stage('Test') {
			parallel 'aws': {
				stage('aws') {
				dockerImage.inside() {
						sh 'which aws && aws --version'
					}
				}
			}, 'azure': {
				stage('azure') {
					dockerImage.inside('-u root') {
						sh 'cd /root'
						sh 'which az && az --version'
					}
				}
			}, 'gcloud': {
				stage('gcloud') {
					dockerImage.inside() {
						sh 'which gcloud && gcloud version'
					}
				}
			}, 'helm': {
				stage('helm') {
					dockerImage.inside() {
						sh 'which helm && helm version --client'
					}
				}
			}, 'kubectl': {
				stage('kubectl') {
					dockerImage.inside() {
						sh 'which kubectl && kubectl version --short --client'
					}
				}
			}, 'pks': {
				stage('pks') {
					dockerImage.inside('-u root') {
						sh 'cd /root'
						sh 'which bosh && bosh --version'
						sh 'which om && om --version'
						sh 'which pks && pks --version'
						sh 'which uaac && uaac --version'
					}
				}
			}, 'vke': {
				stage('vke') {
					dockerImage.inside() {
						sh 'which vke && vke --version'
					}
				}
			}
		}

		stage('Push') {
			/* Finally, we'll push the image with two tags:
			 * First, the incremental build number from Jenkins
			 * Second, the 'latest' tag.
			 * Pushing multiple tags is cheap, as all the layers are reused. */
			docker.withRegistry("${env.registryUrl}", "${env.harborCredentials}") {
				if (env.BRANCH_NAME == 'master') {
					dockerImage.push("${tag}")
					dockerImage.push("stable")
				} else if (env.BRANCH_NAME == 'dev') {
					dockerImage.push("${tag}-dev")
					dockerImage.push("latest")
				} else {
					println("*****Successful test build!*****")
				}
			}
		}
	}
}