package org.uqbar.helloWorld.ui

import android.app.Activity
import android.os.Bundle
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.view.View.OnClickListener
import android.widget.Button
import android.widget.TextView
import org.uqbar.helloWorld.domain.Greeting
import org.uqbar.helloWorld.services.GreetingService
import retrofit.Callback
import retrofit.RestAdapter
import retrofit.RetrofitError
import retrofit.client.Response

class MainActivity extends Activity implements OnClickListener {

	override onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState)
		setContentView(R.layout.activity_main)
		val botonConvertir = findViewById(R.id.buscar) as Button
		botonConvertir.onClickListener = this
	}

	override onCreateOptionsMenu(Menu menu) {

		// Inflate the menu this adds items to the action bar if it is present.
		menuInflater.inflate(R.menu.main, menu)
		true
	}

	override onOptionsItemSelected(MenuItem item) {

		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		val id = item.itemId
		if (id == R.id.action_settings) {
			return true
		}
		return super.onOptionsItemSelected(item)
	}

	override onClick(View v) {

		// Construimos el servicio REST al que tenemos que llamar
		val API_URL = "http://rest-service.guides.spring.io"
		val restAdapter = new RestAdapter.Builder().setEndpoint(API_URL).build
		val GreetingService greetingService = restAdapter.create(typeof(GreetingService))

		// Invocamos al servicio acá
		greetingService.getGreeting(
			new Callback<Greeting>() {

				override failure(RetrofitError e) {
					Log.e("", e.message)
				}

				override success(Greeting greeting, Response response) {
					val txtSaludo = findViewById(R.id.saludo) as TextView
					txtSaludo.text = greeting.id + " | " + greeting.content
				}

			})
	}

}
