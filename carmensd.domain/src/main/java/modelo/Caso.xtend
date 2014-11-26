package modelo

import java.util.List

class Caso {
	
	@Property Villano responsable
	@Property List<Pais> planDeEscape
	@Property List<String> reporte
	@Property String objetoDelRobo
    @Property Pais paisDelRobo
    @Property boolean resuelto;
    @Property String nombreCaso;
    
    new(String nombreCaso, Pais paisDondeOcurrioElRobo){
    	this._responsable = null;
    	this._planDeEscape = newArrayList();
    	this._reporte = null;
    	this._objetoDelRobo = "Diamante";
    	this.paisDelRobo = paisDondeOcurrioElRobo;
    	this._resuelto = false;
    	this.nombreCaso = nombreCaso;
    }
	
}