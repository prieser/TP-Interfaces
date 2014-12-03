package applicationModel

import modelo.Expediente
import modelo.Villano
import org.uqbar.commons.utils.Observable

@Observable
class VillanoAppModel {

	@Property Villano villanoEnEdicion
	@Property Expediente expediente

	new(Expediente expedienteReal, Villano villano) {
		villanoEnEdicion = villano
		expediente = expedienteReal
	}

	def guardarElNuevoVillano() {
		expediente.agregarVillano(villanoEnEdicion)
	}

	def actualizarElVillano() {
		expediente.actualizarVillano(villanoEnEdicion)
	}
}
