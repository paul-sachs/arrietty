var marker = null,
    position = null,
    map = null;
    
$(function () {
  $('#locateMeButton').on('click', locateMe);
});

function initMap() {
  var myLatLng = {lat: 43.6532, lng: -79.3832};
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 4,
    center: myLatLng
  });
  marker = new google.maps.Marker({
    position: myLatLng,
    map: map,
    title: 'I\'m here'
  });
  
  var input = document.getElementById('map-input');
  var locateMeButton = document.getElementById('map-locate-me');
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(locateMeButton);
  
  var autocomplete = new google.maps.places.Autocomplete(input);
      autocomplete.bindTo('bounds', map);
  
  $(locateMeButton).on('click', locateMe);
  
  autocomplete.addListener('place_changed', function() {
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      window.alert("Autocomplete's returned place contains no geometry");
      return;
    }
    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(17);  // Why 17? Because it looks good.
    }
    marker.setPosition(place.geometry.location);
  });
  locateMe();
}

function handleLocationError(browserHasGeolocation, pos) {
  $('#loader').addClass('hidden').removeClass('loading');
  $('#locateMeButton').removeClass('hidden');
}

function locateMe(event) {
  if (event) event.preventDefault();
  $('#loader').removeClass('hidden').addClass('loading');
  $('#locateMeButton').addClass('hidden');
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      locationFound(pos);
      $('#loader').addClass('hidden').removeClass('loading');
      $('#locateMeButton').removeClass('hidden');
    }, function() {
      handleLocationError(true, infoWindow, map.getCenter());
    });
  } else {
    handleLocationError(false, infoWindow, map.getCenter());
  }
}

function locationFound(pos) {
  marker.setPosition(pos);
  map.setZoom(14);
  map.setCenter(pos);
}

// function locateMe(event) {
//   if (event) event.preventDefault();
//   $('#loader').removeClass('hidden').addClass('loading');
//   $('#locateMeButton').addClass('hidden');
//   navigator.geolocation.getCurrentPosition(function (pos) {
//     position = pos;
//     $.ajax('/locate_me', {
//         async: true,
//         data: {
//           position: pos
//         },
//         method: 'GET',
//         dataType: 'json'
//       })
//       .done(function(result) {
//         var googlePos = {lat: position.coords.latitude, lng: position.coords.longitude};
//         locationFound(googlePos);
//         $('#preference_location').val(result.country+", "+result.city+", "+result.neighborhood);
//       }).always(function(){
//         $('#loader').addClass('hidden').removeClass('loading');
//         $('#locateMeButton').removeClass('hidden');
//       });
//   }, null, null);
// }


$(function() {
  $('#preference_image').on('change', function(event) {
    var files = event.target.files;
    var image = files[0]
    var reader = new FileReader();
    reader.onload = function(file) {
      $('#image-preview').attr('src',file.target.result);
    }
    reader.readAsDataURL(image);
    console.log(files);
  });
});