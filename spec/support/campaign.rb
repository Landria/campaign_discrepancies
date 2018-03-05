# frozen_string_literal: true

# This class stubs Ruby on Rails Campaign model
class Campaign
  attr_accessor :id, :job_id, :status, :external_reference, :ad_description
  alias description ad_description
end
