class CreateHeadings < ActiveRecord::Migration
  def change
    create_table :headings do |t|
      t.string :type
      t.string :content
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
