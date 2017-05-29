class CRM

require_relative 'contact.rb'



  def initialize(name)
    @crm_name = name
  end

  def main_menu
    while true
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts ""
    puts"***********************************"
    puts "Welcome to CRM: #{@crm_name.upcase}"
    puts"************************************"
    puts ""
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all the contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    puts 'Enter a number: '
  end

  def choose_attribute
    puts "[1] First Name"
    puts "[2] Last Name"
    puts "[3] Email"
    puts "[4] Note"
    puts "[5] Exit"
    puts "Enter Number: "
    choice = gets.chomp.to_i

    case choice
    when 1
       attribute = :first_name
    when 2
      attribute = :last_name
    when 3
       attribute = :email
     when 4
       attribute = :note
     when 5 then main_menu
     end
     return attribute
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
    puts ""
    puts ""
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


    contact = Contact.create(first_name: first_name,
  last_name:  last_name,
  email:      email,
  note:       note)

    puts " "
    puts "Contact Successfully Added"




  end

  def modify_existing_contact
    puts "Please Enter ID Number of Contact you wish to Modify"
    puts "OR ENTER ? to get a list of contacts"
    id = gets.chomp

      if id == "?"
       display_all_contacts
       puts "**"
       puts "Enter ID of Contact you wish to Modify:"
       id = gets.chomp.to_i
       contact = Contact.find(id)
     else contact = Contact.find(id.to_i)
     end



     puts "What would you like to modify about #{ contact.full_name }?"

     attribute = gets.chomp

     puts "Enter New #{attribute.upcase.tr("_"," ")}:"
     value = gets.chomp

      contact.update_attribute(attribute,value)
      puts "#{contact.first_name}'s #{attribute.upcase} has been updated"

  end

  def delete_contact
    puts "Enter ID of Contact you would like to DELETE:"
    puts "*** OR ENTER ? for a list of contacts ***"
    id = gets.chomp
    if id == "?"
      display_all_contacts
      puts "Enter ID of Contact you would like to DELETE:"
      id = gets.chomp
    end
    contact = Contact.find(id.to_i)

    puts "Are You Sure you want to delete #{contact.first_name}? (Y or N)"
    confirm = gets.chomp.upcase

    if confirm == "Y" || "YES"
      contact.delete
      puts "Contact DELETED"
    else main_menu
    end

  end

  def display_all_contacts

    p Contact.all
    # Contact.all.each do |contact| print "ID: #{contact.id}  NAME: #{contact.full_name} EMAIL: #{contact.email}"
    #   puts "Notes: #{contact.note}"


  end

  def search_by_attribute
    puts "Which Category would you like to SEARCH by?"
    attribute = gets.chomp.to_sym

  puts "Search Term:"
  value = gets.chomp

  arg = {attribute => value}

p Contact.find_by(arg)





  end


end

at_exit do
  ActiveRecord::Base.connection.close
end

# my_crm = CRM.new("Vigilante Vixen")
#
# my_crm.main_menu
