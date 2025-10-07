terraform {
  required_providers {
    dynatrace = {
      source  = "dynatrace-oss/dynatrace"
      version = "~> 1.0"
    }
  }
}

provider "dynatrace" {
  # Configuration will be provided via environment variables
  # DT_ENV_URL and DT_API_TOKEN
}