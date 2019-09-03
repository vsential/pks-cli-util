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
				dockerImage.inside(-u root) {
						sh 'which aws && aws --version'
					}
				}
			}, 'azure': {
				stage('azure') {
					dockerImage.inside(-u root) {
						sh 'which az && az --version'
					}
				}
			}, 'bosh': {
				stage('bosh') {
					dockerImage.inside(-u root) {
						sh 'which bosh && bosh --version'
					}
				}
			}, 'gcloud': {
				stage('gcloud') {
					dockerImage.inside(-u root) {
						sh 'which gcloud && gcloud version'
					}
				}
			}, 'helm': {
				stage('helm') {
					dockerImage.inside(-u root) {
						sh 'which helm && helm version --client'
					}
				}
			}, 'kubectl': {
				stage('kubectl') {
					dockerImage.inside(-u root) {
						sh 'which kubectl && kubectl version --short --client'
					}
				}
			}, 'om': {
				stage('om') {
					dockerImage.inside(-u root) {
						sh 'which om && om --version'
					}
				}
			}, 'pks': {
				stage('pks') {
					dockerImage.inside(-u root) {
						sh 'which pks && pks --version'
					}
				}
			}, 'uaac': {
				stage('uaac') {
					dockerImage.inside(-u root) {
						sh 'which uaac && uaac --version'
					}
				}
			}, 'vke': {
				stage('vke') {
					dockerImage.inside(-u root) {
						sh 'which vke && vke --version'
					}
				}
			}
		}

//		stage('Test') {
			/* Ideally, we would inside(-u root) a test framework against our image.
			   For this example, we're using a Volkswagen-type approach ;-) */
/*			dockerImage.inside(-u root) {
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