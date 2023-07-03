

variable "github_owner" {
  description = "GitHub organization or user"
  type        = string
  default     = "notablehealth"
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
  }))
  default = {}
}
