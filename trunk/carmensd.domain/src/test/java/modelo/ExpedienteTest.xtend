package modelo

import org.junit.Before
import junit.framework.Assert
import org.junit.Test
import exceptions.VillanoYaExisteException

class ExpedienteTest {

	Expediente expediente
	Villano villano

	@Before def void setup() {
		expediente = new Expediente
		villano = new Villano("Doctor melocoton")
	}

	@Test def void testAgregarUnNuevoVillanoCorrectamente() {
		expediente.agregarVillano(villano)
		Assert.assertTrue("Se espera que el villano se haya agregado correctamente: ", expediente.villanos.contains(villano))
	}
	
	@Test def void testBuscarVillanoEnLaColeccion() {
		expediente.agregarVillano(villano)
		Assert.assertEquals(villano,expediente.buscarVillanoEnLaColeccion(villano.nombre));
	}
	
	@Test def void testBuscarVillanoEnLaColeccionExNull() {
		expediente.agregarVillano(villano)
		Assert.assertEquals("buscarVillanoEnLaColeccion no encontro a nadie",expediente.buscarVillanoEnLaColeccion("sarlanga").nombre);
	}
	
	
	@Test(expected=VillanoYaExisteException) 
	def void testAgregarUnVillanoConElMismoNombreQueOtro() {
		var villanoRepetido = new Villano
		villano.nombre = "Maloso"
		villanoRepetido.nombre = "Maloso"

		expediente.agregarVillano(villano)
		expediente.agregarVillano(villanoRepetido)
		Assert.fail("Ya estaba Maloso como villano")
	}
	
	

}
