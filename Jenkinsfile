pipeline {
    agent any
    

    stages {
        stage('Preparing gradlew') {
            steps {
                bat 'gradlew.bat'
            }
        }
       stage('test') {
            steps {
                bat './gradlew test'
            }
        }
      /*  stage('build') {
            steps {
                sh './gradlew build'
            }
        }
        stage('Release') {
            steps {
                sh 'token="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"'
                sh 'tag=$(git describe --tags)'
                sh 'message="$(git for-each-ref refs/tags/$tag --format=\'%(contents)\')"'
                sh 'name=$(echo "$message" | head -n1)'
                sh 'description=$(echo "$message" | tail -n +3)'
                sh 'release=$(curl -XPOST -H "Authorization:token $token" --data \'{"tag_name": "$tag", "target_commitish": "main", "name": "$name", "body": "$description", "draft": false, "prerelease": false}\' "https://api.github.com/repos/YoussF/caesar-cipher/releases)"'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
        */
    }
}