# DevOps eksamen

### Krav

Applikasjonen og tilhørende DevOps infrastruktur skal gjøres tilgjenglig i GitHib repositories.

Det skal lages minst to repositories,

Ett til infrastruktur (concourse + terraform)
Ett for en eksempel-applikasjon.
N antall for andre applikasjoner eller komponenter

Det skal opprettes tre identiske miljøer

- CI (Contuinous integraiton) - Master branch i applikasjon-repository skal til enhver tid installeres i dette miljøet.
- Stage - Dette er et miljø som typisk brukes for tester, for eksmpel ytelses- eller sikkerhetstester.
- Prod - Dette er miljøet som kundene- eller brukerene av løsningen opplever.

Nødvendig infrastruktur skal så langt det lar seg gjøre opprettes med Terraform. Det skal ikke være nødvendig å for eksaminator å ha terraform installert på PC for å etablere infrastrukturen - terraformkoden skal kjøres av CI/CD verktøy (concourse).

[Eksamens oppgave](https://github.com/PGR301-2018/oppgave-eksamen)

## Beskrivelse

Prosjektet er splitet opp i to repoer, et for infrastruktur og et for applikasjons kode.
Infrastrure repoet bruker Terraform og Concourse for å bygge, teste og deploye infrastrukturen og applikasjonskoden. Alt starter med Terraform som inisierer infrastrukturen hos Heroku, dette inkluderer 3 forskjellig miljøer koblet sammen av en pipeline. Når applikasjonskoden endres trigges det et bygge hos concourse som tester og produserer et Docker image, som senere blir pushet til starten av pipelinen hos Heroku (CI miljøet).

[Applikasjon](https://github.com/devopsanonuser/exam-app) </br>
[infrastruktur](https://github.com/devopsanonuser/exam-infra) </br>

### Oppgaver

- [x] Basis pipeline (10 poeng)
- [x] Docker (20 poeng)
- [x] Overvåkning, varsling og Metrics (20 poeng)
- [x] Applikasjonslogger (10 poeng)
- [ ] Serverless (10 Poeng)

### Før kjøring

#### Installasjoner

Installer [Docker](https://www.docker.com/) og [Concourse](https://concourse-ci.org/)

#### Endringer

Husk å endre følgende filer:

```bash
./credentials_template.yml
./terraform/provider_heroku.tf
./terraform/statuscake.tf
./terraform/variables.tf
```

Husk å navngi `credentials_template.yml` som `credentials.yml` når du er ferdig

**NB:** `heroku_app_name_prefix` er samme som `heroku_app_name` uten `-ci` på.
