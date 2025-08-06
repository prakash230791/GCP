
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

## Troubleshooting
