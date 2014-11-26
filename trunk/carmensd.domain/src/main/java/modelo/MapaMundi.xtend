package modelo

import java.util.List
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.ObservableUtils
import exceptions.LugarNoExisteException
import exceptions.PaisNoExisteException
import exceptions.PaisRepetidoException
import exceptions.CampoVacioException
import exceptions.AccionInvalidaException

@Observable
class MapaMundi {

	@Property List<Pais> listaPaises
	static MapaMundi instance = new MapaMundi()

	static def getInstance() {
		instance
	}

	new() {
		super()
		listaPaises = newArrayList()
		var india = new Pais("India")
		india.caracteristicas.add("Tiene muchos habitantes")
		india.caracteristicas.add("Hay un rio muy contaminado")
		india.agregarNuevoLugar(new Banco(new Informante("Si, vino aqui un señor preguntando sobre piramides")))
		india.agregarNuevoLugar(new Embajada(new Informante("Si, vino aqui un señor preguntando sobre los faraones")))
		india.agregarNuevoLugar(new Club(new Informante("Si, vino aqui un señor con muchos anillos")))

		var egipto = new Pais("Egipto")
		egipto.caracteristicas.add("Tiene piramides")
		egipto.caracteristicas.add("Hace mucho calor")
		egipto.caracteristicas.add("Hay camellos")
		egipto.agregarNuevoLugar(new Embajada(new Informante("Si, vino aqui un señor preguntando sobre la moneda que usan en Francia e Italia.")))
		egipto.agregarNuevoLugar(new Banco(new Informante("Si, vino aqui un señor mas bien bajito")))
		egipto.agregarNuevoLugar(new Biblioteca(new Informante("Ayer vino un hombre de negro muy extraño")))

		var suda = new Pais("Sudafrica")
		suda.caracteristicas.add("En el pasado era colonia inglesa")
		suda.agregarNuevoLugar(new Banco(new Cuidador()))
		suda.agregarNuevoLugar(new Biblioteca(new Cuidador()))
		suda.agregarNuevoLugar(new Club(new Cuidador()))

		india.crearConexionCon(egipto)
		egipto.crearConexionCon(suda)
		listaPaises.addAll(india, egipto, suda)
	}

	def eliminarPais(Pais paisSeleccionado) {
		if(!paisSeleccionado.paisesConConexionAereaString.empty) {
			throw new AccionInvalidaException("El pais que intena borrar tiene conexiones a otros paises. Quite estas conexiones para poder borrarlo.")
		} 
			this.listaPaises.remove(paisSeleccionado)
			ObservableUtils::firePropertyChanged(this, "listaPaises", this.listaPaises)
	}

	def agregarPaisNuevo(Pais pais) {

		if(pais.nombre.empty) {
			throw new CampoVacioException("El pais que intenta agregar no tiene nombre")
		}
 		
		if(paisExiste(pais.nombre)) {
			throw new PaisRepetidoException("El pais con ese nombre ya existe")
		} 

		listaPaises.add(pais)
		ObservableUtils::firePropertyChanged(this, "listaPaises", this.listaPaises)
	}
	

	def getLugarConId(int idDelLugar) {
		var Lugar lugarBuscado = null
		for (Pais unPais : this.listaPaises) {
			if(lugarBuscado == null) lugarBuscado = unPais.getLugarConId(idDelLugar) // solamente busca el lugar si todavia no lo encontro
		}

		if(lugarBuscado == null) throw new LugarNoExisteException("El lugar no existe.")
		lugarBuscado
	}

	def getPais(String nombreDelPais) {
		var Pais paisBuscado = null
		for (Pais unPais : this.listaPaises) {
			if(nombreDelPais.equals(unPais.nombre)) paisBuscado = unPais
		}

		if(paisBuscado == null) throw new PaisNoExisteException("El pais no existe.")
		paisBuscado
	}
	
	def paisExiste(String nombre) {
		listaPaises.exists[unPais|nombre.equalsIgnoreCase(unPais.nombre)]
	}

}
