class CreateLessons < ActiveRecord::Migration
  def self.up
    create_table :lessons do |t|
      t.string :title
      t.references :university

      t.timestamps
    end
  end

  def self.down
    drop_table :lessons
  end
end
