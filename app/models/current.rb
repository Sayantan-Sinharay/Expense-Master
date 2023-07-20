# frozen_string_literal: true

# Represents a namespace for managing current user attributes.
class Current < ActiveSupport::CurrentAttributes
  attribute :user
end
