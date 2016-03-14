



function panelButtons(){
	$('#panel-buttons').find('button').click(function(){
		$('.panel.active').removeClass('active');
		$('#panel-buttons').find('.active').removeClass('active');
		$(this).addClass('active');
		$("#"+ $(this).data('target')).addClass('active');
	})
}