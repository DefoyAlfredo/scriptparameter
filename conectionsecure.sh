#!/bin/bash

# Instalar UFW
apt-get update
apt-get install ufw -y

# Modificar el archivo sshd_config
sed -i 's/Port 22/Port 2225/' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config
echo "AllowUsers tu_usuario" >> /etc/ssh/sshd_config

# Reiniciar el servicio SSH
service sshd restart

# Reiniciar UFW
ufw enable

# Permitir tráfico por el nuevo puerto
ufw allow 2225/tcp

# Permitir conexión SSH solo al usuario indicado
ufw allow from any to any port 2225 proto tcp

# Solicitar el usuario con permiso de conexión
read -p "Ingresa el usuario con permiso de conexión por SSH: " usuario_permiso
echo "AllowUsers $usuario_permiso" >> /etc/ssh/sshd_config

# Reiniciar el servicio SSH para aplicar los cambios
service sshd restart

echo "Configuración completada. El usuario $usuario_permiso tiene permiso de conexión por SSH."
