package modelo

import java.util.List

class JuegoA {
	@Property List<Caso> listaDeCasosSinResolver
	@Property CasoE casoActual
	@Property Expediente expedienteDelJuego
	@Property MapaMundi mapamundiDelJuego
	static JuegoA instance = new JuegoA()
	
	def static getInstance() {
		instance
	}
	
	new() {
		mapamundiDelJuego = MapaMundi.getInstance()
		expedienteDelJuego = Expediente.getInstance()
		casoActual = new CasoE("unChoreo",mapamundiDelJuego.listaPaises.get(0),expedienteDelJuego.villanos.get(2))
		listaDeCasosSinResolver = newArrayList()
		listaDeCasosSinResolver.add(casoActual)
		
	}
	
	
}