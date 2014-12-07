package modelo

import modelo.Ocupante

class Cuidador extends Ocupante {

	new() {
	}
	
	override ejecutarAccion() {
		return "Lo siento, creo que se ha equivocado de ciudad"
	}
	
}
