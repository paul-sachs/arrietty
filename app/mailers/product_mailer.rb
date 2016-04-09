class ProductMailer < ApplicationMailer
	default from: "alice.advocate@gmail.com"

	def contact_email(product, body)
		@body = body

		mail to: product.user.email, subject: "User request for \"#{product.name}\""
	end
end