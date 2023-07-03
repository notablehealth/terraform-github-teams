
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
# terraform-github-teams

[![Releases](https://img.shields.io/github/v/release/notablehealth/terraform-github-teams)](https://github.com/notablehealth/terraform-github-teams/releases)

[Terraform Module Registry](https://registry.terraform.io/modules/notablehealth/teams/github)

Terraform module to manage GitHub teams

## Requirements

- GitHub personal access token with admin rights to an organization
  - Provide token via environment variable
  >>export GITHUB\_TOKEN='TOKEN'

## Features

- Manage GitHub teams
  - Manage nested teams (currently 4 levels)
- Manage team members

Terraform doesn't handle dynamic recursion or resource dependencies. To do
nested teams, the code would either need to be run multiple times or manage
a fixed maximum number of levels. This module manages up to 4 levels of nesting.
But could easily be expanded to more.

## Usage

Basic usage of this module is as follows:

```hcl
module "example" {
    source = "notablehealth/<module-name>/github"
    # Recommend pinning every module to a specific version
    # version = "x.x.x"

    # Required variables
    github_owner =
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 5.29 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 5.29.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_team.teams_level2](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) | resource |
| [github_team.teams_level3](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) | resource |
| [github_team.teams_level4](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) | resource |
| [github_team.teams_root](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) | resource |
| [github_team_members.self](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_owner"></a> [github\_owner](#input\_github\_owner) | GitHub organization | `string` | n/a | yes |
| <a name="input_teams"></a> [teams](#input\_teams) | GitHub Team configuration objects | <pre>map(object({<br>    name        = string<br>    description = string<br>    privacy     = optional(string, "closed")<br>    parent_team = optional(string)<br>    members = optional(list(object({<br>      full_name = optional(string)<br>      username  = string<br>      role      = optional(string, "member")<br>    })))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_teams_level2"></a> [teams\_level2](#output\_teams\_level2) | GitHub level 2 teams |
| <a name="output_teams_level3"></a> [teams\_level3](#output\_teams\_level3) | GitHub level 3 teams |
| <a name="output_teams_level4"></a> [teams\_level4](#output\_teams\_level4) | GitHub level 4 teams |
| <a name="output_teams_root"></a> [teams\_root](#output\_teams\_root) | GitHub root level teams |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
