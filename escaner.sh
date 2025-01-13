#!/bin/bash 

#colores 
verde="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
red="\e[0;31m\033[1m"
azul="\e[0;34m\033[1m"
amarillo="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquesa="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"


trap ctrl_c INT

function ctrl_c(){
	echo -e "\n\n${red}[!]${endColour}${gray} Saliendo...\n${endColour}"
  exit 0
}


sleep 3

#UDP 

output_udp=$(ss -l | grep -i "listen" | grep "u_str" | awk '{print $1$2$6}'| sed 's/\([a-z]\)\([A-Z0-9]\)/\1 \2/g' | sed 's/\([a-zA-Z]\)\([0-9]\)/\1 \2/g')

protocolo_u=$(echo -e "$output_udp" | awk '{print $1}')
estado_l=$(echo -e "$output_udp" | awk '{print $2}')
puerto_p=$(echo -e "$output_udp" | awk '{print $3}')

num_lines=$(echo "$protocolo_u" | wc -l)

# Iterar sobre cada línea y mostrar en tres columnas
for ((i=1; i<=$num_lines; i++)); do
    echo -e "${amarillo}[+]${endColour}Puerto:${gray} $(echo "$puerto_p" | sed -n "${i}p") ${endColour}${verde} $(echo "$estado_l" | sed -n "${i}p") ${endColour} --> ${gray} $(echo "$protocolo_u" | sed -n "${i}p") ${endColour}"
done



# Modelo TCP
output=$(ss -l | grep "tcp" | grep -i "listen" | awk '{print $1$2$5}' | sed 's/\([a-z]\)\([A-Z0-9]\)/\1 \2/g' | sed 's/\([a-zA-Z]\)\([0-9]\)/\1 \2/g' | sed 's/\([A-Z]\)\(\[\)/\1 \2/g' | sed -e 's/\[\|\]/ /g' -e 's/:/ : /' | sed 's/://g' | grep -v "ipp") 

protocolo=$(echo -e "$output" | awk '{print $1}')
estado=$(echo -e "$output" | awk '{print $2}')
ip=$(echo -e "$output" | awk '{print $3}')
puerto=$(echo -e "$output" | awk '{print $4}')

echo -e "${amarillo}[+]${endColour}Puerto: ${gray}$puerto${endColour}  ${verde}$estado${endColour} --> ${gray}$protocolo${endColour}"
