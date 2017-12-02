# frozen_string_literal: true

class WebhooksController < ApplicationController
  def push
    result = Webhooks::Process.call(payload: params)

    if result.success?
      head :no_content
    else
      render status: :unprocessable_entity, json: {
        error_type: result.error_type,
        error_message: result.error_message
      }
    end
  end
end
