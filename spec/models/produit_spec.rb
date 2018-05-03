require 'rails_helper'

# Suite de tests pour le modèle: Produit
RSpec.describe Produit, type: :model do
  ## Test de la relation/cardinalité
  # S'assurer qu'un Produit appartient à un fournisseur
  it { should belong_to(:fournisseur)}

  ## Tester les validateurs
  # s'assurer que les colonnes obligatoires sont présentes avant la sauvegarde
  it { should validate_presence_of(:nom) }
  it { should validate_presence_of(:quantite) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:prix) }

  # s'assurer que les colonnes prix et quantité sont des nombres
  it { should validate_numericality_of(:quantite) }
  it { should validate_numericality_of(:prix) }

end
