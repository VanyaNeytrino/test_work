require 'sqlite3'
require 'active_record'
require_relative './environment'



class CreateDB < ActiveRecord::Migration

  def up
    create_table :quotations , {:id => false} do |t|
      t.integer :number
      t.integer :date
      t.integer :rating
      t.text    :text
    end
    puts 'ran up method'
  end

  def down
    drop_table :quotations
    puts 'ran down method'
  end
end
CreateDB.migrate(:up)
