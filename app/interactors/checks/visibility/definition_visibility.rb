# frozen_string_literal: true

module Checks
  module Visibility
    class DefinitionVisibility < Checks::Visibility::Base
      ERROR = "Definition '%<definition>s' should be private"

      # FIXME: For some reason, all definitions are public in the JSON exported from Stoplight.
      def call
        context.errors = []

        swagger['definitions'].each_value do |definition|
          next unless definition['x-stoplight']['public']
          context.errors << format(ERROR, definition: definition['x-stoplight']['name'])
        end
      end
    end
  end
end
