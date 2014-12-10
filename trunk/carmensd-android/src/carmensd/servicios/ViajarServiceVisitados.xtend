package carmensd.servicios

import retrofit.Callback
import retrofit.http.GET
import java.util.List

interface ViajarServiceVisitados {
	
	@GET("/destinosVisitados")
	def void getLugaresVisitados(Callback<List<String>> callback)
	
}