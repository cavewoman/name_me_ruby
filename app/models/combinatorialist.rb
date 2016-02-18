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
  attr_accessor :real

  def initialize(attributes = {})
    attributes = defaults.merge(attributes.symbolize_keys)
    @options = attributes[:options]
    @real = attributes[:real]
    @combinations = attributes[:combinations]
  end

  def execute
    (1..options.count).to_a.each do |num|
      options.permutation(num).to_a.each{|array| combinations << array.join }
    end
    @combinations = @combinations.uniq
    @combinations = only_real_words(@combinations) if @real
    true
  end

  def only_real_words(words)

  end

  def real_word?(word)
    key = 'd572f99a-439e-4394-876a-738db07d2479'
    response = RestClient.get("http://www.dictionaryapi.com/api/v1/references/collegiate/xml/#{word}?key=#{key}")
    xml = Nokogiri::XML.parse(response)
    suggestions = xml.children.select{|node| node.children.select{|n| n.name == 'suggestion'}.count > 0}
    suggestions.count > 0 ? false : true
  end

  private

  def defaults
    { options: [], combinations: [], real: nil }
  end
  
  def options_available
    unless options.count > 0
      errors.add(:options, 'You must provide at least one option')
      false
    end
  end
  
end
