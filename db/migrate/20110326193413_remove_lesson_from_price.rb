class RemoveLessonFromPrice < ActiveRecord::Migration
  def self.up
    remove_column :prices, :lesson
    add_column    :prices, :lesson_id, :integer
  end

  def self.down
    add_column    :prices, :lesson, :string
    remove_column :prices, :lesson_id
  end
end
