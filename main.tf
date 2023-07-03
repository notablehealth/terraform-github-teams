/**
 * # terraform-github-teams
 *
 * [![Releases](https://img.shields.io/github/v/release/notablehealth/terraform-github-teams)](https://github.com/notablehealth/terraform-github-teams/releases)
 *
 * [Terraform Module Registry](https://registry.terraform.io/modules/notablehealth/teams/github)
 *
 * Terraform module to manage GitHub teams
 *
 * ## Requirements
 *
 * - GitHub personal access token with admin rights to an organization
 *   - Provide token via environment variable
 *   >>export GITHUB_TOKEN='TOKEN'
 *
 * ## Features
 *
 * - Manage GitHub teams
 *   - Manage nested teams (currently 4 levels)
 * - Manage team members
 *
 * Terraform doesn't handle dynamic recursion or resource dependencies. To do
 * nested teams, the code would either need to be run multiple times or manage
 * a fixed maximum number of levels. This module manages up to 4 levels of nesting.
 * But could easily be expanded to more.
 *
 */

locals {
  teams_root = [for team in var.teams : team.name if team.parent_team == null]
  teams_level2 = [for team in var.teams : team.name
  if contains(local.teams_root, team.parent_team != null ? team.parent_team : "")]
  teams_level3 = [for team in var.teams : team.name
  if contains(local.teams_level2, team.parent_team != null ? team.parent_team : "")]
  teams_level4 = [for team in var.teams : team.name
  if contains(local.teams_level3, team.parent_team != null ? team.parent_team : "")]
}

resource "github_team" "teams_root" {
  for_each                  = { for team in var.teams : team.name => team if team.parent_team == null }
  create_default_maintainer = false
  description               = each.value.description
  name                      = each.value.name
  parent_team_id            = each.value.parent_team != null ? replace(lower(each.value.parent_team), "/[ .]/", "-") : null
  privacy                   = each.value.privacy
}
resource "github_team" "teams_level2" {
  for_each = { for team in var.teams : team.name => team
  if contains(local.teams_root, team.parent_team != null ? team.parent_team : "") }
  create_default_maintainer = false
  description               = each.value.description
  name                      = each.value.name
  parent_team_id            = each.value.parent_team != null ? replace(lower(each.value.parent_team), "/[ .]/", "-") : null
  privacy                   = each.value.privacy
  depends_on                = [github_team.teams_root]
}
resource "github_team" "teams_level3" {
  for_each = { for team in var.teams : team.name => team
  if contains(local.teams_level2, team.parent_team != null ? team.parent_team : "") }
  create_default_maintainer = false
  description               = each.value.description
  name                      = each.value.name
  parent_team_id            = each.value.parent_team != null ? replace(lower(each.value.parent_team), "/[ .]/", "-") : null
  privacy                   = each.value.privacy
  depends_on                = [github_team.teams_level2]
}
resource "github_team" "teams_level4" {
  for_each = { for team in var.teams : team.name => team
  if contains(local.teams_level3, team.parent_team != null ? team.parent_team : "") }
  create_default_maintainer = false
  description               = each.value.description
  name                      = each.value.name
  parent_team_id            = each.value.parent_team != null ? replace(lower(each.value.parent_team), "/[ .]/", "-") : null
  privacy                   = each.value.privacy
  depends_on                = [github_team.teams_level3]
}

resource "github_team_members" "self" {
  for_each = { for team in var.teams : team.name => team
  if team.members != null }

  # Build team name -> id
  # just need id or slug
  #team_id = github_team.self[each.value.name].id
  team_id = replace(lower(each.value.name), "/[ .]/", "-")

  dynamic "members" {
    for_each = each.value.members
    content {
      role     = members.value.role
      username = members.value.username
    }
  }
  depends_on = [github_team.teams_root, github_team.teams_level2, github_team.teams_level3, github_team.teams_level4]
}
