package modelo

import junit.framework.Assert
import org.junit.Test
import org.junit.Before

class PaisTest {

	Pais pais
	Ocupante ocupante = new Informante
	Pais paisLimitrofe = new Pais("Israel")
	
	@Before def void setup() {
		pais = new Pais("Egipto")
	}

	@Test def void testAgregarNuevaConexionAOtroPais() {
		pais.crearConexionCon(paisLimitrofe)
		Assert.assertTrue("Se espera que el pais limitrofe se agregue correctamente", pais.paisesConConexionAereaString.contains("Israel"))
	}
	
	@Test def void testBorrarConexionAOtroPais() {
		pais.paisesConConexionAerea.add(paisLimitrofe)
		Assert.assertTrue("Se espera que el pais a borrar, se encuentre previamente cargado", pais.paisesConConexionAerea.contains(paisLimitrofe))
		pais.eliminarConexion(paisLimitrofe)
		Assert.assertFalse("Se espera que el pais limitrofe borrado no se encuentre en la lista", pais.paisesConConexionAerea.contains(paisLimitrofe))
	}

	@Test def void testAgregarCaracteristicaAUnPais() {
		pais.agregarCaracteristica("Caracteristica nueva")
		Assert.assertTrue("Se espera que la lista caracteristica contenga la agregada", pais.caracteristicas.contains("Caracteristica nueva"))
	}

	@Test def void testBorrarCaracteristicaDeUnPais() {
		pais.agregarCaracteristica("Caracteristica para borrar")
		pais.borrarCaracteristica("Caracteristica para borrar")
		Assert.assertTrue("Se espera que la caracteristica sea borrada", pais.caracteristicas.empty)

	}
	
	@Test def void testAgregarNuevoLugarDeInteres() {
		var banco = new Banco(ocupante)
		pais.agregarNuevoLugar(banco)
		Assert.assertTrue("Se espera que el lugar de interes nuevo se agregue correctamente", pais.lugaresDeInteres.contains(banco))
	}
	
	@Test def void testBorrarLugarDeInteres() {
		var banco = new Banco(ocupante)
		pais.lugaresDeInteres.add(banco)
		Assert.assertTrue("Se espera que el lugar de interes a borrar se encuentre previamente cargado", pais.lugaresDeInteres.contains(banco))
		pais.eliminarLugar(banco)
		Assert.assertFalse("Se espera que el lugar borrado no se encuentre mas en la lista", pais.lugaresDeInteres.contains(banco))
	}
	
}
