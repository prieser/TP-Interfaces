package modelo

import java.util.List
import org.uqbar.commons.utils.Observable

@Observable
class Juego {

	@Property List<Caso> listaDeCasosSinResolver
	@Property Caso casoActual
	@Property Expediente expedienteDelJuego
	@Property MapaMundi mapamundiDelJuego
	@Property Detective detectiveACargo
	static Juego instance = new Juego()
	
	def static getInstance() {
		instance
	}

	new() {
		
		//cambiar para que trabaje con CasoE
		
		var pais = new Pais("Inglaterra")
    	pais.lugaresDeInteres.add(new Banco(new Informante("Si, vino aqui un señor preguntando sobre la moneda que usan en Francia e Italia.")))
		pais.lugaresDeInteres.add(new Biblioteca(new Informante("He visto a un hombre sospechoso merodeando por el lugar. Dijo estar averiguando sobre cursos de italiano express.")))
		pais.lugaresDeInteres.add(new Club(new Informante("Vi hace varios dias un hombre por aqui. No dijo nada pero me llamo la atencion su reloj de pulsera.")))
    	var paisConexion1 = new Pais("Francia");
    	var paisConexion2 = new Pais("Italia");
    	pais.paisesConConexionAerea.addAll(paisConexion1, paisConexion2)
		
		
		
		//detectiveACargo = new Detective(null)
		var caso1 = new Caso("El robo de la momia", pais)
		//detectiveACargo.setCaso(caso1)
		
		expedienteDelJuego = new Expediente
		mapamundiDelJuego = new MapaMundi
		listaDeCasosSinResolver = newArrayList()
		listaDeCasosSinResolver.add(caso1)
      	detectiveACargo = new Detective(casoActual)
      
      	var villano1 = new Villano
		var villano2 = new Villano
		
		villano1.agregarNuevaSenia("Gordo")
		villano1.agregarNuevaSenia("Alto")
		villano1.agregarNuevoHobbie("Tenis")
		villano1.agregarNuevoHobbie("Don Satur")
		villano1.cambiarNombreDelVillano("Juan P. Guanpirola")
		
		villano2.agregarNuevaSenia("Flaco")
		villano2.agregarNuevaSenia("Petiso")
		villano2.agregarNuevoHobbie("Fichines")
		villano2.agregarNuevoHobbie("Toddy")
		villano2.cambiarNombreDelVillano("Sofia Sangarlanga")
		
		expedienteDelJuego.agregarVillano(villano1)
		expedienteDelJuego.agregarVillano(villano2)
      
      	//aceptarCaso()
	}

	def aceptarCaso() {
		casoActual = listaDeCasosSinResolver.head
		detectiveACargo.estoyPais = casoActual.paisDelRobo
		//detectiveACargo.setCaso(casoActual)
	}

}
