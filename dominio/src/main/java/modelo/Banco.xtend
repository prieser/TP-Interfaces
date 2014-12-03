package modelo

class Banco extends Lugar {
	
	new(Ocupante elOcupante) {
		super("Banco", elOcupante)
	}
	
	new() {
		super("Banco", null)
	}
	
	
}