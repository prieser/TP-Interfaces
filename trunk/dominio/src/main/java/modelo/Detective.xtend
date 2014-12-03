package modelo

import exceptions.LugarInvalidoException
import java.util.ArrayList
import java.util.List
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable
import exceptions.PaisInvalidoException

@Observable
class Detective {
	@Property Caso caso
	@Property Pais estoyPais;
	@Property List<String> miListaDePistas;
	@Property Lugar lugarQueVoyAVisitar;
	@Property Pais pasiAlQueQuieroViajar;
	static Detective instance

	static def getInstance() {
		instance
	}

	new(Caso caso) {
		this.caso = caso;
		this.estoyPais = null;
		this.miListaDePistas = new ArrayList<String>();
	}

	def iniciarCaso() {
		this.setEstoyPais(this.getCaso().getPaisDelRobo);
	}

	def viajar(Pais pais) {
		if(estoyPais.paisesConConexionAereaString.contains(pais.nombre)) {
			estoyPais = pais;
			ObservableUtils::firePropertyChanged(this, "estoyPais", this.estoyPais)
		} else {
			throw new PaisInvalidoException("El pais al que intenta viajar no tiene conexion con el pais donde se encuentra ahora")
		}
	}

	def arrestar(Villano villano) {
		this.getCaso().resuelto = true;
		this.getCaso().setResponsable = villano;
	}

	def visitarLugar(int idDelLugarQueVoyAVisitar) {
		var Lugar lugarAVisitar
		lugarAVisitar = this.estoyPais.getLugarConId(idDelLugarQueVoyAVisitar)
		if(lugarAVisitar == null) throw new LugarInvalidoException("Se encuentra en un pais que no tiene el lugar que intenta visitar")
		lugarAVisitar.getInformacion
	}

}
