#!/bin/bash

TEXT='\033[0;33m'
MENU='\033[1;33m'
PROMPT='\033[0;34m'
NC='\033[0m'
FILE=~/.reMarkable-template-installer
KEYFILE=~/.ssh/id_rsa_reMarkable

echo -e "😄  reMarkable Template Installer v0.1\n"

if ! command -v jq &> /dev/null
then
    echo "✋  Du må installere kommandolinjeverktøyet 'jq' for å fortsette"
    exit 1
fi

# Lag en pause slik at brukeren kan gjøre seg klar
echo -e "${TEXT}Plugg din reMarkable til strømforsyningen slik at den raskere kobler seg opp til"
echo -e "${TEXT}det trådløse nettet; skru den på og trykk [SPACE] for å fortsette.${NC}\n"
read -n1 -s -r key

function getCredentials() {
	echo -e -n "${PROMPT}Hva er IP-adressen til din reMarkable: ${NC}" 
	read IP_ADDRESS
	echo $IP_ADDRESS | base64 > ~/.reMarkable-template-installer
}

if test -f "$KEYFILE"; then
	echo -e "🔓  Benytter eksisterende SSH nøkkelpar"
else
	echo -e "🔓  Vi trenger et SSH nøkkelpar\n"
	echo -e "${TEXT}Om du ikke har IP-adresse og passord klart, kan du finne dette på din reMarkable"
	echo -e "under ${MENU}Menu > Settings > Copyrights and licenses${TEXT}. Se helt nederst hvor begge"
	echo -e "deler er oppgitt i avsnittet ${MENU}GPLv3 Compliance${NC}.\n"
	echo -e "${TEXT}Neste gang du kjører dette skriptet skal du ikke behøve å gå igjennom denne"
	echo -e "prosedyren så lenge enheten har en fast IP-adresse.\n"
	ssh-keygen -f $KEYFILE -q -N ""
	getCredentials
	# ssh-copy-id virker ikke av en eller annen grunn
	# ssh-copy-id -i $KEYFILE root@$IP_ADDRESS
	ssh root@$IP_ADDRESS "mkdir -p ~/.ssh && \
		touch .ssh/authorized_keys && \
		chmod -R u=rwX,g=,o= ~/.ssh && \
		cat >> .ssh/authorized_keys" < $KEYFILE.pub
fi

# Les inn IP-adressen fra tidligere
if test -f "$FILE"; then
	IFS=$'\r\n' GLOBIGNORE='*' command eval  'XYZ=($(cat $FILE))'
	IP_ADDRESS=`echo ${XYZ[0]} | base64 -d`
fi

# Last ned malbeskrivelsene
echo -e "⬇️  Laster ned malbeskrivelser"
scp -q -i $KEYFILE root@$IP_ADDRESS:/usr/share/remarkable/templates/templates.json ./templates-remarkable.json

# Lag til en ekstra kopi med tidsstempel, sånn i tilfelle noe går galt og vi
# må legge tilbake en gammel kopi. Dette må i så fall gjøres manuelt.
current_time=$(date "+%Y.%m.%d-%H.%M.%S")
cp templates-remarkable.json templates-backup.$current_time 

# Kombiner malfilene til én – merk at disse blir sortert alfabetisk etter navn
# og at maler som evt. har blitt fjernet fra templates-fragment.json ikke vil
# bli fjernet fra templates.json
echo -e "🧩  Sammenstiller malbeskrivelser"
rm -f ./templates.json
jq -s '{templates: ([.[][]] | flatten | unique_by(.filename))}' templates-remarkable.json templates-fragment.json > templates.json 

# Last opp fil med nye malbeskrivelser samt alle malene
echo -e "⬆️  Laster opp maler og malbeskrivelser"
scp -q -i $KEYFILE ./templates.json root@$IP_ADDRESS:/usr/share/remarkable/templates/templates.json
scp -q -i $KEYFILE ./templates/* root@$IP_ADDRESS:/usr/share/remarkable/templates/
echo -e "🔄  Starter om ${TEXT}Xochitl${NC} for å iverksette endringene"
ssh -i $KEYFILE  root@$IP_ADDRESS -f 'systemctl restart xochitl'
echo -e "🥰  Kos deg med oppdaterte maler!"