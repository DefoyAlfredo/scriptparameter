#!/bin/bash

# Verificar si el usuario actual es root
if [ "$(whoami)" != "root" ]; then
    echo "Este script necesita ser ejecutado como root"
    exit 1
fi

# Instalar sudo
apt-get update
apt-get install -y sudo

# Solicitar nombre de usuario a agregar al archivo sudoers
read -p "Ingrese el nombre de usuario a agregar al archivo sudoers: " username

# Agregar usuario al archivo sudoers como root
echo "$username ALL=(ALL:ALL) ALL" >> /etc/sudoers

echo "El usuario $username ha sido agregado al archivo sudoers como root"
