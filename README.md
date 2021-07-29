# Itema-tilpassede skjermbilder og maler for reMarkable

![suspended screen](./sleeping_reMarkable.jpeg)


## Skjermbilder

Vi har foreløpig kun ett skjermbilde. Dette bildet vises når reMarkable er i sovemodus, hvilket er den tilstanden den havner i når man trykker lett på knappen mens enheten er på – eller det går en viss tid uten at enheten er i bruk. Filen skal legges på `/usr/share/remarkable/suspended.png`.

## Maler

Alle disse malene er laget for at man skal kunne bytte mellom de uten at ting flytter på seg. Så hvis man f.eks. har valgt linjeark, men vil gå over til linjeark med oppgaveliste, alternativt ruteark – så skal det alikevel se pent ut.

Merk at reMarkable strengt tatt ikke støtter tilpassede maler, men at det stort sett ikke medfører noen ulemper. Bortsett fra når man bruker "desktop"-applikasjonen. Den har ikke disse malene innebygd og vil derfor klage ved fremvisning. Hvis man skal sende en side eller fler som PDF til noen andre, er det best å gjøre dette fra reMarkable. Da får man med seg riktig mal.

| Itema grid margin | Itema lines margin | Itema lines checklist |
| ----------------- | ------------------ | --------------------- |
| ![](./templates/P%20Itema%20grid%20margin%20small.png)| ![](./templates/P%20Itema%20lines%20margin%20small.png)| ![](./templates/P%20Itema%20lines%20checklist%20small.png)|
| Itema blank checklist | Itema week plan | |
| ![](./templates/P%20Itema%20blank%20checklist%20small.png)| ![](./templates/P%20Itema%20week.png)| |

SVG og PNG versjonene av disse filene (de ligger i [./templates](./templates/)) må kopieres inn i `/usr/share/remarkable/templates/` og `/usr/share/remarkable/templates/templates.json` må redigeres for at malene skal plukkes opp. Her må teksten som ligger i [./templates-fragment.json](./templates-fragment.json/) flettes inn.

## Installasjon

### Automatisk installasjon

Om du har tilordnet enheten en fast IP-adresse kan opplasting og oppdatering av maler gjøres så enkelt som dette (ved å kjøre skriptet `install.sh`):

```
$ ./install.sh
😄  reMarkable Template Installer v0.1

Plugg din reMarkable til strømforsyningen slik at den raskere kobler seg opp til
det trådløse nettet; skru den på og trykk [SPACE] for å fortsette.

🔓  Benytter eksisterende SSH nøkkelpar
⬇️  Laster ned malbeskrivelser
🧩  Sammenstiller malbeskrivelser
⬆️  Laster opp maler og malbeskrivelser
🔄  Starter om Xochitl for å iverksette endringene
🥰  Kos deg med oppdaterte maler!
```

Merk at ved første gangs kjøring av skriptet må man oppgi IP-adressen til enheten, samt passordet til rotbrukeren. Denne informasjonen finner du ved å gå inn på **Menu > Settings > Copyrights and licenses**. Helt nederst, i avsnittet **GPLv3 Compliance**, er det oppgitt både passord for innlogging og IP-adressen til enheten.

Installasjonsskriptet vil opprette et SSH-nøkkelpar og kopiere den offentlige nøkkelen over til enheten slik at videre autentisering ikke behøves. Det er ikke tatt høyde for at IP-addresen endres, så det anbefales at man går inn på tråløsruteren/DHCP-tjeneren og tilordner en fast adresse for enheten.

### Manuell installasjon
For å kunne endre på systemfilene til reMarkable, så må man ha tilgang til enheten gjennom [SSH](https://remarkablewiki.com/tech/ssh). Man må bruke `scp` for å kopiere over filer og `ssh` for å restarte _xochitl_ etter endringer. Man kan også skru av og på med knappen for å ta endringene i bruk, men det tar mye lengre tid.

Går du inn på **Menu > Settings > Copyrights and licenses** finner du helt nederst, i avsnittet **GPLv3 Compliance**, både passord for innlogging og IP-adressen til enheten.

```bash
❯ ssh root@10.0.0.199
root@10.0.0.199's password:
ｒｅＭａｒｋａｂｌｅ
╺━┓┏━╸┏━┓┏━┓   ┏━┓╻ ╻┏━╸┏━┓┏━┓
┏━┛┣╸ ┣┳┛┃ ┃   ┗━┓┃ ┃┃╺┓┣━┫┣┳┛
┗━╸┗━╸╹┗╸┗━┛   ┗━┛┗━┛┗━┛╹ ╹╹┗╸
reMarkable: ~/ 
```
Etter at filer er overført, og du ønsker å aktivere endringene kan fra terminalen til enheten utføre `systemctl restart xochitl`. 

