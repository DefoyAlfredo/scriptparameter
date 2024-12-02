#!/bin/bash

# Verificar si el usuario actual es root
if [ "$(whoami)" != "root" ]; then
    echo "Este script necesita ser ejecutado como root"
    exit 1
fi

# Instalar UFW
pacman -Sy --noconfirm ufw

# Modificar el archivo sshd_config
sed -i 's/#Port 22/Port 2225/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Solicitar el usuario con permiso de conexión
read -p "Ingresa el usuario con permiso de conexión por SSH: " usuario_permiso

# Verificar si el usuario existe en el sistema
if id "$usuario_permiso" &>/dev/null; then
    echo "AllowUsers $usuario_permiso" >> /etc/ssh/sshd_config
else
    echo "El usuario $usuario_permiso no existe"
    exit 1
fi

# Reiniciar el servicio SSH
systemctl restart sshd

# Habilitar UFW
ufw enable

# Permitir tráfico por el nuevo puerto
ufw allow 2225/tcp

# Permitir conexión SSH solo al usuario indicado
ufw allow from any to any port 2225 proto tcp

# Reiniciar el servicio SSH para aplicar los cambios
systemctl restart sshd

echo "Configuración completada. El usuario $usuario_permiso tiene permiso de conexión por SSH."
