

variable "github_owner" {
  description = "GitHub organization"
  type        = string
}

variable "teams" {
  description = "GitHub Team configuration objects"
  type = map(object({
    name        = string
    description = string
    privacy     = optional(string, "closed")
    parent_team = optional(string)
    members = optional(list(object({
      full_name = optional(string)
      username  = string
      role      = optional(string, "member")
    })))
    repository = optional(object({
      name       = string
      permission = optional(string, "pull")
    }))
    review_request_delegation = optional(object({
      algorithm    = optional(string, "ROUND_ROBIN")
      member_count = optional(number)
      notify       = optional(bool)
    }))
  }))
  validation {
    condition = alltrue([
      for team in var.teams : contains(["closed", "secret"], team.privacy)
    ])
    error_message = "privacy must be one of 'closed, secret'"
  }
  validation { # FIX handle members is null
    condition = alltrue([
      for team in var.teams : alltrue([
        for member in team.members : contains(["member", "maintainer"], member.role)
      ]) if team.members != null
    ])
    error_message = "members.role must be one of 'member, maintainer'"
  }
  validation { # FIX handle repostory is null
    condition = alltrue([
      for team in var.teams : contains(["pull", "triage", "push", "maintain", "admin"], team.repository.permission)
      if team.repository != null
    ])
    error_message = "repository.permissions must be one of 'pull, triage, push, maintain, admin'"
  }
  validation { # FIX handle review_request_delegation is null
    condition = alltrue([
      for team in var.teams : contains(["ROUND_ROBIN", "LOAD_BALANCE"], team.review_request_delegation.algorithm)
      if team.review_request_delegation != null
    ])
    error_message = "review_request_delegation.algorithm must be one of 'ROUND_ROBIN, LOAD_BALANCE'"
  }
  default = {}
}
