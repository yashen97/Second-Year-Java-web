<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Removing Markers</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 70%;
        margin: 1rem;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        background: #00416A;  /* fallback for old browsers */
background: -webkit-linear-gradient(to right, #FFE000, #799F0C, #00416A);  /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(to right, #FFE000, #799F0C, #00416A); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
        height: 100%;
      }
    </style>
  </head>
  <%
  if(session.getAttribute("LID")==null){
      response.sendRedirect(request.getContextPath()+ "/userEvents.jsp");
  }
//  int EID = (int) session.getAttribute("EID");
  %>
  <body>
    <div id="floating-panel">
      <!--<input onclick="clearMarkers();" type=button value="Hide Markers">
      <input onclick="showMarkers();" type=button value="Show All Markers">
      <input onclick="deleteMarkers();" type=button value="Delete Markers">-->
    </div>
      <p class="display-1 text-light text-center">Select Map Location</p>
    <div id="map"></div>
    
    <form action="LosMap" method="post">
        <input type="hidden" name = "lat" id="latt">
        <input type="hidden" name = "lon" id="lonn">
        <input type="hidden" name="eid" value="<%=session.getAttribute("LID")%>">
        <center><button class=" mt-3 mb-5 btn btn-lg btn-primary" type="submit" >Done</button></center>
    </form>
    
    <script>

      // In the following example, markers appear when the user clicks on the map.
      // The markers are stored in an array.
      // The user can then click an option to hide, show or delete the markers.
      var map;
      var markers = [];

      function initMap() {
        var haightAshbury = {lat: 7.8731, lng: 80.7718};

        map = new google.maps.Map(document.getElementById('map'), {
          zoom: 8,
          center: haightAshbury,
          mapTypeId: 'terrain'
        });
        var latt = document.getElementById("latt");
        var lonn = document.getElementById("lonn");
        map.addListener('click', function(event) {
          addMarker(event.latLng);
          var late=event.latLng.lat().toString();
          var lange=event.latLng.lng().toString();
          latt.value = late;
          lonn.value = lange;
        });

        // Adds a marker at the center of the map.
        addMarker(haightAshbury);
      }

      // Adds a marker to the map and push to the array.
      function addMarker(location) {
        deleteMarkers()
        var marker = new google.maps.Marker({
          position: location,
          map: map
        });
        markers.push(marker);
        
      }

      // Sets the map on all markers in the array.
      function setMapOnAll(map) {
        for (var i = 0; i < markers.length; i++) {
          markers[i].setMap(map);
        }
      }

      // Removes the markers from the map, but keeps them in the array.
      function clearMarkers() {
        setMapOnAll(null);
      }

      // Shows any markers currently in the array.
      function showMarkers() {
        setMapOnAll(map);
      }

      // Deletes all markers in the array by removing references to them.
      function deleteMarkers() {
        clearMarkers();
        markers = [];
      }
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBZCdaW4FfTwwbQtEMA6sdJor5FchEJpRU&callback=initMap">
    </script>
  </body>
</html>