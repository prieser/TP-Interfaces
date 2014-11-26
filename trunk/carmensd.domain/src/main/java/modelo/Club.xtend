package modelo

class Club extends Lugar {

	new(Ocupante elOcupante) {
		super("Club", elOcupante)
	}

	new() {
		super("Club", null)
	}

}
