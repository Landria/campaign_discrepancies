# frozen_string_literal: true

require 'campaign_discrepancy/external_ads'

module CampaignDiscrepancy
  class Checker
    attr_accessor :state, :external_ads, :errors

    METRICS = { status: :status, description: :ad_description }.freeze

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
      rescue NoMethodError => e
        @errors << e
      end

      self
    end

    def success
      @errors.empty?
    end

    private

    def difference(ad)
      external_reference = ad.reference.to_i
      campaign = Campaign.find_by(external_reference: external_reference)
      discrepancies = find_discrepancies(ad, campaign)

      { remote_reference: external_reference, discrepancies: [discrepancies] } unless discrepancies.empty?
    end

    def find_discrepancies(ad, campaign)
      discrepancies = {}

      METRICS.each_pair do |metric|
        discrepancies[metric[0]] = format_discrapency(ad, campaign, metric) \
          unless send("#{metric[0]}_equals?", ad.send(metric[0]), campaign.send(metric[1]))
      end

      discrepancies
    end

    def format_discrapency(ad, campaign, metric)
      { remote: ad.send(metric[0]).to_s, local: campaign.send(metric[1]).to_s }
    end

    METRICS.each_key do |metric|
      define_method("#{metric}_equals?") do |remote_m, local_m|
        remote_m.to_s == local_m.to_s
      end
    end

    def status_equals?(external_status, local_status)
      case external_status
      when 'disabled'
        local_status == :paused || local_status == :deleted
      when 'enabled'
        local_status == :active
      end
    end
  end
end
