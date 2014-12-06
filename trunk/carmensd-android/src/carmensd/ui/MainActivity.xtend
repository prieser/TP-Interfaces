package carmensd.ui

import android.app.Activity
import android.os.Bundle
import android.widget.TextView
import carmensd.servicios.PaisActualService
import modelos.Pais
import retrofit.Callback
import retrofit.RestAdapter
import retrofit.RetrofitError
import retrofit.client.Response

class MainActivity extends Activity {
	
	override void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        
        val servicio = crearServicioPrincipal()
        servicio.getPaisActual(new Callback<Pais>() {
        	
        		override failure(RetrofitError e) {
        			e.printStackTrace
        		}
        		
        		override success(Pais pais, Response response) {
        			ponerNombreDelPaisActual(pais)
        		}
        	}
        )
        
    }
	
	def void ponerNombreDelPaisActual(Pais pais) {
		findViewById(R.id.pais_actual) as TextView => [
			text = pais.nombre
		]
	}
	
	
	
	protected def crearServicioPrincipal() {
		val SERVER_IP = "192.168.1.34"
		val API_URL = '''http://192.168.1.34:9000/caso'''
		val restAdapter = new RestAdapter.Builder().setEndpoint(API_URL).build
		val PaisActualService paisActualService = restAdapter.create(PaisActualService)
		paisActualService
	}
	
}