# Step-by-Step Guide: Export Dynatrace Data Privacy Configuration

## Prerequisites
- Terraform installed and available in PATH
- Dynatrace environment URL and API token with appropriate permissions

## Steps

### 1. Create Working Directory
```bash
mkdir dynatrace-terraform
cd dynatrace-terraform
```

### 2. Create Terraform Configuration
Create `main.tf`:
```hcl
terraform {
  required_providers {
    dynatrace = {
      source  = "dynatrace-oss/dynatrace"
      version = "~> 1.0"
    }
  }
}

provider "dynatrace" {
  # Configuration via environment variables
}
```

### 3. Initialize Terraform
```bash
terraform init
```

### 4. Set Environment Variables
Add to `~/.bashrc`:
```bash
export DT_ENV_URL="https://your-environment-id.live.dynatrace.com"
export DT_API_TOKEN="your-api-token"
```

**CRITICAL**: Always verify your environment variables before proceeding:
```bash
echo $DT_ENV_URL
echo $DT_API_TOKEN
```

⚠️ **Warning**: If these variables are empty, the export will run without errors but create empty folders.

Reload environment:
```bash
source ~/.bashrc
```

### 5. Export Configuration Only (for cross-environment deployment)

#### 5.1 Export Data Privacy Configuration
```bash
source ~/.bashrc
./.terraform/providers/registry.terraform.io/dynatrace-oss/dynatrace/1.85.0/linux_amd64/terraform-provider-dynatrace_v1.85.0 -export dynatrace_data_privacy
```

#### 5.2 Verify Export
```bash
ls -la configuration/
```

You should see:
- `main.tf`
- `modules/data_privacy/` directory
- Various `___*.tf` files

### 6. Deploy to Target Environment

#### 6.1 Set Target Environment Variables
```bash
export DT_ENV_URL="https://target-environment-id.live.dynatrace.com"
export DT_API_TOKEN="dt0c01.TARGET_TOKEN_HERE"
```

#### 6.2 Verify Variables
```bash
echo $DT_ENV_URL
echo $DT_API_TOKEN
```

#### 6.3 Deploy Configuration
```bash
cd configuration
terraform init
terraform plan    # Review what will be created
terraform apply
```

## File Structure After Export

```
dynatrace-terraform/
├── main.tf                           # Your provider config
├── configuration/                    # Export output
│   ├── main.tf                      # Module references
│   ├── ___providers___.tf           # Provider configuration
│   ├── ___variables___.tf           # Variables
│   ├── ___resources___.tf           # Resource definitions
│   └── modules/
│       └── data_privacy/
│           ├── data_privacy.tf      # Actual resource config
│           └── ___providers___.tf   # Module provider config
```

## Troubleshooting

### Empty Folders After Export
**Cause**: Environment variables not set or incorrect
**Solution**: Verify both variables show values, then re-run export

### Authentication Errors
**Cause**: Invalid token or URL
**Solution**: Verify token permissions and URL format (should include https://)

## Security Notes

- Exported files contain configuration values but no secrets
- API tokens are read from environment variables, not stored in files
- Safe to commit configuration files to version control
- Never commit `terraform.tfstate` files containing sensitive data

## Result
You now have a reusable Terraform module containing your Dynatrace data privacy settings that can be applied to other environments. The exported configuration files serve as templates for cross-environment deployment.
