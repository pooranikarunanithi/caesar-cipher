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
        stage('build') {
            steps {
                bat './gradlew build'
            }
        }
        stage('Release') {
            steps {

                /*sh 'token="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"'*/
                withCredentials([string(credentialsId: 'mytoken', variable: 'token')])

                /*sh 'tag=$(git describe --tags)'*/
                bat 'set tag=%git describe --tags%'

                /*sh 'message="$(git for-each-ref refs/tags/$tag --format=\'%(contents)\')"'*/
                bat 'for /f "delims=" %%i in (\'git for-each-ref refs/tags/%tag% --format^="%%(contents)"\') do set message=%%i'

               /* sh 'name=$(echo "$message" | head -n1)'*/
                 bat 'echo %message% | set /p name='

                /*sh 'description=$(echo "$message" | tail -n +3)'*/
                bat 'echo %message% | more +2 | set /p description='

                bat 'release=$(curl -XPOST -H "Authorization:token $token" --data \'{"tag_name": "$tag", "target_commitish": "main", "name": "$name", "body": "$description", "draft": false, "prerelease": false}\' "https://api.github.com/repos/YoussF/caesar-cipher/releases)"'
            }
        }
        /*stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }*/
    }
}

        