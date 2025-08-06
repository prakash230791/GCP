
# Deploying a Linux VM on Google Cloud using Deployment Manager

This guide provides a simple example of how to deploy a Linux virtual machine on Google Cloud using a Deployment Manager template.

## Prerequisites

1.  **Google Cloud SDK:** Make sure you have the `gcloud` command-line tool installed and configured on your machine.
2.  **Authentication:** Authenticate with Google Cloud:
    ```bash
    gcloud auth login
    gcloud auth application-default login
    ```
3.  **Project:** Set your default project:
    ```bash
    gcloud config set project [YOUR_PROJECT_ID]
    ```

## Deployment Steps

There are two ways to deploy this infrastructure:

### 1. Manual Deployment

You can use the provided `deploy.sh` script to deploy the VM manually. Make sure you have the Google Cloud SDK installed and configured.

```bash
./deploy.sh
```

### 2. Automated Deployment with GitHub Actions

This repository is configured with a GitHub Actions workflow to automatically deploy the infrastructure when you push to the `main` branch.

To make this work, you need to configure the following secrets in your GitHub repository settings:

*   `GCP_PROJECT_ID`: Your Google Cloud project ID.
*   `GCP_SA_KEY`: A JSON key for a Google Cloud service account with the `Deployment Manager Editor` and `Compute Admin` roles.

Once the secrets are configured, any push to the `main` branch will trigger the deployment.

## Verify

Once the deployment is complete, you can see your new VM in the Google Cloud Console or by running:

```bash
gcloud compute instances list
```

## Cleanup

To delete the deployment and all its resources, run:

```bash
gcloud deployment-manager deployments delete my-first-vm
```
