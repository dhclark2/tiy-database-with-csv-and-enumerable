require 'csv'

class Employee
  attr_accessor :name, :phone, :address, :position, :salary, :slack, :github
end

class Database
  def initialize
    @people = []

    CSV.foreach("employees.csv", headers:true) do |person|
      name = person["name"]
      phone = person["phone"]
      address = person["address"]
      position = person["position"]
      salary = person["salary"]
      slack = person["slack"]
      github = person["github"]

      add_new_employee(name, phone, address, position, salary, slack, github)
    end
  end

  def prompt_user
    puts "Hello.  Would you like to Add (A), Search (S), or Delete (D) an entry?"
    gets.chomp
  end

  def add_new_employee
    employee = Employee.new

    puts "What is the name?"
    employee.name = gets.chomp
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

    @people << employee
  end

  # def search_and_print(name)
  #
  # end

  def print_all_results
    @people.each do |person|
      puts
      puts "Employee: #{person.name}"
      puts "Phone Numer: #{person.phone}"
      puts "Home Address: #{person.address}"
      puts "Job Title: #{person.position}"
      puts "Annual Salary: #{person.salary}"
      puts "Slack Account: #{person.slack}"
      puts "GitHub Account: #{person.github}"
      puts
      puts
    end
  end

  def delete_employee_entry
    asdf
  end

  def save_entry
    csv = CSV.open("employees.csv", "w")
    csv.add_row %w[name phone address position salary slack github]

    @people.each do |person|
      csv.add_row [person.name, person.phone, person.address, person.position, person.salary, person.slack, person.github]
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
          add_new_employee
          save_entry
          break
        end

        if prompt_answer == "S"
          # search_and_print
          print_all_results
          break
        end

        if prompt_answer == "D"
          delete_employee_entry
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
