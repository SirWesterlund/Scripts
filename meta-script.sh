#!/bin/bash

# DO NOT EDIT THIS SCRIPT 
# IT WILL BE AUTOMATICALLY GENERATED

echo "Cambios realizados:"

# Se ha eliminado el usuario 'csueca'
deluser csueca

# Se ha eliminado el usuario 'aberlanas'
deluser aberlanas

# Se ha creado un nuevo usuario 'jguesseado' con la información:
# - Nombre: Jose Guesser
# - Teléfono: 909999876
# - Correo: timeguesser@champion.co.uk
useradd -m -d "/home/jguesseado" -s "/bin/bash" -u 5004 -c "Jose Guesser, ,909999876, ,timeguesser@champion.co.uk" "jguesseado"
echo "jguesseado:909999876"| chpasswd 

# Se ha cambiado el nombre del usuario 'apepino' a 'Adrian Largo'
chfn -f "Adrian Largo" apepino

# Se ha cambiado el nombre del usuario 'vthin' a 'Viktor Think'
chfn -f "Viktor Think" vthin

# Se ha cambiado el nombre del usuario 'dtanke' a 'Westerlund'
chfn -f "Westerlund" dtanke

# Se ha cambiado el teléfono del usuario 'jmarchante' a '398776543'
chfn -r "398776543" jmarchante

# Se ha cambiado el nombre del usuario 'lautarino' a 'Lautaro Guapeton'
chfn -f "Lautaro Guapeton" lautarino

# Se ha cambiado el teléfono del usuario 'lautarino' a '876666543'
chfn -r "876666543" lautarino

# Se ha cambiado el correo del usuario 'lautarino' a 'leomessi@argentina.ar'
usermod -c "leomessi@argentina.ar" lautarino

