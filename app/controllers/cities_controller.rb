class CitiesController < ApplicationController
  before_action :set_country
  before_action :set_country_city, only: [:show, :update, :destroy]

  # GET /countrys/:country_id/cities
  def index

    json_response(@country.cities)
  end

  # GET /countrys/:country_id/cities/:id
  def show
    json_response(@city)
  end

  # POST /countrys/:country_id/cities
  def create
    @country.cities.create!(city_params)
    json_response(@country, :created)
  end

  # PUT /countrys/:country_id/cities/:id
  def update
    @city.update(city_params)
    head :no_content
  end

  # DELETE /countrys/:country_id/cities/:id
  def destroy
    @city.destroy
    head :no_content
  end

  private

  def city_params
    params.permit(:name, :done)
  end

  def set_country
    @country = Country.find(params[:country_id])
  end

  def set_country_city
    @city = @country.cities.find_by!(id: params[:id]) if @country
  end
end
