package modelo

import java.util.ArrayList
import java.util.List
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable

@Observable
class Pais {
	@Property String nombre
	@Property List<String> caracteristicas
	@Property List<Lugar> lugaresDeInteres
	@Property List<Pais> paisesConConexionAerea // Caducada, no la saco x posibles conflictos
	@Property List<String> paisesConConexionAereaString

	new(String nombreDelPais) {
		this._nombre = nombreDelPais
		this._caracteristicas = newArrayList()
		this._lugaresDeInteres = new ArrayList<Lugar>()
		this._paisesConConexionAerea = newArrayList()
		this._paisesConConexionAereaString = newArrayList()
	}

	new() {
		this._lugaresDeInteres = newArrayList()
		this._caracteristicas = newArrayList()
		this._paisesConConexionAerea = newArrayList()
	}
	
	def conexionesToString(){
		paisesConConexionAerea.forEach[ p | paisesConConexionAereaString.add(p.nombre)]
	}

	def crearConexionCon(Pais conexionAAgregar) {
		//recive paises pero guarda el un string con el nombre
		paisesConConexionAereaString.add(conexionAAgregar.nombre)
		conexionAAgregar.paisesConConexionAereaString.add(this.nombre)
		ObservableUtils::firePropertyChanged(this, "paisesConConexionAerea", paisesConConexionAerea)
	}

	def borrarCaracteristica(String string) {
		caracteristicas.remove(string)
		ObservableUtils::firePropertyChanged(this, "caracteristicas", caracteristicas)
	}

	def agregarCaracteristica(String string) {
		this.caracteristicas.add(string)
		ObservableUtils::firePropertyChanged(this, "caracteristicas", caracteristicas)
	}

	def eliminarConexion(Pais pais) {
		this.paisesConConexionAerea.remove(pais)
		ObservableUtils::firePropertyChanged(this, "paisesConConexionAerea", paisesConConexionAerea)
	}

	def eliminarLugar(Lugar lugar) {
		lugaresDeInteres.remove(lugar)
		ObservableUtils::firePropertyChanged(this, "lugaresDeInteres", this.lugaresDeInteres)
	}

	def agregarNuevoLugar(Lugar lugar) {
		lugaresDeInteres.add(lugar)
		ObservableUtils::firePropertyChanged(this, "lugaresDeInteres", this.lugaresDeInteres)
	}

	def getLugarConId(int idDelLugar) {
		var Lugar lugarBuscado = null
		for (Lugar unLugar : this.lugaresDeInteres) {
			if(idDelLugar.equals(unLugar.id)) lugarBuscado = unLugar
		}
		lugarBuscado
	}

}
