package jar

import jar.mapamundi.MapamundiPage
import org.apache.wicket.markup.html.WebPage
import org.apache.wicket.markup.html.form.Form
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.uqbar.wicket.xtend.XButton
import jar.expediente.ExpedientePage

class HomePage extends WebPage {
	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	
	
	new() {
		val Form formulario = new Form("formulario")
		agregarBotonAbrirExpediente(formulario)
		agregarBotonAbrirMapamundi(formulario)
		this.addChild(formulario)
	}
	
	def agregarBotonAbrirExpediente(Form parent) {
		var nuevoButton = new XButton("abrirExpedienteBoton").onClick = [ |
			responsePage = new ExpedientePage(this)
		]
		parent.addChild(nuevoButton)
	}
	
	def agregarBotonAbrirMapamundi(Form parent) {
		var nuevoButton = new XButton("abrirMapamundiBoton").onClick = [ |
			responsePage = new MapamundiPage(this)
		]
		parent.addChild(nuevoButton)
	}
	
}