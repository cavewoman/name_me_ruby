require 'active_model'

class Combinatorialist
  include ActiveModel::Model
  extend ActiveModel::Callbacks
  include ActiveModel::Validations
  include ActiveModel::Conversion

  validates :options, presence: true
  validate :options_available

  attr_accessor :options
  attr_accessor :combinations

  def initialize(attributes = {})
    attributes = defaults.merge(attributes.symbolize_keys)
    @options = attributes[:options]
    @combinations = attributes[:combinations]
  end

  def execute
    (1..options.count).to_a.each do |num|
      options.permutation(num).to_a.each{|array| combinations << array.join }
    end
    true
  end

  private

  def defaults
    { options: [], combinations: [] }
  end
  
  def options_available
    unless options.count > 0
      errors.add(:options, 'You must provide at least one option')
      false
    end
  end
  
end
