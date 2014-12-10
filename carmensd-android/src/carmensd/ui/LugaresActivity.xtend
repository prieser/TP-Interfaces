package carmensd.ui

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.ListView
import carmensd.servicios.LugaresService
import java.util.ArrayList
import java.util.List
import modelos.Lugar
import retrofit.Callback
import retrofit.RestAdapter
import retrofit.RetrofitError
import retrofit.client.Response
import android.widget.AdapterView.OnItemClickListener;

class LugaresActivity extends Activity {

	override void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_lugares);

		val servicio = crearServicioDeLugares()
		servicio.getLugaresParaVisitar(new Callback<List<Lugar>>() {
				override failure(RetrofitError e) {
					e.printStackTrace
				}

				override success(List<Lugar> listaDeLugares, Response responce) {
					ponerListaDeLugares(listaDeLugares)
				}

			}
		)

	}

	def void ponerListaDeLugares(List<Lugar> lugares) {
		var ArrayList<String> listaDeStrings = newArrayList()
		for(Lugar unLugar : lugares){
			listaDeStrings.add(unLugar.nombreLugar)
		}
		
		var ListView listView = findViewById(R.id.listaDeLugares) as ListView
		var ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, listaDeStrings)
		listView.setAdapter(adapter);
		
		listView.setOnItemClickListener(new OnItemClickListener() {
			override void onItemClick(AdapterView<?> arg0, View view, int pos, long arg3) {
				
			}
		})
	}

	protected def crearServicioDeLugares() {
		val SERVER_IP = "192.168.1.35"
		val API_URL = '''http://192.168.1.35:9000/caso'''
		val restAdapter = new RestAdapter.Builder().setEndpoint(API_URL).build
		val LugaresService lugaresService = restAdapter.create(LugaresService)
		lugaresService
	}

//	def void visitarLugar(View v) {
//		val servicio = crearServicioDeLugares()
//		servicio.getPistaDelLugar(
//			1, // Este ID tiene que variar de acuerdo al lugar que este visitando
//			new Callback<String>() {
//				override failure(RetrofitError e) {
//					e.printStackTrace
//				}
//
//				override success(String pista, Response arg1) {
//					val pistaText = findViewById(R.id.textoPista) as TextView
//					pistaText.setText(pista)
//				}
//
//			}
//		)
//	}

}
