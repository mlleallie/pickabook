class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.text :question

      t.timestamps null: false
    end
  end
end
