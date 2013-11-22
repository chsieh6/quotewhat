class RemoveDescriptionsFromPin < ActiveRecord::Migration
  def change
  	remove_column :pins, :descriptions, :string
  end
end
