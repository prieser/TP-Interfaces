package jar.mapamundi

import java.io.Serializable
import modelo.Lugar
import modelo.MapaMundi
import modelo.Pais
import org.uqbar.commons.utils.Observable
import java.util.List
import exceptions.AccionInvalidaException

@Observable
class EditarPaisAppModel implements Serializable {

	@Property String nuevaCaracteristica
	@Property List<String> listaDeCaracteristicasAgregadas
	@Property List<String> listaDeCaracteristicasRemovidas

	@Property Lugar lugarElegido
	@Property List<Lugar> listaDeLugaresAgregados
	@Property List<Lugar> listaDeLugaresRemovidos

	@Property Pais paisDeConexionElegido
	@Property List<Pais> listaDeConexionesAgregadas
	@Property List<Pais> listaDeConexionesRemovidas

	@Property MapaMundi mapamundiDelJuego
	@Property Pais paisEnEdicion

	new(Pais paisAEditar) {
		this.paisEnEdicion = paisAEditar
		this.listaDeCaracteristicasAgregadas = newArrayList()
		this.listaDeCaracteristicasRemovidas = newArrayList()

		this.listaDeLugaresAgregados = newArrayList()
		this.listaDeLugaresRemovidos = newArrayList()

		this.listaDeConexionesAgregadas = newArrayList()
		this.listaDeConexionesRemovidas = newArrayList()

		this.mapamundiDelJuego = MapaMundi.getInstance()
	}

	def listaDePaises() {
		this.mapamundiDelJuego.listaPaises
	}

	def guardarLaNuevaCaracteristica() {
		if(nuevaCaracteristica == null) {
			throw new AccionInvalidaException("Indique una caracteristica antes de agregarla")
		}
		this.paisEnEdicion.agregarCaracteristica(nuevaCaracteristica)
		if(!listaDeCaracteristicasRemovidas.contains(nuevaCaracteristica)) {
			this.listaDeCaracteristicasAgregadas.add(nuevaCaracteristica)
		}
		this.nuevaCaracteristica = null
	}

	def eliminarCaracteristica(String caracteristicaAEliminar) {
		this.paisEnEdicion.borrarCaracteristica(caracteristicaAEliminar)
		if(!listaDeCaracteristicasAgregadas.contains(caracteristicaAEliminar)) {
			this.listaDeCaracteristicasRemovidas.add(caracteristicaAEliminar)
		}
	}

	def guardarElNuevoLugar() {
		if(lugarElegido == null) {
			throw new AccionInvalidaException("Elija un lugar antes de agregarlo")
		}
		this.paisEnEdicion.agregarNuevoLugar(lugarElegido)
		if(!listaDeLugaresRemovidos.contains(lugarElegido)) {
			this.listaDeLugaresAgregados.add(lugarElegido)
		}
	}

	def eliminarLugar(Lugar lugarAEliminar) {
		this.paisEnEdicion.eliminarLugar(lugarAEliminar)
		if(!listaDeLugaresAgregados.contains(lugarAEliminar)) {
			this.listaDeLugaresRemovidos.add(lugarAEliminar)
		}
	}

	def crearLaConexion() {
		if(lugarElegido == null) {
			throw new AccionInvalidaException("Elija una conexion antes de agregarla")
		}
		this.paisEnEdicion.crearConexionCon(paisDeConexionElegido)
		if(!listaDeConexionesRemovidas.contains(paisDeConexionElegido)) {
			this.listaDeConexionesAgregadas.add(paisDeConexionElegido)
		}
	}

	def eliminarConexion(Pais paisADesconectar) {
		this.paisEnEdicion.eliminarConexion(paisADesconectar)
		if(!listaDeConexionesAgregadas.contains(paisADesconectar)) {
			this.listaDeConexionesRemovidas.add(paisADesconectar)
		}
	}

	def guardarPais() {
		
		if(paisEnEdicion.nombre == null) {
			throw new AccionInvalidaException("No se puede guardar el Pais sin indicar un nombre")
		}
		if(!mapamundiDelJuego.paisExiste(paisEnEdicion.nombre)) {
			this.mapamundiDelJuego.agregarPaisNuevo(paisEnEdicion)
		}
	}

	def cancelarCambios() {
		for (Lugar unlugar : this.listaDeLugaresRemovidos) {
			if(!this.paisEnEdicion.lugaresDeInteres.contains(unlugar)) {
				paisEnEdicion.agregarNuevoLugar(unlugar)
			}
		}

		for (Lugar unlugar : this.listaDeLugaresAgregados) {
			paisEnEdicion.eliminarLugar(unlugar)
		}

		for (Pais unPais : this.listaDeConexionesRemovidas) {
			if(!this.paisEnEdicion.paisesConConexionAerea.contains(unPais)) {
				paisEnEdicion.crearConexionCon(unPais)
			}
		}

		for (Pais unPais : this.listaDeConexionesAgregadas) {
			paisEnEdicion.eliminarConexion(unPais)
		}

		for (String unaCaracteristica : this.listaDeCaracteristicasRemovidas) {
			if(!this.paisEnEdicion.caracteristicas.contains(unaCaracteristica)) {
				paisEnEdicion.agregarCaracteristica(unaCaracteristica)
			}
		}

		for (String unaCaracteristica : this.listaDeCaracteristicasAgregadas) {
			paisEnEdicion.borrarCaracteristica(unaCaracteristica)
		}

	}
}
