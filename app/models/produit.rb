class Produit < ApplicationRecord
  belongs_to :fournisseur

  validates :nom, :description, presence: true
  validates :quantite, :prix, presence: true, numericality: true

end
