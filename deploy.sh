PROJECT_ID="lab03-467223"

gcloud config set project $PROJECT_ID

gcloud deployment-manager deployments create my-first-vm --template vm_template.yaml
