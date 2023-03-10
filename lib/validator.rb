require 'date'

class Validator
  attr_reader :data
  
  def initialize(data)
    @data = data
  end

  def data_checker
    if nome_completo_valido? && aniversario_valido? && senha_valida? && cpf_valido?
      'Válido'
    else
      'Inválido'
    end
  end
  

  private
  
  def nome_completo_valido?
    nome_completo = data[:nome_completo]
    return false if nome_completo.nil?
    nome_completo.match?(/\A\p{L}+(\s+\p{L}+)+\z/)
  end
  
  
  def aniversario_valido?
    aniversario = data[:aniversario]
    aniversario_date = Date.strptime(aniversario, '%d/%m/%Y')
    aniversario_date.month.between?(1, 12) && aniversario_date <= Date.today
  rescue ArgumentError
    false
  end
  
  def senha_valida?
    senha = data[:senha]
    senha && senha.match?(/\A(?=.*\d)(?=.*[A-Z])[\p{Print}]{8,}\z/)
  end
  
  def cpf_valido?
    cpf = data[:cpf]
    return false unless cpf.length == 11 && cpf.match?(/\A\d{11}\z/)
  
    # Calcula o primeiro dígito verificador
    soma = 0
    9.times do |i|
      soma += cpf[i].to_i * (10 - i)
    end
    resto = soma % 11
    if resto < 2
      digito_verificador_1 = 0
    else
      digito_verificador_1 = 11 - resto
    end
  
    # Verifica o primeiro dígito verificador
    return false unless digito_verificador_1 == cpf[9].to_i
  
    # Calcula o segundo dígito verificador
    soma = 0
    10.times do |i|
      soma += cpf[i].to_i * (11 - i)
    end
    resto = soma % 11
    if resto < 2
      digito_verificador_2 = 0
    else
      digito_verificador_2 = 11 - resto
    end
  
    # Verifica o segundo dígito verificador
    digito_verificador_2 == cpf[10].to_i
  end
  
end