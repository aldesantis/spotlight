# frozen_string_literal: true

class WebhooksController < ApplicationController
  def push
    head :no_content
  end
end
