gem 'activerecord', "=4.2.7"
require "active_record"
require "mini_record"

AcriveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'crm.sqlite3')

class Contact < ActiveRecord::Base 


  # attr_accessor :first_name, :last_name, :email, :note

  # attr_reader :id




  def full_name

    "#{first_name} #{last_name}"

  end

end
