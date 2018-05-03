class ProduitsController < ApplicationController
  before_action :set_fournisseur
  before_action :set_fournisseur_produit, only: [:show, :update, :destroy]

  before_action :authenticate_request!

  # GET /fournisseurs/:fournisseur_id/produits
  def index
    json_response(@fournisseur.produits)
  end

  # GET /fournisseurs/:fournisseur_id/produits/:id
  def show
    json_response(@produit)
  end

  # POST /fournisseurs/:fournisseur_id/produits
  def create
    @fournisseur.produits.create!(produit_params)
    json_response(@fournisseur, :created)
  end

  # PUT /fournisseurs/:fournisseur_id/produits/:id
  def update
    @produit.update(produit_params)
    head :no_content
  end

  # DELETE /fournisseurs/:fournisseur_id/produits/:id
  def destroy
    @produit.destroy
    head :no_content
  end

  private

  def produit_params # whitelist params
    params.permit(:nom, :quantite, :description, :prix)
  end

  def set_fournisseur
    @fournisseur = Fournisseur.find(params[:fournisseur_id])
  end

  def set_fournisseur_produit
    @produit = @fournisseur.produits.find_by!(id: params[:id]) if @fournisseur
  end
end