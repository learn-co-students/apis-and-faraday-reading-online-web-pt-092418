class SearchesController < ApplicationController
  def search
  end

  def foursquare

    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'DMQPCTA3V45QP4Y0AP1VIQTJV1KB305P0OY4HVD3U1YOMJVM'
        req.params['client_secret'] = 'N3CME0YC32YIQT00Z1IWITJO2WGREFWN5GYSKGW0ZKFACMKC'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        # req.options.timeout = 0
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
