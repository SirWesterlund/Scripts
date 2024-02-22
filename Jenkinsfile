pipeline {
    agent any
  
    stages {
        stage('Ejecutar script') {
            steps {
                script {
                    sh '''
                        curl -X POST -H 'Content-Type: application/json' -d '{"chat_id": "6380688873", "text": "__", "disable_notification": false}'  https://api.telegram.org/bot6861368113:AAH5mQ1vG6t6ksXrA4oKlKdl17qgBVhmoD0/sendMessage
                        curl -X POST -H 'Content-Type: application/json' -d '{"chat_id": "6380688873", "text": " * Tarea en marcha:", "disable_notification": false}'  https://api.telegram.org/bot6861368113:AAH5mQ1vG6t6ksXrA4oKlKdl17qgBVhmoD0/sendMessage
                        chmod 764 /home/ubuntu/workspace/Tarea-Final/python-diff.py
                        python3 /home/ubuntu/workspace/Tarea-Final/python-diff.py old.xlsx new.xlsx
                        chmod 764 /home/ubuntu/workspace/Tarea-Final/meta-script.sh
                        curl -X POST -H 'Content-Type: application/json' -d '{"chat_id": "6380688873", "text": "Paso 1: Ejecutando script... -> Hecho.", "disable_notification": false}'  https://api.telegram.org/bot6861368113:AAH5mQ1vG6t6ksXrA4oKlKdl17qgBVhmoD0/sendMessage
                    '''
                }
            }
        }
        stage('Enviar y ejecutar meta-script') {
            steps {
                script {
                    sh '''
                        scp -p meta-script.sh admin@172.17.0.4:/home/admin/meta-script.sh
                        ssh -t admin@172.17.0.4 sudo ./meta-script.sh
                        curl -X POST -H 'Content-Type: application/json' -d '{"chat_id": "6380688873", "text": "Paso 2: Enviar y ejecutar meta-script. -> Hecho.", "disable_notification": false}'  https://api.telegram.org/bot6861368113:AAH5mQ1vG6t6ksXrA4oKlKdl17qgBVhmoD0/sendMessage
                    '''
                }
            }
        }
        stage('Crear PDF con Pandoc') {
            steps {
                sh '''
                    pandoc -s logs.md -o logs.pdf --pdf-engine=wkhtmltopdf
                    curl -X POST -H 'Content-Type: application/json' -d '{"chat_id": "6380688873", "text": "Paso 3: Creando PDF. -> Hecho", "disable_notification": false}'  https://api.telegram.org/bot6861368113:AAH5mQ1vG6t6ksXrA4oKlKdl17qgBVhmoD0/sendMessage
                    curl -X POST -H 'Content-Type: application/json' -d '{"chat_id": "6380688873", "text": " * Compartiendo PDF:", "disable_notification": false}'  https://api.telegram.org/bot6861368113:AAH5mQ1vG6t6ksXrA4oKlKdl17qgBVhmoD0/sendMessage
                    curl -X POST "https://api.telegram.org/bot6861368113:AAH5mQ1vG6t6ksXrA4oKlKdl17qgBVhmoD0/sendDocument" -F chat_id="6380688873" -F document="@logs.pdf"
                '''
            }
        }
        stage('Envio el Markdown a GitHub') {
            steps {
                script {
                    sh '''
                        git config --global user.email 'davidtronchoni02@gmail.com'
                        git config --global user.name 'SirWesterlund'
                        git add logs.pdf
                        git commit -m "push"
                        git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/SirWesterlund/Scripts.git HEAD:main
                        curl -X POST -H 'Content-Type: application/json' -d '{"chat_id": "6380688873", "text": "Paso 4: Envio el Markdown a GitHub. -> Hecho", "disable_notification": false}'  https://api.telegram.org/bot6861368113:AAH5mQ1vG6t6ksXrA4oKlKdl17qgBVhmoD0/sendMessage
                        curl -X POST -H 'Content-Type: application/json' -d '{"chat_id": "6380688873", "text": " * Compartiendo plantilla Markdown:", "disable_notification": false}'  https://api.telegram.org/bot6861368113:AAH5mQ1vG6t6ksXrA4oKlKdl17qgBVhmoD0/sendMessage
                        curl -X POST "https://api.telegram.org/bot6861368113:AAH5mQ1vG6t6ksXrA4oKlKdl17qgBVhmoD0/sendDocument" -F chat_id="6380688873" -F document="@logs.md"
                    '''
                }
            }
        }
    }
    post {
        success {
            script {
                sh '''
                    curl -X POST -H 'Content-Type: application/json' -d '{"chat_id": "6380688873", "text": " * Tarea terminada con éxito", "disable_notification": false}' https://api.telegram.org/bot6861368113:AAH5mQ1vG6t6ksXrA4oKlKdl17qgBVhmoD0/sendMessage
                '''
            }
        }
        failure {
            script {
                sh '''
                    ssh jenkins@172.17.0.2 zip -r logs.zip ${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_NUMBER}
                    scp jenkins@172.17.0.2:/var/jenkins_home/logs.zip .
                    curl -X POST -H 'Content-Type: application/json' -d '{"chat_id": "6380688873", "text": " * Tarea terminada sin éxito", "disable_notification": false}' https://api.telegram.org/bot6861368113:AAH5mQ1vG6t6ksXrA4oKlKdl17qgBVhmoD0/sendMessage
                    curl -X POST -H 'Content-Type: application/json' -d '{"chat_id": "6380688873", "text": " * Compartiendo comprimido de los logs:", "disable_notification": false}' https://api.telegram.org/bot6861368113:AAH5mQ1vG6t6ksXrA4oKlKdl17qgBVhmoD0/sendMessage
                    curl -X POST "https://api.telegram.org/bot6861368113:AAH5mQ1vG6t6ksXrA4oKlKdl17qgBVhmoD0/sendDocument" -F chat_id="6380688873" -F document="@logs.zip"
                '''
            }
        }
    }
}

