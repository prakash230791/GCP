
### 2. Automated Deployment with GitHub Actions

This repository is configured with a GitHub Actions workflow to automatically deploy the infrastructure when you push to the `main` branch.

To make this work, you need to configure two sets of permissions:

#### A. GitHub Actions Service Account

Create a service account for GitHub Actions to use. This account needs the following roles:

*   `Deployment Manager Editor`
*   `Compute Admin`
*   `Service Usage Admin`

Create a JSON key for this service account and add it as a secret named `GCP_SA_KEY` in your GitHub repository settings. Also add your `GCP_PROJECT_ID` as a secret.

#### B. Compute Engine Default Service Account

The virtual machine itself uses the **Compute Engine default service account** to run the startup script. This service account needs permission to create secrets.

1.  **Find the service account:** Go to the **IAM** page in the Google Cloud Console. Find the service account that ends with `@developer.gserviceaccount.com`. Its name will be in the format `[PROJECT_NUMBER]-compute@developer.gserviceaccount.com`.
2.  **Grant permissions:** Click the pencil icon to edit the service account's roles. Add the **`Secret Manager Admin`** role.

Once both service accounts have the correct permissions, any push to the `main` branch will trigger the deployment.

## Troubleshooting

If the secrets are not being created, it is likely that the startup script on the VM is failing. You can check the logs of the startup script by running the following command:

```bash
gcloud compute instances get-serial-port-output my-first-vm --zone=us-central1-a
```

Look for any error messages related to `gcloud secrets` or `PERMISSION_DENIED`.
