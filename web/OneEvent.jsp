<%@page import="model.Connections"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Infomation</title>
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
      
    </style>
</head>
<body>
     <header>
         
            <%
        String show = "block";
       String hide = "none";
   if(session.getAttribute("NIC")!=null){
       show = "none";
       hide = "block";
   }
   
   %>
    <div>
     <i class="fa fa-paw" aria-hidden="true"></i>

      <a href="index.jsp" style="text-decoration: none; color: yellow;" ><p>I Pet</p></a>
    </div>
      <nav  style="display:<%=show%>">
      <ul style="padding-top: 10px">
        <li><a style="text-decoration: none; background-color: rgba(255,255,255,0.3);color:black" href="allEvents.jsp">Events</a></li>
        <li><a style="text-decoration: none" href="Shelter.jsp">Shelter</a></li>
        <li><a style="text-decoration: none" href="register.jsp">Sign up</a></li>
        <li><a style="text-decoration: none" href="login.jsp">Sign in</a></li>
      </ul>
    </nav>
   <nav  style="display:<%=hide%>">
      <ul style="padding-top: 10px">
          <li><a style="text-decoration:none" href="userEvents.jsp">My Profile</a></li>
        <li><a style="text-decoration: none; background-color: rgba(255,255,255,0.3);color:black" href="allEvents.jsp">Events</a></li>
        <li><a style="text-decoration: none" href="Shelter.jsp">Shelter</a></li>
        <li ><a style="background-color:rgba(255,0,0,0.8); text-decoration: none; color:white" href="login.jsp">Log out</a></li>
      </ul>
    </nav>
  </header>
  <%    String eid = "";
      if(request.getQueryString()==null){
          response.sendRedirect(request.getContextPath()+"/allEvents.jsp");
      }
      else{
      eid = request.getParameter("EID");
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
        sql = "SELECT * from events WHERE EID='"+eid+"'";
        
        rs = stat.executeQuery(sql);
        while(rs.next()){
            String Title = rs.getString("Title");
            String Date = rs.getString("Date");
            String Time = rs.getString("Time");
            String Place= rs.getString("Place");
            String Type = rs.getString("Type");
            String Descr = rs.getString("Descr");
            String Thumb = rs.getString("Thumbnail");
            String lat = rs.getString("Lat");
            String lon = rs.getString("Lon");
            
            String ava = "none";
            if(lat.equals("no")||lon.equals("no")){
               ava = "none";
            }
            else{
                ava = "block";
            }
                %> 
        <h1 class="font-weight-light text-center text-lg-middle mt-4 mb-0"><%=Title%></h1><hr>
        <div class="row justify-content-between">
            <div class="col-6"><img src="public/data/events/<%=Thumb%>" style="padding:1px;border:thin solid black;"  width="400px" height="400px"></div>
            <div class="col-6">
                <div style="color: crimson; font-weight: bold; font-size: 24pt;">TYPE :- <%= Type%>
                <div style="color:rgb(120, 44, 175); font-weight: bold; font-size: large; margin-top: 5%;" >Location :- <%=Place%></div>
                <kbd>Date :- <%=Date%></kbd>
                <kbd class="bg-warning text-dark" >Time :- <%=Time%></kbd>
                <div style="font-size: 24pt; margin-top: 5%;">Description</div><hr>
                <p style="color:black; font-size: 14pt;"><%=Descr%></p>
                    <!--<a href="login.jsp" class="btn btn-lg btn-primary">Join Event</a>-->
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
          content:'<h5><%=Title%></h5>'
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
  <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBZCdaW4FfTwwbQtEMA6sdJor5FchEJpRU&callback=initMap">
    </script>
              <%}%>
     

    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>