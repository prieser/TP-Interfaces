package modelo

import java.util.ArrayList
import java.util.List
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.Entity
import exceptions.AccionInvalidaException
import exceptions.CaracteristicaRepetidaException
import exceptions.CampoVacioException
import exceptions.LugarYaAnadidoException

@Observable
class Pais extends Entity {
	@Property String nombre
	@Property List<String> caracteristicas
	@Property List<Lugar> lugaresDeInteres
	@Property List<Lugar> lugaresPosibles
	@Property List<Pais> paisesConConexionAerea // Caducada, no la saco x posibles conflictos
	@Property List<String> paisesConConexionAereaString

	new(String nombreDelPais) {
		this.nombre = nombreDelPais
		this.caracteristicas = newArrayList()
		this.lugaresDeInteres = new ArrayList<Lugar>()
		this.lugaresPosibles = new ArrayList<Lugar>()
		var banco = new Banco()
		var biblioteca = new Biblioteca()
		var embajada = new Embajada()
		var club = new Club()
		this.lugaresPosibles.addAll(banco, biblioteca, embajada, club)
		this.paisesConConexionAereaString = newArrayList()
		this.paisesConConexionAerea = newArrayList()
	}

	new() {
		this.nombre = null
		this.caracteristicas = newArrayList()
		this.lugaresDeInteres = new ArrayList<Lugar>()
		this.lugaresPosibles = new ArrayList<Lugar>()
		var banco = new Banco()
		var biblioteca = new Biblioteca()
		var embajada = new Embajada()
		var club = new Club()
		this.lugaresPosibles.addAll(banco, biblioteca, embajada, club)
		this.paisesConConexionAereaString = newArrayList()
		this.paisesConConexionAerea = newArrayList()
	}

	def conexionesToString() {
		paisesConConexionAerea.forEach[p|paisesConConexionAereaString.add(p.nombre)]
	}

	def crearConexionCon(Pais conexionAAgregar) {
		if(this.paisesConConexionAereaString.contains(conexionAAgregar.nombre) || this.nombre.equalsIgnoreCase(conexionAAgregar.nombre)) {
			throw new AccionInvalidaException("La conexion que intenta crear ya existe o es invalida")
		}

		this.paisesConConexionAerea.add(conexionAAgregar)
		conexionAAgregar.paisesConConexionAerea.add(this)

		paisesConConexionAereaString.add(conexionAAgregar.nombre)
		conexionAAgregar.paisesConConexionAereaString.add(this.nombre)
	}

	def eliminarConexion(Pais pais) {
		this.paisesConConexionAerea.remove(pais)
		pais.paisesConConexionAerea.remove(this)

		this.paisesConConexionAereaString.remove(pais.nombre)
		pais.paisesConConexionAereaString.remove(this.nombre)
	}

	def borrarCaracteristica(String string) {
		caracteristicas.remove(string)
	}

	def agregarCaracteristica(String string) {
		if(string.empty) {
			throw new CampoVacioException("Esta intentando agregar una caracteristica vacia")
		}

		if(this.caracteristicas.contains(string)) {
			throw new CaracteristicaRepetidaException("La caracteristica que intenta agregar ya existe")
		}
		this.caracteristicas.add(string)
		ObservableUtils::firePropertyChanged(this, "caracteristicas", caracteristicas)
	}

	def eliminarLugar(Lugar lugar) {
		lugaresDeInteres.remove(lugar)
		lugaresPosibles.add(lugar)
		ObservableUtils::firePropertyChanged(this, "lugaresDeInteres", this.lugaresDeInteres)
	}

	def agregarNuevoLugar(Lugar lugar) {
		if(this.lugaresDeInteres.size == 3) {
			throw new AccionInvalidaException("No se pueden cargar mas lugares a este pais. Ya alncanzo el maximo permitido")
		}

		if(estaEnLaListaDeLugaresPosibles(lugar)) {
			lugaresDeInteres.add(lugar)
			removerLugarPosible(lugar)
		} else {
			throw new LugarYaAnadidoException("El lugar que intenta agregar ya pertenece al pais")

		}
	}

	def getLugarConId(int idDelLugar) {
		var Lugar lugarBuscado = null
		for (Lugar unLugar : this.lugaresDeInteres) {
			if(idDelLugar.equals(unLugar.id)) lugarBuscado = unLugar
		}
		lugarBuscado
	}

	def estaEnLaListaDeLugaresPosibles(Lugar lugarAAgregar) {
		return (lugaresPosibles.exists[unLugar|unLugar.nombreLugar == lugarAAgregar.nombreLugar])
	}

	def removerLugarPosible(Lugar lugarARemover) {
		var Lugar lugarBuscado
		for (Lugar unLugar : this.lugaresPosibles) {
			if(lugarARemover.nombreLugar.equals(unLugar.nombreLugar)) {
				lugarBuscado = unLugar
			}
		}
		lugaresPosibles.remove(lugarBuscado)
	}

	override equals(Object objeto) {
		var resultado = false
		if(objeto != null) {
			resultado = (this.nombre == (objeto as Pais).nombre)
		}
		return resultado
	}

}
