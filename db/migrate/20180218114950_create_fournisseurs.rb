class CreateFournisseurs < ActiveRecord::Migration[5.1]
  def change
    create_table :fournisseurs do |t|
      t.string :nom
      t.string :adresse
      t.string :tel

      t.timestamps
    end
  end
end
