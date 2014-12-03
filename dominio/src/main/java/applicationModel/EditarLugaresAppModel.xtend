package applicationModel

import exceptions.CantidadLugaresLlenoException
import exceptions.CaracteristicaNoSeleccionadaException
import exceptions.LugarYaAnadidoException
import modelo.Lugar
import modelo.Pais
import org.uqbar.commons.utils.Observable

@Observable
class EditarLugaresAppModel {
	
	@Property Pais paisElegido
	@Property Lugar lugarElegido
	@Property Lugar lugarElegidoAEliminar
	
	
	new(Pais pais) {
		this._paisElegido = pais
	}
	
	
	def agregarLugar() {
		if(this.paisElegido.lugaresDeInteres.contains(lugarElegido)){
			throw new LugarYaAnadidoException("este lugar ya lo ha añadido, seleccione otro")
		}
		else if(paisElegido.lugaresDeInteres.size == 3){
			throw new CantidadLugaresLlenoException("se permiten agregar hasta tres lugares por país")
		}else{
			this.paisElegido.agregarNuevoLugar(lugarElegido)
		}
	}
	
	def eliminarLugar() {
		if(lugarElegidoAEliminar != null){
			this.paisElegido.eliminarLugar(lugarElegidoAEliminar)
		}else{
			throw new CaracteristicaNoSeleccionadaException("seleccione un lugar para eliminar")
		}
	}

}