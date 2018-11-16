# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# Create years
years = [2015, 2016, 2017, 2018]
years.each_with_index do |year, i|
  current = (i + 1).eql?(years.size)
  Year.where(value: year).first_or_create do |y|
    y.current_year = current
  end
end

roster_data = JSON.parse(File.read("db/roster.json"))

roster_data.each do |child|
  c = Child.find_or_create_by(name: child["child"]) do |ch|
    ch.days = child["days"]
    ch.dob = child["dob"]
  end

  unless child["parent1"].nil?
    parent1 = Parent.find_or_create_by(name: child["parent1"]["name"]) do |par|
      par.email = child["parent1"]["email"]
      par.phone_number = child["parent1"]["phone"]
      par.job = child["job"]
      par.address = child["address"]
    end

    c.parents << parent1 unless c.parents.map(&:id).include?(parent1.id)
  end

  unless child["parent2"].nil?
    parent2 = Parent.find_or_create_by(name: child["parent2"]["name"]) do |par|
      par.email = child["parent2"]["email"]
      par.phone_number = child["parent2"]["phone"]
      par.job = child["job"]
      par.address = child["address"]
    end

    c.parents << parent2 unless c.parents.map(&:id).include?(parent2.id)
  end
end

