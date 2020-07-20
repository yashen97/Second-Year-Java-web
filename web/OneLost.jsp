<%@page import="model.Connections"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lost Infomation</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link href="public/assets/css/detail.css" rel="stylesheet" type="text/css"/>
    <link href="public/assets/css/allevent.css" rel="stylesheet" type="text/css"/>
    <style>
        #map{
            height:400px;
            width: 80%;
            padding: 5px;
            margin: 5rem;
        }
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
              width: 20%;
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
              color:red;
              text-decoration: none;
              cursor: pointer;
            }
    </style>
</head>
<body>
     <header>
         
            <%
        String show = "block";
       String hide = "none";
       String nic = "";
   if(session.getAttribute("NIC")!=null){
       show = "none";
       hide = "block";
       nic = (String) session.getAttribute("NIC");
   }
   
   %>
    <div>
     <i class="fa fa-paw" aria-hidden="true"></i>

      <a href="index.jsp" style="text-decoration: none; color: yellow;" ><p>I Pet</p></a>
    </div>
      <nav  style="display:<%=show%>">
      <ul style="padding-top: 10px">
        <li><a style="text-decoration: none; background-color: rgba(255,255,255,0.3);color:black" href="viewlost.jsp">Lost Pets</a></li>
        <li><a style="text-decoration: none" href="Shelter.jsp">Shelter</a></li>
        <li><a style="text-decoration: none" href="register.jsp">Sign up</a></li>
        <li><a style="text-decoration: none" href="login.jsp">Sign in</a></li>
      </ul>
    </nav>
   <nav  style="display:<%=hide%>">
      <ul style="padding-top: 10px">
          <li><a style="text-decoration:none" href="userEvents.jsp">My Profile</a></li>
        <li><a style="text-decoration: none; background-color: rgba(255,255,255,0.3);color:black" href="viewlost.jsp">Lost Pets</a></li>
        <li><a style="text-decoration: none" href="Shelter.jsp">Shelter</a></li>
        <li ><a style="background-color:rgba(255,0,0,0.8); text-decoration: none; color:white" href="login.jsp">Log out</a></li>
      </ul>
    </nav>
  </header>
  <%    String lid = "";
      if(request.getQueryString()==null){
          response.sendRedirect(request.getContextPath()+"/viewlost.jsp");
      }
      else{
      lid = request.getParameter("LID");
      }
      

  %>
    <div class="container">
   <% 
    Connection conn;
    Statement stat;
    ResultSet rs;
    String sql;
    
        Connections log = new Connections();
        log.Connect();
        conn = log.con;
        stat = log.qry;
        sql = "SELECT * from lost WHERE LID='"+lid+"'";
        
        rs = stat.executeQuery(sql);
        while(rs.next()){
            String Name = rs.getString("Name");
            String Type = rs.getString("Type");
            String Age = rs.getString("Age");
            String Colour = rs.getString("Colour");
            String LSLoc = rs.getString("LSLoc");
            String Thumb = rs.getString("Thumbnail");
            String lat = rs.getString("Lat");
            String lon = rs.getString("Lon");
            String dis = rs.getString("Dis");
            String onic = rs.getString("ONIC");
            
            String ava = "none";
            if(lat.equals("no")||lon.equals("no")){
               ava = "none";
            }
            else{
                ava = "block";
            }
                %> 
        <h1 class="font-weight-light text-center text-lg-middle mt-4 mb-0"><%=Name%></h1><hr>
        <div class="row justify-content-between">
            <div class="col-6"><img src="public/data/lost/<%=Thumb%>" style="padding:1px;border:thin solid black;"  width="400px" height="400px"></div>
            <div class="col-6">
                <div style="color: crimson; font-weight: bold; font-size: 24pt;">TYPE :- <%= Type%>
                <div style="color:rgb(120, 44, 175); font-weight: bold; font-size: large; margin-top: 5%;" >Age :- <%=Age%></div>
                <kbd>Colour :- <%=Colour%></kbd><br>
                <kbd class="bg-warning text-dark" >Last Seen :- <%=LSLoc%></kbd>
                <div style="font-size: 24pt; margin-top: 5%;">Description</div><hr>
                <p style="color:black; font-size: 14pt;"><%=dis%></p>
                 <button style="display:<%=hide%>" id="myBtn" class="btn btn-primary active">Report Found</button>   
                 <a style="text-decoration:none" href="login.jsp"><h2 style="display:<%=show%>; color: purple; text-align: center;">Sign in to Report</h2></a>
                </div>
                    <hr>
                           </div>
        </div>
    
    </div>
                    <!--map-->
                    <center><div id="map" style="display:<%=ava%>" ></div></center>
                     <script>
    function initMap(){
      // Map options
      var options = {
        zoom:8,
        center:{lat:7.8731,lng:80.7718}
      }

      // New map
      var map = new google.maps.Map(document.getElementById('map'), options);

      // Listen for click on map
//      google.maps.event.addListener(map, 'click', function(event){
//        // Add marker
//        addMarker({coords:event.latLng});
//      });

      /*
      // Add marker
      var marker = new google.maps.Marker({
        position:{lat:42.4668,lng:-70.9495},
        map:map,
        icon:'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png'
      });

      var infoWindow = new google.maps.InfoWindow({
        content:'<h1>Lynn MA</h1>'
      });

      marker.addListener('click', function(){
        infoWindow.open(map, marker);
      });
      */

      // Array of markers
      var markers = [
        {
          coords:{lat:<%=lat%>,lng:<%=lon%>},
          //iconImage:'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png',
          content:'<h5><%=Name%></h5>'
        },
//        {
//          coords:{lat:42.8584,lng:-70.9300},
//          content:'<h1>Amesbury MA</h1>'
//        },
//        {
//          coords:{lat:42.7762,lng:-71.0773}
//        }
      ];

      // Loop through markers
      for(var i = 0;i < markers.length;i++){
        // Add marker
        addMarker(markers[i]);
      }

      // Add Marker Function
      function addMarker(props){
        var marker = new google.maps.Marker({
          position:props.coords,
          map:map,
          //icon:props.iconImage
        });

        // Check for customicon
        if(props.iconImage){
          // Set icon image
          marker.setIcon(props.iconImage);
        }

        // Check content
        if(props.content){
          var infoWindow = new google.maps.InfoWindow({
            content:props.content
          });

          marker.addListener('click', function(){
            infoWindow.open(map, marker);
          });
        }
      }
    }
  </script>
 

<!-- The Modal -->
<div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <span class="close">&times;</span>
    <h4 style="margin-top: 3%; margin-bottom: 6%;">Are you sure?</h4>
   
     <form method="post" action="found" class="form-group" >
         <div class="form-group row">
                    <input type="hidden" name="lid" value="<%=lid%>">
                    <input type="hidden" name="nic" value="<%=nic%>">
                    <input type="hidden" name="onic" value="<%=onic%>">
                     <input type="hidden" name="pname" value="<%=Name%>">
                    <button type="submit" class="btn btn-lg btn-primary">I Found it</button>
     </div>           
     </form>
                    <button id="x" class="btn-danger" >Cancel</button>
    </div>
    

<script>
// Get the modal
var modal = document.getElementById("myModal");

// Get the button that opens the modal
var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 

var x = document.getElementById("x");

btn.onclick = function() {
  modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
  modal.style.display = "none";
}

x.onclick = function() {
  modal.style.display = "none";
}
// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}
</script>
  <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBZCdaW4FfTwwbQtEMA6sdJor5FchEJpRU&callback=initMap">
    </script>
              <%}%>
     

    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>