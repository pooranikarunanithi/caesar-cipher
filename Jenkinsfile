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
                 script {
                def tag = bat(returnStdout: true, script: 'echo %tag%').trim()
    // Use the tag variable as needed
                }
                bat '''
                setlocal enabledelayedexpansion
                for /f "usebackq delims=" %%i in (`git for-each-ref refs/tags/%tag% --format="(contents)"`) do (
                set "message=%%i"
                )
                echo %message%
                '''



               /* bat'name=$(echo "$message" | head -n1)'*/
               bat '''
            for /f "usebackq delims=" %%i in (`echo %message% ^| more +1`) do (
            set "name=%%i"
            goto :done
            )
            :done
            echo %name%
                '''

                /*bat'description=$(echo "$message" | tail -n +3)'*/
                  bat '''
                    setlocal enabledelayedexpansion
                    set /a count=0
                    for /f "usebackq delims=" %%i in (`echo %message% ^| more +3`) do (
                    set /a count+=1
                    set "line[!count!]=%%i"
                    )
                    set "description=!line[1]!"
                    for /l %%i in (2,1,!count!) do (
                    set "description=!description!^r^n!line[%%i]!"
                    )
                    echo %description%
                    '''
  sh 'release=$(curl -XPOST -H "Authorization:token $token" --data \'{"tag_name": "$tag", "target_commitish": "main", "name": "$name", "body": "$description", "draft": false, "prerelease": false}\' "https://api.github.com/repos/YoussF/caesar-cipher/releases)"'
            }
        }
        /*stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }*/
    
