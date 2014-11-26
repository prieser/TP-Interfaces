package modelo

import exceptions.VillanoNoExisteException
import exceptions.VillanoYaExisteException
import java.util.List
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable
import exceptions.UltimoSospechosoException

/**
 * Clase Expediente denota a la coleccion de villanos disponibles.
 */
@Observable
class Expediente {

	@Property List<Villano> villanos;
	static Expediente instance = new Expediente();

	static def getInstance() {
		instance
	}

	new() {
		villanos = newArrayList()
		fabricarVillanos()
	}

	def agregarVillano(Villano villanoAAgregar) {
		if(villanoExiste(villanoAAgregar.nombre)) throw new VillanoYaExisteException("El villano que intenta ingresar ya existe.")
		else{
			villanos.add(villanoAAgregar)	
		}
		ObservableUtils.firePropertyChanged(this, "villanos", this.villanos);
	}

	def actualizarVillano(Villano villanoAAgregar) {
		var villanoBuscado = buscarVillanoEnLaColeccion(villanoAAgregar.nombre)
		if(villanoBuscado == null) throw new VillanoNoExisteException("El villano que intenta modificar no existe")
		villanos.remove(villanoBuscado)
		villanos.add(villanoAAgregar)
		ObservableUtils.firePropertyChanged(this, "villanos", this.villanos);
	}
	def quitarVillano(Villano v){
		if(villanos.size()==1) throw new UltimoSospechosoException("Intenta eliminar el ultimo sospechozo, Sin Villanos no hay Trabajo!")
		villanos.remove(v)
	}

	def villanoExiste(String nombre) {
		villanos.exists[unVillano|nombre.equalsIgnoreCase(unVillano.nombre)]
	}

	/** Metodo que dado el nombre de un villano, lo busca en la coleccion de villanos que tiene el expdiente. En caso de no encontrarlo, retorna null */
	def buscarVillanoEnLaColeccion(String nombreDelVillano) {
		var Villano villanoBuscado = new Villano
		villanoBuscado.nombre = "buscarVillanoEnLaColeccion no encontro a nadie"
		for (Villano unVillano : this.villanos) {
			if(nombreDelVillano.equalsIgnoreCase(unVillano.nombre)) villanoBuscado = unVillano
		}
		villanoBuscado
	}
	
	def fabricarVillanos(){
		var villano1 = new Villano
		var villano2 = new Villano
		var villano3 = new Villano
		
		villano1.agregarNuevaSenia("Gordo")
		villano1.agregarNuevaSenia("Alto")
		villano1.agregarNuevoHobbie("Tenis")
		villano1.agregarNuevoHobbie("Don Satur")
		villano1.cambiarNombreDelVillano("Juan P. Guanpirola")
		villano1.sexoMasculino
		
		villano2.agregarNuevaSenia("Flaco")
		villano2.agregarNuevaSenia("Petiso")
		villano2.agregarNuevoHobbie("Fichines")
		villano2.agregarNuevoHobbie("Toddy")
		villano2.cambiarNombreDelVillano("Sofia Sangarlanga")
		villano2.sexoFemenino
		
		villano3.agregarNuevaSenia("Flaco")
		villano3.agregarNuevaSenia("con rulos")
		villano3.agregarNuevoHobbie("futbol")
		villano3.agregarNuevoHobbie("bulos")
		villano3.cambiarNombreDelVillano("Valderrama")
		
		agregarVillano(villano1)
		agregarVillano(villano2)
		agregarVillano(villano3)
	}
}
