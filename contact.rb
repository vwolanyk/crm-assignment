gem 'activerecord', "=4.2.7"
require "active_record"
require "mini_record"

AcriveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'crm.sqlite3')




class Contact

# Attribute methods

  attr_accessor :first_name, :last_name, :email, :note

  attr_reader :id

# Class Variables

  @@contacts = []
  @@id = 1000


  # This method should initialize the contact's attributes
  def initialize(first_name, last_name, email, note = "N/A")
    @first_name = first_name
    @last_name  = last_name
    @email = email
    @note = note
    @id = @@id
    @@id += 1

  end

  # This method should call the initializer,
  # store the newly created contact, and then return it
  def self.create(first_name, last_name, email, note = "N/A")
    new_contact = Contact.new(first_name, last_name, email, note = "N/A")

    @@contacts << new_contact

    return new_contact
  end

  # This method should return all of the existing contacts
  def self.all
    @@contacts
  end

  # This method should accept an id as an argument
  # and return the contact who has that id
  def self.find(id)

    result = @@contacts.select {|contact| contact.id == id }
    return result[0]
    #  @@contacts.each do |contact|
    #     if contact.id == id
    #       return contact
    #     end
    #   end
  end

  #  should allow you to search for a contact using attributes other than id
  # by specifying both the name of the attribute and the value
  # eg. searching for 'first_name', 'Betty' should return the first contact named Betty


  def self.find_by(attribute, attribute_value)

    # Send function converts string to symb to call method, cannot use arg to pass through as method
    result = @@contacts.select {|contact|
      contact.send(attribute) == attribute_value}
      return result[0]

  end

  # This method should allow you to specify
  # 1. which of the contact's attributes you want to update
  # 2. the new value for that attribute
  # and then make the appropriate change to the contact
  def update(attribute, new_value)

    case attribute
    when "first_name"
      @first_name = new_value
    when "last_name"
    when "email"
      @email = new_value
    when "note"
       @note = new_value
    end
  end

  # This method should delete all of the contacts
  def self.delete_all

    @@contacts.clear

  end

  def full_name

    "#{first_name} #{last_name}"

  end

  # This method should delete the contact
  # HINT: Check the Array class docs for built-in methods that might be useful here
  def delete

    @@contacts.delete(self)

  end

  # Feel free to add other methods here, if you need them.
  def display_contact_info

     puts "ID: #{id} NAME: #{full_name} EMAIL: #{email}"
     puts "NOTES: #{note}"
  end

end
Contact.create("joe", "joe", "dd@dd.com")
Contact.create("Betty", "Davis", "bd@bd.com", "Eyes")

 # p betty.update("first_name", "Bets")
 #
 # p Contact.all
 #
 # betty.delete
 #
 # p Contact.all
