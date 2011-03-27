class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.integer :university_id
      t.integer :kind, :default => 0
      t.integer :user_id
      t.string :text

      t.timestamps
    end
  end

  def self.down
    drop_table :reviews
  end
end
