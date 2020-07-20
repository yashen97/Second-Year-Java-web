<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>I Pet Registration</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- STYLE CSS -->
    <link href="public/assets/css/ureg.css" rel="stylesheet" type="text/css"/>
    <link href="public/assets/css/index.css" rel="stylesheet" type="text/css"/>
    <!--<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">-->
    <!-- Javascript code to derive gender and dob  -->
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script>
         $(function () {
                $("#btnSubmit").click(function () {
                    var password = $("#txtPassword").val();
                    var confirmPassword = $("#txtConfirmPassword").val();
                    if (password != confirmPassword) {
                        alert("Passwords do not match.");
                        return false;
                    }
                    return true;
                });
            });
        
      function reviewNIC() {
        var gender, fullDate, byr, bdate;

        var nic = document.getElementById("nic").value;
        var dob = document.getElementById("dob");
        var sex = document.getElementById("sex");

        // Verify Old Id
        if (nic.length == 10 && (nic.includes("V") || nic.includes("v"))) {
          byr = nic.slice(0, 2);
          bdate = nic.slice(2, 5);
          if (bdate >= 001 && bdate <= 366) {
            gender = "Male";
            byr = "19" + byr;
            console.log("Birth Year :" + byr);
            fullDate = dateFromDay(byr, bdate);
            fullDate = fullDate.toISOString().slice(0, 10);
            dob.value = fullDate;
            sex.value = gender;
          } else if (bdate >= 501 && bdate <= 866) {
            gender = "Female";
            byr = "19" + byr;
            console.log("Birth Year :" + byr);
            fullDate = dateFromDay(byr, bdate);
            fullDate = fullDate.toISOString().slice(0, 10);
            dob.value = fullDate;
            sex.value = gender;
          } else {
            alert("Invalid NIC");
            sex.value = "";
            dob.value = null;
          }
        }

        //Verify New Id
        else if (nic.length == 12) {
          byr = nic.slice(0, 4);
          bdate = nic.slice(4, 7);
          if (bdate >= 001 && bdate <= 366) {
            gender = "Male";

            fullDate = dateFromDay(byr, bdate);
            fullDate = fullDate.toISOString().slice(0, 10);
            dob.value = fullDate;
            sex.value = gender;
          } else if (bdate >= 501 && bdate <= 866) {
            gender = "Female";
            fullDate = dateFromDay(byr, bdate);
            fullDate = fullDate.toISOString().slice(0, 10);
            dob.value = fullDate;
            sex.value = gender;
          } else {
			alert("Invalid NIC");
            sex.value = "";
            dob.value = null;
          }
        }

        //Not Valid Id
        else {
        }
      }

      function dateFromDay(year, day) {
        var date = new Date(year, 0); // initialize a date in `year-01-01`
        return new Date(date.setDate(day)); // add the number of days
      }
    </script>
  </head>
<%
    String change = "none";
if(request.getQueryString()!= null){
    change = "block";
}
%>
  <body>
      <header>
    <div>
     <i class="fa fa-paw" aria-hidden="true"></i>

      <p>iPet</p>
    </div>
    <nav>
      <ul>
        <li><a href="allEvents.jsp">Events</a></li>
        <li><a href="Shelter.jsp">Shelter</a></li>
        <li><a style="background-color: rgba(255,255,255,0.5); color:black;" href="register.jsp">Sign up</a></li>
        <li><a href="login.jsp">Sign in</a></li>
      </ul>
    </nav>
  </header>
    <div
      class="wrapper" style="margin-top:10px;"
      style="background-image: url('public/assets/images/regback.jpg');"
    >
        
      <div class="inner">
        <div class="image-holder">
          <img src="public/assets/images/regform.jpg" alt="" />
        </div>
          
          <form action="register" method="post">
              <center><kbd style="color: white; background-color:#FF0060; padding:10px; display: <%=change%>">Your NIC is already registered ! Please try <a style="background-color: yellow; text-decoration: none" href="forget.jsp?nic=<%=request.getParameter("Nic")%>">Resetting Password</a></kbd></center>
              <h3 style="margin-top:1rem">Registration Form</h3>
          
          <div class="form-group">
            <input
              type="text"
              placeholder="First Name"
              name="fname"
              class="form-control"
              required
            />
            <input
              type="text"
              placeholder="Last Name"
              class="form-control"
              name="lname"
              required
            />
          </div>
          <div class="form-wrapper">
            <input
              type="text"
              placeholder="NIC"
              id="nic"
              name="nic"
              onkeyup="reviewNIC()"
              class="form-control"
              required
              maxlength="12"
              minlength="10"
            />
            <i class="zmdi zmdi-account"></i>
          </div>
          <div class="form-group">
            <input
              type="text"
              placeholder="Gender"
              id="sex"
              name="sex"
              class="form-control"
              required
            />
            <input
              type="date"
              placeholder="DOB"
              id="dob"
              name="dob"
              class="form-control"
              required
            />
          </div>
          <div class="form-wrapper">
            <input
              type="email"
              name="email"
              placeholder="Email Address"
              class="form-control"
              required
            />
            <i class="zmdi zmdi-email"></i>
          </div>
          <div class="form-wrapper">
            <input
              type="text"
              name="address"
              placeholder="Address"
              class="form-control"
              required
            />
            <i class="zmdi zmdi-pin"></i>
          </div>
          <div class="form-group">
            <input
              type="text"
              placeholder="City"
              name="city"
              class="form-control"
              required
            />
            <input
              type="text"
              placeholder="District"
              name="district"
              class="form-control"
              required
            />
          </div>
          <div class="form-wrapper">
            <input
              type="password"
              placeholder="Password (min 6 char)"
              class="form-control"
              minlength="6"
              id="txtPassword"
              required
            />
            <i class="zmdi zmdi-lock"></i>
          </div>
          <div class="form-wrapper">
            <input
              type="password"
              placeholder="Confirm Password"
              class="form-control"
              name="password"
              minlength="6"
              id="txtConfirmPassword"
              required
            />
            <i class="zmdi zmdi-lock"></i>
          </div>
          <button id="btnSubmit">
            Register
            <i class="zmdi zmdi-arrow-right"></i>
          </button>
        </form>
      </div>
    </div>
  </body>
</html>
