pipeline {
    agent any

    stages {
    stage('Preparing gradlew') {
        steps {
            bat 'icacls gradlew /grant:r "%username%":(F)'
        }
    }
}

        stage('test') {
            steps {
                bat './gradlew test'
            }
        }
        stage('build') {
            steps {
                bat'./gradlew build'
            }
        }
        stage('Release') {
            steps {
                bat 'token="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"'
                bat 'tag=$(git describe --tags)'
                bat 'message="$(git for-each-ref refs/tags/$tag --format=\'%(contents)\')"'
                bat 'name=$(echo "$message" | head -n1)'
                bat 'description=$(echo "$message" | tail -n +3)'
                bat'release=$(curl -XPOST -H "Authorization:token $token" --data \'{"tag_name": "$tag", "target_commitish": "main", "name": "$name", "body": "$description", "draft": false, "prerelease": false}\' "https://api.github.com/repos/YoussF/caesar-cipher/releases)"'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}