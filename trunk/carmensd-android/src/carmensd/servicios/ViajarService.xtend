package carmensd.servicios

import retrofit.Callback
import retrofit.http.GET

interface ViajarService {

  @GET("/destinos")
  def void getDestinos(Callback<DestinosPosibles> callback)
  
}