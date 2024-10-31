
output "teams_root" {
  description = "GitHub root level teams"
  value       = local.teams_root
}
output "teams_level2" {
  description = "GitHub level 2 teams"
  value       = local.teams_level2
}
output "teams_level3" {
  description = "GitHub level 3 teams"
  value       = local.teams_level3
}
output "teams_level4" {
  description = "GitHub level 4 teams"
  value       = local.teams_level4
}

output "repositories" {
  description = "Team repository permissions"
  value = {
    for team in var.teams : team.name => {
      repo = team.repository
    } if team.repository != null
  }
}
