require 'active_model'

class Combinatorialist
  include ActiveModel::Model
  extend ActiveModel::Callbacks
  include ActiveModel::Validations
  include ActiveModel::Conversion

  validates :options, presence: true
  validate :options_available

  attr_accessor :options

  def initialize(attributes = {})
    attributes = defaults.merge(attributes.symbolize_keys)
    @options = attributes[:options]
  end

  private

  def defaults
    { options: [] }
  end
  
  def options_available
    unless options.count > 0
      errors.add(:options, 'You must provide at least one option')
      false
    end
  end
  
end
