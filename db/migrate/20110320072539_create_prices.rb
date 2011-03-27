class CreatePrices < ActiveRecord::Migration
  def self.up
    create_table :prices do |t|
      t.float :attestation
      t.float :course_work
      t.float :score_3
      t.float :score_4
      t.float :score_5
      t.float :test
      t.integer :university_id
      t.integer :lesson_id
      t.integer :teacher_id

      t.timestamps
    end
  end

  def self.down
    drop_table :prices
  end
end
