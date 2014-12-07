package carmensd.servicios

import retrofit.Callback
import retrofit.http.GET
import java.util.List
import modelos.Lugar

interface LugaresService {

	@GET("/lugares")
	def void getLugaresParaVisitar(Callback<List<Lugar>> callback)

}
