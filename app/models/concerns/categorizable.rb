module Categorizable
  extend ActiveSupport::Concern

  EXPENSE_CATEGORIES = [
    "Food & Dining",
    "Transportation",
    "Housing",
    "Utilities",
    "Healthcare",
    "Entertainment",
    "Shopping",
    "Education",
    "Travel",
    "Other"
  ].freeze

  included do
    validates :category, inclusion: { in: EXPENSE_CATEGORIES }
  end

  class_methods do
    def categories
      EXPENSE_CATEGORIES
    end
  end
end
