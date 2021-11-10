class CreateYearings < ActiveRecord::Migration[6.0]
  def change
    create_table :yearings do |t|
      t.references :topic, null: false, foreign_key: true
      t.references :year, null: false, foreign_key: true

      t.timestamps
    end
  end
end
