package modelo

import java.util.List
import java.util.ArrayList
import exceptions.PaisInvalidoException
import exceptions.LugarInvalidoException

class CasoE extends Caso {

	@Property Pais estoyPais;
	@Property List<String> miListaDePistas;
	@Property Lugar lugarQueVoyAVisitar;
	@Property Pais pasiAlQueQuieroViajar;
	@Property Expediente expediente;
	@Property Villano elResponsable;
	@Property List<String> paisesVisitados;
	
	static CasoE instance

	def static getInstance() {
		instance
	}

	new(String nombreCaso, Pais paisDondeOcurrioElRobo, Villano responsable) {
		super(nombreCaso, paisDondeOcurrioElRobo)
		this.estoyPais = paisDondeOcurrioElRobo;
		this.miListaDePistas = new ArrayList<String>();
		this.elResponsable = responsable;
		//this.setEstoyPais(getPaisDelRobo);
		this.expediente = Expediente.getInstance()
		this.paisesVisitados = newArrayList;
		instance = this
	}

	def viajar(Pais pais) {
		if(estoyPais.paisesConConexionAereaString.contains(pais.nombre)) {
			this.paisesVisitados.add(estoyPais.nombre)
			estoyPais = pais;
		} else {
			throw new PaisInvalidoException("El pais al que intenta viajar no tiene conexion con el pais donde se encuentra ahora")
		}
	}

	def boolean responsableAcertado(Villano acusado){
		if (elResponsable.nombre == acusado.nombre){
			return true
		}else {
			return false
		}
	}
	
	def arrestar(Villano villano) {
		resuelto = true;
		setResponsable = villano;
	}
	
	def visitarLugar(int idDelLugarQueVoyAVisitar) {
		var Lugar lugarAVisitar
		lugarAVisitar = this.estoyPais.getLugarConId(idDelLugarQueVoyAVisitar)
		if(lugarAVisitar == null) throw new LugarInvalidoException("Se encuentra en un pais que no tiene el lugar que intenta visitar")
		lugarAVisitar.getInformacion
	}

}
