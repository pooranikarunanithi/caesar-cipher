pipeline {
    agent any

    stages {
        stage('Preparing gradlew for ubuntu') {
            steps {
                sh 'chmod +x gradlew'
            }
        }
        stage('test') {
            steps {
                sh './gradlew test'
            }
        }
        stage('build') {
            steps {
                sh './gradlew build'
            }
        }
        stage('Release') {
            steps {
                withCredentials([string(credentialsId: 'mygittoken', variable: 'GITHUB_TOKEN')])
                {
        
                script {
                    TAG = sh (
                    script: 'git describe --tags | awk -F - \'{print $1}\'',
                    returnStdout: true).trim()
                    echo "Tag value: ${TAG}"
                
                    RELEASE = sh (script: """
                    curl -X POST \
                        -H "Authorization: token ${GITHUB_TOKEN}" \
                        -d '{"tag_name": "${TAG}","target_commitish": "main","name": "Release Initial","body": "First release","draft": false,"prerelease": false}' "https://api.github.com/repos/pooranikarunanithi/caesar-cipher/releases"|jq -r .id
                        """,
                    returnStdout: true).trim()
                    echo "Release value: ${RELEASE}"
                    sh (script: """
                    curl -s -X POST \
                            -H "Authorization: token ${GITHUB_TOKEN}" \
                            --header "Content-Type: application/octet-stream" \
                            --data-binary @"build/libs/caesar-cipher.jar" https://uploads.github.com/repos/pooranikarunanithi/caesar-cipher/releases/${RELEASE}/assets?name=caesar-cipher.jar
                        """,
                    returnStdout: false)   

                    
                }
                //sh 'token="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"'
                //sh 'tag=$(git describe --tags)'
                //sh 'message="$(git for-each-ref refs/tags/$tag --format=\'%(contents)\')"'
                //sh 'name=$(echo "$message" | head -n1)'
                //sh 'description=$(echo "$message" | tail -n +3)'
                //sh 'release=$(curl -XPOST -H "Authorization:token $token" --data \'{"tag_name": "$tag", "target_commitish": "main", "name": "$name", "body": "$description", "draft": false, "prerelease": false}\' "https://api.github.com/repos/YoussF/caesar-cipher/releases)"'
            //}
        }
            }
        }
    }
         post {
        always {
            archiveArtifacts artifacts: 'build/libs/caesar-cipher.jar', onlyIfSuccessful: true
        }
    }
        
   }
        
    
           
    