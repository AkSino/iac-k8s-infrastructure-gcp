# iac-k8s-infrastructure-gcp
Manage your Kubernetes infrastructure as code (IaC) effortlessly with this repository on GCP.


## Kubernetes Dashboard Access Guide

This guide explains how to obtain an authentication token to access the Kubernetes Dashboard and how to access the dashboard using the token.

### Step 1: Get an Authentication Token

1. Open your terminal.

2. Use the following command to obtain the authentication token from the Kubernetes cluster. Replace `<VM_IP>` with the IP address of your Kubernetes VM:

   ```bash
   kubectl get secret admin-user -n kubernetes-dashboard -o jsonpath={".data.token"} | base64 -d
   ```
This command retrieves the authentication token from the `admin-user` secret in the `kubernetes-dashboard` namespace.

3. The token will be displayed in your terminal. Copy this token; you'll need it to access the dashboard.

### Step 2: Access the Kubernetes Dashboard

1. Open a web browser.

2. Use the following URL to access the Kubernetes Dashboard. Replace <VM_IP> with the IP address of your Kubernetes VM:

```perl
https://<VM_IP>:30002/#/login
```

3. When you access the URL, you will see the Kubernetes Dashboard login page.

4. In the "Token" field, paste the authentication token you obtained in Step 1.

5. Click "Connect" to log in to the dashboard.

6. You will now have access to the Kubernetes Dashboard and can manage your cluster.

That's it! You are now logged in to the Kubernetes Dashboard using the authentication token.