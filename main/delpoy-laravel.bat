@echo off
REM Laravel Deployment Script for Windows (Batch)
REM Author: Your Name
REM Date: %date%

COLOR 0B
echo ==========================================
echo Laravel Application Deployment Script
echo ==========================================
echo.

REM Prompt for project name
set /p PROJECT_NAME="Enter project name: "

if "%PROJECT_NAME%"=="" (
    COLOR 0C
    echo Error: Project name cannot be empty!
    pause
    exit /b 1
)

REM Prompt for UI choice
echo.
COLOR 0E
echo Select UI Framework:
COLOR 0F
echo 1) Mary UI
echo 2) Wire UI
echo 3) TallCraft UI
echo 4) Sheaf UI
echo 5) Flowbite
echo 6) BladewindUI
echo 7) Multiple UI (Install all frameworks)
COLOR 0E
set /p UI_CHOICE="Enter your choice (1-7): "
COLOR 0F

if "%UI_CHOICE%"=="" (
    COLOR 0C
    echo Error: Invalid choice!
    pause
    exit /b 1
)

if %UI_CHOICE% LSS 1 (
    COLOR 0C
    echo Error: Invalid choice!
    pause
    exit /b 1
)

if %UI_CHOICE% GTR 7 (
    COLOR 0C
    echo Error: Invalid choice!
    pause
    exit /b 1
)

echo.
COLOR 0A
echo Creating Laravel project: %PROJECT_NAME%
echo ==========================================
COLOR 0F

REM Create new Laravel project
call composer create-project laravel/laravel "%PROJECT_NAME%"

if errorlevel 1 (
    COLOR 0C
    echo Error: Failed to create Laravel project!
    pause
    exit /b 1
)

cd "%PROJECT_NAME%"

echo.
COLOR 0A
echo Installing Livewire...
COLOR 0F
call composer require livewire/livewire

echo.
COLOR 0A
echo Installing Spatie Permissions...
COLOR 0F
call composer require spatie/laravel-permission

echo.
COLOR 0A
echo Installing Spatie Activity Log...
COLOR 0F
call composer require spatie/laravel-activitylog

echo.
COLOR 0A
echo Installing Tailwind CSS...
COLOR 0F
call npm install -D tailwindcss postcss autoprefixer
call npx tailwindcss init -p

REM Install UI Framework(s)
if "%UI_CHOICE%"=="1" (
    echo.
    COLOR 0A
    echo Installing Mary UI...
    COLOR 0F
    call composer require robsontenorio/mary
    call php artisan mary:install
) else if "%UI_CHOICE%"=="2" (
    echo.
    COLOR 0A
    echo Installing Wire UI...
    COLOR 0F
    call composer require wireui/wireui
    call php artisan wireui:install
) else if "%UI_CHOICE%"=="3" (
    echo.
    COLOR 0A
    echo Installing TallCraft UI...
    COLOR 0F
    call composer require developermithu/tallcraftui
    call php artisan tallcraftui:install
) else if "%UI_CHOICE%"=="4" (
    echo.
    COLOR 0A
    echo Installing Sheaf UI...
    COLOR 0F
    call composer require sheafui/sheaf
    call npm install @sheaf-ui/sheaf
    call php artisan sheaf:install
) else if "%UI_CHOICE%"=="5" (
    echo.
    COLOR 0A
    echo Installing Flowbite...
    COLOR 0F
    call npm install flowbite
) else if "%UI_CHOICE%"=="6" (
    echo.
    COLOR 0A
    echo Installing BladewindUI...
    COLOR 0F
    call composer require mkocansey/bladewind
    call php artisan vendor:publish --tag=bladewind-public --force
    call php artisan vendor:publish --tag=bladewind-config
) else if "%UI_CHOICE%"=="7" (
    echo.
    COLOR 0A
    echo Installing Multiple UI Frameworks...
    COLOR 0F
    echo.
    echo [1/6] Installing Mary UI...
    call composer require robsontenorio/mary
    call php artisan mary:install
    
    echo.
    echo [2/6] Installing Wire UI...
    call composer require wireui/wireui
    call php artisan wireui:install
    
    echo.
    echo [3/6] Installing TallCraft UI...
    call composer require developermithu/tallcraftui
    call php artisan tallcraftui:install
    
    echo.
    echo [4/6] Installing Sheaf UI...
    call composer require sheafui/sheaf
    call npm install @sheaf-ui/sheaf
    call php artisan sheaf:install
    
    echo.
    echo [5/6] Installing Flowbite...
    call npm install flowbite
    
    echo.
    echo [6/6] Installing BladewindUI...
    call composer require mkocansey/bladewind
    call php artisan vendor:publish --tag=bladewind-public --force
    call php artisan vendor:publish --tag=bladewind-config
    
    COLOR 0A
    echo.
    echo All UI frameworks installed successfully!
    COLOR 0F
)

echo.
COLOR 0A
echo Configuring Tailwind CSS...
COLOR 0F

REM Update tailwind.config.js based on UI choice
if "%UI_CHOICE%"=="5" (
    REM Flowbite only configuration
    (
    echo /** @type {import('tailwindcss'^).Config} */
    echo export default {
    echo   content: [
    echo     "./resources/**/*.blade.php",
    echo     "./resources/**/*.js",
    echo     "./resources/**/*.vue",
    echo     "./app/Livewire/**/*.php",
    echo     "./node_modules/flowbite/**/*.js"
    echo   ],
    echo   theme: {
    echo     extend: {},
    echo   },
    echo   plugins: [
    echo     require('flowbite/plugin'^)
    echo   ],
    echo }
    ) > tailwind.config.js
) else if "%UI_CHOICE%"=="6" (
    REM BladewindUI only configuration
    (
    echo /** @type {import('tailwindcss'^).Config} */
    echo export default {
    echo   content: [
    echo     "./resources/**/*.blade.php",
    echo     "./resources/**/*.js",
    echo     "./resources/**/*.vue",
    echo     "./app/Livewire/**/*.php",
    echo     "./vendor/mkocansey/bladewind/resources/views/**/*.blade.php",
    echo   ],
    echo   theme: {
    echo     extend: {},
    echo   },
    echo   plugins: [],
    echo }
    ) > tailwind.config.js
) else if "%UI_CHOICE%"=="7" (
    REM Multiple UI - All frameworks configuration
    (
    echo /** @type {import('tailwindcss'^).Config} */
    echo export default {
    echo   content: [
    echo     "./resources/**/*.blade.php",
    echo     "./resources/**/*.js",
    echo     "./resources/**/*.vue",
    echo     "./app/Livewire/**/*.php",
    echo     "./vendor/robsontenorio/mary/src/View/Components/**/*.php",
    echo     "./vendor/wireui/wireui/src/*.php",
    echo     "./vendor/wireui/wireui/ts/**/*.ts",
    echo     "./vendor/wireui/wireui/src/WireUi/**/*.php",
    echo     "./vendor/wireui/wireui/src/Components/**/*.php",
    echo     "./vendor/developermithu/tallcraftui/src/**/*.php",
    echo     "./vendor/sheafui/sheaf/src/**/*.php",
    echo     "./vendor/mkocansey/bladewind/resources/views/**/*.blade.php",
    echo     "./node_modules/flowbite/**/*.js"
    echo   ],
    echo   theme: {
    echo     extend: {},
    echo   },
    echo   plugins: [
    echo     require('flowbite/plugin'^)
    echo   ],
    echo }
    ) > tailwind.config.js
) else (
    REM Default configuration for single UI frameworks
    (
    echo /** @type {import('tailwindcss'^).Config} */
    echo export default {
    echo   content: [
    echo     "./resources/**/*.blade.php",
    echo     "./resources/**/*.js",
    echo     "./resources/**/*.vue",
    echo     "./app/Livewire/**/*.php",
    echo     "./vendor/robsontenorio/mary/src/View/Components/**/*.php",
    echo     "./vendor/wireui/wireui/src/*.php",
    echo     "./vendor/wireui/wireui/ts/**/*.ts",
    echo     "./vendor/wireui/wireui/src/WireUi/**/*.php",
    echo     "./vendor/wireui/wireui/src/Components/**/*.php",
    echo     "./vendor/developermithu/tallcraftui/src/**/*.php",
    echo     "./vendor/sheafui/sheaf/src/**/*.php",
    echo   ],
    echo   theme: {
    echo     extend: {},
    echo   },
    echo   plugins: [],
    echo }
    ) > tailwind.config.js
)

REM Update app.css
(
echo @tailwind base;
echo @tailwind components;
echo @tailwind utilities;
) > resources\css\app.css

echo.
COLOR 0A
echo Publishing configuration files...
COLOR 0F
call php artisan vendor:publish --provider="Spatie\Permission\PermissionServiceProvider"
call php artisan vendor:publish --provider="Spatie\Activitylog\ActivitylogServiceProvider" --tag="activitylog-migrations"
call php artisan vendor:publish --provider="Spatie\Activitylog\ActivitylogServiceProvider" --tag="activitylog-config"

echo.
COLOR 0A
echo Configuring environment...
COLOR 0F

REM Setup .env
if not exist .env (
    copy .env.example .env
    call php artisan key:generate
)

set /p DB_NAME="Enter database name (default: %PROJECT_NAME%): "
if "%DB_NAME%"=="" set DB_NAME=%PROJECT_NAME%

set /p DB_USER="Enter database username (default: root): "
if "%DB_USER%"=="" set DB_USER=root

set /p DB_PASS="Enter database password: "

REM Update .env file using PowerShell
powershell -Command "(Get-Content .env) -replace 'DB_DATABASE=.*', 'DB_DATABASE=%DB_NAME%' | Set-Content .env"
powershell -Command "(Get-Content .env) -replace 'DB_USERNAME=.*', 'DB_USERNAME=%DB_USER%' | Set-Content .env"
powershell -Command "(Get-Content .env) -replace 'DB_PASSWORD=.*', 'DB_PASSWORD=%DB_PASS%' | Set-Content .env"

echo.
COLOR 0A
echo Running migrations...
COLOR 0F
call php artisan migrate

echo.
COLOR 0A
echo Building assets...
COLOR 0F
call npm install
call npm run build

echo.
COLOR 0B
echo ==========================================
COLOR 0A
echo Deployment completed successfully!
COLOR 0B
echo ==========================================
COLOR 0F
echo.
COLOR 0E
echo Project Location: %CD%
COLOR 0F
echo.
echo Next steps:
echo 1. Configure your web server to point to: %CD%\public
echo 2. Start development server: php artisan serve
echo.
COLOR 0E
echo Documentation:
COLOR 0F
echo - Laravel: https://laravel.com/docs
echo - Livewire: https://livewire.laravel.com

if "%UI_CHOICE%"=="1" (
    echo - Mary UI: https://mary-ui.com
) else if "%UI_CHOICE%"=="2" (
    echo - Wire UI: https://livewire-wireui.com
) else if "%UI_CHOICE%"=="3" (
    echo - TallCraft UI: https://tallcraftui.developermithu.com
) else if "%UI_CHOICE%"=="4" (
    echo - Sheaf UI: https://sheafui.dev
) else if "%UI_CHOICE%"=="5" (
    echo - Flowbite: https://flowbite.com/docs/getting-started/laravel
) else if "%UI_CHOICE%"=="6" (
    echo - BladewindUI: https://bladewindui.com/install
) else if "%UI_CHOICE%"=="7" (
    echo - Mary UI: https://mary-ui.com
    echo - Wire UI: https://livewire-wireui.com
    echo - TallCraft UI: https://tallcraftui.developermithu.com
    echo - Sheaf UI: https://sheafui.dev
    echo - Flowbite: https://flowbite.com/docs/getting-started/laravel
    echo - BladewindUI: https://bladewindui.com/install
)

echo - Spatie Permission: https://spatie.be/docs/laravel-permission
echo - Spatie Activity Log: https://spatie.be/docs/laravel-activitylog
echo.
COLOR 0A
if "%UI_CHOICE%"=="7" (
    echo NOTE: All UI frameworks are installed. You can use any combination in your project!
    echo.
)
COLOR 0F
pause
