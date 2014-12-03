package applicationModel

import modelo.Pais
import exceptions.CaracteristicaNoSeleccionadaException
import exceptions.CampoVacioException
import org.uqbar.commons.utils.Observable

@Observable
class EditarCaracteristicasAppModel {
	
	@Property Pais pais
	@Property String caracteristicaAgregar
	@Property String caracteristicaElegida
	
	new(Pais pais){
		this._pais = pais
	}
	
	def eliminarCaracteristica() {
		if(caracteristicaElegida != ""){
			this.pais.borrarCaracteristica(caracteristicaElegida)	
		}else{
			throw new CaracteristicaNoSeleccionadaException("selecciona una caracteristica para eliminar")
		}
	}
	
	def agregarCaracteristica() {
		if(this.caracteristicaAgregar != ""){
			this.pais.agregarCaracteristica(this.caracteristicaAgregar)
		}else{
			throw new CampoVacioException("introduzca una caracteristica para agregar");
		}
	}
}