package applicationModel

import modelo.Lugar
import org.uqbar.commons.utils.Observable

@Observable
class LugarAppModel {

	@Property Lugar lugarQueEstoyVisitando
	@Property String nombreDelCasoQueEstoyResolviendo

	new(Lugar lugarQueVoyAVisitar) {
		lugarQueEstoyVisitando = lugarQueVoyAVisitar
	}
	
	def pistaDelLugar() {
		lugarQueEstoyVisitando.ocupante.ejecutarAccion()
	}
}
