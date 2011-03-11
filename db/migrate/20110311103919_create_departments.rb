class CreateDepartments < ActiveRecord::Migration
  def self.up
    create_table :departments do |t|
      t.string :title, :null => false
      t.integer :country_id, :default => 1, :null => false
    end
  end

  def self.down
    drop_table :departments
  end
end
