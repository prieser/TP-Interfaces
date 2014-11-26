'use strict';

var app = angular.module('carmenApp', []);

app.controller('mainController', function ($scope, $http) {

	$scope.actualizarPagina = function(caso) {
    	$scope.caso = caso;
        $scope.paisActual = $scope.caso.estoyPais.nombre;
        $scope.lugares = $scope.caso.estoyPais.lugaresDeInteres;
        $scope.paisesViajar = $scope.caso.estoyPais.paisesConConexionAereaString;
        $scope.villanos = $scope.caso.expediente.villanos;
        $scope.paisesVisitados = $scope.caso.paisesVisitados;
    }
	
    $scope.actualizarLista = function () {
        $http.get('/caso')
            .success(function (data) {
                $scope.actualizarPagina(data);
            }
        )
    }
    $scope.actualizarLista();
    
    $scope.visitarLugar = function (lugar) {
        $scope.lugarElegido = lugar;
        $scope.pista = "Esta es la pista del " + this.lugarElegido.nombreLugar + " -> " + this.lugarElegido.informacion;
//        appendearPista()
        $("#verLibroModal").modal({});
    }
    
    $scope.destino = "dondeQuieroViajar";
    
    $scope.setDestino = function (dondeQuieroViajar) {
    	$scope.destino = dondeQuieroViajar;	
    }

    $scope.viajar = function (nombreDelPaisDestino) {
        $http.get('/caso/viajar/' + nombreDelPaisDestino)
        	.success(function (data) {
	            //$scope.notificarMensaje('Libro eliminado!');
	            //$scope.actualizarLista();
	            $scope.actualizarPagina(data)	
        });
    }
    
    $scope.posibleCulpable = "";

    
    $scope.arrestar = function(){
            if(posibleCulpable == ""){
                alert("elegir un villano para generar la orden de arresto");
            } else{
                $http.get('/emitirOrdenPara/' + posibleCulpable)
                .success(function (data) {
                    if(data){
                        alert("has capturado al culpable");
                    }else{
                        alert("te has equivocado, vuelve a intentarlo");
                    }
                }
            )
            }
        }
     

    //Mensaje de notificacion cuando ocurre un evento
    $scope.msgs = [];
    $scope.notificarMensaje = function (mensaje) {
        $scope.msgs.push(mensaje);

        $timeout(function () {
            while ($scope.msgs.length > 0)
                $scope.msgs.pop();
        }, 3000);
    };


    //ESTO NO ESTA FUNCIONANDO. SI SOBRA TIEMPO ARREGLARLO
    var appendearPista = function () {
        document.getElementById("filaPrincipal").innerHTML = "<div class='col-sm-4 columnaPaisActual'><img class='thumbnail' src='images/matute.jpeg'><div id='pista'>{{pista}}</div></div>";
    }

});

