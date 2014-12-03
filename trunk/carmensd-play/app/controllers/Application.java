package controllers;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import modelo.*;
import org.uqbar.commons.model.UserException;
import play.libs.Json;
import play.mvc.Controller;
import play.mvc.Result;
import views.html.index;

//
// el dominio


public class Application extends Controller {

    public static Result index() {
        return ok(index.render("Your new application is ready."));
    }

    //iniciarJuego que devuelve un caso + los posibles villanos para pedir la orden de arresto
    public static Result caso() {
        response().setContentType("application/json");
        //JuegoA juego = new JuegoA();
        JuegoA juego = JuegoA.getInstance();
        CasoE caso = juego.getCasoActual();
        JsonNode json1 = Json.toJson(caso);
        return ok(json1);
    }

    //pistaDelLugar que espera un lugar y un caso y devuelve la pista
    public static Result pista(int idDelLugar) {
        return ok(Json.toJson(MapaMundi.getInstance().getLugarConId(idDelLugar)));
    }

    //Este servicio lo uso cuando quiero que el detective visite un lugar dentro del pais en el que se encuentra.
    public static Result visitarLugar(int idDelLugar) {
        return ok(Json.toJson(CasoE.getInstance().visitarLugar(idDelLugar)));
    }

    //viajar que espera un destino y un caso y devuelve el nuevo estado del caso (lista de fallidos - viajes posibles - lugares del pais - lugares recorridos)
    public static Result viajar(String destino) {
        response().setContentType("application/json");
        
        Pais paisDestino = MapaMundi.getInstance().getPais(destino);
        CasoE.getInstance().viajar(paisDestino);
        
        JsonNode json1 = Json.toJson(CasoE.getInstance());
        return ok(json1);
    }
    
    // guidosWork :P
    
    public static Result verificarCulpable(String villano){
        response().setContentType("application/json");
        
        Villano acusado = Expediente.getInstance().buscarVillanoEnLaColeccion(villano);
        boolean ok = CasoE.getInstance().responsableAcertado(acusado);
        
        //un boolean no puede transformarse a json!
        		
        JsonNode json1 = Json.toJson(ok);
        return ok(json1);
        		
    	/*
    	JuegoA juego = JuegoA.getInstance();
        CasoE caso = juego.getCasoActual().getInstance();
        if(caso.elResponsable.nombre.equals(villanoElegido)){
            JsonNode jsonBool = Json.toJson(true);
        }else{
            JsonNode jsonBool = Json.toJson(false);
        }
        return ok(jsonBool);
        */
    }
	
    
    public static Result lugaresDisponibles() {
        return ok(Json.toJson(CasoE.getInstance().getEstoyPais().getLugaresDeInteres()));
    }

    public static Result destinosDisponibles() {
        return ok(Json.toJson(CasoE.getInstance().getEstoyPais().getPaisesConConexionAereaString()));
    }

    protected static ObjectNode crearJsonError(String message) {
        ObjectNode result = Json.newObject();
        result.put("error", message);
        return result;
    }

    protected static ObjectNode crearJsonOk() {
        ObjectNode result = Json.newObject();
        result.put("status", "OK");
        return result;
    }


}


