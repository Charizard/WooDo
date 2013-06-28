// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require bootstrap
//= require_tree .

$(function(){
    $('.incomplete').draggable();
    $('.incomplete').droppable({
        drop: function(event, ui){
            var src = ui.draggable.text().trim().split(' ');
            var from_list_id = src[2];
            var from_order_number = src[1];
            var dest = $(this).text().trim().split(' ');
            var to_list_id = src[2];
            var to_order_number = src[1];
            $.ajaxSetup({
                'beforeSend': function(xhr) { xhr.setRequestHeader("Accept", "text/javascript") }
            });
            $.ajax('lists/'+ from_list_id +'/reorder/', {
                type: "POST",
                data: { from_list_id: from_list_id, from_order_number: from_order_number, to_list_id: to_list_id, to_order_number: to_order_number }
            });
        }
    });
});
