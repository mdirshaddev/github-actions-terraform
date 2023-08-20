terraform {
  terraform {
  cloud {
    organization = "mdirshaddev"

    workspaces {
      name = "github-actions-terraform"
    }
  }
}
  
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "~> 0.3"
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

  git_repository = {
    type = "github"
    repo = "mdirshaddev/github-actions-terraform"
  }
}

resource "vercel_deployment" "mdirshad" {
  project_id = vercel_project.mdirshad.id
  production = true

  environment = {

  }
}

resource "vercel_project_domain" "mdirshad" {
  project_id = vercel_project.mdirshad.id
  domain = "mdirshad.vercel.app"
}

output "deployment_url" {
  value = vercel_deployment.mdirshad.url
}

output "deployment_id" {
  value = vercel_deployment.mdirshad.id
}

output "vercel_instance" {
  value = vercel_project.mdirshad.id
}