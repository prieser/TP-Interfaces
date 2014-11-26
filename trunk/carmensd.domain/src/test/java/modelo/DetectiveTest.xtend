package modelo

import org.junit.Assert
import org.junit.Before
import org.junit.Test

class DetectiveTest {

	Detective detective;
	Caso caso;

	var Biblioteca biblioteca = new Biblioteca(new Cuidador());
	var Embajada embajada = new Embajada(new Cuidador());

	Cuidador cuidador = new Cuidador();
	var Club club = new Club(cuidador);

	@Before def void setup() {
		caso = new Caso("Robo de diamantes", new Pais("Ruanda"));
		detective = new Detective(caso);
		
		val lugaresInteres = newArrayList(club, embajada, biblioteca)
		caso.paisDelRobo.lugaresDeInteres = lugaresInteres;
	}

	@Test def void testIniciarCaso() {
		detective.iniciarCaso();
		Assert.assertEquals("Verifico que el detective se encuentra en el pais del caso:","Ruanda", detective.estoyPais.nombre);
	}
	
	@Test def void testViajar() {
		var paisActual = new Pais("Sudan")
		var paisDestino = new Pais("Argelia")
		paisActual.crearConexionCon(paisDestino)
		detective.estoyPais = paisActual
		detective.viajar(paisDestino)
		Assert.assertEquals("Se espera que el detective viaje hasta Argelia", paisDestino, detective.estoyPais)
	}
}
