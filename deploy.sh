PROJECT_ID="lab03-467223"

gcloud config set project $PROJECT_ID

gcloud deployment-manager deployments update my-first-vm03 --template vm_template.jinja --project $PROJECT_ID --properties="timestamp:$(date +%s)" || \
  gcloud deployment-manager deployments create my-first-vm03 --template vm_template.jinja --project $PROJECT_ID --properties="timestamp:$(date +%s)"
