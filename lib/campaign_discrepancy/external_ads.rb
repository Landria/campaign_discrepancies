# frozen_string_literal: true

require 'httparty'
require 'settings'
require 'uri'

module CampaignDiscrepancy
  class ExternalAds
    include ::HTTParty

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
    end
  end
end
