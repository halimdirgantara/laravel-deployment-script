#!/bin/bash

# Laravel Deployment Script for Linux
# Author: Your Name
# Date: $(date +%Y-%m-%d)

echo "=========================================="
echo "Laravel Application Deployment Script"
echo "=========================================="
echo ""

# Prompt for project name
read -p "Enter project name: " PROJECT_NAME

if [ -z "$PROJECT_NAME" ]; then
    echo "Error: Project name cannot be empty!"
    exit 1
fi

# Prompt for UI choice
echo ""
echo "Select UI Framework:"
echo "1) Mary UI"
echo "2) Wire UI"
echo "3) TallCraft UI"
echo "4) Sheaf UI"
echo "5) Flowbite"
echo "6) BladewindUI"
read -p "Enter your choice (1-6): " UI_CHOICE

if [ "$UI_CHOICE" -lt "1" ] || [ "$UI_CHOICE" -gt "6" ]; then
    echo "Error: Invalid choice!"
    exit 1
fi

echo ""
echo "Creating Laravel project: $PROJECT_NAME"
echo "=========================================="

# Create new Laravel project
composer create-project laravel/laravel "$PROJECT_NAME"

if [ $? -ne 0 ]; then
    echo "Error: Failed to create Laravel project!"
    exit 1
fi

cd "$PROJECT_NAME"

echo ""
echo "Installing Livewire..."
composer require livewire/livewire

echo ""
echo "Installing Spatie Permissions..."
composer require spatie/laravel-permission

echo ""
echo "Installing Spatie Activity Log..."
composer require spatie/laravel-activitylog

echo ""
echo "Installing Tailwind CSS..."
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

# Install UI Framework
if [ "$UI_CHOICE" == "1" ]; then
    echo ""
    echo "Installing Mary UI..."
    composer require robsontenorio/mary
    php artisan mary:install
else
    echo ""
    echo "Installing Wire UI..."
    composer require wireui/wireui
    php artisan wireui:install
fi

echo ""
echo "Configuring Tailwind CSS..."

# Update tailwind.config.js
cat > tailwind.config.js << 'EOF'
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
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOF

# Update app.css
cat > resources/css/app.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

echo ""
echo "Publishing configuration files..."
php artisan vendor:publish --provider="Spatie\Permission\PermissionServiceProvider"
php artisan vendor:publish --provider="Spatie\Activitylog\ActivitylogServiceProvider" --tag="activitylog-migrations"
php artisan vendor:publish --provider="Spatie\Activitylog\ActivitylogServiceProvider" --tag="activitylog-config"

echo ""
echo "Configuring environment..."

# Setup .env
if [ ! -f .env ]; then
    cp .env.example .env
    php artisan key:generate
fi

read -p "Enter database name (default: $PROJECT_NAME): " DB_NAME
DB_NAME=${DB_NAME:-$PROJECT_NAME}

read -p "Enter database username (default: root): " DB_USER
DB_USER=${DB_USER:-root}

read -sp "Enter database password: " DB_PASS
echo ""

# Update .env file - Set MySQL as default database
sed -i "s/DB_CONNECTION=.*/DB_CONNECTION=mysql/" .env
sed -i "s/DB_DATABASE=.*/DB_DATABASE=$DB_NAME/" .env
sed -i "s/DB_USERNAME=.*/DB_USERNAME=$DB_USER/" .env
sed -i "s/DB_PASSWORD=.*/DB_PASSWORD=$DB_PASS/" .env

echo ""
echo "Running migrations..."
php artisan migrate

echo ""
echo "Building assets..."
npm install
npm run build

echo ""
echo "=========================================="
echo "Deployment completed successfully!"
echo "=========================================="
echo ""
echo "Project Location: $(pwd)"
echo ""
echo "Next steps:"
echo "1. Configure your web server to point to: $(pwd)/public"
echo "2. Set proper permissions: sudo chown -R www-data:www-data storage bootstrap/cache"
echo "3. Start development server: php artisan serve"
echo ""
echo "Documentation:"
echo "- Laravel: https://laravel.com/docs"
echo "- Livewire: https://livewire.laravel.com"
if [ "$UI_CHOICE" == "1" ]; then
    echo "- Mary UI: https://mary-ui.com"
else
    echo "- Wire UI: https://livewire-wireui.com"
fi
echo "- Spatie Permission: https://spatie.be/docs/laravel-permission"
echo "- Spatie Activity Log: https://spatie.be/docs/laravel-activitylog"
echo ""