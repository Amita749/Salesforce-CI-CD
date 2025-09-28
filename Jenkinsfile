pipeline {
    agent any

    environment {
        JWT_KEY   = credentials('sf_jwt_key')
        SFDC_HOST = 'https://test.salesforce.com'
        GIT_URL   = 'https://github.com/Amita749/Salesforce-CI-CD.git'
    }

    parameters {
        choice(name: 'ACTION', choices: ['DEPLOY','ROLLBACK'], description: 'Choose Deploy or Rollback')
        choice(name: 'BRANCH_NAME', choices: ['feature/dev','QA','main'], description: 'Git branch to deploy from')
        choice(name: 'TARGET_ORG', choices: ['Jenkins1', 'Jenkins2'], description: 'Select target Salesforce Org')
        string(name: 'METADATA', defaultValue: '', description: 'Metadata to deploy (comma separated, e.g., ApexClass:Demo)')
        string(name: 'ROLLBACK_COMMIT', defaultValue: '', description: 'Commit ID to rollback to (required for rollback)')
        string(name: 'TEST_CLASSES', defaultValue: '', description: 'Comma-separated Apex test classes to run (optional)')
    }

    stages {

        stage('Prepare Code') {
            steps {
                script {
                    if (params.ACTION == 'ROLLBACK') {
                        if (!params.ROLLBACK_COMMIT?.trim()) {
                            error("ROLLBACK_COMMIT is required for rollback!")
                        }
                        echo "🔄 Rolling back to commit: ${params.ROLLBACK_COMMIT}"
                        bat "git fetch origin"
                        bat "git checkout ${params.ROLLBACK_COMMIT}"
                    } else {
                        git branch: "${params.BRANCH_NAME}", url: "${GIT_URL}"
                    }
                }
            }
        }

        stage('Auth Org') {
            steps {
                script {
                    def credsMap = [
                        Jenkins1: [consumerCredId: 'JENKINS1_CONSUMER_KEY', user: 'naman.rawat@dynpro.com.jenkins1'],
                        Jenkins2: [consumerCredId: 'JENKINS2_CONSUMER_KEY', user: 'naman.rawat@dynpro.com.jenkins2']
                    ]
                    def creds = credsMap[params.TARGET_ORG]
                    withCredentials([string(credentialsId: creds.consumerCredId, variable: 'CONSUMER_KEY')]) {
                        bat "sf auth jwt grant --client-id %CONSUMER_KEY% --jwt-key-file \"%JWT_KEY%\" --username ${creds.user} --instance-url ${SFDC_HOST} --alias ${params.TARGET_ORG}"
                    }
                }
            }
        }

        stage('Prepare Manifest') {
            steps {
                script {
                    def metadataList = "ApexClass:${params.METADATA}"
                    if (params.TEST_CLASSES?.trim()) {
                        def testClasses = params.TEST_CLASSES.split(',')
                            .collect { it.trim() }
                            .findAll { it }
                            .collect { "ApexClass:${it}" }
                            .join(',')
                        if (testClasses) metadataList += ",${testClasses}"
                    }
                    bat "sf project generate manifest --metadata \"${metadataList}\" --output-dir manifest"
                }
            }
        }

        stage('Validate and Deploy') {
            steps {
                script {
                    def testParam = params.TEST_CLASSES?.trim()
                    def testLevel = ""

                    if (testParam) {
                        testLevel = "--test-level RunSpecifiedTests --tests ${testParam}"
                    } else {
                        // if no test classes provided
                        if (params.TARGET_ORG == "Jenkins1" || params.TARGET_ORG == "Jenkins2") {
                            testLevel = "--test-level NoTestRun"  // sandbox only
                        } else {
                            testLevel = "--test-level RunLocalTests" // prod safety
                        }
                    }

                    def validate = bat(returnStatus: true, script: "sf project deploy validate --manifest manifest\\package.xml --target-org ${params.TARGET_ORG} ${testLevel}")
                    
                    if (validate != 0) {
                        echo "❌ Validation failed. No changes were deployed."
                        currentBuild.description = "Validation failed"
                        error("Stopping pipeline because validation failed")
                    } else {
                        echo "✅ Validation passed, deploying..."
                        bat "sf project deploy start --manifest manifest\\package.xml --target-org ${params.TARGET_ORG} ${testLevel}"
                        currentBuild.description = (params.ACTION == 'ROLLBACK') ? "Rollback deployed" : "Deployment successful"
                    }
                }
            }
        }
    }

    post {
        always {
            echo "🔹 Build Status: ${currentBuild.currentResult}"
            echo "🔹 Action Description: ${currentBuild.description}"
        }
    }
}
