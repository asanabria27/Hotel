class InvoiceDetail < ActiveRecord::Base

	belongs_to :services
	belongs_to :invoices

	attr_accessor :service,:ayudante

	before_save :set_precio

	private

		def set_precio
			self.precio = self.subtotal / self.cantidad
		end

end
