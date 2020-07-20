<%@page import="java.time.Period"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="model.Connections"%>
<%@page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://kit.fontawesome.com/85bcb2089a.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"> 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="public/assets/js/profile.js" defer="" type="text/javascript"></script>
    <link href="public/assets/css/profilePg.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
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
</style>
    <%
        
        if(session.getAttribute("NIC")==null){
        response.sendRedirect(request.getContextPath()+"/login.jsp");
        }
        else{
           
            
    Connection conn;
    Statement stat;
    ResultSet rs, rs2;
    String sql,sql2;
         System.out.println("Name " + session.getAttribute("NIC"));
        Connections log = new Connections();
        log.Connect();
        conn = log.con;
        stat = log.qry;
        
        sql2 = "SELECT count(NIC) FROM appoint WHERE NIC = '"+session.getAttribute("NIC")+"'";
        rs2 = stat.executeQuery(sql2);
        int count = 0;
        if(rs2.next()){
        count = rs2.getInt("count(NIC)");
        }
        
        sql = "SELECT * from users WHERE NIC = '"+session.getAttribute("NIC")+"'";
        rs = stat.executeQuery(sql);
        
        
        String Name = "";
        String NIC = "";
        String Gender = "";
        String DOB = "";
        String Email = "";
        String Address ="";
        String City = "";
        String District ="";
        String profile = "";
        String cover = "";

        
        
        if(rs.next()){
        Name = rs.getString("Name");
        NIC = rs.getString("NIC");
        Gender = rs.getString("Gender");
        DOB = rs.getString("DOB");
        Email = rs.getString("Email");
        Address = rs.getString("Address");
        City = rs.getString("City");
        District = rs.getString("District");
        cover = rs.getString("cover");
        profile = rs.getString("profile");
        
  String s = DOB;
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
  
  Calendar c = Calendar.getInstance();
  c.setTime(sdf.parse(s));
  int year = c.get(Calendar.YEAR);
  int month = c.get(Calendar.MONTH) + 1;
  int date = c.get(Calendar.DATE);
  LocalDate l1 = LocalDate.of(year, month, date);
  LocalDate now1 = LocalDate.now();
  Period diff1 = Period.between(l1, now1);
  System.out.println("Age : " + diff1.getYears() + " years");
        

    %>
    <title><%=Name%> [ Settings ]</title>
</head>
<body>
   
    <div class="cover-photo"  style="background-image: url(public/data/users/cover/<%=cover%>); background-repeat: no-repeat;"><a id="coverbtn" >
    </div>
    <div class="body">
        <section class="left-col user-info">
            <div class="profile-avatar" style="background-image: url(public/data/users/profile/<%=profile%>); background-repeat: no-repeat;
                background-size: 216px 216px;">
                <div class="inner">
                    
                    <div class="change">
                        <a id="probtn"><i class="fas fa-plus-circle" id="BtnDP"></i></a>
                    </div>
                
                </div>
            </div>
            <div class="lef-col-con">
                <h1 style="font-size:14pt"><%="@" + Name%></h1>
                <div class="meta">
                    <p><i class="fa fa-fw fa-map-marker"></i> <%=City%>, <%=District%></p>
                    <p><i class="fa fa-fw fa-id-card-o"></i> <%=NIC%></p>
                    <p><i class="fa fa-birthday-cake"></i> <%=diff1.getYears()%> Years</p>
                </div>
                
            </div>
        </section>
      
       <section class="section center-col content" >
       
           
                <div class="mt-3" style="width: 1000px;">
                    <button class="btn" onclick="window.location.href='userEvents.jsp'">Events</button>
                    <button class="btn" onclick="window.location.href='lostmy.jsp'">Lost my Pet</button>
                    <button class="btn" onclick="window.location.href='Shelter.jsp'">Shelter</button>
                    <button class="btn" onclick="window.location.href='viewlost.jsp'">View Lost</button>
                    <button class="btn active" onclick="window.location.href='userProfile.jsp'">Settings</button>
                    <button style="font-size:18px; margin-left: 10px;" id="petc" class="btn-lg btn-success">Cart [<%=count%>] <i class="fa fa-shopping-cart"></i></button>
                    <button class="btn-lg btn-danger ml-5" onclick="window.location.href='login.jsp'">Log Out</button>
                             
                  </div>
                <hr>
                <!-- Edit Profile Start -->
                <div class="container py-2">
                    <div class="row my-2">
                        <!-- edit form column -->
                        <div class="col-lg-8 order-lg-1 personal-info">
                            <form role="form" action="userupdate" method="POST">
                                <div class="form-group row">
                                    <label class="col-lg-3 col-form-label form-control-label">Full name</label>
                                    <div class="col-lg-9">
                                        <input class="form-control" type="text" name="name" value="<%=Name%>" />
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                    <label class="col-lg-3 col-form-label form-control-label">NIC</label>
                                    <div class="col-lg-9">
                                        <input class="form-control" type="text" maxlength="12" minlength="10" name="newnic" value="<%=NIC%>" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-lg-3 col-form-label form-control-label">Date of Birth</label>
                                    <div class="col-lg-9">
                                        <input class="form-control" type="date" name="DOB" value="<%=DOB%>" />
                                    </div>
                                </div>
<!--                                <div class="form-group row">
                                    <label class="col-lg-3 col-form-label form-control-label">Contact Number</label>
                                    <div class="col-lg-9">
                                        <input class="form-control" type="text" name="contactNo" value="<%%>" />
                                    </div>
                                </div>-->
                                <div class="form-group row">
                                    <label class="col-lg-3 col-form-label form-control-label">Address</label>
                                    <div class="col-lg-9">
                                        <input class="form-control" type="text" name="address" value="<%=Address%>" placeholder="Street" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-lg-3 col-form-label form-control-label"></label>
                                    <div class="col-lg-4">
                                        <input class="form-control" type="text" name="city" value="<%=City%>" placeholder="City" />
                                    </div>
                                    <div class="col-lg-4">
                                        <input class="form-control" type="text" name="district" value="<%=District%>" placeholder="District" />
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                    <label class="col-lg-3 col-form-label form-control-label">Email</label>
                                    <div class="col-lg-9">
                                        <input class="form-control" name="email" type="email" value="<%=Email%>" />
                                    </div>
                                </div>
                                     <div class="form-group row">
                                    <div class="col-lg-9 ml-auto text-right">
                                        <input type="submit" class="btn btn-primary active" value="Save Changes" style="margin-top: 10%;">
                                    </div>
                                </div>
                            </form>
                                    
                                <div class="form-group row">
                                    <label class="col-lg-3 col-form-label form-control-label">Password</label>
                                    <div class="col-lg-9">
                                        <!--<input type="button" class="btn btn-primary active" value="Change password" id="passbtn" >-->
                                 

<!-- Trigger/Open The Modal -->
<button id="myBtn" class="btn btn-primary active">Change Password</button>

<!-- The Modal -->
<div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <span class="close">&times;</span>
    <h4 style="margin-top: 3%; margin-bottom: 6%;">To Change Password</h4>
    <form action="userdataupdate" method="post" class="form-group" >     
    <div class="form-group row">
                <label class="col-lg-3 col-form-label form-control-label">Current Password</label>
                <div class="col-lg-5">
                    <input class="form-control" required minlength="6" name="current" type="password" />
                </div>
            </div>

            <div class="form-group row">
                <label class="col-lg-3 col-form-label form-control-label">New Password</label>
                <div class="col-lg-5">
                    <input class="form-control" required minlength="6" id="password" name="pwd" type="password"  />
                </div>
            </div>

            <div class="form-group row">
                <label class="col-lg-3 col-form-label form-control-label">Confirm Password</label>
                <div class="col-lg-5">
                    <input class="form-control" required minlength="6" name="cpwd" type="password" id="confirm_password" />
                </div>
            </div>
            <input type="submit" value="Change" class="btn btn-primary active float-right" style="width: 120px; margin-top: 5%; margin-left: 38%;">
    </form>
    </div></div>
    

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
</script>
                                    </div>
                                    
                                </div>
                                    
<!-- The Modal -->
<div id="myModa" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <span class="close">&times;</span>
    <h4 style="margin-top: 3%; margin-bottom: 6%;">Change Your Profile Picture</h4>
                    <form action="imageDP" method="post" enctype="multipart/form-data">
                    <label for="file" style="color: #222; font-weight: bold">Include Event Image</label>
                    <input type="file" required accept="image/png, image/jpeg" name="file" size="50" />
                    <div class="form-submit">
                    <input type="submit" class="btn btn-success" name="submit" id="submit" class="submit" value="Update Photo" />
                </div>
                    </form>
    </div></div>
<script>
// Get the modal
var moda = document.getElementById("myModa");

// Get the button that opens the modal
var bt = document.getElementById("BtnDP");

// Get the <span> element that closes the modal
var spann = document.getElementsByClassName("close")[1];

// When the user clicks the button, open the modal 
bt.onclick = function() {
  moda.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
spann.onclick = function() {
  moda.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == moda) {
    moda.style.display = "none";
  }
}
</script>

<!-- The Modal -->
<div id="myMod" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <span class="close">&times;</span>
    <div class="container">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-8"><h2><b></b>Pending Adoption</b></h2></div>
                    
                </div>
            </div>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Due Date</th>
                        <th>Photo</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                   
                    <!-- here -->
                    <tr>
                        <td>Wolf</td>
                        <td>2020-05-21</td>
                        <td><img src="default.jpg" width="170px" height="100px"></td>
                        <td>
                            <form action="hello" method=post>
                            <button class="delete" title="Delete" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></button>
                        </form>
                        </td>
                    </tr>
                  <!-- Here -->
                  
                </tbody>
            </table>
           
    </div>     
  </div>

</div>

<script>
// Get the modal
var modall = document.getElementById("myMod");

// Get the button that opens the modal
var btnn = document.getElementById("petc");

// Get the <span> element that closes the modal
var spa = document.getElementsByClassName("close")[2];

// When the user clicks the button, open the modal 
btnn.onclick = function() {
  modall.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
spa.onclick = function() {
  modall.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modall.style.display = "none";
  }
}
</script>


                        </div>
                    </div>
                </div>
                <!-- End of Edit Profile -->
                <%}}%>
        </section>
<!--      <section class="right-col">
        
      </section>-->
      
    </div>
    <!-- form for change password -->


    <script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/67239/masonry.pkgd.min.js"></script>
    <script type="text/javascript" src="//use.typekit.net/psm0wvc.js"></script>
    <script type="text/javascript">try{Typekit.load();}catch(e){}</script>

    
</body>


