package modelo

import java.util.ArrayList
import java.util.List
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable
import exceptions.SeniaRepetidaException

/**
 * Clase que denota al villano que extiende de Ocupante. Tiene una lista de senias y hobbies (strings).
 */
@Observable
class Villano {

	@Property String nombre
	@Property Sexo sexo
	@Property List<String> seniasParticulares
	@Property List<String> hobbies

	/**
 	* Metodo que cambia el nombre de un villano por otro. Luego dispara el aviso del cambio en la propiedad.
 	*/
	def cambiarNombreDelVillano(String nuevoNombre) {
		nombre = nuevoNombre
		ObservableUtils.firePropertyChanged(this, "nombre", this.nombre);
	}

	/**
	 * Metodo que agrega una seña a la lista de señas que tiene el villano.
	 * Luego de agregar la seña. Dispara una notificacion para refrescar las vistas y mostrar el cambio.
	 */
	def agregarNuevaSenia(String seniaAAgregar) {
		if(seniasParticulares.contains(seniaAAgregar)) {
			throw new SeniaRepetidaException("La senia que intenta agregar ya existe")
		}
		seniasParticulares.add(seniaAAgregar)
		ObservableUtils.firePropertyChanged(this, "seniasParticulares", this.seniasParticulares);
	}

	/**
	 * Metodo que elimina una seña a la lista de señas que tiene el villano.
	 * Luego de eliminar la seña. Dispara una notificacion para refrescar las vistas y mostrar el cambio.
	 */
	def eliminarSenia(String seniaAEliminar) {
		seniasParticulares.remove(seniaAEliminar)
		ObservableUtils.firePropertyChanged(this, "seniasParticulares", this.seniasParticulares);
	}

	/**
	 * Metodo que agrega una hobbbie a la lista de hobbies que tiene el villano.
	 */
	def agregarNuevoHobbie(String hobbieNuevo) {
		hobbies.add(hobbieNuevo)
		ObservableUtils.firePropertyChanged(this, "hobbies", this.hobbies);
	}

	def eliminarHobbie(String hobbieARemover) {
		hobbies.remove(hobbieARemover)
		ObservableUtils.firePropertyChanged(this, "hobbies", this.hobbies);

	}

	new() {
		this._seniasParticulares = new ArrayList<String>
		this._hobbies = new ArrayList<String>
	}
	new(String nombre) {
		this._nombre = nombre
		this._seniasParticulares = new ArrayList<String>
		this._hobbies = new ArrayList<String>
	}

}
