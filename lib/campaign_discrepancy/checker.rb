# frozen_string_literal: true

require 'campaign_discrepancy/external_ads'

module CampaignDiscrepancy
  include ExternalAds

  class Checker

    def initialize
      @state = []
      @external_ads = []
      @success = true
    end

    def perform
      @state
    end
  end
end
