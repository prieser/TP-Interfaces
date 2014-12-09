package carmensd.ui

import android.app.Activity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.TextView
import carmensd.servicios.LugaresService
import java.util.List
import modelos.Lugar
import retrofit.Callback
import retrofit.RestAdapter
import retrofit.RetrofitError
import retrofit.client.Response

class LugaresActivity extends Activity {

	override void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_lugares);

		val servicio = crearServicioDeLugares()
		servicio.getLugaresParaVisitar(
			new Callback<List<Lugar>>() {
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
		val SERVER_IP = "192.168.1.34"
		val API_URL = '''http://192.168.1.34:9000/caso'''
		val restAdapter = new RestAdapter.Builder().setEndpoint(API_URL).build
		val LugaresService lugaresService = restAdapter.create(LugaresService)
		lugaresService
	}

	def void visitarLugar(View v) {
		val servicio = crearServicioDeLugares()
		servicio.getPistaDelLugar(
			1, // Este ID tiene que variar de acuerdo al lugar que este visitando
			new Callback<String>() {
				override failure(RetrofitError e) {
					e.printStackTrace
				}

				override success(String pista, Response arg1) {
					val pistaText = findViewById(R.id.textoPista) as TextView
					pistaText.setText(pista)
				}

			}
		)
	}

}
