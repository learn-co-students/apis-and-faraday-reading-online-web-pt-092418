class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '3NKI23YT5TKE1DSJ2HKOUDYZWAD503UIECGQ5PGHPWPQRY1F'
        req.params['client_secret'] = 'V3Z0P4GYWXFQTDJ1MY2MIUMI23BUXGP5PN1BFAAPJJC3OJPC'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end

      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end

      rescue Faraday::ConnectionFailed
        @error = "There was a timeout. Please try again."
      end
    render 'search'
  end
end
