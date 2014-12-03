package modelo

import org.uqbar.commons.utils.Observable

@Observable
abstract class Lugar {
	
	@Property String nombreLugar
	@Property Ocupante ocupante
	@Property int id //TODO: EL ID DEBERIA AUTOINCREMENTARSE Y SER INVISIBLE AL USUARIO. LAS SUBLCLASES NO DEBERIAN TENERLO EN SU CONSTRUCTOR.
	static int contadorIncremental = 0
	
	new(String nombreL, Ocupante elOcupante){
		this._id = contadorIncremental
		this._nombreLugar = nombreL
		this._ocupante = elOcupante
		Lugar.contadorIncremental++
	}
	
	def getInformacion() {
		this.ocupante.ejecutarAccion
	}
}