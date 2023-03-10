require_relative 'validator'
class DataControl
  attr_reader :data_list
  
  
  def initialize(data_list)
    @data_list = data_list
  end
  
  def validate_data_list
    invalid_indices = []
    data_list.each_with_index do |data, i|
      validator = Validator.new(data)
      invalid_indices << i unless validator.data_checker == 'Válido'
    end
    invalid_indices.empty? ? "Todos são válidos" : invalid_indices
  end
end
