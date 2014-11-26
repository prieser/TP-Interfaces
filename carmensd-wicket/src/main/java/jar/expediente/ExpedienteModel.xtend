package jar.expediente

import modelo.Villano
import java.util.List
import org.uqbar.commons.utils.Observable
import java.io.Serializable
import modelo.Expediente
import modelo.Sexo
import org.apache.wicket.model.Model
import org.apache.wicket.model.IModel

@Observable
class ExpedienteModel implements Serializable{
	
	@Property Expediente expediente
	@Property Villano villanoSeleccionado
	
	@Property Villano villanoNuevo = null
	@Property String nuevoNombre = "Nuevo Villano"
	@Property String nuevaCaracteristica = "Nueva Caracteristica"
	@Property String nuevoHobbie = "Nuevo Hobbie"
	@Property Sexo nuevoSexo = null
	
	@Property IModel<Sexo> sexos = new Model<Sexo>();
	
	new(){
		this.expediente = Expediente.getInstance();
		primerVillano
	}
	
	def primerVillano(){
		this.villanoSeleccionado = expediente.villanos.get(0)
	}
	
	def seleccionarVillanoNuevo(){
		this.villanoSeleccionado = this.getVillanoNuevo()
	}
	
	def agregarVillanoNuevo(){
		villanoNuevo = new Villano(this.nuevoNombre)
		expediente.agregarVillano(villanoNuevo)
		seleccionarVillanoNuevo
	}
	
	def eliminarVillano(Villano x){
		expediente.quitarVillano(x)
		primerVillano
	}
	
	def sexoUpdate() {
		var s = sexos.toString.substring(56,57)
		//Model:classname=[org.apache.wicket.model.Model]:object=[Femenino]
		villanoSeleccionado.sexo(s)
	}
	
	
}