class CreateMonths < ActiveRecord::Migration[6.0]
  def change
    create_table :months do |t|
      t.integer :users_total
      t.integer :notes_total
      t.integer :users_confirmed
      t.integer :notes_per_user
    end
  end
end
