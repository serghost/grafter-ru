class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.string :title
      t.integer :department_id
    end
  end

  def self.down
    drop_table :cities
  end
end
