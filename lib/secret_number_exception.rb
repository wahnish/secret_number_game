class ColorChoiceException < StandardError
	attr_accessor :exception_message

	def initialize (exception_message = "ErRoR...ErRoR...smoke and fire!!!")
		super(exception_message)
	end

end