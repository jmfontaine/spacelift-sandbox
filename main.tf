terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
    }
  }
}

provider "spacelift" {
}

resource "spacelift_stack" "push_info_to_github_pr" {
  branch            = "main"
  name              = "Push information to GitHub PR"
  project_root      = "/push-info-to-github-pr"
  repository        = "spacelift-sandbox"
  terraform_version = "1.1.4"

  after_init = [<<EOT
curl -d "{\"body\": \"After init example\"}" -H "Authorization:Token $GITHUB_TOKEN" -X POST -s "https://api.github.com/repos/{$TF_VAR_spacelift_repository}/issues/{$TF_VAR_spacelift_pull_request_id}/comments"
EOT
]
  after_plan = [<<EOT
curl -d "{\"body\": $(terraform plan -no-color | jq -Rs .)}" -H "Authorization:Token $GITHUB_TOKEN" -X POST -s "https://api.github.com/repos/{$TF_VAR_spacelift_repository}/issues/{$TF_VAR_spacelift_pull_request_id}/comments"
EOT
]
}

resource "spacelift_environment_variable" "push_info_to_github_pr_github_token" {
  stack_id       = spacelift_stack.push_info_to_github_pr.id
  name           = "GITHUB_TOKEN"
  value          = "" # Enter the value via the UI
  write_only     = true

  lifecycle {
    # Keep the value entered via the UI when updating the stack
    ignore_changes = [value]
  }
}