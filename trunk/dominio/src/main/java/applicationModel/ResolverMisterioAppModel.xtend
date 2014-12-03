package applicationModel

import modelo.Caso
import modelo.Detective
import modelo.Expediente
import modelo.Juego
import modelo.Lugar
import org.uqbar.commons.utils.Observable

@Observable
class ResolverMisterioAppModel {

	@Property Lugar lugarSeleccionado
	@Property Juego juego
	@Property Caso caso
	@Property Expediente expedienteDelJuego
	@Property Detective detectiveACargo

	new(Juego juego, Lugar lugar) {
		this.lugarSeleccionado = lugar
		this.juego = juego
	}

	new(Detective detective, Caso caso, Expediente expediente) {
		this.caso = caso
		this.expedienteDelJuego = expediente
		this.detectiveACargo = detective
	}

	def primerLugar() {
		this.detectiveACargo.estoyPais.lugaresDeInteres.get(0)
	}

	def segundoLugar() {
		this.detectiveACargo.estoyPais.lugaresDeInteres.get(1)
	}

	def tercerLugar() {
		this.detectiveACargo.estoyPais.lugaresDeInteres.get(2)
	}
}
