param(
    [Parameter(Mandatory=$true)]
    [string]$GitHubUsername
)

$RepoName = "portfolio"
$ProjectDir = $PSScriptRoot

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  DEPLOY PORTFOLIO LEN GITHUB PAGES" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Init git
Write-Host "[1/4] Khoi tao Git repository..." -ForegroundColor Yellow
Set-Location $ProjectDir
if (Test-Path ".git") {
    Write-Host "  -> Git da duoc khoi tao truoc do, bo qua." -ForegroundColor Gray
} else {
    git init
}

# Step 2: Add & commit
Write-Host "[2/4] Them file va commit..." -ForegroundColor Yellow
git add .
git commit -m "Initial commit: portfolio website" 2>$null
if ($LASTEXITCODE -ne 0) {
    git commit -m "Update portfolio" --allow-empty
}
git branch -M main

# Step 3: Add remote & push
$RemoteUrl = "https://github.com/$GitHubUsername/$RepoName.git"
Write-Host "[3/4] Push code len GitHub..." -ForegroundColor Yellow
Write-Host "  -> Remote: $RemoteUrl" -ForegroundColor Gray

git remote remove origin 2>$null
git remote add origin $RemoteUrl
git push -u origin main

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "  LOI KHI PUSH!" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Co the ban chua tao repository tren GitHub." -ForegroundColor Red
    Write-Host "Hay tao repo tai: https://github.com/new" -ForegroundColor Yellow
    Write-Host "  - Ten repo: $RepoName" -ForegroundColor White
    Write-Host "  - Chon Public" -ForegroundColor White
    Write-Host "  - KHONG tick 'Add a README'" -ForegroundColor White
    Write-Host ""
    Write-Host "Sau khi tao xong, chay lai lenh deploy." -ForegroundColor Yellow
    exit 1
}

# Step 4: Instructions
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  PUSH THANH CONG!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Buoc cuoi: Bat GitHub Pages" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Mo link: https://github.com/$GitHubUsername/$RepoName/settings/pages" -ForegroundColor White
Write-Host "2. Muc 'Source': chon 'Deploy from a branch'" -ForegroundColor White
Write-Host "3. Muc 'Branch': chon 'main' -> '/ (root)'" -ForegroundColor White
Write-Host "4. Nhan 'Save'" -ForegroundColor White
Write-Host ""
Write-Host "Sau 1-2 phut, trang web se co tai:" -ForegroundColor Green
Write-Host "  https://$GitHubUsername.github.io/$RepoName/" -ForegroundColor Cyan
Write-Host ""

# Try to open the settings page automatically
$SettingsUrl = "https://github.com/$GitHubUsername/$RepoName/settings/pages"
Write-Host "Dang mo trang Settings..." -ForegroundColor Gray
Start-Process $SettingsUrl
