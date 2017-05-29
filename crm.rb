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
# GETS NEW CONTACT INFO
    puts ""
    print "Enter First Name: "
    first_name = gets.chomp

    print "Enter Last Name: "
    last_name = gets.chomp

    print "Enter Email Address: "
    email = gets.chomp

    print "Additional Info(press enter if none): "
    note = gets.chomp

# CREATES A NEW CONTCT
    contact = Contact.create(first_name: first_name, last_name:  last_name, email: email, note: note)

# VISUAL DISPLAY THAT CONTACT ADDED to DATABASE (May be unnecessary in future)
    puts " "
    puts "Contact Successfully Added"
  end

  def modify_existing_contact
    # GETS id to search for (option display contacts to find ID number)
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

# GETS Attribute to Modify/Update
     puts "What would you like to modify about #{ contact.full_name }?"

     attribute = gets.chomp

#  GETS NEW VALUE FOR ATTRIBUTE
     puts "Enter New #{attribute.upcase.tr("_"," ")}:"
     value = gets.chomp
# UPDATES CONTACT INFO IN DATABASE
      contact.update_attribute(attribute,value)
# VISUAL display update occured
      p "#{contact.first_name}'s #{attribute.upcase} has been updated"

  end

  def delete_contact
    # Get ID of COntact (with option of listing contacts)
    puts "Enter ID of Contact you would like to DELETE:"
    puts "*** OR ENTER ? for a list of contacts ***"
    id = gets.chomp
    if id == "?"
      display_all_contacts
      puts "Enter ID of Contact you would like to DELETE:"
      id = gets.chomp
    end

    # FInd Contact by ID
    contact = Contact.find(id.to_i)

    # CONFIRM deletion
    puts "Are You Sure you want to delete #{contact.first_name}? (Y or N)"
    confirm = gets.chomp.upcase

    if confirm == "Y" ||  confirm == "YES"

# CONTACT DELETED HERE
      contact.delete
      p "Contact DELETED"
    else main_menu
    end

  end

  def display_all_contacts
    p Contact.all
    # PREV extra to display contacts PRETTY
    # Contact.all.each do |contact| print "ID: #{contact.id}  NAME: #{contact.full_name} EMAIL: #{contact.email}"
    #   puts "Notes: #{contact.note}"
  end

  def search_by_attribute
    # GETS attribute to search by
    puts "Which Category would you like to SEARCH by?"
    attribute = gets.chomp.to_sym

    # GETS value of attribute
    puts "Search Term:"
    value = gets.chomp

    # Creates Hash to pass arg through find_by method
    arg = {attribute => value}

    # Display Contact Found
    p Contact.find_by(arg)
  end

# End of Class
end

# Closes connections upon exit mini-record does not and max 5 connections
at_exit do
  ActiveRecord::Base.connection.close
end

# my_crm = CRM.new("Vigilante Vixen")
#
# my_crm.main_menu
