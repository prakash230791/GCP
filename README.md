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

## Connecting to the VM

To connect to your new virtual machine, you will need the username, password, and the VM's external IP address.

### 1. Retrieve Credentials

The username and a randomly generated password were stored in Google Secret Manager during deployment. Use these commands to retrieve them:

```bash
# Retrieve the username
VM_USERNAME=$(gcloud secrets versions access latest --secret="vm-username")

# Retrieve the password
VM_PASSWORD=$(gcloud secrets versions access latest --secret="vm-password")

echo "Username: $VM_USERNAME"
echo "Password: $VM_PASSWORD"
```

### 2. Get the External IP Address

Find the external IP address of your VM using the following command:

```bash
EXTERNAL_IP=$(gcloud compute instances describe my-first-vm --zone=us-central1-a --format='get(networkInterfaces[0].accessConfigs[0].natIP)')

echo "External IP: $EXTERNAL_IP"
```

### 3. Connect using SSH

Now you can use any standard SSH client to connect to the machine. You will be prompted for the password you retrieved in the first step.

```bash
ssh ${VM_USERNAME}@${EXTERNAL_IP}
```

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

## Troubleshooting

If the secrets are not being created, it is likely that the startup script on the VM is failing. You can check the logs of the startup script by running the following command:

```bash
gcloud compute instances get-serial-port-output my-first-vm --zone=us-central1-a
```

Look for any error messages related to `gcloud secrets` or `PERMISSION_DENIED`.