package carmensd.servicios

import retrofit.Callback
import retrofit.http.GET
import java.util.List

interface ViajarService {
	
	@GET("/destinos")
	def void getLugaresParaViajar(Callback<List<String>> callback)
	
}