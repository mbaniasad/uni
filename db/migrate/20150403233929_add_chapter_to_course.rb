class AddChapterToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :chapter, :integer
  end
end
