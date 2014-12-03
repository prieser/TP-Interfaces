package modelo

import java.util.List
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.ObservableUtils
import exceptions.LugarNoExisteException
import exceptions.PaisNoExisteException

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
		india.lugaresDeInteres.add(new Banco(new Informante("Si, vino aqui un señor preguntando sobre piramides")))
		india.lugaresDeInteres.add(new Embajada(new Informante("Si, vino aqui un señor preguntando sobre los faraones")))
		india.lugaresDeInteres.add(new Club(new Informante("Si, vino aqui un señor con muchos anillos")))

		var egipto = new Pais("Egipto")
		egipto.lugaresDeInteres.add(new Embajada(new Informante("Si, vino aqui un señor preguntando sobre la moneda que usan en Francia e Italia.")))
		egipto.lugaresDeInteres.add(new Banco(new Informante("Si, vino aqui un señor mas bien bajito")))
		egipto.lugaresDeInteres.add(new Biblioteca(new Informante("Ayer vino un hombre de negro muy extraño")))
		
		var korea = new Pais("Korea")
		korea.lugaresDeInteres.add(new Embajada(new Cuidador()))
		korea.lugaresDeInteres.add(new Banco(new Cuidador()))
		korea.lugaresDeInteres.add(new Biblioteca(new Cuidador()))
		
		var china = new Pais("China")
		china.lugaresDeInteres.add(new Embajada(new Cuidador()))
		china.lugaresDeInteres.add(new Banco(new Cuidador()))
		china.lugaresDeInteres.add(new Biblioteca(new Cuidador()))

		var suda = new Pais("Sudafrica")
		suda.lugaresDeInteres.add(new Banco(new Cuidador()))
		suda.lugaresDeInteres.add(new Biblioteca(new Cuidador()))
		suda.lugaresDeInteres.add(new Club(new Cuidador()))

		india.crearConexionCon(egipto)
		india.crearConexionCon(korea)
		india.crearConexionCon(china)
		egipto.crearConexionCon(suda)
		listaPaises.addAll(india, egipto, suda)
	}

	def eliminarPais(Pais paisSeleccionado) {
		this.listaPaises.remove(paisSeleccionado)
		ObservableUtils::firePropertyChanged(this, "listaPaises", this.listaPaises)
	}

	def agregarPaisNuevo(Pais pais) {
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

}
