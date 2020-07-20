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
                <button onclick="window.location.href='userEvents.jsp'"  class="btn-danger mt-2" >X</button>
                
            <form method="POST" class="appointment-form" action="lostpet" id="appointment-form">
                <h2>Lost Pet Form</h2>
                
                <div class="form-group-1">
                    <label for="title" style="color: #222; font-weight: bold">Pet Name</label>
                    <input type="text" name="name" required />
                    <label for="date" style="color: #222; font-weight: bold">Animal Type</label>
                    <input type="text" name="type" required />
                    <label for="time" style="color: #222; font-weight: bold">Last Seen Location</label>
                    <input type="text" name="lsloc" id="time" required />
                    <label for="place" style="color: #222; font-weight: bold">Age</label>
                    <input type="text" name="age" id="place"  required />
                    <label for="type" style="color: #222; font-weight: bold">Colour</label>
                    <input type="text" name="colour" id="type" required />
                    <label for="desc" style="color: #222; font-weight: bold">Description</label>
                    <input type="text" name="des" id="desc" required />
                </div>
                
                <div class="form-submit">
                    
                    <input type="reset" value="Reset" class="btn btn-danger">
                   
                    <center><input type="submit" name="submit" id="submit" class="btn-lg btn-success" value="Report Pet" /></center>
                </div>
            </form>
        </div>
                <!--Image-->
                <div style="display:<%=pic%> ; padding:3rem;">
                    <form action="imageLost" method="post" enctype="multipart/form-data">
                    <label for="file" style="color: #222; font-weight: bold">Include Pet Image</label>
                    <input type="file" required accept="image/png, image/jpeg" name="file" size="50" />
                    <div class="form-submit">
                    <input type="submit" name="submit" id="submit" class="submit" value="Upload" />
                    <kbd style="background-color: orangered; padding: 5px;"><a style="text-decoration: none; color:white;" href="userEvents.jsp">Skip</a></kbd>
                </div>
                    </form>
                </div>
             
    </div></div>
    

        </div>
    </div>

</body>
</html>