class AddChapterToQuestions < ActiveRecord::Migration
  def change
      add_column :questions, :chapter, :integer
  end
end
