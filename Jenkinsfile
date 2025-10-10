pipeline {
    agent any

    environment {
        JWT_KEY   = credentials('sf_jwt_key')
        SFDC_HOST = 'https://test.salesforce.com'
        GIT_URL   = 'https://github.com/Amita749/Salesforce-CI-CD.git'
    }

    parameters {
        choice(name: 'ACTION', choices: ['DEPLOY','ROLLBACK'], description: 'Choose Deploy or Rollback')
        choice(name: 'BRANCH_NAME', choices: ['feature/dev','feature/new','QA','main'], description: 'Git branch to deploy from')
        choice(name: 'TARGET_ORG', choices: ['Jenkins1', 'Jenkins2'], description: 'Select target Salesforce Org')
        string(name: 'METADATA', defaultValue: '', description: 'Metadata to deploy (comma separated, e.g., ApexClass:Demo,CustomSite:Dummy_Portal)')
        string(name: 'ROLLBACK_COMMIT', defaultValue: '', description: 'Commit ID to rollback to (required for rollback)')
        string(name: 'TEST_CLASSES', defaultValue: '', description: 'Comma-separated Apex test classes to run (optional)')
    }

    stages {
        stage('Clean Workspace') {
            steps { deleteDir() }
        }

        stage('Check CLI') {
            steps {
                echo "🔹 Salesforce CLI version..."
                bat 'sf --version'
            }
        }

        stage('Checkout') {
            steps { git branch: "${params.BRANCH_NAME}", url: "${GIT_URL}" }
        }

        stage('Auth Org') {
            steps {
                script {
                    def credsMap = [
                        Jenkins1: [consumerCredId: 'JENKINS1_CONSUMER_KEY', user: 'naman.rawat@dynpro.com.jenkins1'],
                        Jenkins2: [consumerCredId: 'JENKINS2_CONSUMER_KEY', user: 'naman.rawat@dynpro.com.jenkins2'],
                        PreSales: [consumerCredId: 'PRESALES_CONSUMER_KEY', user: 'naman.rawat@dynpro.com.presales']
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
                    // Use METADATA as-is to preserve type (ApexClass, CustomSite, etc.)
                    def metadataList = params.METADATA?.trim()
                    if (!metadataList) {
                        error("No metadata specified for deployment.")
                    }

                    // Append test classes if provided
                    if (params.TEST_CLASSES?.trim()) {
                        def testClasses = params.TEST_CLASSES.split(',')
                            .collect { it.trim() }
                            .findAll { it }
                            .collect { "ApexClass:${it}" }
                            .join(',')

                        if (testClasses) {
                            metadataList += ",${testClasses}"
                        }
                    }

                    echo "🔹 Metadata to deploy: ${metadataList}"
                    bat "sf project generate manifest --metadata \"${metadataList}\" --output-dir manifest"
                }
            }
        }

        stage('Validate and Deploy') {
            steps {
                script {
                    def manifestPath = "${WORKSPACE}\\manifest\\package.xml"
                    def testParam = params.TEST_CLASSES?.trim()
                    def testLevel = testParam ? "--test-level RunSpecifiedTests --tests ${testParam}" : "--test-level RunLocalTests"

                    // Ensure test-results folder exists
                    bat 'mkdir test-results || exit 0'

                    echo "🔹 Validating deployment..."
                    def validateStatus = bat(returnStatus: true, script: """
                        sf project deploy validate --manifest "${manifestPath}" --target-org ${TARGET_ORG} ${testLevel} > test-results\\validate-output.txt
                    """)

                    archiveArtifacts artifacts: 'test-results/validate-output.txt', allowEmptyArchive: false

                    if (validateStatus != 0) {
                        echo "Validation failed."
                        currentBuild.description = "Validation failed"
                        error("Stopping pipeline because validation failed")
                    } else {
                        echo "Validation passed, deploying..."
                        def deployStatus = bat(returnStatus: true, script: """
                            sf project deploy start --manifest "${manifestPath}" --target-org ${TARGET_ORG} ${testLevel} --ignore-conflicts  > test-results\\deploy-output.txt
                        """)

                        archiveArtifacts artifacts: 'test-results/deploy-output.txt', allowEmptyArchive: false

                        if (deployStatus != 0) {
                            echo " Deployment failed."
                            currentBuild.description = "Deployment failed"
                            error("Deployment failed")
                        } else {
                            echo "Deployment successful"
                            currentBuild.description = "Deployment successful"
                        }
                    }
                }
            }
        }

        stage('Archive Test Results') {
            steps {
                echo "🔹 Archiving test results..."
                archiveArtifacts artifacts: 'test-results/**', allowEmptyArchive: true
            }
        }
    }

    post {
        always {
            echo "🔹 Build Status: ${currentBuild.currentResult}"
            echo "🔹 Action Description: ${currentBuild.description}"

            emailext(
                subject: "Jenkins Build ${currentBuild.fullDisplayName}: ${currentBuild.currentResult}",
                body: """
                <html>
                <body>
                    <h3>Jenkins Build Notification</h3>
                    <table border="1" cellpadding="5" cellspacing="0" style="border-collapse: collapse;">
                        <tr><th align="left">Job Name</th><td>${env.JOB_NAME}</td></tr>
                        <tr><th align="left">Build Number</th><td>${env.BUILD_NUMBER}</td></tr>
                        <tr><th align="left">Status</th><td><b>${currentBuild.currentResult}</b></td></tr>
                        <tr><th align="left">Action Description</th><td>${currentBuild.description}</td></tr>
                        <tr><th align="left">Build URL</th><td><a href="${env.BUILD_URL}">${env.BUILD_URL}</a></td></tr>
                    </table>
                    <p>Regards,<br/>Jenkins CI/CD</p>
                </body>
                </html>
                """,
                mimeType: 'text/html',
                to: "amita.chaudhary@dynpro.com",
                attachmentsPattern: 'test-results/*.txt'
            )
        }
    }
}
