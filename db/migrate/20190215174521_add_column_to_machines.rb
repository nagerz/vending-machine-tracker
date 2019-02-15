class AddColumnToMachines < ActiveRecord::Migration[5.1]
  def change
    add_column :machines, :snack_id, :integer
  end
end
