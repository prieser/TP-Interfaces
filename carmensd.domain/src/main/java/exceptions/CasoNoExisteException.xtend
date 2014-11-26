package exceptions

import org.uqbar.commons.model.UserException

class CasoNoExisteException extends UserException {
	
	new(String message) {
		super(message)
	}
}