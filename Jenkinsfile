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
                bat 'set token=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'
                bat '`git describe --tags` > tag.txt'
                bat 'set /p tag=<tag.txt'
                bat '`git show %tag% | findstr /b /c:"" /c:"[A-Za-z]"` > message.txt'
                bat 'set /p name=<message.txt'
                bat 'set /p description=<message.txt'
                bat "set release=`curl -XPOST -H \"Authorization:token %token%\" --data \"{\\\"tag_name\\\": \\\"%tag%\\\", \\\"target_commitish\\\": \\\"main\\\", \\\"name\\\": \\\"%name%\\\", \\\"body\\\": \\\"%description%\\\", \\\"draft\\\": false, \\\"prerelease\\\": false}\" \"https://api.github.com/repos/YoussF/caesar-cipher/releases\"`"
                bat 'echo %release%'
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