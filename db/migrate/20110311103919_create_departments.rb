class CreateDepartments < ActiveRecord::Migration
  def self.up
    create_table :departments do |t|
      t.string :title
      t.integer :country_id, :default => 1
    end
  end

  def self.down
    drop_table :departments
  end
end
