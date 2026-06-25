#!/bin/bash

cd ~/UTN-FRA_SO_Examenes/202406/ansible/
sudo ansible-playbook -i inventory playbook.yml -e "alumno_nombre=Agustin alumno_apellido=DiazMazzotta alumno_division=116"
