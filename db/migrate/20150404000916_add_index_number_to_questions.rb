class AddIndexNumberToQuestions < ActiveRecord::Migration
  def change
     add_column :questions, :index_number, :string 
  end
end
