terraform {
  required_providers {
    spacelift = {
      source = "spacelift-io/spacelift"
      version = "~> 0.1"
    }
  }
}

provider "spacelift" {}

resource "spacelift_space" "sol_eng" {
  description     = "Solutions Engineering team space"
  name            = "Solutions Engineering"
  parent_space_id = "root"
}
