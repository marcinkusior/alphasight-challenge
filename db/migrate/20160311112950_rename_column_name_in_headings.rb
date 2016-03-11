







class RenameColumnNameInHeadings < ActiveRecord::Migration
  def change
  	 rename_column :headings, :type, :group
  end
end
