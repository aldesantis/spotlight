# frozen_string_literal: true

module Analyses
  class Perform < ApplicationOrganizer
    accept :analysis
    required :analysis

    organize MarkRunning, Checkout, ParseConfig, MarkCompleted
  end
end
