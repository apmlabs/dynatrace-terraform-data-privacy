# 🔒 Dynatrace Terraform Data Privacy Export Tool

<div align="center">

[![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Dynatrace](https://img.shields.io/badge/dynatrace-%23007ACC.svg?style=for-the-badge&logo=dynatrace&logoColor=white)](https://www.dynatrace.com/)
[![License](https://img.shields.io/github/license/apmlabs/dynatrace-terraform-data-privacy?style=for-the-badge)](LICENSE)
[![Contributors](https://img.shields.io/github/contributors/apmlabs/dynatrace-terraform-data-privacy?style=for-the-badge)](https://github.com/apmlabs/dynatrace-terraform-data-privacy/graphs/contributors)

**Automate your Dynatrace data privacy configuration exports with Terraform! 🚀**

[Getting Started](#-getting-started) •
[Documentation](#-documentation) •
[Examples](#-examples) •
[Contributing](#-contributing) •
[Support](#-support)

</div>

## 📋 Table of Contents

- [🎯 About](#-about)
- [✨ Features](#-features)
- [🚀 Getting Started](#-getting-started)
- [📖 Documentation](#-documentation)
- [💡 Examples](#-examples)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)
- [💬 Support](#-support)

## 🎯 About

This project helps you export and manage Dynatrace data privacy settings using Terraform's Infrastructure as Code approach. Perfect for teams who want to version control their privacy configurations and maintain compliance across multiple environments!

### Why Use This Tool?

- 🔄 **Version Control**: Track changes to your privacy settings over time
- 🏗️ **Infrastructure as Code**: Manage configurations alongside your infrastructure
- 🔒 **Compliance**: Maintain audit trails for regulatory requirements
- 🚀 **Automation**: Integrate with CI/CD pipelines for consistent deployments

## ✨ Features

- ✅ Export existing Dynatrace data privacy configurations
- ✅ Generate Terraform-compatible configuration files
- ✅ Support for multiple environments
- ✅ Automated module structure generation
- ✅ Environment variable-based authentication
- ✅ Comprehensive error handling and validation

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have:

- 🔧 **Terraform** >= 1.0 installed
- 🌐 **Dynatrace environment** with API access
- 🔑 **API token** with configuration read permissions
- 💻 **terraform-provider-dynatrace** executable

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/apmlabs/dynatrace-terraform-data-privacy.git
   cd dynatrace-terraform-data-privacy
   ```

2. **Set up environment variables**
   ```bash
   export DT_ENV_URL="https://your-environment.live.dynatrace.com"
   export DT_API_TOKEN="your-api-token"
   ```

3. **Initialize Terraform**
   ```bash
   terraform init
   ```

### Quick Start Guide

1. **Export your current configuration**
   ```bash
   terraform-provider-dynatrace -export dynatrace_data_privacy
   ```

2. **Review generated files**
   ```bash
   ls -la configuration/modules/data_privacy/
   ```

3. **Plan your deployment**
   ```bash
   terraform plan
   ```

4. **Apply changes** (if needed)
   ```bash
   terraform apply
   ```

## 📖 Documentation

### Configuration Structure

```
📁 Project Root
├── 📄 main.tf                    # Main Terraform configuration
├── 📁 configuration/
│   └── 📁 modules/
│       └── 📁 data_privacy/
│           ├── 📄 main.tf         # Data privacy resources
│           ├── 📄 variables.tf    # Input variables
│           └── 📄 outputs.tf      # Output values
```

### Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `DT_ENV_URL` | Your Dynatrace environment URL | ✅ |
| `DT_API_TOKEN` | API token with read permissions | ✅ |

### Provider Configuration

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
  # Configuration will be read from environment variables
}
```

## 💡 Examples

### Basic Export

```bash
# Export all data privacy settings
terraform-provider-dynatrace -export dynatrace_data_privacy
```

### Advanced Usage

```bash
# Export with custom output directory
terraform-provider-dynatrace -export dynatrace_data_privacy -output-dir ./custom-config
```

## 🤝 Contributing

We love contributions! Here's how you can help:

1. 🍴 **Fork** the repository
2. 🌿 **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. 💾 **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. 📤 **Push** to the branch (`git push origin feature/amazing-feature`)
5. 🔄 **Open** a Pull Request

### Development Setup

```bash
# Clone your fork
git clone https://github.com/your-username/dynatrace-terraform-data-privacy.git

# Install dependencies
terraform init

# Run tests
terraform validate
```

### Code of Conduct

Please read our [Code of Conduct](CODE_OF_CONDUCT.md) before contributing.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 💬 Support

- 📚 **Documentation**: Check our [Wiki](https://github.com/apmlabs/dynatrace-terraform-data-privacy/wiki)
- 🐛 **Bug Reports**: [Create an issue](https://github.com/apmlabs/dynatrace-terraform-data-privacy/issues/new?template=bug_report.md)
- 💡 **Feature Requests**: [Request a feature](https://github.com/apmlabs/dynatrace-terraform-data-privacy/issues/new?template=feature_request.md)
- 💬 **Discussions**: [Join the conversation](https://github.com/apmlabs/dynatrace-terraform-data-privacy/discussions)

---

<div align="center">

**Made with ❤️ by the APM Labs team**

[⭐ Star this repo](https://github.com/apmlabs/dynatrace-terraform-data-privacy) if you find it helpful!

</div>