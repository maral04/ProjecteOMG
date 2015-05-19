$( document ).ready(function(){
	var correuCorrect = false;
	var msgCorrect = false;
	
	$('#enviar').attr('disabled','disabled');
	$('#enviar').css("cursor","not-allowed");
	
	//Comprova que l'imput del correu estigui a cord amb la cadena de Reg.
	$('#correu').focusout(function() {
		var inputVal = $(this).val();
		var correuReg = /[A-Za-z0-9._-]{2,}[@][A-Za-z0-9._-]{2,}[.][A-Za-z0-9._-]{2,}/;
		
		if(!correuReg.test(inputVal)) {
			correuCorrect = false;
			$().setError("mailerrmsg","correu",true);
		}else{
			correuCorrect = true;
			$().setError("mailerrmsg","",false);
		}
	});
	
	//Comprova que l'input del missatge no estingui en blanc.
	$('#missatge').focusout(function() {
		var inputVal = $(this).val();
		
		if(inputVal == "") {
			msgCorrect = false;
			$().setError("msgerrmsg","missatge",true);
		}else{			
			msgCorrect = true;
			$().setError("msgerrmsg","",false);
		}
	});
	
	$('#nom').hover(function() {
		$('#nom').focus();
	});
	
	$('#correu').hover(function() {
		$('#correu').focus();
	});
	
	$('#missatge').hover(function() {
		$('#missatge').focus();
	});
	
	//Canvia el color de la lletra i introdueix el missatge dessitjat
	//a la label d'error corresponent. 
	$.fn.setError = function(id, msg , mostra) {
		if(mostra == true){
			$('#enviar').attr('disabled','disabled');
			$('#enviar').css("cursor","not-allowed");
			$('#'+id).css('color','#FF1717');
			$('#'+id).html('El '+msg+' es incorrecte.').show();
			$('#'+id).css("cursor","default");
		}else{
			if(correuCorrect == true && msgCorrect == true){
				$('#enviar').removeAttr('disabled');
				$('#enviar').css("cursor","pointer");
			}
			$('#'+id).hide();
		}
	};
});