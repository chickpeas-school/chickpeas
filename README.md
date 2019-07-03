# Chickpeas Platform

## Installation

The platform is installed for local development with a standard Github workflow:
```
~$> git clone git@github.com:chickpeas-school/chickpeas.git
~$> cd chickpeas
```

## Local Development

#### Database

The platform depends on Postgres both for `development` and `production`. 

[PostgreSQL Download](https://www.postgresql.org/download/)

You will need to make sure that PostgreSQL is configured properly. The following is the standard configuration for the platform:

`config/database.yml`
```
default: &default
  adapter: postgresql
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000
  username: "chickpeas"
  password: "password"
```
Please, change the default setting to what makes the most sense for your use case. In the case above, you will need to make sure that PostgreSQL has a `chickpeas` User account with the `password` above. 
```
~$> su - postgres
~$> createuser --interactive --pwprompt
```
For more information about the user creation process in PostgreSQL, refer to the [PostgreSQL documentation](https://www.postgresql.org/docs/9.3/app-createuser.html).
