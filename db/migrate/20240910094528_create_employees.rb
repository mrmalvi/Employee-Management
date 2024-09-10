class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.integer :employee_id, null: false, unique: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      # t.json :phone_numbers, null: false, default: []
      t.date :doj, null: false
      t.decimal :salary, null: false

      t.timestamps
    end
    add_index :employees, :employee_id, unique: true
  end
end
