package jar.mapamundi

import modelo.Pais
import org.apache.wicket.markup.html.WebPage
import org.apache.wicket.markup.html.basic.Label
import org.apache.wicket.markup.html.form.Form
import org.apache.wicket.markup.html.form.TextField
import org.apache.wicket.model.CompoundPropertyModel
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.uqbar.wicket.xtend.XButton
import org.uqbar.wicket.xtend.XListView
import org.apache.wicket.markup.html.panel.FeedbackPanel
import modelo.Lugar
import org.apache.wicket.markup.html.form.DropDownChoice
import org.apache.wicket.model.PropertyModel
import org.apache.wicket.markup.html.form.ChoiceRenderer

class EditarPaisPage extends WebPage {
	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods

	private final MapamundiPage parentPage
	var EditarPaisAppModel editarPaisAppModel

	new(MapamundiPage page, Pais paisAEditar) {
		this.parentPage = page
		this.editarPaisAppModel = new EditarPaisAppModel(paisAEditar)
		val Form<EditarPaisAppModel> form = new Form<EditarPaisAppModel>("editarPaisForm", new CompoundPropertyModel<EditarPaisAppModel>(this.editarPaisAppModel))
		agregarCampoNombreDelPais(form)
		agregarCampoNuevaCaracteristica(form)
		agregarListaDeCaracteristicas(form)

		agregarDropDownParaElegirLugar(form)
		agregarListaDeLugares(form)

		agregarDropDownParaElegirPais(form)
		agregarListaDeConexiones(form)

		agregarBotonGuardar(form)
		agregarBotonCancelar(form)
		agregarFeedbackPanel(form)

		addChild(form)
	}

	def agregarFeedbackPanel(Form<EditarPaisAppModel> form) {
		form.addChild(new FeedbackPanel("feedbackPanel"))
	}

	def agregarCampoNombreDelPais(Form<EditarPaisAppModel> form) {
		form.addChild(new TextField<String>("paisEnEdicion.nombre"))
	}

	def agregarCampoNuevaCaracteristica(Form<EditarPaisAppModel> form) {
		form.addChild(new TextField<String>("nuevaCaracteristica"))
		var nuevoButton = new XButton("guardarNuevaCaracteristica").onClick = [ |
			this.editarPaisAppModel.guardarLaNuevaCaracteristica
		]
		form.addChild(nuevoButton)
	}

	def agregarListaDeCaracteristicas(Form<EditarPaisAppModel> form) {
		var listViewCaracteristicas = new XListView<String>("paisEnEdicion.caracteristicas")
		listViewCaracteristicas.populateItem = [ item |
			var data = item.modelObject
			item.addChild(new Label("unaCaracteristica", data))
			item.addChild(
				new XButton("eliminarCaracteristica").onClick = [ |
					this.editarPaisAppModel.eliminarCaracteristica(item.modelObject)
				]
			)
		]
		form.addChild(listViewCaracteristicas)
	}

	def agregarDropDownParaElegirLugar(Form<EditarPaisAppModel> form) {
		form.addChild(new DropDownChoice<Lugar>("lugaresPosibles", new PropertyModel(editarPaisAppModel, "lugarElegido"), this.editarPaisAppModel.paisEnEdicion.lugaresPosibles, new ChoiceRenderer<Lugar>("nombreLugar")))
		form.addChild(
			new XButton("guardarNuevoLugar").onClick = [ |
				this.editarPaisAppModel.guardarElNuevoLugar()
			]
		)
	}

	def agregarListaDeLugares(Form<EditarPaisAppModel> form) {
		var listViewLugares = new XListView<Lugar>("paisEnEdicion.lugaresDeInteres")
		listViewLugares.populateItem = [ item |
			var data = item.modelObject
			item.addChild(new Label("unLugar", data.nombreLugar))
			item.addChild(new XButton("eliminarLugar").onClick = [|this.editarPaisAppModel.eliminarLugar(item.modelObject)])
		]
		form.addChild(listViewLugares)
	}
	
	
	def agregarListaDeConexiones(Form<EditarPaisAppModel> form) {
		var listViewConexiones = new XListView<Pais>("paisEnEdicion.paisesConConexionAerea")
		listViewConexiones.populateItem = [ item |
			var data = item.modelObject
			item.addChild(new Label("unPais", data.nombre))
			item.addChild(new XButton("desconectarPais").onClick = [|this.editarPaisAppModel.eliminarConexion(item.modelObject)])
		]
		form.addChild(listViewConexiones)
	}
	
	def agregarDropDownParaElegirPais(Form<EditarPaisAppModel> form) {
		form.addChild(new DropDownChoice<Pais>("paisesPosibles", new PropertyModel(editarPaisAppModel, "paisDeConexionElegido"), editarPaisAppModel.mapamundiDelJuego.listaPaises, new ChoiceRenderer<Pais>("nombre")))
		form.addChild(
			new XButton("crearNuevaConexion").onClick = [ |
				this.editarPaisAppModel.crearLaConexion()
			]
		)
	}

	def agregarBotonGuardar(Form<EditarPaisAppModel> form) {
		var nuevoButton = new XButton("guardar").onClick = [ |
			this.editarPaisAppModel.guardarPais
			responsePage = this.parentPage
		]
		form.addChild(nuevoButton)
	}

	def agregarBotonCancelar(Form<EditarPaisAppModel> form) {
		var nuevoButton = new XButton("cancelar").onClick = [ |
			this.editarPaisAppModel.cancelarCambios
			responsePage = this.parentPage
		]
		form.addChild(nuevoButton)
	}

}
