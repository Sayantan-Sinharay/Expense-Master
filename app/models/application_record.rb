# frozen_string_literal: true

# Base class for all application models.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
