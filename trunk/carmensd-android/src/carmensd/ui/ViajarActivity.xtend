package carmensd.ui

import android.app.Activity
import android.os.Bundle
import android.widget.ArrayAdapter
import android.widget.ListView
import carmensd.servicios.ViajarService
import java.util.List
import retrofit.Callback
import retrofit.RestAdapter
import retrofit.RetrofitError
import retrofit.client.Response

class ViajarActivity extends Activity {
	

	override void onCreate(Bundle savedInstanceState) {
			super.onCreate(savedInstanceState);
			setContentView(R.layout.activity_viajar);
	
			val servicio = crearServicioDeLugares()
			servicio.getLugaresParaViajar(new Callback<List<String>>() {
		
				override failure(RetrofitError e) {
					e.printStackTrace
				}
				
				override success(List<String> listaDeLugares, Response responce) {
					lista(listaDeLugares)
				}
	
			}
		)
		

	}
		
	def lista(List<String> listaDeLugares){
		var ListView listaDePaises = findViewById(R.id.listaDePaises) as ListView;  
		var ArrayAdapter<String> adapter = new ArrayAdapter<String>(this,android.R.layout.simple_list_item_1, listaDeLugares);
		listaDePaises.setAdapter(adapter);	
	}
	
	
	
	protected def crearServicioDeLugares() {
		//val SERVER_IP = "192.168.137.1"
		val SERVER_IP = "192.168.1.34" //rieserIP
		val API_URL = '''http://«SERVER_IP»:9000/caso'''
		val restAdapter = new RestAdapter.Builder().setEndpoint(API_URL).build
		val ViajarService viajarService = restAdapter.create(ViajarService)
		viajarService
	}

}