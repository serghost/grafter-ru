class CreatePrices < ActiveRecord::Migration
  def self.up
    create_table :prices do |t|
      t.boolean :trusted,       :default => false
      t.float :attestation
      t.float :course_work
      t.float :score_3
      t.float :score_4
      t.float :score_5
      t.float :test
      t.integer :university_id, :null => false
      t.integer :user_id,       :null => false
      t.string :lesson,         :null => false
      t.string :teacher_id,     :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :prices
  end
end
