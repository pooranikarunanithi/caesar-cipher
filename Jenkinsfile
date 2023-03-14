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
                bat 'set token="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"'
                bat'tag=$(git describe --tags --always)'
                bat "git for-each-ref refs/tags/%tag% --format=\"%%(contents)\"" > tag.txt
set /p message=<tag.txt
setlocal EnableDelayedExpansion
set "name="
set "description="
for /f "tokens=*" %%i in ("!message!") do (
    if not defined name (
        set "name=%%i"
    ) else (
        if not defined description (
            set "description=%%i"
        ) else (
            set "description=!description!%%i"
        )
    )
)
set "description=!description:~2!"
curl -XPOST -H "Authorization:token %token%" --data "{\"tag_name\": \"%tag%\", \"target_commitish\": \"main\", \"name\": \"!name!\", \"body\": \"!description!\", \"draft\": false, \"prerelease\": false}" "https://api.github.com/repos/YoussF/caesar-cipher/releases"

        /*stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
        */
    }
}