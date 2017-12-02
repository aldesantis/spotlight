# frozen_string_literal: true

module Webhooks
  class Process < ApplicationOrganizer
    organize [Parse, EnqueueAnalysis, ReportStatus]

    accept :payload
    required :payload
  end
end
