# Laravel Deployment Scripts

Automated deployment scripts for creating new Laravel applications with pre-configured packages and UI frameworks.

## 🚀 Features

- **Laravel** - Latest version installation
- **Livewire** - Full-stack framework for Laravel
- **Tailwind CSS** - Utility-first CSS framework
- **Spatie Permission** - Role and permission management
- **Spatie Activity Log** - Log user activities
- **Multiple UI Frameworks** - Choose from 6 different UI libraries

## 📦 Included Packages

| Package | Description |
|---------|-------------|
| [Laravel](https://laravel.com) | PHP web application framework |
| [Livewire](https://livewire.laravel.com) | Dynamic interfaces without leaving PHP |
| [Tailwind CSS](https://tailwindcss.com) | Utility-first CSS framework |
| [Spatie Permission](https://spatie.be/docs/laravel-permission) | Role-based access control |
| [Spatie Activity Log](https://spatie.be/docs/laravel-activitylog) | Activity logging system |

## 🎨 UI Framework Options

Choose one of these UI frameworks during installation:

1. **[Mary UI](https://mary-ui.com)** - Gorgeous Laravel Blade UI Components made for Livewire 3
2. **[Wire UI](https://livewire-wireui.com)** - Heroicons-based components for Livewire
3. **[TallCraft UI](https://tallcraftui.developermithu.com)** - Modern TALL stack components
4. **[Sheaf UI](https://sheafui.dev)** - Elegant UI components with CLI installation
5. **[Flowbite](https://flowbite.com/docs/getting-started/laravel)** - Popular Tailwind CSS component library
6. **[BladewindUI](https://bladewindui.com)** - Beautiful Blade components

## 📋 Prerequisites

Before running the scripts, ensure you have the following installed:

- **PHP** >= 8.1
- **Composer** - [Download here](https://getcomposer.org/download/)
- **Node.js** >= 16.x and **NPM** - [Download here](https://nodejs.org/)
- **Database** (MySQL, PostgreSQL, SQLite, or SQL Server)

### Verify Installation

```bash
php --version
composer --version
node --version
npm --version
```

## 🐧 Linux Installation

### 1. Download the Script

```bash
curl -O https://raw.githubusercontent.com/halimdirgantara/laravel-deploy-scripts/main/deploy-laravel.sh
```

Or clone the repository:

```bash
git clone https://github.com/halimdirgantara/laravel-deploy-scripts.git
cd laravel-deploy-scripts
```

### 2. Make Script Executable

```bash
chmod +x deploy-laravel.sh
```

### 3. Run the Script

```bash
./deploy-laravel.sh
```

### 4. Follow the Prompts

- Enter your project name
- Select UI framework (1-6)
- Configure database credentials
- Wait for installation to complete

## 🪟 Windows Installation

You can use either the **Batch Script** or **PowerShell Script**:

### Option A: Using Batch Script (.bat)

#### 1. Download the Script

Download `deploy-laravel.bat` from the repository or create it manually.

#### 2. Run the Script

Double-click the file or run from Command Prompt:

```cmd
deploy-laravel.bat
```

### Option B: Using PowerShell Script (.ps1) - Recommended

#### 1. Download the Script

Download `deploy-laravel.ps1` from the repository.

#### 2. Enable Script Execution (First Time Only)

Open PowerShell as Administrator and run:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### 3. Run the Script

Right-click the script and select "Run with PowerShell" or:

```powershell
.\deploy-laravel.ps1
```

### 4. Follow the Prompts

- Enter your project name
- Select UI framework (1-6)
- Configure database credentials
- Wait for installation to complete

## 🗄️ Database Setup

### Create Database

Before running the script, create a database:

**MySQL/MariaDB:**
```sql
CREATE DATABASE your_project_name;
```

**PostgreSQL:**
```sql
CREATE DATABASE your_project_name;
```

**SQLite:**
No setup needed, just use the file path.

## 🎯 What the Script Does

1. ✅ Creates a new Laravel project
2. ✅ Installs Livewire
3. ✅ Installs and configures Tailwind CSS
4. ✅ Installs Spatie Permission package
5. ✅ Installs Spatie Activity Log package
6. ✅ Installs your chosen UI framework
7. ✅ Configures Tailwind for the selected UI
8. ✅ Publishes vendor configurations
9. ✅ Sets up environment variables
10. ✅ Runs database migrations
11. ✅ Builds frontend assets

## 🔧 Post-Installation

### 1. Start Development Server

```bash
cd your-project-name
php artisan serve
```

Visit: `http://localhost:8000`

### 2. Configure Permissions (Linux)

```bash
sudo chown -R www-data:www-data storage bootstrap/cache
sudo chmod -R 775 storage bootstrap/cache
```

### 3. Set Production Environment

For production deployment, update `.env`:

```env
APP_ENV=production
APP_DEBUG=false
```

Run optimization:

```bash
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

## 📚 Documentation Links

- [Laravel Documentation](https://laravel.com/docs)
- [Livewire Documentation](https://livewire.laravel.com)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [Spatie Permission Documentation](https://spatie.be/docs/laravel-permission)
- [Spatie Activity Log Documentation](https://spatie.be/docs/laravel-activitylog)

## 🐛 Troubleshooting

### Common Issues

**Issue: Composer not found**
```bash
# Install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

**Issue: npm not found**
```bash
# Install Node.js and npm
# Visit: https://nodejs.org/
```

**Issue: Permission denied (Linux)**
```bash
chmod +x deploy-laravel.sh
```

**Issue: PowerShell script won't run (Windows)**
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**Issue: Database connection failed**
- Verify database credentials in `.env`
- Ensure database server is running
- Check database exists

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is open-sourced software licensed under the [MIT license](LICENSE).

## 👨‍💻 Author

Your Name - [@yourhandle](https://twitter.com/yourhandle)

## ⭐ Support

If you find this project helpful, please give it a star!

---

**Happy Coding! 🚀**
