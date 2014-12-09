package carmensd.ui

import android.app.Activity
import android.os.Bundle
import carmensd.servicios.LugaresService
import java.util.List
import modelos.Lugar
import retrofit.Callback
import retrofit.RestAdapter
import retrofit.RetrofitError
import retrofit.client.Response
import android.widget.Button

class LugaresActivity extends Activity {

	override void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_pistas);

		val servicio = crearServicioDeLugares()
		servicio.getLugaresParaVisitar(new Callback<List<Lugar>>() {
				override failure(RetrofitError e) {
					e.printStackTrace
				}
				
				override success(List<Lugar> listaDeLugares, Response responce) {
					
					val nombreDelLugar1 = findViewById(R.id.boton_lugar1) as Button
					val nombreDelLugar2 = findViewById(R.id.boton_lugar2) as Button
					val nombreDelLugar3 = findViewById(R.id.boton_lugar3) as Button
					
					nombreDelLugar1.setText(listaDeLugares.get(0).nombreLugar)
					nombreDelLugar2.setText(listaDeLugares.get(1).nombreLugar)
					nombreDelLugar3.setText(listaDeLugares.get(2).nombreLugar)
					
				}
	
			}
		)

	}
	
	protected def crearServicioDeLugares() {
		//val SERVER_IP = "192.168.137.1"
		val SERVER_IP = "192.168.1.34" //rieserIP
		val API_URL = '''http://«SERVER_IP»:9000/caso'''
		val restAdapter = new RestAdapter.Builder().setEndpoint(API_URL).build
		val LugaresService lugaresService = restAdapter.create(LugaresService)
		lugaresService
	}

}
