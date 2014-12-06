package carmensd.servicios

import retrofit.Callback
import retrofit.http.GET
import modelos.Pais

interface PaisActualService {
	
	@GET("/paisActual")
  	def void getPaisActual(Callback<Pais> callback)
	
}