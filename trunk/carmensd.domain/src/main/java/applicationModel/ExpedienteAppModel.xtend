package applicationModel

import modelo.Expediente
import modelo.Villano
import org.uqbar.commons.utils.Observable

@Observable
class ExpedienteAppModel {

	@Property Villano villanoSeleccionado;
	@Property Expediente expediente;

	new(Expediente expedienteReal) {
		this.expediente = expedienteReal
	}
	
	def guardar(Villano villano) {
		expediente.agregarVillano(villano)
	}

}
