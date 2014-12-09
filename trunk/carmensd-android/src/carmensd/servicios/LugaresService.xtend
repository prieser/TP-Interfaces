package carmensd.servicios

import java.util.List
import modelos.Lugar
import retrofit.Callback
import retrofit.http.GET
import retrofit.http.Path

interface LugaresService {

	@GET("/lugares")
	def void getLugaresParaVisitar(Callback<List<Lugar>> callback)

	@GET("/visitarLugar/{idLugar}")
	def void getPistaDelLugar(@Path("idLugar") int idLugar, Callback<String> callback)
}
