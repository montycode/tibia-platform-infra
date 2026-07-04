# Publish all Tibia Platform repos to GitHub (montycode)
# Prerequisites: gh auth login

$ErrorActionPreference = "Stop"
$Owner = "montycode"
$ReposRoot = Split-Path -Parent $PSScriptRoot

$repos = @(
  "tibia-platform-shared",
  "tibia-platform-infra",
  "tibia-platform-api",
  "tibia-platform-worker",
  "tibia-platform-web",
  "tibia-discord-bot"
)

Write-Host "Checking GitHub authentication..."
gh auth status | Out-Null

foreach ($repo in $repos) {
  $path = Join-Path $ReposRoot $repo
  if (-not (Test-Path $path)) {
    Write-Warning "Skipping missing repo: $path"
    continue
  }

  Write-Host "`n=== $repo ===" -ForegroundColor Cyan

  $exists = gh repo view "$Owner/$repo" 2>$null
  if (-not $exists) {
    Write-Host "Creating GitHub repository $Owner/$repo..."
    gh repo create "$Owner/$repo" --public --source $path --remote origin --push --description "Tibia Guild Platform - $repo"
  } else {
    Write-Host "Repository exists, pushing..."
    git -C $path push -u origin main
  }
}

Write-Host "`nDone! Repositories:" -ForegroundColor Green
foreach ($repo in $repos) {
  Write-Host "  https://github.com/$Owner/$repo"
}
