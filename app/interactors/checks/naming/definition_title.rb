# frozen_string_literal: true

module Checks
  module Naming
    class DefinitionTitle < Checks::Naming::Base
      ERROR = "Definition '%<actual>s' should be named '%<expected>s'"

      def call
        context.errors = []

        swagger['definitions'].each_value do |definition|
          expected = titleize(definition['title'])
          actual = definition['title']

          next unless expected != actual
          context.errors << format(ERROR, actual: actual, expected: expected)
        end
      end
    end
  end
end
