class FournisseursController < ApplicationController
  before_action :set_fournisseur, only: [:show, :update, :destroy]

  before_action :authenticate_request!

  # GET /fournisseurs
  def index
    @fournisseurs = Fournisseur.all
    json_response(@fournisseurs)
  end

  # POST /fournisseurs
  def create
    @fournisseur = Fournisseur.create!(fournisseur_params)
    json_response(@fournisseur, :created)
  end

  # GET /fournisseurs/:id
  def show
    json_response(@fournisseur)
  end

  # PUT /fournisseurs/:id
  def update
    @fournisseur.update(fournisseur_params)
    head :no_content
  end

  # DELETE /fournisseurs/:id
  def destroy
    @fournisseur.destroy
    head :no_content
  end

  private

  def fournisseur_params
    # whitelist params
    params.permit(:nom, :tel, :adresse)
  end

  def set_fournisseur
    @fournisseur = Fournisseur.find(params[:id])
  end
end