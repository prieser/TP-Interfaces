package applicationModel

import modelo.Caso
import modelo.Villano
import modelo.Expediente
import org.uqbar.commons.utils.Observable

@Observable
class OrdenDeArrestoAppModel {
	var Caso caso
	@Property Villano villanoAArrestar
	var Expediente expediente
	@Property Villano villanoSeleccionado
	
	new(Caso elCaso, Expediente elExpediente) {
		this.caso = elCaso
		this.expediente = elExpediente
	}
	
	
	
	
	
	//////////////////////////////////////////ACCESORS///////////////////////////////////
	
	def getCaso(){
		return caso
	}
	
	def getExpediente(){
		return expediente
	}
	
}