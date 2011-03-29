class ChangeColumnInCity < ActiveRecord::Migration
  def self.up
    change_table :cities do |cities|
      cities.rename :title, :city_title
    end
  end

  def self.down
    change_table :cities do |cities|
      cities.rename :city_title, :title
    end
  end
end
