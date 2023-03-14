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
                withCredentials([string(credentialsId: 'mytoken', variable: 'token')])
             {   
              
          
                bat 'set tag= && for /f "delims=" %%i in (\'git describe --tags --always\') do set tag=%%i'
def tag = bat(returnStdout: true, script: 'echo %tag%').trim()

                bat'message="$(git for-each-ref refs/tags/$tag --format=\'%(contents)\')"'
                bat'name=$(echo "$message" | head -n1)'
                bat'description=$(echo "$message" | tail -n +3)'
                bat'release=$(curl -XPOST -H "Authorization:token $token" --data \'{"tag_name": "$tag", "target_commitish": "main", "name": "$name", "body": "$description", "draft": false, "prerelease": false}\' "https://api.github.com/repos/YoussF/caesar-cipher/releases)"'
            }
            }
        }
        /*stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
        */
    }
}