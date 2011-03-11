class CreateUniversities < ActiveRecord::Migration
  def self.up
    create_table :universities do |t|
      t.string :short, :null => false
      t.string :title, :null => false, :unique => true
      t.integer :city_id, :null => false
      t.string :logo_file_name
      t.string :logo_content_type
      t.integer :logo_file_size
      t.datetime :logo_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :universities
  end
end
