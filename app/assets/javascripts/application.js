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
//= require bootstrap
//= require_tree .

function clear()
{
    document.findElementById('#show-error').innerHTML = ""
}

function checkAndInsert()
{    
    var task_name = document.form["task-creator"]["taskvalue"].value;
    var test = true;
    var check_symbol = false
    for(var i=0;i<task_name.length;i++)
    {
        if(i==0 && task_name[i]=='@')
            test = false;
        if(i==task_name.length && task_name[i]=='@')
            test = false;
        if(i!=0 && i!=task_name.length && task_name[i]=='@')
            check_symbol = true;
    }
    if(check_symbol)
        test = true;
    alert(test);

    if(test)
    {
        document.findElementById('#show-error').innerHTML = "<div class='alert alert-error'>Invalid.</div>"        
    }
    else
        sendAjaxRequest(task_name)
}

function sendAjaxRequest(value)
{
    $.ajax({
        type: "POST"
        url: "/tasks"
        data: 'value='+value
        dataType: "html"
        success: function(msg){
                    if(parseInt(msg)){
                        
                    }
                }
    });
}
