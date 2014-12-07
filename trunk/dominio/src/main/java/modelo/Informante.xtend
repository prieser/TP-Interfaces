package modelo

class Informante extends Ocupante {

	@Property String pista

	new(String pista) {
		this.pista = pista
	}

	override ejecutarAccion() {
		return pista
	}

}
