package modelo

class Informante extends Ocupante{
	
	@Property String miPista;
	
	new(String nuevaPista){
		miPista = nuevaPista;
	}
	
	new() {
		super()
	}
	
	override ejecutarAccion() {
		//si el villano está en el país, nos da la información según la política del lugar
		miPista
	}
	
}