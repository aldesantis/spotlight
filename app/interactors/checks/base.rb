# frozen_string_literal: true

module Checks
  class Base < ApplicationInteractor
    accept :swagger
    required :swagger
  end
end
