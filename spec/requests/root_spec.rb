require 'requests_helper'

RSpec.describe '/', type: :request do
  describe 'GET /' do
    it 'Responds with an error message' do
      get '/'

      expect(body['errors']).to eq ['Please use API']
    end
  end
end
