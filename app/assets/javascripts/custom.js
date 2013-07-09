$(function(){
		$('#tasks').sortable({
      update: function(event, ui) {
      	console.log('trigger');
        ui.item.trigger('drop', ui.item.index());
      }
    });
	/*$("#task").sortable({
			update: function() {
				after = $("#task-sortable").sortable("toArray");
				list_id = $(this).parent().prev().find('#list-id').text();
				$.ajaxSetup({
    				'beforeSend': function(xhr) { xhr.setRequestHeader("Accept", "text/javascript") }
    		});
				$.ajax({
						url: '/lists/'+ list_id +'/reorder/',
    				type: "POST",
    		    data: { reorder: after }
    		  });
			}
	});*/
});
