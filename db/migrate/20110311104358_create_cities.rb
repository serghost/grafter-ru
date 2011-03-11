class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.string :title, :null => false
      t.integer :department_id, :null => false
    end
  end

  def self.down
    drop_table :cities
  end
end
