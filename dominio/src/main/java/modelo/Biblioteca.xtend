package modelo

class Biblioteca extends Lugar {

	new(Ocupante elOcupante) {
		super("Biblioteca", elOcupante)
	}
	
	new() {
		super("Biblioteca", null)
	}

}
