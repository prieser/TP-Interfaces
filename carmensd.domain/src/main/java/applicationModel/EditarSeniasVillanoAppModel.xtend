package applicationModel

import org.uqbar.commons.utils.Observable
import modelo.Villano

@Observable
class EditarSeniasVillanoAppModel {

	@Property Villano villanoEnEdicion
	@Property String seniaSeleccionada
	@Property String seniaAAgregar

	new(Villano villano) {
		villanoEnEdicion = villano
	}
	
	def eliminarSenia() {
		villanoEnEdicion.eliminarSenia(seniaSeleccionada)
	}

	def agregarSenia() {
		villanoEnEdicion.agregarNuevaSenia(seniaAAgregar)
		seniaAAgregar = ""
	}

}
