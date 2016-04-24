var marker = null,
    position = null,
    map = null,
    geocoder = null;
$(function () {
  $('#locateMeButton').on('click', locateMe);
  $('#updatepreferences').on('click', submitForm);
});


function initMap() {
  geocoder = new google.maps.Geocoder();
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
  var savedLocation = $('#map-input').val();
  if(savedLocation.length > 0){
    geocoder.geocode( { 'address': savedLocation}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        map.setCenter(results[0].geometry.location);
        map.fitBounds(results[0].geometry.viewport);
        marker = new google.maps.Marker({
            map: map,
            position: results[0].geometry.location
        });
      }
    });
  }
  else {
    locateMe();
  }
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
  geocoder.geocode({'location': pos}, function(results, status) {
    if (status === google.maps.GeocoderStatus.OK && results[1]) {
      $('#map-input').val(results[1].formatted_address);
    }
  });
}

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

function submitForm(event) {
  if (marker == null) {
    event.preventDefault();
    alert("Please set location");
  }
  else {
    var position = marker.getPosition();
    var lat = position.lat();
    var lng = position.lng();
    
    $('#latitude').val(lat);
    $('#longitude').val(lng);
  }
}