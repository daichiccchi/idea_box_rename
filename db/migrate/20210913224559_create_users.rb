class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :user_area
      t.integer :user_job
      t.integer :school_year
      t.timestamps
    end
  end
end
