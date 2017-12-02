# frozen_string_literal: true

module Webhooks
  class Process < ApplicationInteractor
    accept :payload
    required :payload

    def call
      Rails.logger.debug payload.inspect
    end
  end
end
