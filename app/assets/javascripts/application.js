// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation


$(function(){ 
  $(document).foundation(); 
  $(document).on("ajax:success ajax:error", function(e, data, status, xhr) {
    var msg = xhr.getResponseHeader('X-Message');
    if (msg) {
      var type = xhr.getResponseHeader('X-Message-Type');
      insert_notification(msg, type);
    }
  });
  $(document).on("ajax:success", '.product-dialog-submit', load_product_dialog);
});

function insert_notification(msg, type) {
  var classes = notification_class(type);
  $("body" ).append( 
     "<div class='callout notification "+classes+"' data-closable>"
      +msg+
      "<button class='close-button' aria-label='Dismiss alert' type='button' data-close>"+
        "<span aria-hidden='true'>&times;</span>"+
      "</button>"+
     "</div>" 
  );
}

function notification_class(type){
  switch(type){
    case 'success':
      return 'success';
    case 'notice':
      return 'secondary';
    case 'error':
      return 'alert';
    default:
      return type;  
  }
}

  
function load_product_dialog(e, data, status, xhr) {
  event.preventDefault();
  $('#product-details').html(data);
  $('#product-details').foundation('open');
}