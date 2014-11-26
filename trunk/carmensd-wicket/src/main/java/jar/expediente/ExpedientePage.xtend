package jar.expediente

import jar.HomePage
import modelo.Sexo
import modelo.Villano
import org.apache.wicket.markup.html.WebPage
import org.apache.wicket.markup.html.basic.Label
import org.apache.wicket.markup.html.form.Form
import org.apache.wicket.markup.html.form.Radio
import org.apache.wicket.markup.html.form.RadioGroup
import org.apache.wicket.markup.html.form.TextField
import org.apache.wicket.markup.html.panel.FeedbackPanel
import org.apache.wicket.model.CompoundPropertyModel
import org.apache.wicket.model.Model
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.uqbar.wicket.xtend.XButton
import org.uqbar.wicket.xtend.XLink
import org.uqbar.wicket.xtend.XListView

class ExpedientePage extends WebPage {
	
	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	
	private final HomePage homePage
	ExpedienteModel expediente
	
	 new(HomePage page) {
	 	this.homePage = page
	 	this.expediente = new ExpedienteModel()
	 	val Form<ExpedienteModel> eform = new Form<ExpedienteModel>("eform",new CompoundPropertyModel<ExpedienteModel>(this.expediente))
	 	add(new Label("titulo", "Expediente del Juego"));
	 	agregarListaDeVillanos(eform)
	 	
	 	mostrarDatosDelVillanoSeleccionado(eform)
	 	nuevoVillano(eform)
	 	agregarBotonDeVolver(eform)
	 	agregarFeedbackPanel(eform)
	 	addChild(eform)
	 	
    }
    
	def agregarListaDeVillanos(Form<ExpedienteModel> parent) {
		var listView = new XListView<Villano>("expediente.villanos")
		listView.populateItem = [ item |
			var data = item.modelObject
			item.addChild(new Label("nombreDelVillano", data.nombre))
			item.addChild(
				new XButton("seleccionarVillano").onClick = [ |
					expediente.villanoSeleccionado = item.modelObject
				]
			)
			item.addChild(
				new XButton("eliminarVillano").onClick = [ |
					expediente.eliminarVillano(item.modelObject)
				]
			)
		]

		parent.addChild(listView)
	}
	
	def mostrarDatosDelVillanoSeleccionado(Form<ExpedienteModel> parent) {
		parent.addChild(new Label("villanoSeleccionado.nombre"))
		parent.addChild(new Label("villanoSeleccionado.sexo"))
		//
		val RadioGroup group = new RadioGroup("group", expediente.sexos);
		group.addChild(new Radio("indef", new Model<Sexo>(Sexo.Indefinido)))
		group.addChild(new Radio("fem", new Model<Sexo>(Sexo.Femenino)))
		group.addChild(new Radio("masc", new Model<Sexo>(Sexo.Masculino)))
		group.addChild(new XButton("cambioDeSexo") => [ onClick = [| expediente.sexoUpdate ]]) //contador=selected.toString.substring(56,57)
		parent.add(group);
		//
		parent.addChild(new TextField<String>("nuevaCaracteristica"))
		parent.addChild(new XButton("agregarNuevaCaracteristica") => [
						onClick = [|
							expediente.villanoSeleccionado.agregarNuevaSenia(expediente.nuevaCaracteristica)
						]
				    ])
		agregarListaDeCaracteristicas(parent)
		parent.addChild(new TextField<String>("nuevoHobbie"))
		parent.addChild(new XButton("agregarHobbie") => [
						onClick = [|
							expediente.villanoSeleccionado.agregarNuevoHobbie(expediente.nuevoHobbie)
						]
				    ])
		agregarListaDeHobbies(parent)
	}
	
	def agregarListaDeCaracteristicas(Form<ExpedienteModel> parent) {
		var listView = new XListView<String>("villanoSeleccionado.seniasParticulares")
		listView.populateItem = [ item |
					val data = item.modelObject
					item.addChild(new Label("caracteristicaDelVillano", data))
					item.addChild(new XLink<Object>("eliminarCaracteristica") => [
						onClick = [|
							expediente.villanoSeleccionado.eliminarSenia(data)
					]])]
		parent.addChild(listView)
	}
	
	def agregarListaDeHobbies(Form<ExpedienteModel> parent) {
		var listView = new XListView<String>("villanoSeleccionado.hobbies")
		listView.populateItem = [ item |
					val data = item.modelObject
					item.addChild(new Label("hobbie", data))
					item.addChild(new XLink<Object>("eliminarHobbie") => [
						onClick = [|
							expediente.villanoSeleccionado.eliminarHobbie(data)
					]])]
		parent.addChild(listView)
	}
	
	def nuevoVillano(Form<ExpedienteModel> parent){
		parent.addChild(new TextField<String>("nuevoNombre"))
		parent.addChild(new XButton("agregarVillano") => [
			onClick = [ |
				expediente.agregarVillanoNuevo
			]
		]
		)
	}
	
	def agregarBotonDeVolver(Form<ExpedienteModel> parent) {
	 	parent.addChild(new XLink<Object>("volver") => [
			onClick = [|
				responsePage = HomePage
			]
		])
	} 

	def agregarFeedbackPanel(Form<ExpedienteModel> form) {
		form.addChild(new FeedbackPanel("feedbackPanel"))
	}
	
}