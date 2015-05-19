$( document ).ready(function(){
	var correuCorrect = false;
	var msgCorrect = false;
	
	//Comprova que l'imput del correu estigui a cord amb la cadena de Reg.
	$.fn.checkEmail = function(){
		var inputVal = $("#correu").val();
		var correuReg = /[A-Za-z0-9._-]{2,}[@][A-Za-z0-9._-]{2,}[.][A-Za-z0-9._-]{2,}/;
		
		if(!correuReg.test(inputVal)) {
			correuCorrect = false;
			$().setError("mailerrmsg","correu",true);
		}else{
			correuCorrect = true;
			$().setError("mailerrmsg","",false);
		}
	};
	
	//Comprova que l'input del missatge no estingui en blanc.
	$.fn.checkMissatge = function(){
		var inputVal = $("#missatge").val();
		
		if(inputVal == "") {
			msgCorrect = false;
			$().setError("msgerrmsg","missatge",true);
		}else{			
			msgCorrect = true;
			$().setError("msgerrmsg","",false);
		}
	};
	
	$('#enviar').click(function() {
		
		$().checkEmail();
		$().checkMissatge();
	});
	
	//Canvia el color de la lletra i introdueix el missatge dessitjat
	//a la label d'error corresponent. 
	$.fn.setError = function(id, msg , mostra) {
		if(mostra == true){
			$('#'+id).css('color','#FF1717');
			$('#'+id).html('El '+msg+' es incorrecte.').show();
			$('#'+id).css("cursor","default");
		}/*else{
			if(correuCorrect == true && msgCorrect == true){
				$('#enviar').removeAttr('disabled');
				$('#enviar').css("cursor","pointer");
			}
			$('#'+id).hide();
		}*/
	};
});