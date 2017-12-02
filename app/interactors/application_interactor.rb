# frozen_string_literal: true

class ApplicationInteractor
  include Interactor

  class << self
    def accept(*keys)
      delegate(*keys, to: :context)
    end

    def required(*keys)
      before do
        keys.each do |key|
          fail ArgumentError, "#{key} is required" unless context.send(key)
        end
      end
    end
  end
end
