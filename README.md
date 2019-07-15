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

Once a user is created, you will be able to create the Database and run the migrations with the following commands:
```
~$> pwd
<DirectoryPath>/chickpeas

~$> rake db:setup
~$> rake db:migrate
```

#### Server

The platform runs off with standard Ruby on Rails commands:
```
~$> rails server
=> Booting Puma
=> Rails 5.2.1 application starting in development
=> Run `rails server -h` for more startup options
Puma starting in single mode...
* Version 3.12.0 (ruby 2.5.1-p57), codename: Llamas in Pajamas
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://0.0.0.0:3000
Use Ctrl-C to stop
```
If you now navigate to [http://localhost:3000](http://localhost:3000), you should see the Chickpeas platform homepage. For more information about Ruby on Rails, check here:

[Ruby on Rails](https://rubyonrails.org/)

[Ruby on Rails - Guides](https://guides.rubyonrails.org/)

## A New Year

When it is time for a new school year to start, you will need to add the roster to the `db/seed.rb` file.

`db/seed.rb`
```
years = [2015, 2016, 2017, 2018]
years.each_with_index do |year, i|
  current = (i + 1).eql?(years.size)
  Year.where(value: year).first_or_create do |y|
    y.current_year = current
  end
end

roster_data = JSON.parse(File.read("db/roster.json"))

roster_data.each do |year, rows|
  year = Year.find_by!(value: year)

  rows.each do |child|
    c = Child.find_or_create_by(name: child["child"].strip) do |ch|
      ch.days = child["days"].strip
      ch.dob = child["dob"].strip
    end

    unless year.children.map(&:id).include?(c.id)
      year.children << c
    end

    unless child["parent1"].nil?
      parent1 = Parent.find_or_create_by(name: child["parent1"]["name"].strip) do |par|
        par.email = child["parent1"]["email"].strip
        par.phone_number = child["parent1"]["phone"].strip
        par.job = child["job"].strip
        par.address = child["address"].strip
      end

      c.parents << parent1 unless c.parents.map(&:id).include?(parent1.id)
    end

    unless child["parent2"].nil?
      parent2 = Parent.find_or_create_by(name: child["parent2"]["name"].strip) do |par|
        par.email = child["parent2"]["email"].strip
        par.phone_number = child["parent2"]["phone"].strip
        par.job = child["job"].strip
        par.address = child["address"].strip
      end

      c.parents << parent2 unless c.parents.map(&:id).include?(parent2.id)
    end
  end
end
```
#### Add the new year
The first change that needs to be made is to add the new year into `seed.rb` file. The year is based on the year in which the school year starts. In other words, when going school starts in the 2019 school year in August or September, the first line in `seed.rb` would become:
```
years = [2015, 2016, 2017, 2018, 2019]
```
You can keep previous years in the array. They will not be recreated. Only years that are not yet in the DB will be added. 

#### Create the `roster.json`

TO DO
