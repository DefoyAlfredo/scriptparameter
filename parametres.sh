#!/bin/bash

# Verificar si el usuario actual es root
if [ "$(whoami)" != "root" ]; then
    echo "Este script necesita ser ejecutado como root"
    exit 1
    fi
# Instalar sudo
apt-get update
apt-get install sudo

# Solicitar nombre de usuario a agregar al archivo sudoers
read -p "Ingrese el nombre de usuario a agregar al archivo sudoers: " username

# Agregar usuario al archivo sudoers como root
echo "$username ALL=(ALL:ALL) ALL" >> /etc/sudoers

echo "El usuario $username ha sido agregado al archivo sudoers como root"

# Instalar ufw
echo "Instalando ufw..."
sudo apt update
sudo apt install ufw -y

# Modificar el archivo sshd_config
echo "Modificando el archivo sshd_config..."
sudo sed -i 's/Port 22/Port 2225/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo sed -i '/PermitRootLogin yes/d' /etc/ssh/sshd_config
sudo sed -i '$a AllowUsers usuario' /etc/ssh/sshd_config

# Reiniciar el servicio SSH
echo "Reiniciando el servicio SSH..."
sudo systemctl restart sshd

# Habilitar ufw y permitir el puerto 2225
sudo ufw allow 2225
sudo ufw enable

echo "Configuración completada. Solo el usuario 'usuario' podrá conectar por SSH al servidor."

#!/bin/bash

# Verificar si el usuario actual es root
if [ "$(whoami)" != "root" ]; then
    echo "Este script necesita ser ejecutado como root"
    exit 1
fi

# Instalar sudo
apt-get update
apt-get install sudo

# Solicitar nombre de usuario a agregar al archivo sudoers
read -p "Ingrese el nombre de usuario a agregar al archivo sudoers: " username

# Agregar usuario al archivo sudoers como root
echo "$username ALL=(ALL:ALL) ALL" >> /etc/sudoers

echo "El usuario $username ha sido agregado al archivo sudoers como root"
