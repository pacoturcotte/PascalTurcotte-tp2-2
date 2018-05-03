require 'rails_helper'

RSpec.describe 'Produits API' do
  # Initialize the test data
  let!(:fournisseur) { create(:fournisseur) }
  let!(:produits) { create_list(:produit, 20, fournisseur_id: fournisseur.id) }
  let(:fournisseur_id) { fournisseur.id }
  let(:id) { produits.first.id }

  # Test suite for GET /fournisseurs/:fournisseur_id/produits
  describe 'GET /fournisseurs/:fournisseur_id/produits' do
    before { get "/fournisseurs/#{fournisseur_id}/produits" }

    context 'when fournisseur exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all "produits" of the "fournisseur"' do
        expect(JSON.parse(response.body).size).to eq(20)
      end
    end

    context 'when "fournisseur" does not exist' do
      let(:fournisseur_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Fournisseur/)
      end
    end
  end

  # Test suite for GET /fournisseurs/:fournisseur_id/produits/:id
  describe 'GET /fournisseurs/:fournisseur_id/produits/:id' do
    before { get "/fournisseurs/#{fournisseur_id}/produits/#{id}" }

    context 'when "produit" of "fournisseur" exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the produit' do
        expect(JSON.parse(response.body)['id']).to eq(id)
      end
    end

    context 'when fournisseur produit does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Produit/)
      end
    end
  end

  # Test suite for PUT /fournisseurs/:fournisseur_id/produits
  describe 'POST /fournisseurs/:fournisseur_id/produits' do
    let(:valid_attributes) { { nom: 'Produit01', quantite: 10, description: 'descriptif 01', prix: 10} }

    context 'when request attributes are valid' do
      before { post "/fournisseurs/#{fournisseur_id}/produits", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/fournisseurs/#{fournisseur_id}/produits", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Nom can't be blank/)
      end
    end
  end

  # Test suite for PUT /fournisseurs/:fournisseur_id/produits/:id
  describe 'PUT /fournisseurs/:fournisseur_id/produits/:id' do
    let(:valid_attributes) { { nom: 'Produit 02', description: "desc", quantite: 10, prix: 1 } }

    before { put "/fournisseurs/#{fournisseur_id}/produits/#{id}", params: valid_attributes }

    context 'when produit exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the produit' do
        updated_produit = Produit.find(id)
        expect(updated_produit.nom).to match(/Produit 02/)
      end
    end

    context 'when the produit does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Produit/)
      end
    end
  end

  # Test suite for DELETE /fournisseurs/:id
  describe 'DELETE /fournisseurs/:id' do
    before { delete "/fournisseurs/#{fournisseur_id}/produits/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end