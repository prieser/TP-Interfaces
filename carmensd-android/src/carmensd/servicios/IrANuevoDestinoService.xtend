package carmensd.servicios

import retrofit.Callback
import retrofit.http.GET
import java.util.List
import retrofit.http.Path
import java.util.List;
import retrofit.Callback;
import retrofit.http.GET;
import retrofit.http.Path;

interface IrANuevoDestinoService {
	
	//@GET("/destinos")
	//def void setViajar(Callback<List<String>> callback)
	@GET("/viajar/{select}")
  	def abstract void setViajar(@Path("select") String select, Callback<List<String>> callback)
}