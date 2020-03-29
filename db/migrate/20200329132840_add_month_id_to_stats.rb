class AddMonthIdToStats < ActiveRecord::Migration[6.0]
  def change
    add_column :stats, :monthId, :integer
  end
end
