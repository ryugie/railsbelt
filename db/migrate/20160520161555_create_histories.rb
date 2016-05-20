class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :amount
      t.integer :lender_id
      t.integer :borrower_id
      t.references :lender, index: true
      t.references :borrower, index: true

      t.timestamps
    end
  end
end
