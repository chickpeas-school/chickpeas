require 'csv'

class RosterTransformer

  attr_reader :filepath

  CHILDS_NAME = "CHILD’S NAME"
  DAYS = "DAYS"
  DOB = "DOB"
  PARENT1 = "PARENT/GUARDIAN 1 NAME, EMAIL, PHONE"
  PARENT2 = "PARENT/GUARDIAN 2 NAME, EMAIL, PHONE"
  CHICKPEAS_JOB = "CHICKPEAS JOB"
  ADDRESS = "ADDRESS"

  def initialize(filepath)
    @filepath = filepath
  end

  def data
    @data ||= CSV.read(filepath, headers: true).reject { |row| row["DAYS"].nil? & row["DOB"].nil? }
  end

  def rows
    @rows ||= data.map do |row|
      RosterRow.new(
        child: row[CHILDS_NAME],
        parent1: row[PARENT1],
        parent2: row[PARENT2],
        days: row[DAYS],
        dob: row[DOB],
        job: row[CHICKPEAS_JOB],
        address: row[ADDRESS]
      )
    end
  end
end

class RosterRow
  attr_accessor :child, :days, :dob, :parent1, :parent2, :job, :address

  def initialize(child: "", parent1: "", parent2: "", days: "", dob: "", job: "", address: "")
    @child = child
    @days = RosterDays.new(days)
    @dob = dob
    @parent1 = RosterParent.new(parent1)
    @parent2 = RosterParent.new(parent2)
    @job = job
    @address = address
  end
end

class RosterParent
  attr_accessor :name, :email, :phone

  def initialize(parent_string)
    name, email, phone = parent_string.split("\n")

    @name = name
    @email = email
    @phone = phone
  end
end

class RosterDays
  attr_accessor :days

  def initialize(days_string)
    @days = case days_string
            when "M-W"
              "M,T,W"
            when "M-Th"
              "M,T,W,Th"
            when "T-F"
              "T,W,Th,F"
            when "T-Th"
              "T,W,Th"
            when "W-F"
              "W,Th,F"
            when "M-F"
              "M,T,W,Th,F"
            else days_string
            end
  end

  def as_json(_)
    days
  end
end
