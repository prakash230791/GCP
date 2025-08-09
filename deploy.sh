PROJECT_ID="lab03-467223"

gcloud config set project $PROJECT_ID

gcloud deployment-manager deployments update gcp-vm01 --template vm_template.jinja --project $PROJECT_ID --properties="timestamp:$(date +%s)" || \
  gcloud deployment-manager deployments create gcp-vm01 --template vm_template.jinja --project $PROJECT_ID --properties="timestamp:$(date +%s)"
