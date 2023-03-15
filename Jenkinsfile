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
                //sh 'token="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"'
                sh 'tag=$(git describe --tags--always)'
                sh 'message="$(git for-each-ref refs/tags/$tag --format=\'%(contents)\')"'
                sh 'name=$(echo "$message" | head -n1)'
                sh 'description=$(echo "$message" | tail -n +3)'
                sh 'release=$(curl -XPOST -H "Authorization:token $token" --data \'{"tag_name": "$tag", "target_commitish": "main", "name": "$name", "body": "$description", "draft": false, "prerelease": false}\' "https://api.github.com/repos/pooranikarunanithi/caesar-cipher/releases)"'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
    }
}