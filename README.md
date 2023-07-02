
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
# terraform-github-teams

[![Releases](https://img.shields.io/github/v/release/notablehealth/terraform-github-teams)](https://github.com/notablehealth/terraform-github-teams/releases)

[Terraform Module Registry](https://registry.terraform.io/modules/notablehealth/teams/github)

Terrafoorm module to manage GitHub teams

## Features

- Mnaage GitHub teams

## Usage

Basic usage of this module is as follows:

```hcl
module "example" {
    source = "notablehealth/<module-name>/github"
    # Recommend pinning every module to a specific version
    # version = "x.x.x"
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_owner"></a> [github\_owner](#input\_github\_owner) | GitHub organization or user | `string` | `"notablehealth"` | no |
| <a name="input_teams"></a> [teams](#input\_teams) | GitHub Team configuration objects | <pre>map(object({<br>    name        = string<br>    description = string<br>    privacy     = optional(string, "closed")<br>    parent_team = optional(string)<br>    members = list(object({<br>      username = string<br>      role     = optional(string, "member")<br>    }))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_teams_level2"></a> [teams\_level2](#output\_teams\_level2) | GitHub level 2 teams |
| <a name="output_teams_level3"></a> [teams\_level3](#output\_teams\_level3) | GitHub level 3 teams |
| <a name="output_teams_level4"></a> [teams\_level4](#output\_teams\_level4) | GitHub level 4 teams |
| <a name="output_teams_root"></a> [teams\_root](#output\_teams\_root) | GitHub root level teams |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
