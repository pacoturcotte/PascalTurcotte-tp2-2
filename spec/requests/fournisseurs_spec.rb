require 'rails_helper'

RSpec.describe 'Fournisseurs API', type: :request do
  # initialiser les données de test
  let!(:fournisseurs) { create_list(:fournisseur, 10) }
  let(:fournisseur_id) { fournisseurs.first.id }

  # Suite de tests pour: GET /fournisseurs
  describe 'GET /fournisseurs' do
    # effectuer une requête HTTP get avant chaque requête
    before { get '/fournisseurs' }

    it 'returns fournisseurs' do
      expect(JSON.parse(response.body)).not_to be_empty
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Suite de tests pour GET /fournisseurs/:id
  describe 'GET /fournisseurs/:id' do
    before { get "/fournisseurs/#{fournisseur_id}" }

    context 'when the record exists' do
      it 'returns fournisseur' do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['id']).to eq(fournisseur_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:fournisseur_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Fournisseur/)
      end
    end
  end

  # Test suite for POST /fournisseurs
  describe 'POST /fournisseurs' do
    # valid payload
    let(:valid_attributes) { { nom: 'Fournisseur01', adresse: '1234 chemin du Roy, Qc, Canada', tel: '418 444 4444' } }

    context 'when the request is valid' do
      before { post '/fournisseurs', params: valid_attributes }

      it 'creates fournisseur' do
        expect(JSON.parse(response.body)['nom']).to eq('Fournisseur01')
        expect(JSON.parse(response.body)['adresse']).to eq('1234 chemin du Roy, Qc, Canada')
        expect(JSON.parse(response.body)['tel']).to eq('418 444 4444')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid ' do
      #before { post '/fournisseurs', params: { nom: 'PasFournisseur01' } }

      it 'returns status code 422' do
        post '/fournisseurs', params: { nom: 'PasFournisseur01' }
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message (1)' do
        post '/fournisseurs', params: { nom: 'PasFournisseur01' }
        #puts "message d'erreur#{response.body}"
        expect(response.body).to match(/Validation failed: Adresse can't be blank/)
        expect(response.body).to match(/Tel can't be blank/)
      end

      it 'returns a validation failure message (2)' do
        post '/fournisseurs', params: { nom: 'PasFournisseur01', adresse:"adresse" }
        #puts "message d'erreur#{response.body}"
        expect(response.body).to match(/Validation failed: Tel can't be blank/)
      end

      it 'returns a validation failure message (3)' do
        post '/fournisseurs', params: { tel: '418 444 4444', adresse:"adresse" }
        #puts "message d'erreur#{response.body}"
        expect(response.body).to match(/Validation failed: Nom can't be blank/)
      end

    end

  end

  # Test suite for PUT /fournisseurs/:id
  describe 'PUT /fournisseurs/:id' do
    let(:valid_attributes) { { nom: 'Fournisseur02' } }

    context 'when the record exists' do
      before { put "/fournisseurs/#{fournisseur_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      #it 'updates the produit' do
      #  updated_produit = Produit.find(id)
      #  expect(updated_produit.name).to match(/Fournisseur02/)
      #end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /fournisseurs/:id
  describe 'DELETE /fournisseurs/:id' do
    before { delete "/fournisseurs/#{fournisseur_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end