package modelo;

import org.junit.Before;
import org.junit.Test;
import junit.framework.Assert

public class MapamundiTest {

	MapaMundi mapamundi
	Pais pais1
	Pais pais2

	@Before def void setup() {
		mapamundi = new MapaMundi
		pais1 = new Pais("Marruecos")
		pais2 = new Pais("Sudan")
		mapamundi.listaPaises.addAll(pais1, pais2)
	}

	@Test def void testEliminarUnPais() {
		mapamundi.eliminarPais(pais1)
		Assert.assertTrue("Se espera que el pais eliminado ya no se encuentre en la lista de paises", !mapamundi.listaPaises.contains(pais1))
	}
	
	@Test def void testAgregarUnPaisNuevo(){
		var paisNuevo = new Pais("China")
		mapamundi.agregarPaisNuevo(paisNuevo)
		Assert.assertTrue("Se espera que el pais agregado se encuentre en la lista de paises", mapamundi.listaPaises.contains(paisNuevo))
	}
	
	@Test def void testBuscarUnLugar() {
		var club = new Club()
		var biblioteca = new Biblioteca()
		var embajada = new Embajada()
		club.id = 3
		biblioteca.id = 4
		embajada.id = 5
		pais1.lugaresDeInteres.addAll(club, biblioteca, embajada)
		
		var lugar1 = mapamundi.getLugarConId(3)
		var lugar2 = mapamundi.getLugarConId(4)
		var lugar3 = mapamundi.getLugarConId(5)
		Assert.assertEquals(club, lugar1)
		Assert.assertEquals(biblioteca, lugar2)
		Assert.assertEquals(embajada, lugar3)
	}

}
