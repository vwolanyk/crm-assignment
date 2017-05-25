class CRM

require_relative './contact.rb'

  def initialize

  end

  def main_menu
    while true
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts"******************"
    puts "Welcome to CRM"
    puts"******************"
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all the contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    puts 'Enter a number: '
  end

  def call_option(user_selected)
    case user_selected
    when 1 then add_new_contact
    when 2 then modify_existing_contact
    when 3 then delete_contact
    when 4 then display_all_contacts
    when 5 then search_by_attribute
    when 6 then abort("See you Soon!")
    else  puts "Please Enter a Valid Selection"
      main_menu
    end

  end

  def add_new_contact

    puts "New Contact Info"
    puts "****************"

    puts ""
    print "Enter First Name: "
    first_name = gets.chomp

    print "Enter Last Name: "
    last_name = gets.chomp

    print "Enter Email Address: "
    email = gets.chomp

    print "Additional Info(press enter if none): "
    note = gets.chomp

    Contact.create(first_name,last_name, email, note)

  end

  def modify_existing_contact
    puts "Please Enter ID Number of Contact you wish to Modify"
    puts "OR ? to get a list of contacts"
    option = gets.chomp
      if option == "?"
       display_all_contacts

       puts "**"
       puts "Enter ID of Contact you wish to Modify:"
       id = gets.chomp
       modifier = Contact.find(id)
     else
       modifier = Contact.find(option)
     end

     puts "What would you like to modify about #{modifier} ?"
     puts "[1] First Name"
     puts "[2] Last Name"
     puts "[3] Email"
     puts "[4] Note"
     puts "[5] Exit"
     puts "Enter Number: "
     choice = gets.chomp


     case choice
     when 1
        attribute = "first_name"
        puts "New First Name:"
     when 2
       attribute = "last_name"
       puts "New Last Name: "
     when 3
        attribute = "email"
        puts "New Email Address:"
      when 4
        attribute = "note"
        puts "New Note: "
      when 5 then main_menu
      end
      value = gets.chomp

      modifier.update(attribute,value)


  end

  def delete_contact

  end

  def display_all_contacts

    Contact.all.each do |contact| print "ID: #{contact.id}  NAME: #{contact.full_name} EMAIL: #{contact.email}"
      puts "Notes: #{contact.note}"
    end

  end

  def search_by_attribute

  end


end

my_crm = CRM.new

my_crm.main_menu
