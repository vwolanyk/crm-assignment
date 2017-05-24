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

    @@contacts.select { |contact| contact.id == id}

  end

  #  should allow you to search for a contact using attributes other than id
  # by specifying both the name of the attribute and the value
  # eg. searching for 'first_name', 'Betty' should return the first contact named Betty


  def self.find_by(attribute, attribute_value)

    # Send function converts string to symb to call method, cannot use arg to pass through as method
    @@contacts.select {|contact| contact.send(attribute) == attribute_value}

  end

  # This method should allow you to specify
  # 1. which of the contact's attributes you want to update
  # 2. the new value for that attribute
  # and then make the appropriate change to the contact
  # def update(attribute, new_value)
  #
  #   = new_value
  #
  # end

  # This method should delete all of the contacts
  def self.delete_all

    @@contacts.clear

  end

  def full_name

  end

  # This method should delete the contact
  # HINT: Check the Array class docs for built-in methods that might be useful here
  def delete

  end

  # Feel free to add other methods here, if you need them.

end
