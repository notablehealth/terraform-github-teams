
# Set GitHub personal access token with environment variable
# export GITHUB_TOKEN='TOKRN''

provider "github" {
  owner = var.github_owner
}
