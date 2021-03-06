class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout 'mailer'

  def number_to_currency_py(number)
  		number_to_currency(number, :unit => "Gs. ",
  									precision: 0, 
  									format: "%n %u",
  								    :separator => ",", 
  									:delimiter => ".")
	end
end
