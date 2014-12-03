package applicationModel

import modelo.Pais
import org.uqbar.commons.utils.Observable
import modelo.MapaMundi

@Observable
class MapaMundiAppModel {
	@Property Pais paisSeleccionado;
	@Property MapaMundi mapamundi;
	
	new(MapaMundi mapamundi){
		this._mapamundi = mapamundi
	}
	
	def removerPais(){
		this.mapamundi.eliminarPais(paisSeleccionado)
	}
}