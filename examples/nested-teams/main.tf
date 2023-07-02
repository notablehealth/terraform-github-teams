/**
 * # Example: nested teams
 *
 */

module "nested_teams" {
  source = "../.."

  github_owner = var.github_owner
  teams = {
    "team-1" = {
      name        = "team-1"
      description = "Top level team"
    },
    "team-2" = {
      name        = "team-2"
      description = "Top level team"
    },
    "team-3" = {
      name        = "team-3"
      description = "Top level team"
    },
    "team-3a" = {
      name        = "team-3a"
      description = "First nested team"
      parent_team = "team-3"
    },
    "team-1a" = {
      name        = "team-1a"
      description = "First nested team"
      parent_team = "team-1"
    },
    "team-1a1" = {
      name        = "team-1a1"
      description = "Second nested team"
      parent_team = "team-1a"
    },
    "team-1a1a" = {
      name        = "team-1a1a"
      description = "Third nested team"
      parent_team = "team-1a1"
    },
  }
}
