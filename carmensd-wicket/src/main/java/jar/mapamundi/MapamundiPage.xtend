package jar.mapamundi

import jar.HomePage
import java.util.List
import modelo.Lugar
import modelo.Pais
import org.apache.wicket.markup.html.WebPage
import org.apache.wicket.markup.html.basic.Label
import org.apache.wicket.markup.html.form.Form
import org.apache.wicket.markup.html.panel.FeedbackPanel
import org.apache.wicket.model.CompoundPropertyModel
import org.apache.wicket.model.PropertyModel
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.uqbar.wicket.xtend.XButton
import org.uqbar.wicket.xtend.XListView
import exceptions.AccionInvalidaException

class MapamundiPage extends WebPage {
	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods

	var ManejadorDePaises manejadorDePaises
	List<Pais> paises
	private final HomePage mainPage

	new(HomePage page) {
		this.mainPage = page
		this.manejadorDePaises = new ManejadorDePaises()
		val Form<ManejadorDePaises> form = new Form<ManejadorDePaises>("formulario", new CompoundPropertyModel<ManejadorDePaises>(this.manejadorDePaises))
		agregarTituloDeLaPagina()
		agregarListaDePaises(form)
		agregarMarcoNombrePais(form)
		agregarMarcoCaracteristicasPais(form)
		agregarMarcoLugaresPais(form)
		agregarMarcoConexionesPais(form)
		agregarBotonVolver(form)
		agregarBotonNuevoPais(form)
		agregarBotonEditarPais(form)
		agregarFeedbackPanel(form)
		addChild(form)
	}

	def agregarFeedbackPanel(Form<ManejadorDePaises> form) {
		form.addChild(new FeedbackPanel("feedbackPanel"))
	}

	def agregarMarcoNombrePais(Form<ManejadorDePaises> parent) {
		var nombreDelPais = new PropertyModel(manejadorDePaises, "paisSeleccionado.nombre")
		parent.addChild(new Label("nombrePaisSeleccionado", nombreDelPais))
	}

	def agregarMarcoCaracteristicasPais(Form<ManejadorDePaises> parent) {

		//TODO: Acordate de hacer esto para todos.
		var listViewCaracteristicas = new XListView<String>("paisSeleccionado.caracteristicas")
		listViewCaracteristicas.populateItem = [ item |
			var data = item.modelObject
			item.addChild(new Label("unaCaracteristica", data))
		]
		parent.addChild(listViewCaracteristicas)
	}

	def agregarMarcoLugaresPais(Form<ManejadorDePaises> parent) {
		var listViewLugaress = new XListView<Lugar>("lugaresPaisSeleccionado", new PropertyModel(manejadorDePaises, "paisSeleccionado.lugaresDeInteres"))
		listViewLugaress.populateItem = [ item |
			var data = item.modelObject
			item.addChild(new Label("unLugar", data.nombreLugar))
		]
		parent.addChild(listViewLugaress)
	}

	def agregarMarcoConexionesPais(Form<ManejadorDePaises> parent) {
		var listViewConexiones = new XListView<String>("conexionesPaisSeleccionado", new PropertyModel(manejadorDePaises, "paisSeleccionado.paisesConConexionAereaString"))
		listViewConexiones.populateItem = [ item |
			var data = item.modelObject
			item.addChild(new Label("unaConexion", data))
		]
		parent.addChild(listViewConexiones)
	}

	def agregarListaDePaises(Form<ManejadorDePaises> parent) {
		var listView = new XListView<Pais>("mapamundiDelJuego.listaPaises")
		listView.populateItem = [ item |
			var data = item.modelObject
			item.addChild(new Label("nombreDelPais", data.nombre))
			item.addChild(
				new XButton("seleccionar").onClick = [ |
					manejadorDePaises.paisSeleccionado = item.modelObject
					seleecionarPais(parent)
				]
			)
			item.addChild(
				new XButton("eliminarPais").onClick = [ |
					manejadorDePaises.eliminarPais(item.modelObject)
				]
			)
		]

		parent.addChild(listView)
	}

	def agregarTituloDeLaPagina() {
		add(new Label("titulo", "Mapamundi del Juego"));
	}

	def seleecionarPais(Form<ManejadorDePaises> parent) {
		var paisSeleccionado = this.manejadorDePaises.paisSeleccionado
	}

	def agregarBotonNuevoPais(Form<ManejadorDePaises> parent) {
		var nuevoButton = new XButton("nuevoPais").onClick = [ |
			responsePage = new EditarPaisPage(this, new Pais)
		]
		parent.addChild(nuevoButton)
	}

	def agregarBotonEditarPais(Form<ManejadorDePaises> parent) {
		var nuevoButton = new XButton("editarPais").onClick = [ |
			var paisSeleccionado = this.manejadorDePaises.paisSeleccionado
			if(paisSeleccionado == null) {
				throw new AccionInvalidaException("Todavia no elegiste ningun pais. Elige uno para poder editarlo.")
			}
			responsePage = new EditarPaisPage(this, this.manejadorDePaises.paisSeleccionado)
		]
		parent.addChild(nuevoButton)
	}

	def agregarBotonVolver(Form<ManejadorDePaises> parent) {
		var nuevoButton = new XButton("volver").onClick = [ |
			responsePage = HomePage
		]
		parent.addChild(nuevoButton)
	}
}
