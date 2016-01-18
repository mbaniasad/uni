class ChangeIndexNumberType < ActiveRecord::Migration
   def up
    change_column :questions, :index_number, 'real USING index_number::real'
  end

  def down
    change_column :questions, :index_number,  :string
  end
end
