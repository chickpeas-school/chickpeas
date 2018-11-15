class RemoveParentIdFromChildren < ActiveRecord::Migration[5.2]
  def change
    remove_reference :children, :parent, index: false
  end
end
