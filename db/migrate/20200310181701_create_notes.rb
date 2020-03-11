class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.string :title
      t.string :game_name
      t.string :game_type
      t.text :content
      t.text :slug

      t.timestamps
    end
  end
end
