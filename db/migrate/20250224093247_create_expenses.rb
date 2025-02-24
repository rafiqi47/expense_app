class CreateExpenses < ActiveRecord::Migration[7.2]
  def change
    create_table :expenses do |t|
      t.decimal :amount
      t.string :category
      t.date :date

      t.timestamps
    end
  end
end
