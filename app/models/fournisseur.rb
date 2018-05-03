class Fournisseur < ApplicationRecord
  has_many :produits, dependent: :destroy

  validates :nom, :adresse, :tel, presence: true

end
