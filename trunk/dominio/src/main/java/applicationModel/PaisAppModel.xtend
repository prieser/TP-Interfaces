package applicationModel

import java.util.List
import modelo.Lugar
import modelo.MapaMundi
import modelo.Pais
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.ObservableUtils
import exceptions.CampoVacioException

@Observable
class PaisAppModel {
	@Property String flag
	@Property Pais pais
	@Property MapaMundi mapamundi
	@Property List<? extends Lugar> lugaresDeInteres
	
	new(String string, MapaMundi mapamundi) {
		this.mapamundi = mapamundi	
		this.pais = new Pais()
		this.flag = string
	}
	
	new(String string, Pais elPais, MapaMundi mapamundi) {
		this.flag = string
		this.pais = elPais
		this.mapamundi = mapamundi
	}
	
	def agregarPais() {
		if(this.flag.equals("n")){
			for(Pais p :this.mapamundi.listaPaises){
				if(p.nombre.equals(pais.nombre)){
					throw new CampoVacioException("este pais ya ha sido añadido")
				}
			}
			if(pais.nombre != "" && pais.nombre != null){ 
				this.mapamundi.agregarPaisNuevo(pais)
//				this.mapamundi.listaPaises.add(pais)
//				ObservableUtils::firePropertyChanged(this, "mapamundi.listaPaises", this.mapamundi.listaPaises)
			}else{
				throw new CampoVacioException("colocar un nombre al pais")
			}
		}
	}
}
