package applicationModel

import modelo.Pais
import org.uqbar.commons.utils.Observable
import java.util.List
import org.uqbar.commons.model.ObservableUtils
import exceptions.CampoVacioException
import java.util.ArrayList

@Observable
class ViajarAppModel {

	@Property Pais paisSeleccionado
	@Property List<Pais> recorridoPaises
	@Property Pais paisEnQueEstoy
	
	new(Pais pais){
		this.recorridoPaises = new ArrayList<Pais>
		this.recorridoPaises.add(pais)
		this.paisEnQueEstoy = pais
	}
	
	new(List<Pais> recorridoPaises){
		this.recorridoPaises = recorridoPaises
	}
	
	def viajar() {
		this.recorridoPaises.add(paisSeleccionado)
		this.paisEnQueEstoy = paisSeleccionado
	}
	
	def volver() {
		if(this.recorridoPaises.size > 1){
			this.recorridoPaises.remove(paisEnQueEstoy)
			this.paisEnQueEstoy = this.recorridoPaises.get(this.recorridoPaises.size -1)
		}else{
			throw new CampoVacioException("estas en el principio del recorrido")
		} 
	}
}