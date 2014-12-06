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

class PistasActivity extends Activity {
	
    override void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pistas);
        
        
        val servicio = crearServicioDePaisActual()
        servicio.getPaisActual(new Callback<Pais>() {
        		override failure(RetrofitError e) {
        			e.printStackTrace
        		}
        		override success(Pais pais, Response response) {
        			ponerNombreDelPais(pais)
        		}
        	}
        )
        
    }
	
	def void ponerNombreDelPais(Pais pais) {
		findViewById(R.id.textView1) as TextView => [
			text = pais.nombre
		]
	}
	
	protected def crearServicioDePaisActual() {
		val SERVER_IP = "192.168.1.34"
		val API_URL = '''http://192.168.1.34:9000'''
		val restAdapter = new RestAdapter.Builder().setEndpoint(API_URL).build
		val PaisActualService paisActualService = restAdapter.create(PaisActualService)
		paisActualService
	}
	
}