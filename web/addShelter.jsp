<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>iPet Event</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link href="public/assets/css/addevent.css" rel="stylesheet" type="text/css"/>
    <style>
body {font-family: Arial, Helvetica, sans-serif;}

/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 50%;
}

/* The Close Button */
.close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}

    #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #floating-panel {
        position: absolute;
        top: 10px;
        left: 25%;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }
      
</style>
</head>
<body>

    <div class="main">
<%  String display = "block";
    String pic = "none";
    if(request.getQueryString()!= null){
        display = "none";
        pic = "block";
    }
%>
        <div class="container">
            <div style="display: <%=display%>">
                <button onclick="window.location.href='admin.jsp'"  class="btn-danger mt-2" >X</button>
                
            <form method="POST" class="appointment-form" action="addShelter" id="appointment-form">
                <h2>Pet Registration Form</h2>
                
                <div class="form-group-1">
                    <label for="title" style="color: #222; font-weight: bold">Pet Name</label>
                    <input type="text" name="name" required />
                    <label for="date" style="color: #222; font-weight: bold">Animal Type</label>
                    <input type="text" name="type" required />
                    <label for="time" style="color: #222; font-weight: bold">Gender</label>
                    <input type="text" name="gender" id="time" required />
                    <label for="place" style="color: #222; font-weight: bold">Age</label>
                    <input type="text" name="age" id="place"  required />
                    <label for="type" style="color: #222; font-weight: bold">Colour</label>
                    <input type="text" name="colour" id="type" required />
                    <label for="desc" style="color: #222; font-weight: bold">Description</label>
                    <input type="text" name="des" id="desc" required />
                </div>
                
                <div class="form-submit">
                    
                    <input type="reset" value="Reset" class="btn btn-danger">
                   
                    <center><input type="submit" name="submit" id="submit" class="btn-lg btn-success" value="Add a Pet" /></center>
                </div>
            </form>
        </div>
                <!--Image-->
                <div style="display:<%=pic%> ; padding:3rem;">
                    <form action="imageShe" method="post" enctype="multipart/form-data">
                    <label for="file" style="color: #222; font-weight: bold">Include Pet Image</label>
                    <input type="file" required accept="image/png, image/jpeg" name="file" size="50" />
                    <div class="form-submit">
                    <input type="submit" name="submit" id="submit" class="submit" value="Upload" />
                    <kbd style="background-color: orangered; padding: 5px;"><a style="text-decoration: none; color:white;" href="admin.jsp">Skip</a></kbd>
                </div>
                    </form>
                </div>
                    <div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <span class="close">&times;</span>
    <h4 style="margin-top: 3%; margin-bottom: 6%;">Choose Location</h4>
 <div id="map"></div>
    <p>Click on the map to add markers.</p>
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

        // This event listener will call addMarker() when the map is clicked.
        map.addListener('click', function(event) {
          addMarker(event.latLng);
          alert("lat:"+event.latLng.lat().toString())
          alert("lng:"+event.latLng.lng().toString())
          var late=event.latLng.lat().toString();
          var lange=event.latLng.lng().toString();
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
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDXtDJjjD6gu3XYrzWn7uLB8TaIKvkevQk&callback=initMap">
    </script>
    </div></div>
    
<!--
<script>
// Get the modal
var modal = document.getElementById("myModal");

// Get the button that opens the modal
var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
btn.onclick = function() {
  modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
  modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}
</script>-->
        </div>
    </div>

</body>
</html>