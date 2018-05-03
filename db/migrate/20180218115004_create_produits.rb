class CreateProduits < ActiveRecord::Migration[5.1]
  def change
    create_table :produits do |t|
      t.string :nom
      t.integer :quantite
      t.string :description
      t.float :prix
      t.references :fournisseur, foreign_key: true

      t.timestamps
    end
  end
end
