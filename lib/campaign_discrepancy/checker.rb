# frozen_string_literal: true

require 'campaign_discrepancy/external_ads'
require 'campaign_discrepancy/analyzer'

module CampaignDiscrepancy
  class Checker
    include Analyzer

    attr_accessor :state, :errors

    def self.run
      new.run
    end

    def initialize
      @state = []
      @errors = []
    end

    def run
      begin
        ExternalAds.fetch.each do |ad|
          state << difference(ad)
        end

        state.compact!
      rescue Errors::ExternalAdsFetchError, NoMethodError => e
        @errors << e
      end

      self
    end

    def success
      @errors.empty?
    end
  end
end
