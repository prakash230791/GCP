PROJECT_ID="[YOUR_PROJECT_ID]"

gcloud config set project $PROJECT_ID

gcloud deployment-manager deployments create my-first-vm --template vm_template.yaml
