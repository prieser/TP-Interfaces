package modelo

abstract class Ocupante {

	@Property String pista;
	
	def abstract String ejecutarAccion();
	
	
}