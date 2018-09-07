require 'rails_helper'

RSpec.describe 'countries API', type: :request do
  # initialize test data
  let!(:countries) { create_list(:country, 10) }
  let(:country_id) { countries.first.id }

  # Test suite for GET /countries
  describe 'GET /countries' do
    # make HTTP get request before each example
    before { get '/countries' }

    it 'returns countries' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /countries/:id
  describe 'GET /countries/:id' do
    before { get "/countries/#{country_id}" }

    context 'when the record exists' do
      it 'returns the country' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(country_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:country_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find country/)
      end
    end
  end

  # Test suite for POST /countries
  describe 'POST /countries' do
    # valid payload
    let(:valid_attributes) { { title: 'Learn Elm', created_by: '1' } }

    context 'when the request is valid' do
      before { post '/countries', params: valid_attributes }

      it 'creates a country' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/countries', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /countries/:id
  describe 'PUT /countries/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/countries/#{country_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /countries/:id
  describe 'DELETE /countries/:id' do
    before { delete "/countries/#{country_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
