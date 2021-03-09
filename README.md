# Itema-tilpassede skjermer og maler for reMarkable

![suspended screen](./sleeping_reMarkable.jpeg)

For å kunne endre på systemfilene til reMarkable, så må man ha tilgang til enheten gjennom [SSH](https://remarkablewiki.com/tech/ssh). Man må bruke `scp` for å kopiere over filer og `ssh` for å restarte _xochitl_ etter endringer. Man kan også skru av og på med knappen for å ta endringene i bruk, men det tar mye lengre tid.


## Skjermbilder

Vi har foreløpig kun ett skjermbilde. Dette bildet vises når reMarkable er i sovemodus, hvilket er den tilstanden den havner i når man trykker lett på knappen mens enheten er på – eller det går en viss tid uten at enheten er i bruk. Filen skal legges på `/usr/share/remarkable/suspended.png`.

![suspended screen](./screens/suspended.png)

## Maler

Alle disse malene er laget for at man skal kunne bytte mellom de uten at ting flytter på seg. Så hvis man f.eks. har valgt linjeark, men vil gå over til linjeark med oppgaveliste, alternativt ruteark – så skal det alikevel se pent ut.

Merk at reMarkable strengt tatt ikke støtter tilpassede maler, men at det stort sett ikke medfører noen ulemper. Bortsett fra når man bruker "desktop"-applikasjonen. Den har ikke disse malene innebygd og vil derfor klage ved fremvisning. Hvis man skal sende en side eller fler som PDF til noen andre, er det best å gjøre dette fra reMarkable. Da får man med seg riktig mal.

| P Itema grid margin small | P Itema lines margin small | P Itema lines checklist small |
| ------------------------- | -------------------------- | ----------------------------- |
| ![](./templates/P%20Itema%20grid%20margin%20small.png)| ![](./templates/P%20Itema%20lines%20margin%20small.png)| ![](./templates/P%20Itema%20lines%20checklist%20small.png)|

SVG og PNG versjonene av disse filene (de ligger i [./templates](./templates/)) må kopieres inn i `/usr/share/remarkable/templates/` og `/usr/share/remarkable/templates/templates.json` må redigeres for at malene skal plukkes opp. Følgende linjer med tekst må legges inn.

```
  {
    "name": "Itema grid margin small",
    "filename": "P Itema grid margin small",
    "iconCode": "\ue99e",
    "categories": [
    "Grids"
      ]
    },
  {
    "name": "Itema lines margin small",
    "filename": "P Itema lines margin small",
    "iconCode": "\ue9a8",
    "categories": [
    "Lines"
      ]
    },
  {
    "name": "Itema lines checklist small",
    "filename": "P Itema lines checklist small",
    "iconCode": "\ue98f",
    "categories": [
      "Lines"
      ]
    },
```

