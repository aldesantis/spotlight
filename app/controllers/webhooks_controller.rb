# frozen_string_literal: true

class WebhooksController < ApplicationController
  def push
    Webhooks::Process.call!(payload: params)
    head :no_content
  end
end
