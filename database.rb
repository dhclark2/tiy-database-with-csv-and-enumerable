require 'csv'

class Employee
  attr_accessor :name, :phone, :address, :position, :salary, :slack, :github
end

class Database
  # Dear fellow programmer
  #
  # This initializer (method) creates a new people array
  #
  # Then it opens a CSV file, reading each line
  # pulls out the values and creates a new person with those details
  # adding them to the array
  def initialize
    @people = []

    # Ruby, please open a CSV file for me, that file will have headers on first row
    # for every row in the CSV file, give me that data in a variable called "csv"
    CSV.foreach("employees.csv", headers:true) do |csv|
      # make a new employee object for me, and put it in a variable called employee
      employee = Employee.new

      # Set the employee object's name to the value of the CSV column "name" (which we can find through the person csv)

      employee.name = csv["name"]
      employee.phone = csv["phone"]
      employee.address = csv["address"]
      employee.position = csv["position"]
      employee.salary = csv["salary"]
      employee.slack = csv["slack"]
      employee.github = csv["github"]

      @people << employee

    end
  end

  def prompt_user
    puts "Hello.  Would you like to Add (A), Search (S), or Delete (D) an entry?"
    puts "To see a fully list of the database  (F)  "
    gets.chomp
  end

  # Dear fellow programmer
  #
  # This method promps a human for details about a new person
  # and then adds them to the array
  def add_new_person

    puts "What is the name?"
    name = gets.chomp

    if @people.any? { |employee| employee.name == name }
      puts "This person is already in the database."
    else
      employee = Employee.new
      employee.name = name
      puts "What is the phone number?"
      employee.phone = gets.chomp
      puts "What is the address?"
      employee.address = gets.chomp
      puts "What is the position?"
      employee.position = gets.chomp
      puts "What is the salary?"
      employee.salary = gets.chomp
      puts "What is the slack account?"
      employee.slack = gets.chomp
      puts "What is the GitHub account?"
      employee.github = gets.chomp
      puts
      puts "Thank you.  These records have been added to the database."
      puts

      @people << employee
    end
  end

  def search_and_print
    puts "What is the name? Search can also be the exact Github or Slack account name."
    name = gets.chomp

    matching_term = @people.select { |employee| employee.name == name || employee.slack == name || employee.github == name }

    if matching_term.empty?
      puts "The search returned no such account."
    else
      matching_term.each do |employee|
        puts
        print "Employee:...........| #{employee.name}"
        puts
        print "Phone Numer:........| #{employee.phone}"
        puts
        print "Home Address:.......| #{employee.address}"
        puts
        print "Job Title:..........| #{employee.position}"
        puts
        print "Annual Salary:......| #{employee.salary}"
        puts
        print "Slack Account:......| #{employee.slack}"
        puts
        print "GitHub Account:.....| #{employee.github}"
        puts
      end
    end

  end

  def print_all_results

    @people.each do |employee|
      puts
      print "Employee:...........| #{employee.name}"
      puts
      print "Phone Numer:........| #{employee.phone}"
      puts
      print "Home Address:.......| #{employee.address}"
      puts
      print "Job Title:..........| #{employee.position}"
      puts
      print "Annual Salary:......| #{employee.salary}"
      puts
      print "Slack Account:......| #{employee.slack}"
      puts
      print "GitHub Account:.....| #{employee.github}"
      puts
      puts
    end
  end

  def delete_who?
    puts "What is the name?"
    name = gets.chomp

    if @people.any? { |employee| employee.name == name }
      @people.delete_if { |employee| employee.name == name }

    else
      puts "Nobody matches"
    end
  end

  def save_entry
    csv = CSV.open("employees.csv", "w")
    csv.add_row %w[name phone address position salary slack github]

    @people.each do |employee|
      csv.add_row [employee.name, employee.phone, employee.address, employee.position, employee.salary, employee.slack, employee.github]
    end
    csv.close
  end

  def program_end_or_repeat
    puts
    puts "Would you like to make another selection? (y/n)"
    gets.chomp
  end

  def menu
    loop do
      prompt_answer = prompt_user

      loop do
        if prompt_answer == "A"
          add_new_person
          save_entry
          break
        end

        if prompt_answer == "S"
          search_and_print
          break
        end

        if prompt_answer == "F"
          print_all_results
          break
        end

        if prompt_answer == "D"
          delete_who?
          save_entry
          break
        end

        if prompt_answer != "A" || prompt_answer != "S" || prompt_answer != "D"
          puts "You entered an incorrect choice."
          break
        end
      end

      search_again = program_end_or_repeat

      if search_again == "n"
        puts "Thank you. Goodbye."
        break
      end
    end
  end
end

database = Database.new
database.menu
