terraform {

  cloud {
    hostname = "app.terraform.io"

    organization = "mdirshaddev"

    workspaces {
      name = "mdirshad-local"
    }
  }
  
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "~> 0.4"
    }
  }
}

provider "vercel" {
  api_token = var.vercel_api_token
}

resource "vercel_project" "mdirshad" {
  name      = "mdirshad"
  framework = "nextjs"

  serverless_function_region = "bom1"

  root_directory = "frontend"
  
  git_repository = {
    type = "github"
    repo = "mdirshaddev/github-actions-terraform"
    production_branch = "main"
  }
}

# resource "vercel_deployment" "mdirshad" {
#   project_id = vercel_project.mdirshad.id
#   project_settings = {
    
#   }
#   ref = "main"
#   production = true
# }

variable "vercel_api_token" {
  type      = string
  sensitive = true
  description = "Vercel API Token for integrating with Vercel"
}

# output "deployment_url" {
#   value = vercel_deployment.mdirshad.url
# }

# output "deployment_id" {
#   value = vercel_deployment.mdirshad.id
# }

output "vercel_instance" {
  value = vercel_project.mdirshad.id
}
