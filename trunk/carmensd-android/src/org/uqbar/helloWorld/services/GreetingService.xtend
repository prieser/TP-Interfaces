package org.uqbar.helloWorld.services

import org.uqbar.helloWorld.domain.Greeting
import retrofit.Callback
import retrofit.http.GET

interface GreetingService {

  @GET("/greeting")
  def void getGreeting(Callback<Greeting> callback)
  
}