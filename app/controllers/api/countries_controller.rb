class Api::CountriesController < Api::ApiController
  
  include Api::Countryable
  
  before_filter :assert_post
  before_filter :assert_country, only: [:list_cities]
  
  # POST /api/countries/list
  def list
    render json: { contents: Api::Country.list }
  end
  
  # POST /api/countries/list_cities
  def list_cities
    Api::City.json_display = Api::City::Json::Filter
    render json: { contents: self.country.active_cities_filter }
  end
  
  
end
