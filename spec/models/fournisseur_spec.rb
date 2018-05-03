require 'rails_helper'

# Suite de tests pour le modèle: Fournisseur
RSpec.describe Fournisseur, type: :model do
  ## Test de la relation/cardinalité
  # S'assurer qu'Fournisseur à une relation 1:N avec le modèle produit
  it { should have_many(:produits).dependent(:destroy) }

  ## Tester les validateurs
  # s'assurer que les colonnes obligatoires sont présentes avant la sauvegarde
  it { should validate_presence_of(:nom) }
  it { should validate_presence_of(:adresse) }
  it { should validate_presence_of(:tel) }
end
