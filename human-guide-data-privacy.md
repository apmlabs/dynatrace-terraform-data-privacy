# Human Guide: Export Dynatrace Data Privacy Settings

This guide shows you how to export Dynatrace data privacy settings using Terraform and manage them across environments.

## Prerequisites

1. **Dynatrace Environment Access**: You need a Dynatrace environment with API access
2. **API Token**: Create a token with appropriate permissions in Dynatrace
3. **Terraform**: Installed on your system

## Step 1: Environment Setup

### 1.1 Create Working Directory
```bash
mkdir dynatrace-terraform
cd dynatrace-terraform
```

### 1.2 Create Terraform Configuration
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

### 1.3 Initialize Terraform
```bash
terraform init
```

### 1.4 Set Environment Variables
Add to your `~/.bashrc` or set for current session:
```bash
export DT_ENV_URL="https://your-environment-id.live.dynatrace.com"
export DT_API_TOKEN="dt0c01.YOUR_TOKEN_HERE"
```

**CRITICAL**: Always verify your environment variables before proceeding:
```bash
echo $DT_ENV_URL
echo $DT_API_TOKEN
```

⚠️ **Warning**: If these variables are empty, the export will run without errors but create empty folders. Always check first!

## Step 2: Choose Your Export Method

You have two main approaches:

### Method A: Export Only (for cross-environment deployment)
### Method B: Export with State Import (for same environment management)

---

## Method A: Export Only → Create State → Apply

**Use this when**: Deploying to different environments or creating templates

### A.1 Export Configuration Only
```bash
source ~/.bashrc
./.terraform/providers/registry.terraform.io/dynatrace-oss/dynatrace/*/linux_amd64/terraform-provider-dynatrace_* -export dynatrace_data_privacy
```

### A.2 Verify Export
Check that files were created:
```bash
ls -la configuration/
```

You should see:
- `main.tf`
- `modules/data_privacy/` directory
- Various `___*.tf` files

### A.3 Check Current State
```bash
cd configuration
terraform state list
```

If empty or no state file exists, you have configs only.

### A.4 Create State from Configs

**Option 1: Manual Import** (requires resource ID)
```bash
terraform import module.data_privacy.dynatrace_data_privacy.environment RESOURCE_ID
```

**Option 2: Re-export with Import** (easier)
```bash
cd ..
./.terraform/providers/registry.terraform.io/dynatrace-oss/dynatrace/*/linux_amd64/terraform-provider-dynatrace_* -export -import-state dynatrace_data_privacy
```

**Option 3: Apply** (Dynatrace provider handles gracefully)
```bash
cd configuration
terraform apply
```

### A.5 Verify State Created
```bash
terraform state list
terraform plan
```

Should show "No changes" if successful.

### A.6 Apply to Different Environment

To deploy to another environment:
1. Set different `DT_ENV_URL` and `DT_API_TOKEN`
2. Run `terraform apply`

---

## Method B: Export with State Import (One Step)

**Use this when**: You want to immediately manage existing resources with Terraform

### B.1 Export and Import in One Step
```bash
source ~/.bashrc
./.terraform/providers/registry.terraform.io/dynatrace-oss/dynatrace/*/linux_amd64/terraform-provider-dynatrace_* -export -import-state dynatrace_data_privacy
```

This will:
- Export configuration files
- Initialize Terraform modules  
- Import resources into state
- Enable immediate Terraform management

### B.2 Verify Everything
```bash
cd configuration
terraform state list
terraform plan
```

Should show the resource in state and "No changes" in plan.

### B.3 Apply to Same Environment
You can now make changes to the configuration and apply:
```bash
terraform apply
```

### B.4 Apply to Different Environment

To deploy to another environment:
1. Remove from current state: `terraform state rm module.data_privacy.dynatrace_data_privacy.environment`
2. Set different `DT_ENV_URL` and `DT_API_TOKEN`
3. Run `terraform apply`

---

## Troubleshooting

### Empty Folders After Export
**Cause**: Environment variables not set or incorrect
**Solution**: 
```bash
echo $DT_ENV_URL
echo $DT_API_TOKEN
```
Verify both show values, then re-run export.

### "Resource Already Exists" Error
**Cause**: Trying to create resource that exists
**Solution**: The Dynatrace provider usually handles this gracefully, but you can:
1. Use `terraform import` to add to state
2. Remove resource from Dynatrace first
3. Use `-import-state` during export

### Authentication Errors
**Cause**: Invalid token or URL
**Solution**:
1. Verify token has correct permissions
2. Check URL format (should include https://)
3. Test API access manually

### No Changes in Plan
**Good**: This means your configuration matches the actual state
**If Unexpected**: Check if you're in the right directory and environment

## Understanding Your Current Situation

Run these commands to understand what you have:

```bash
# Check if state file exists
ls terraform.tfstate

# Check what's tracked in state  
terraform state list

# See differences between config and actual state
terraform plan
```

**Interpreting Results:**
- **No state file + configs exist**: You have configs only, need to import
- **Empty state list**: State file exists but no resources tracked
- **Plan shows "create"**: Resource not in state, will try to create
- **Plan shows "No changes"**: Config matches state perfectly

## File Structure After Export

```
dynatrace-terraform/
├── main.tf                           # Your provider config
├── configuration/                    # Export output
│   ├── main.tf                      # Module references
│   ├── ___providers___.tf           # Provider configuration
│   ├── ___variables___.tf           # Variables
│   ├── ___resources___.tf           # Resource definitions
│   ├── terraform.tfstate            # State file (if imported)
│   └── modules/
│       └── data_privacy/
│           ├── data_privacy.tf      # Actual resource config
│           └── ___providers___.tf   # Module provider config
```

## Security Notes

- Exported files contain configuration values but no secrets
- API tokens are read from environment variables, not stored in files
- Safe to commit configuration files to version control
- Never commit `terraform.tfstate` files containing sensitive data

## Cross-Environment Deployment

### Deploying Exported Configs to New Environment

When you have exported configurations (without state import) and want to deploy them to a different Dynatrace environment:

#### Step 1: Prepare Target Environment
```bash
# Set target environment variables
export DT_ENV_URL="https://target-environment-id.live.dynatrace.com"
export DT_API_TOKEN="dt0c01.TARGET_TOKEN_HERE"

# Verify they're set
echo $DT_ENV_URL
echo $DT_API_TOKEN
```

#### Step 2: Copy Configuration Files
Copy your exported configuration files to a new directory or ensure you're working with the exported configs.

#### Step 3: Deploy to Target
```bash
cd configuration
terraform init
terraform plan    # Review what will be created
terraform apply
```

### Key Points for Cross-Environment Deployment

- **Export-only workflow** creates configs specifically for cross-environment deployment
- The exported `.tf` files contain resource definitions but no state tracking
- Terraform will create these resources as new in the target environment
- No import commands needed since you're creating fresh resources
- Always verify environment variables before applying to prevent silent failures

### Workflow Selection Summary

| Scenario | Method | Commands |
|----------|--------|----------|
| Deploy to new environment | Export only | `terraform-provider-dynatrace -export resource_name` |
| Manage existing resources | Export + import | `terraform-provider-dynatrace -export -import-state resource_name` |
| Template for multiple envs | Export only | `terraform-provider-dynatrace -export resource_name` |

## Next Steps

After successful export and state management:
1. Review the exported configuration in `modules/data_privacy/data_privacy.tf`
2. Understand the current data privacy settings
3. Make any desired changes to the configuration
4. Apply changes with `terraform apply`
5. Use the configuration as a template for other environments
