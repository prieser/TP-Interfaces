package applicationModel

import modelo.Pais

//Could not find property with name conexionelegida in class class applicationModel.EditarConexionesAppModel
import org.uqbar.commons.utils.Observable
import modelo.MapaMundi
import exceptions.SinConexionAEliminarException
import exceptions.SinConexionParaAgregarException
import exceptions.LugarYaAnadidoException

@Observable
class EditarConexionesAppModel {
	
	@Property Pais paisElegido
	@Property Pais conexionElegida
	@Property Pais paisSeleccionado
	@Property MapaMundi mapamundi
	
	new(Pais pais) {
		this._paisElegido = pais
	}
	
	new(Pais pais, MapaMundi mundi) {
		this._paisElegido = pais
		this._mapamundi = mundi
	}
	
	def eliminarConexion() {
		if(paisSeleccionado != null){
			this.paisElegido.eliminarConexion(paisSeleccionado)
		}else{
			throw new SinConexionAEliminarException("debe escoger un pais para eliminar")
		}
	}
	
	def agregarConexion() {
		if(conexionElegida == null){
			throw new SinConexionParaAgregarException("debe escoger un pais para agregar una conexion")
		}
		else if(this.paisElegido.paisesConConexionAerea.contains(conexionElegida)){
			throw new LugarYaAnadidoException("esta conexion ya ha sido añadida")
		}else{
			this.paisElegido.crearConexionCon(conexionElegida)
		}
	}
}