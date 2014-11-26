package applicationModel

import modelo.Villano
import org.uqbar.commons.utils.Observable

@Observable
class EditarHobbiesVillanoAppModel {

	@Property Villano villanoEnEdicion
	@Property String hobbieSeleccionado
	@Property String hobbieAAgregar

	new(Villano villano) {
		villanoEnEdicion = villano
	}

	def eliminarHobbie() {
		villanoEnEdicion.eliminarHobbie(hobbieSeleccionado)
	}

	def agregarHobbie() {
		villanoEnEdicion.agregarNuevoHobbie(hobbieAAgregar)
		hobbieAAgregar = ""
	}
}
