class AddImagesToTopics < ActiveRecord::Migration[6.0]
  def change
    add_column :topics, :images, :string
  end
end
