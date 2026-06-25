sudo apt update
sudo apt install git -y
whoami
cd ~
pwd
sudo apt update
exit
whoami
groups
sudo whoami
sudo apt update
sudo apt install git -y
git --version
sudo apt update
sudo apt install wget gpg
UBUNTU_CODENAME=jammy
wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | sudo gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/ansible.list
sudo apt update && sudo apt install ansible
ansible --version
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl status docker
sudo docker run hello-world
cd ~
git clone https://github.com/upszot/UTN-FRA_SO_Examenes.git
ls
./UTN-FRA_SO_Examenes/202406/script_Precondicion.sh
source ~/.bashrc
git clone https://github.com/agustingustavodiazmazzotta/UTNFRA_SO_2do_TP_Mazzotta.git
ls -l
cd UTNFRA_SO_2do_TP_Mazzotta/
ls -l
sudo fdisk /dev/sdb
sudo fdisk /dev/sdd
lsblk
sudo pvcreate /dev/sdb1
sudo pvcreate /dev/sdd1
sudo pvs
sudo vgcreate vg_datos /dev/sdb1
sudo vgcreate vg_temp /dev/sdd1
sudo vgs
sudo lvcreate -L 5M    -n lv_docker    vg_datos
sudo lvcreate -L 1.5G  -n lv_workareas vg_datos
sudo lvcreate -L 512M  -n lv_swap      vg_temp
sudo lvs
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_docker
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_workareas
sudo mkswap    /dev/mapper/vg_temp-lv_swap
sudo mkdir -p /var/lib/docker
sudo mkdir -p /work
sudo mount /dev/mapper/vg_datos-lv_docker    /var/lib/docker
sudo mount /dev/mapper/vg_datos-lv_workareas /work
sudo swapon /dev/mapper/vg_temp-lv_swap
echo "/dev/mapper/vg_datos-lv_docker    /var/lib/docker  ext4  defaults  0 2" | sudo tee -a /etc/fstab
echo "/dev/mapper/vg_datos-lv_workareas /work            ext4  defaults  0 2" | sudo tee -a /etc/fstab
echo "/dev/mapper/vg_temp-lv_swap       none             swap  sw        0 0" | sudo tee -a /etc/fstab
sudo mount -a
sudo pvs && sudo vgs && sudo lvs
df -h /var/lib/docker /work
swapon --show
sudo systemctl restart docker
sudo systemctl status docker
ls -l
cd 
mv RTA_Examen_20260625/ UTNFRA_SO_2do_TP_Mazzotta/
ls -l
cd UTNFRA_SO_2do_TP_Mazzotta/
cd RTA_Examen_20260625/ 
ls -l
sudo vim Punto_A.sh
cd ..
git add .
git commit -m "ADD: Punto_A.sh"
git push
cat ~/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt
#!/bin/bash
USUARIO_REF=$1
LISTA=$2
if [[ -z "$USUARIO_REF" || -z "$LISTA" ]]; then echo "Uso: $0 <usuario_referencia> <path_lista_usuarios>"; exit 1; fi
nano ~/RTA_Examen_$(date +%Y%m%d)/MazzottaAltaUser-Groups.sh
nano ~/UTNFRA_SO_2do_TP_Mazzotta/RTA_Examen_20260625/MazzottaAltaUser-Groups.sh
sudo cp ~/UTNFRA_SO_2do_TP_Mazzotta/RTA_Examen_20260625/MazzottaAltaUser-Groups.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/MazzottaAltaUser-Groups.sh
sudo /usr/local/bin/MazzottaAltaUser-Groups.sh amazzotta ~/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt
nano ~/UTNFRA_SO_2do_TP_Mazzotta/RTA_Examen_20260625/Punto_B.sh
cd ~/UTNFRA_SO_2do_TP_Mazzotta
git add .
git commit -m "ADD: Punto_B.sh y MazzottaAltaUser-Groups.sh"
git push
ls ~/UTN-FRA_SO_Examenes/202406/docker/
cat ~/UTN-FRA_SO_Examenes/202406/docker/index.html
nano ~/UTN-FRA_SO_Examenes/202406/docker/index.html
cat ~/UTN-FRA_SO_Examenes/202406/docker/index.html
cat > ~/UTN-FRA_SO_Examenes/202406/docker/Dockerfile << 'EOF'
FROM nginx
COPY index.html /usr/share/nginx/html/index.html
EOF

cd ~/UTN-FRA_SO_Examenes/202406/docker/
docker build -t agustingustavodiazmazzotta/web1-mazzotta .
sudo docker build -t agustingustavodiazmazzotta/web1-mazzotta .
sudo docker run -d -p 8080:80 --name web1-test agustingustavodiazmazzotta/web1-mazzotta
sudo docker ps
sudo docker login
sudo docker push agustingustavodiazmazzotta/web1-mazzotta
cat > ~/UTN-FRA_SO_Examenes/202406/docker/run.sh << 'EOF'
#!/bin/bash
sudo docker run -d -p 8080:80 --name web1-mazzotta agustingustavodiazmazzotta/web1-mazzotta
EOF

cat > ~/UTNFRA_SO_2do_TP_Mazzotta/RTA_Examen_20260625/Punto_C.sh << 'EOF'
#!/bin/bash

cd ~/UTN-FRA_SO_Examenes/202406/docker/
sudo docker build -t agustingustavodiazmazzotta/web1-mazzotta .
sudo docker run -d -p 8080:80 --name web1-mazzotta agustingustavodiazmazzotta/web1-mazzotta
sudo docker login
sudo docker push agustingustavodiazmazzotta/web1-mazzotta
EOF

cd ~/UTNFRA_SO_2do_TP_Mazzotta
git add .
git commit -m "ADD: Punto_C.sh"
git push
ls ~/UTN-FRA_SO_Examenes/202406/ansible/
cat ~/UTN-FRA_SO_Examenes/202406/ansible/playbook.yml
ls ~/UTN-FRA_SO_Examenes/202406/ansible/roles/2do_parcial/
ls ~/UTN-FRA_SO_Examenes/202406/ansible/roles/2do_parcial/tasks/
cat ~/UTN-FRA_SO_Examenes/202406/ansible/roles/2do_parcial/tasks/main.yml
ls ~/UTN-FRA_SO_Examenes/202406/ansible/roles/2do_parcial/
mkdir ~/UTN-FRA_SO_Examenes/202406/ansible/roles/2do_parcial/templates
cat > ~/UTN-FRA_SO_Examenes/202406/ansible/roles/2do_parcial/templates/datos_alumno.j2 << 'EOF'
Nombre: {{ alumno_nombre }} Apellido: {{ alumno_apellido }}
Division: {{ alumno_division }}
EOF

cat > ~/UTN-FRA_SO_Examenes/202406/ansible/roles/2do_parcial/templates/datos_equipo.j2 << 'EOF'
IP: {{ ansible_default_ipv4.address }}
Distribución: {{ ansible_distribution }} {{ ansible_distribution_version }}
Cantidad de Cores: {{ ansible_processor_vcpus }}
EOF

cat > ~/UTN-FRA_SO_Examenes/202406/ansible/roles/2do_parcial/tasks/main.yml << 'EOF'
---
- name: Crear estructura de directorios
  file:
    path: "{{ item }}"
    state: directory
    mode: '0755'
  loop:
    - /tmp/2do_parcial/alumno
    - /tmp/2do_parcial/equipo

- name: Generar datos_alumno.txt
  template:
    src: datos_alumno.j2
    dest: /tmp/2do_parcial/alumno/datos_alumno.txt

- name: Generar datos_equipo.txt
  template:
    src: datos_equipo.j2
    dest: /tmp/2do_parcial/equipo/datos_equipo.txt

- name: Configurar sudoers para grupo 2PSupervisores
  copy:
    dest: /etc/sudoers.d/2PSupervisores
    content: "%2PSupervisores ALL=(ALL) NOPASSWD: ALL\n"
    mode: '0440'
    validate: /usr/sbin/visudo -cf %s
EOF

cat ~/UTN-FRA_SO_Examenes/202406/ansible/inventory
ls ~/UTN-FRA_SO_Examenes/202406/ansible/inventory/
cat ~/UTN-FRA_SO_Examenes/202406/ansible/inventory/hosts
cd ~/UTN-FRA_SO_Examenes/202406/ansible/
sudo ansible-playbook -i inventory playbook.yml -e "alumno_nombre=AgustinGustavo alumno_apellido=DiazMazzotta alumno_division=116"
cat /tmp/2do_parcial/alumno/datos_alumno.txt
cat /tmp/2do_parcial/equipo/datos_equipo.txt
cat > ~/UTNFRA_SO_2do_TP_Mazzotta/RTA_Examen_20260625/Punto_D.sh << 'EOF'
#!/bin/bash

cd ~/UTN-FRA_SO_Examenes/202406/ansible/
sudo ansible-playbook -i inventory playbook.yml -e "alumno_nombre=Agustin alumno_apellido=DiazMazzotta alumno_division=116"
EOF

cd ~/UTNFRA_SO_2do_TP_Mazzotta
cp -r ~/UTN-FRA_SO_Examenes/202406 .
git add .
git commit -m "ADD: Punto_D.sh y carpeta 202406"
git push
history -a
