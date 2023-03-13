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
        bat 'set tag=%GIT_TAG%'
        bat 'for /f "delims=" %%i in (\'git describe --tags\') do set tag=%%i'
        bat 'for /f "delims=" %%i in (\'git for-each-ref refs/tags/%tag% --format="^(contents)\'^"%\'"\') do set message=%%i'
        bat 'for /f "delims=" %%i in (\'echo %message% ^| findstr /r /c:"^^^"^"^"\'\'\'"\') do set name=%%i'
        bat 'for /f "tokens=* skip=2 delims=" %%i in ("%message%") do set description=%%i'
        bat 'set description=%description:"=%'
        bat 'set release=^
            curl -XPOST -H "Authorization:token %token%"^
            --data "{\\"tag_name\\": \\"%tag%\\", \\"target_commitish\\": \\"main\\", \\"name\\": \\"%name%\\", \\"body\\": \\"%description%\\", \\"draft\\": false, \\"prerelease\\": false}"^
            "https://api.github.com/repos/YoussF/caesar-cipher/releases"^
        '
        bat '%release%'
    }
}
        }
      /*  stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
        */
    }
}