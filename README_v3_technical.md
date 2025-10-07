# Dynatrace Terraform Data Privacy Export

Terraform configuration for exporting Dynatrace data privacy settings using the dynatrace-oss provider.

## Requirements

- Terraform >= 1.0
- terraform-provider-dynatrace executable
- Dynatrace environment with API access
- API token with configuration read permissions

## Setup

### 1. Environment Variables

```bash
export DT_ENV_URL="https://your-environment.live.dynatrace.com"
export DT_API_TOKEN="your-api-token"
```

### 2. Provider Configuration

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

provider "dynatrace" {}
```

### 3. Export Configuration

```bash
terraform-provider-dynatrace -export dynatrace_data_privacy
```

This generates:
```
configuration/
└── modules/
    └── data_privacy/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

### 4. Initialize and Plan

```bash
terraform init
terraform plan
```

## File Structure

```
.
├── main.tf                           # Provider configuration
└── configuration/
    └── modules/
        └── data_privacy/
            ├── main.tf                # Exported resources
            ├── variables.tf           # Variable definitions
            └── outputs.tf             # Output definitions
```

## Usage

The export command creates Terraform configuration files that represent your current Dynatrace data privacy settings. These files can be:

- Version controlled
- Modified as needed
- Applied to other environments
- Used for compliance documentation

## Authentication

The provider uses environment variables for authentication:

- `DT_ENV_URL`: Your Dynatrace environment URL
- `DT_API_TOKEN`: API token with appropriate permissions

## Security Considerations

- Store API tokens securely
- Use least-privilege API tokens
- Review exported configurations before applying
- Maintain audit logs of configuration changes

## Troubleshooting

### Common Issues

1. **Authentication errors**: Verify `DT_ENV_URL` and `DT_API_TOKEN`
2. **Permission errors**: Ensure API token has configuration read access
3. **Export failures**: Check terraform-provider-dynatrace executable is in PATH

### Debug Mode

```bash
TF_LOG=DEBUG terraform-provider-dynatrace -export dynatrace_data_privacy
```

## References

- [Dynatrace Terraform Provider](https://github.com/dynatrace-oss/terraform-provider-dynatrace)
- [Dynatrace API Documentation](https://www.dynatrace.com/support/help/dynatrace-api/)
- [Terraform Documentation](https://www.terraform.io/docs/)