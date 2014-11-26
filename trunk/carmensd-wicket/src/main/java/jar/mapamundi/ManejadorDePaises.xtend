package jar.mapamundi

import java.io.Serializable
import modelo.MapaMundi
import modelo.Pais
import org.uqbar.commons.utils.Observable

@Observable
class ManejadorDePaises implements Serializable {

	@Property Pais paisSeleccionado
	@Property MapaMundi mapamundiDelJuego

	new() {
		this.mapamundiDelJuego = MapaMundi.getInstance()
	}
	
	def seleccionarPais(Pais paisElegido){
		this.paisSeleccionado = paisElegido
	}
	
	def eliminarPais(Pais pais) {
		this.mapamundiDelJuego.eliminarPais(pais)
	} 
}
