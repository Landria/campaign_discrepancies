# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'CampaignDiscrepancy::Checker' do
  let(:subject) { CampaignDiscrepancy::Checker.new }

  let(:campaign_1) do
    instance_double(
      'Campaign',
      id: 11,
      job_id: 52,
      status: :active,
      external_reference: 1,
      ad_description: 'Ruby on Rails Developer'
    )
  end

  let(:campaign_2) do
    instance_double(
      'Campaign',
      id: 12,
      job_id: 52,
      status: :deleted,
      external_reference: 2,
      ad_description: 'Description for campaign 12'
    )
  end

  let(:campaign_3) do
    instance_double(
      'Campaign',
      id: 13,
      job_id: 52,
      status: :paused,
      external_reference: 3,
      ad_description: 'Description for campaign 13'
    )
  end

  let(:result) do
    [
      {
        "remote_reference": 1,
        "discrepancies": [
          "status": {
            "remote": 'enabled',
            "local": 'active'
          },
          "description": {
            "remote": 'Description for campaign 11',
            "local": 'Ruby on Rails Developer'
          }
        ]
      },
      {
        "remote_reference": 3,
        "discrepancies": [
          "status": {
            "remote": 'enabled',
            "local": 'paused'
          }
        ]
      }
    ]
  end

  before do
    allow(Campaign).to receive(:find_by).with(external_reference: 1).and_return(campaign_1)
    allow(Campaign).to receive(:find_by).with(external_reference: 2).and_return(campaign_2)
    allow(Campaign).to receive(:find_by).with(external_reference: 3).and_return(campaign_3)
  end

  context '#perform' do
    it { expect(subject.perform).to eq result }
  end
end
