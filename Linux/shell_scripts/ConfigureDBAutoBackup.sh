#!/bin/bash

# Auto Backup Server Database Setup Script

echo "1. Installing Nano Editor (if not already installed)..."
sudo apt install nano -y

# Defina as variáveis conforme necessário
USER="your_username" # Substitua pelo seu nome de usuário
SERVER_ROOT_FOLDER="canary" # Substitua pelo nome da pasta raiz do seu servidor

echo "2. Navigating to the desired script directory..."
cd /home/$USER/$SERVER_ROOT_FOLDER || exit

echo "3. Creating the backup-database.sh script..."
cat <<EOT >> backup-database.sh
#!/bin/bash

# Configuração do script de backup
path="/home/$USER/database-backup"  # Caminho para o backup do banco de dados
nameBackup="prod-oracle"            # Ambiente onde está hospedado
mysqlUser="XX"                      # Seu usuário MySQL
mysqlPass="XX"                      # Sua senha MySQL
mysqlDatabase="XX"                  # Nome do seu banco de dados

TIMER="\$(date +'%d-%m-%Y-%H-%M')"

if [[ -z "\$mysqlUser" || -z "\$mysqlPass" || -z "\$mysqlDatabase" ]]; then
    echo "Por favor, preencha usuário, senha e banco de dados nas configurações."
else
    mysqldump -u\$mysqlUser -p\$mysqlPass \$mysqlDatabase > \$path"/"\$nameBackup".sql" &&
    cd \$path &&
    git add . &&
    git commit -m "Backup uploaded automatically '\$nameBackup'" &&
    git push &&
    echo "Backup Complete."
fi
EOT

echo "4. Giving execution permissions to the script..."
chmod +x backup-database.sh

echo "5. Adding script to crontab for automatic execution..."
# Nota: Modifique os cron jobs conforme necessário
(crontab -l 2>/dev/null; echo "0 5,23 * * * /home/$USER/$SERVER_ROOT_FOLDER/backup-database.sh") | crontab -

echo "Setup complete. The backup script has been added to crontab for automatic execution."
