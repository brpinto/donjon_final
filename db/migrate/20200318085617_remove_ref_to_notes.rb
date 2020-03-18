class RemoveRefToNotes < ActiveRecord::Migration[6.0]
  def change
    remove_reference :notes, :user, foreign_key: true
  end
end
