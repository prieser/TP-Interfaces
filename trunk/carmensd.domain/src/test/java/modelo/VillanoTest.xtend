package modelo

import org.junit.Test
import junit.framework.Assert
import org.junit.Before
import exceptions.SeniaRepetidaException

class VillanoTest {

	Villano villano

	@Before def void setup() {
		villano = new Villano
	}

	@Test def void testAgregarUnaNuevaSeniaCorrectamente() {
		Assert.assertTrue(villano.seniasParticulares.empty)

		villano.agregarNuevaSenia("Esta es una nueva senia")
		Assert.assertTrue("Se espera que el villano tenga la nueva seña: ", villano.seniasParticulares.contains("Esta es una nueva senia"))
	}

	@Test(expected=SeniaRepetidaException) def void testAgregarUnaNuevaSeniaRepetida() {
		Assert.assertTrue(villano.seniasParticulares.empty)

		villano.agregarNuevaSenia("senia repetida")
		villano.agregarNuevaSenia("senia repetida")
		Assert.fail("El villano ya tenia la seña")

	}

	@Test def void testEliminarUnaNuevaSenia() {
		Assert.assertTrue(villano.seniasParticulares.empty)

		villano.seniasParticulares.add("Senia nueva")

		villano.eliminarSenia("Senia nueva")
		Assert.assertTrue("Se espera que el villano ya no tenga la seña eliminada: ", !villano.seniasParticulares.contains("Senia nueva"))
	}

	@Test def void testAgregarUnNuevoHobbieCorrectamente() {
		Assert.assertTrue(villano.hobbies.empty)

		villano.agregarNuevoHobbie("Esta es un nuevo hobbie")
		Assert.assertTrue("Se espera que el villano tenga un nuevo hobbie: ", villano.hobbies.contains("Esta es un nuevo hobbie"))
	}

}
