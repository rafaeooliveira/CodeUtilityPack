#!/bin/bash

# ServerAutoRestartLog.sh

# 1. Verificar e instalar o Nano
echo "Verificando e instalando o Nano..."
sudo apt install nano -y

# 2. Navegar até a pasta do servidor
echo "Navegando até a pasta do servidor..."
cd canary || exit

# 3. Criar o script canary.sh
echo "Criando o script canary.sh..."
sudo tee canary.sh > /dev/null <<EOT
#!/bin/bash
ulimit -c unlimited
while true; do
  ./canary 2>&1 | awk '{ print strftime("%F %T - "), \$0; fflush(); }' | tee "logs/\$(date +"%F %H-%M-%S.log")";
done
EOT

# 4. Dar permissão ao script criado
echo "Configurando permissões para o script..."
sudo chmod 775 canary.sh

# 5. Criar pasta para logs do servidor
echo "Criando pasta para logs do servidor..."
sudo mkdir -p logs

# 6. Instalar o Screen
echo "Instalando o Screen..."
sudo apt install screen -y

echo "Tutorial finalizado. Utilize os comandos do Screen para gerenciar o script."

# Instruções para usar o Screen
echo "
Comandos básicos do Screen:
- Para abrir uma nova sessão: screen
- Para sair de uma sessão, mantendo-a em execução: CTRL + A, depois D
- Para retornar à última sessão aberta: screen -r
- Para finalizar uma sessão: CTRL + A, depois :quit
"
