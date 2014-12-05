package carmensd.ui

import android.app.Activity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.view.View.OnClickListener
import android.widget.Button
import android.widget.TextView
import carmensd.servicios.DestinosPosibles
import carmensd.servicios.ViajarService
import retrofit.Callback
import retrofit.RestAdapter
import retrofit.RetrofitError
import retrofit.client.Response

class MainActivity extends Activity implements OnClickListener {

	override onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState)

		setContentView(R.layout.activity_main)

		val botonViajar = findViewById(R.id.viajarBoton) as Button
		botonViajar.onClickListener = this
	}

	override onClick(View v) {

		val SERVER_IP = "192.168.1.35"
		val API_URL = '''http://192.168.1.35:9000/caso'''
		
		val restAdapter = new RestAdapter.Builder().setEndpoint(API_URL).build
		val ViajarService viajarService = restAdapter.create(typeof(ViajarService))

		viajarService.getDestinos(new Callback<DestinosPosibles>() {

				override failure(RetrofitError e) {
					Log.e("", e.message)
				}

				override success(DestinosPosibles destinos, Response response) {
					val txtSaludo = findViewById(R.id.saludo) as TextView
					txtSaludo.text = destinos.destinos.get(0)
				}

			})
	}

}
