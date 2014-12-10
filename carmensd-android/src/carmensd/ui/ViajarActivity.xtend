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
import java.util.List
import java.util.ArrayList
import android.widget.ArrayAdapter
import android.widget.ListView
import android.view.View
import android.content.Intent
import android.widget.Button
import carmensd.servicios.ViajarService
import android.content.Context
import android.widget.AdapterView
import android.widget.AdapterView.OnItemClickListener;
import carmensd.servicios.IrANuevoDestinoService
import android.util.Log
import android.net.Uri
import carmensd.servicios.ViajarServiceVisitados

class ViajarActivity extends Activity {
	

	override void onCreate(Bundle savedInstanceState) {
			super.onCreate(savedInstanceState);
			setContentView(R.layout.activity_viajar);
			
			val TextView texto = findViewById(R.id.texto) as TextView;
			texto.setText("Recorrido Actual")
	
			lugares()	
			visitados()
		
	}
	
	def void lugares(){
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
	
	def void visitados(){
		val servicio = crearServicioDeLugaresVisitados()
		servicio.getLugaresVisitados(new Callback<List<String>>() {
			override failure(RetrofitError e) {
				e.printStackTrace
			}
			override success(List<String> listaDeLugares, Response responce) {
				listaVisitados(listaDeLugares)
			}
	
		}
		)	
	}
		
	def void lista(List<String> listaDeLugares){
		val ListView listaDePaises = findViewById(R.id.listaDePaises) as ListView;  
		var ArrayAdapter<String> adapter = new ArrayAdapter<String>(this,android.R.layout.simple_list_item_1, listaDeLugares);
		listaDePaises.setAdapter(adapter);	
		
		val TextView pais_actual = findViewById(R.id.pais_actual) as TextView; 
		
		listaDePaises.setOnItemClickListener(new OnItemClickListener() {
			override onItemClick(AdapterView<?> parent, View view, int position, long id) {
				pais_actual.setText("Usted esta en "+ listaDePaises.getItemAtPosition(position))
				viajar(listaDePaises.getItemAtPosition(position) as String)
				
				visitados()
				
			}
  		})
		
	}
	def void listaVisitados(List<String> listaDeLugares){
		val ListView listaDePaisesVisitados = findViewById(R.id.listaDePaisesVisitados) as ListView;  
		var ArrayAdapter<String> adapter = new ArrayAdapter<String>(this,android.R.layout.simple_list_item_1, listaDeLugares);
		listaDePaisesVisitados.setAdapter(adapter);	
		
		//val TextView pais_visitado1 = findViewById(R.id.pais_visitado1) as TextView;
		//pais_visitado1.setText(listaDePaisesVisitados.getItemAtPosition(0) as String)
		
		
	}
	
	protected def crearServicioDeLugares() {
		val SERVER_IP = "192.168.1.14"
		//val SERVER_IP = "192.168.1.34" //rieserIP
		val API_URL = '''http://«SERVER_IP»:9000/caso'''
		val restAdapter = new RestAdapter.Builder().setEndpoint(API_URL).build
		val ViajarService viajarService = restAdapter.create(ViajarService)
		viajarService
	}
	protected def crearServicioDeLugaresVisitados() {
		val SERVER_IP = "192.168.1.14"
		//val SERVER_IP = "192.168.1.34" //rieserIP
		val API_URL = '''http://«SERVER_IP»:9000/caso'''
		val restAdapter = new RestAdapter.Builder().setEndpoint(API_URL).build
		val ViajarServiceVisitados viajarServiceVisitados = restAdapter.create(ViajarServiceVisitados)
		viajarServiceVisitados
	}
	
	
	def void viajar(String select) {
		val viajarService = IrANuevoDestino()

		viajarService.setViajar(select, 
			new Callback<List<String>>() {

				override failure(RetrofitError e) {
					Log.e("", e.message)
					e.printStackTrace
				}

				override success(List<String> peliculas, Response response) {
					//mostrarPeliculas(peliculas)
					lugares()
				}

			})
		
	}
	
	protected def IrANuevoDestino() {
		
		val SERVER_IP = "192.168.56.1"
		//val SERVER_IP = "192.168.1.34" //rieserIP
		val API_URL = '''http://«SERVER_IP»:9000/caso'''
		
		val restAdapter = new RestAdapter.Builder().setEndpoint(API_URL).build
		val IrANuevoDestinoService irANuevoDestino = restAdapter.create(IrANuevoDestinoService)
		irANuevoDestino
	}

}