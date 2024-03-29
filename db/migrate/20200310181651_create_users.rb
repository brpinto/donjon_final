class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.boolean :confirmed
      t.string :confirmation_token
      t.string :recover_password

      t.timestamps
    end
  end
end