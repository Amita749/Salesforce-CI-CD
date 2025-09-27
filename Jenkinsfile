pipeline {
    agent any

    environment {
        JWT_KEY   = credentials('sf_jwt_key')
        SFDC_HOST = 'https://test.salesforce.com'
        GIT_URL   = 'https://github.com/Amita749/Jenkins_Pipeline.git'
    }

    parameters {
        choice(name: 'ACTION', choices: ['DEPLOY','ROLLBACK','BACKSYNC'], description: 'Choose action')
        choice(name: 'BRANCH_NAME', choices: ['main','QA','feature/dev'], description: 'Git branch to use')
        choice(name: 'TARGET_ORG', choices: ['Jenkins1','Jenkins2'], description: 'Target Salesforce Org')
        string(name: 'METADATA', defaultValue: '', description: 'Metadata to deploy (e.g. ApexClass:AdderHelper)')
        string(name: 'ROLLBACK_COMMIT', defaultValue: '', description: 'Commit ID for rollback (only for ROLLBACK)')
        string(name: 'TEST_CLASSES', defaultValue: '', description: 'Comma-separated test classes (optional)')
    }

    stages {

        stage('Checkout Git') {
            when { expression { params.ACTION != 'BACKSYNC' } }
            steps { git branch: "${params.BRANCH_NAME}", url: "${GIT_URL}" }
        }

        stage('Auth Salesforce Org') {
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
            when { expression { params.ACTION == 'DEPLOY' } }
            steps {
                script {
                    if (!params.METADATA?.trim()) {
                        error("❌ METADATA parameter is required for deployment.")
                    }
                    bat "sf project generate manifest --metadata \"${params.METADATA}\" --output-dir manifest"
                }
            }
        }

        stage('Deploy / Rollback / Backsync') {
            steps {
                script {

                    /*****************
                     * DEPLOYMENT
                     *****************/
                    if (params.ACTION == 'DEPLOY') {
                        def testParam = params.TEST_CLASSES?.trim()
                        def existingTests = []

                        if (testParam) {
                            // Correctly format test classes for SOQL query
                            def formattedTests = testParam.split(',').collect { "'${it.trim()}'" }.join(',')
                            def queryCmd = "sf data query -q \"SELECT Name FROM ApexClass WHERE Name IN (${formattedTests})\" --target-org ${params.TARGET_ORG} --json"
                            def queryResult = bat(returnStdout: true, script: queryCmd).trim()
                            def json = readJSON text: queryResult
                            if (json.result && json.result.records) {
                                existingTests = json.result.records.collect { it.Name }
                            }
                        }

                        def testLevel = "NoTestRun"
                        def testFlag = ""
                        if (existingTests && !existingTests.isEmpty()) {
                            testLevel = "RunSpecifiedTests"
                            testFlag = "--tests ${existingTests.join(',')}"
                        }

                        echo "🔍 Validating with test level: ${testLevel}, tests: ${existingTests}"

                        def validate = bat(returnStatus: true, script: "sf project deploy validate --manifest manifest\\package.xml --target-org ${params.TARGET_ORG} --test-level ${testLevel} ${testFlag}")
                        if (validate != 0) {
                            error("❌ Validation failed. Deployment skipped.")
                        }

                        echo "✅ Validation passed, deploying..."
                        def deploy = bat(returnStatus: true, script: "sf project deploy start --manifest manifest\\package.xml --target-org ${params.TARGET_ORG} --test-level ${testLevel} ${testFlag}")
                        if (deploy != 0) {
                            error("❌ Deployment failed. Org unchanged.")
                        } else {
                            echo "🎉 Deployment successful!"
                        }
                    }

                    /*****************
                     * ROLLBACK
                     *****************/
                    else if (params.ACTION == 'ROLLBACK') {
                        if (!params.ROLLBACK_COMMIT?.trim()) {
                            error("❌ You must provide a ROLLBACK_COMMIT ID.")
                        }
                        echo "🔄 Rolling back to commit ${params.ROLLBACK_COMMIT}"
                        bat "git checkout ${params.ROLLBACK_COMMIT}"
                        bat "git checkout -b rollback-${params.ROLLBACK_COMMIT}"
                        bat "sf project deploy start --manifest manifest\\package.xml --target-org ${params.TARGET_ORG} --test-level NoTestRun"
                        echo "✅ Rollback deployment complete."
                    }

                    /*****************
                     * BACKSYNC
                     *****************/
                    else if (params.ACTION == 'BACKSYNC') {
                        echo "🔄 Retrieving metadata from ${params.TARGET_ORG} and syncing to Git..."
                        bat "sf project retrieve start --manifest manifest\\package.xml --target-org ${params.TARGET_ORG}"
                        bat "git add ."
                        bat "git commit -m \"Backsync from ${params.TARGET_ORG}\" || echo \"No changes to commit\""
                        bat "git push origin ${params.BRANCH_NAME}"
                        echo "✅ Backsync complete."
                    }
                }
            }
        }
    }

    post {
        always {
            echo "🔹 Build Status: ${currentBuild.currentResult}"
        }
    }
}
