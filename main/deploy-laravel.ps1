# Laravel Deployment Script for Windows (PowerShell)
# Author: Your Name
# Date: Get-Date

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Laravel Application Deployment Script" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Prompt for project name
$PROJECT_NAME = Read-Host "Enter project name"

if ([string]::IsNullOrWhiteSpace($PROJECT_NAME)) {
    Write-Host "Error: Project name cannot be empty!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Prompt for UI choice
Write-Host ""
Write-Host "Select UI Framework:" -ForegroundColor Yellow
Write-Host "1) Mary UI"
Write-Host "2) Wire UI"
Write-Host "3) TallCraft UI"
Write-Host "4) Sheaf UI"
Write-Host "5) Flowbite"
Write-Host "6) BladewindUI"
$UI_CHOICE = Read-Host "Enter your choice (1-6)"

if ($UI_CHOICE -notmatch '^[1-6]$') {
    Write-Host "Error: Invalid choice!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "Creating Laravel project: $PROJECT_NAME" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan

# Create new Laravel project
composer create-project laravel/laravel $PROJECT_NAME

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to create Laravel project!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Set-Location $PROJECT_NAME

Write-Host ""
Write-Host "Installing Livewire..." -ForegroundColor Green
composer require livewire/livewire

Write-Host ""
Write-Host "Installing Spatie Permissions..." -ForegroundColor Green
composer require spatie/laravel-permission

Write-Host ""
Write-Host "Installing Spatie Activity Log..." -ForegroundColor Green
composer require spatie/laravel-activitylog

Write-Host ""
Write-Host "Installing Tailwind CSS..." -ForegroundColor Green
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

# Install UI Framework
switch ($UI_CHOICE) {
    "1" {
        Write-Host ""
        Write-Host "Installing Mary UI..." -ForegroundColor Green
        composer require robsontenorio/mary
        php artisan mary:install
    }
    "2" {
        Write-Host ""
        Write-Host "Installing Wire UI..." -ForegroundColor Green
        composer require wireui/wireui
        php artisan wireui:install
    }
    "3" {
        Write-Host ""
        Write-Host "Installing TallCraft UI..." -ForegroundColor Green
        composer require developermithu/tallcraftui
        php artisan tallcraftui:install
    }
    "4" {
        Write-Host ""
        Write-Host "Installing Sheaf UI..." -ForegroundColor Green
        composer require sheafui/sheaf
        npm install @sheaf-ui/sheaf
        php artisan sheaf:install
    }
    "5" {
        Write-Host ""
        Write-Host "Installing Flowbite..." -ForegroundColor Green
        npm install flowbite
    }
    "6" {
        Write-Host ""
        Write-Host "Installing BladewindUI..." -ForegroundColor Green
        composer require mkocansey/bladewind
        php artisan vendor:publish --tag=bladewind-public --force
        php artisan vendor:publish --tag=bladewind-config
    }
}

Write-Host ""
Write-Host "Configuring Tailwind CSS..." -ForegroundColor Green

# Update tailwind.config.js based on UI choice
if ($UI_CHOICE -eq "5") {
    # Flowbite configuration
    @"
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./resources/**/*.blade.php",
    "./resources/**/*.js",
    "./resources/**/*.vue",
    "./app/Livewire/**/*.php",
    "./node_modules/flowbite/**/*.js"
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require('flowbite/plugin')
  ],
}
"@ | Out-File -FilePath "tailwind.config.js" -Encoding utf8
} elseif ($UI_CHOICE -eq "6") {
    # BladewindUI configuration
    @"
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./resources/**/*.blade.php",
    "./resources/**/*.js",
    "./resources/**/*.vue",
    "./app/Livewire/**/*.php",
    "./vendor/mkocansey/bladewind/resources/views/**/*.blade.php",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
"@ | Out-File -FilePath "tailwind.config.js" -Encoding utf8
} else {
    # Default configuration for other UI frameworks
    @"
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./resources/**/*.blade.php",
    "./resources/**/*.js",
    "./resources/**/*.vue",
    "./app/Livewire/**/*.php",
    "./vendor/robsontenorio/mary/src/View/Components/**/*.php",
    "./vendor/wireui/wireui/src/*.php",
    "./vendor/wireui/wireui/ts/**/*.ts",
    "./vendor/wireui/wireui/src/WireUi/**/*.php",
    "./vendor/wireui/wireui/src/Components/**/*.php",
    "./vendor/developermithu/tallcraftui/src/**/*.php",
    "./vendor/sheafui/sheaf/src/**/*.php",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
"@ | Out-File -FilePath "tailwind.config.js" -Encoding utf8
}

# Update app.css
@"
@tailwind base;
@tailwind components;
@tailwind utilities;
"@ | Out-File -FilePath "resources/css/app.css" -Encoding utf8

Write-Host ""
Write-Host "Publishing configuration files..." -ForegroundColor Green
php artisan vendor:publish --provider="Spatie\Permission\PermissionServiceProvider"
php artisan vendor:publish --provider="Spatie\Activitylog\ActivitylogServiceProvider" --tag="activitylog-migrations"
php artisan vendor:publish --provider="Spatie\Activitylog\ActivitylogServiceProvider" --tag="activitylog-config"

Write-Host ""
Write-Host "Configuring environment..." -ForegroundColor Green

# Setup .env
if (-not (Test-Path .env)) {
    Copy-Item .env.example .env
    php artisan key:generate
}

$DB_NAME = Read-Host "Enter database name (default: $PROJECT_NAME)"
if ([string]::IsNullOrWhiteSpace($DB_NAME)) {
    $DB_NAME = $PROJECT_NAME
}

$DB_USER = Read-Host "Enter database username (default: root)"
if ([string]::IsNullOrWhiteSpace($DB_USER)) {
    $DB_USER = "root"
}

$DB_PASS = Read-Host "Enter database password" -AsSecureString
$DB_PASS_Plain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($DB_PASS))

# Update .env file - Set MySQL as default database
(Get-Content .env) -replace 'DB_CONNECTION=.*', "DB_CONNECTION=mysql" | Set-Content .env
(Get-Content .env) -replace 'DB_DATABASE=.*', "DB_DATABASE=$DB_NAME" | Set-Content .env
(Get-Content .env) -replace 'DB_USERNAME=.*', "DB_USERNAME=$DB_USER" | Set-Content .env
(Get-Content .env) -replace 'DB_PASSWORD=.*', "DB_PASSWORD=$DB_PASS_Plain" | Set-Content .env

Write-Host ""
Write-Host "Running migrations..." -ForegroundColor Green
php artisan migrate

Write-Host ""
Write-Host "Building assets..." -ForegroundColor Green
npm install
npm run build

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Deployment completed successfully!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Project Location: $(Get-Location)" -ForegroundColor Yellow
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Configure your web server to point to: $(Get-Location)\public"
Write-Host "2. Start development server: php artisan serve"
Write-Host ""
Write-Host "Documentation:" -ForegroundColor Yellow
Write-Host "- Laravel: https://laravel.com/docs"
Write-Host "- Livewire: https://livewire.laravel.com"

switch ($UI_CHOICE) {
    "1" { Write-Host "- Mary UI: https://mary-ui.com" }
    "2" { Write-Host "- Wire UI: https://livewire-wireui.com" }
    "3" { Write-Host "- TallCraft UI: https://tallcraftui.developermithu.com" }
    "4" { Write-Host "- Sheaf UI: https://sheafui.dev" }
    "5" { Write-Host "- Flowbite: https://flowbite.com/docs/getting-started/laravel" }
    "6" { Write-Host "- BladewindUI: https://bladewindui.com/install" }
}

Write-Host "- Spatie Permission: https://spatie.be/docs/laravel-permission"
Write-Host "- Spatie Activity Log: https://spatie.be/docs/laravel-activitylog"
Write-Host ""
Read-Host "Press Enter to exit"
