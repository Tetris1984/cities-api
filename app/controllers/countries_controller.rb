class CountriesController < ApplicationController
  before_action :set_country, only: [:show, :update, :destroy]

  # GET /countries
  def index
    if params["country_name"].present?
      @countries = Country.where("countries.name ILIKE ?", "%#{params["country_name"]}%")
    else
      @countries = Country.all
    end

    json_response(@countries)
  end

  # POST /countries
  def create
    @country = Country.create!(country_params)
    json_response(@country, :created)
  end

  # GET /countries/:id
  def show
    json_response(@country)
  end

  # PUT /countries/:id
  def update
    @country.update(country_params)
    head :no_content
  end

  # DELETE /countries/:id
  def destroy
    @country.destroy
    head :no_content
  end

  private

  def country_params
    # whitelist params
    params.permit(:name, :created_by)
  end

  def set_country
    @country = Country.find(params[:id])
  end
end
