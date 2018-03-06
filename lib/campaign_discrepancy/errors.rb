

require 'httparty'
require 'campaign_discrepancy/errors'
require 'settings'
require 'uri'

module CampaignDiscrepancy
  module Errors
    class ExternalAdsFetchError < StandardError; end
  end
end
