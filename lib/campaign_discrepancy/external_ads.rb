# frozen_string_literal: true

require 'httparty'
require 'campaign_discrepancy/errors'
require 'settings'
require 'uri'

module CampaignDiscrepancy
  class ExternalAds
    include ::HTTParty
    include Errors

    attr_accessor :endpoint, :data

    ENDPOINT = Settings.campaign_discrepancy_base_endpoint

    class << self
      def fetch
        new(ENDPOINT).fetch
      end
    end

    def initialize(endpoint)
      @endpoint = endpoint
    end

    def fetch
      JSON.parse(self.class.get(endpoint))['ads'].map { |ad| OpenStruct.new(ad) }
    rescue TypeError, JSON::ParserError, NoMethodError
      raise Errors::ExternalAdsFetchError, 'Remote ads fetching error ocurred'
    end
  end
end
