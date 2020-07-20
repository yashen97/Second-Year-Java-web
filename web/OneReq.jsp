<%@page import="java.time.Period"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Connections"%>
<%@page import="java.sql.*"%>
<html>
    <head>
	  <meta charset = "utf-8">
	  <title></title>
	  <link href="https://fonts.googleapis.com/css?family=Baloo+Chettan%7CLora" rel="stylesheet">
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
          
      <style>

/* Setting the box-sizing rule */

*, *:before, *:after {
  -webkit-box-sizing: border-box; 
  -moz-box-sizing: border-box; 
  box-sizing: border-box;
}

/* Setting the font-family */

h1,
h2,
h3, 
nav,
footer p {
	font-family: 'Baloo Chettan', cursive;
}

 figcaption,
 p {
	font-family: 'Lora', serif;
}

/* Making the images responsive */

img {
	max-width: 100%;
}

/* Styling the body tag */

body {
	background: rgb(25, 48, 255);
	line-height: 1.5;
}

/* center align everything in one spot */

nav a,
h2,
h3,
.gradientBackground,
figcaption,
footer p  {
	text-align: center;
}

/* Centering the webpage */

.wrapper {
	max-width: 70em;
	margin: 0 auto;
}

/* Styling the header section */

.main-header {
	background: #007cff;
	background-image: linear-gradient(45deg, #0077ff, #007cff);
	height: 13em;
}

/* Styling the h1 inside the .main-header */

.main-header h1 {
	color: white;
	margin: 0;
	padding-top: .50em;
	text-align: center;
}

/* Styling the navigation */

nav ul {
	margin-top: 0;
	padding: 0;
	list-style-type: none;
}

nav a {
	display: block;
	font-size: 1.2em;
	font-weight: bold;
	margin-bottom: 1em;
	text-decoration: none;
}

/* Styling the navigation pseudo class */

nav a:link {
	color: rgb(255, 255, 255);
}

nav a:visited {
	color: rgb(159, 245, 0);
}

nav a:hover {
	color: white;
	text-decoration: underline;
}

/* Removing the space from the h2 */

h2 {
	margin-top: 0;
}

/* Styling the class .gradientBackground  and footer */

.gradientBackground,
footer {
	background: #007cff;
	background-image: radial-gradient(rgb(0, 225, 255), rgb(35, 68, 255));
	padding: .65em;
}

footer p {
	font-size: 1.3em;
	font-weight: bold;
}

/*
==============================
MEDIA QUERIES
==============================
*/

@media (min-width: 550px) and (max-width: 650px) {
	.main-header {
		height: 4em;
	}
	.main-header h1 {
		padding-left: .65em;
		font-size: 1.5rem;
		float: left;
	}
	nav {
		float: right;
	}
	nav li {
		display: inline-block;
	}
	nav a {
		padding-top: .85em;
		padding-right: 1em;
	}
}

@media (min-width: 651px) {
	.main-header {
		height: 10em;
	}
	.main-header h1 {
		float: none;
	}
	nav {
		float: none;
		text-align: center;
	}
	nav li {
		display: inline-block;
	}
	nav a {
		padding: 1em;
	}
	.primary-content,
	.secondary-content {
		margin-right: .75em;
	}
	.col {
		display: inline-block;
		margin-right: -4px;
		padding-left: 1em;
		padding-right: 1em;
		vertical-align: top;
		width: 50%;
	}
}

    </style>
   
</head>
    <body>
        <%
            String aid = "";
            String nic = "";
            String pid = "";
           
            if(session.getAttribute("NIC")!=null){
                if(session.getAttribute("Type").equals("admin")){
        if(request.getQueryString()!= null){
           aid = request.getParameter("AID");
           nic = request.getParameter("NIC");
           pid = request.getParameter("PID");
        }
        else{
         response.sendRedirect(request.getContextPath() + "/acceptapp.jsp");
                }
                }
        else{
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
        }
            else{
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            }
       
    Connection conn;
    Statement stat;
    ResultSet rs,rs2;
    String sql,sql2;
    
        Connections log = new Connections();
        log.Connect();
        conn = log.con;
        stat = log.qry;
        
        String UNAME = "", NIC = "", GENDER = "", DOB = "", Email = "", City = "", District = "", profile = "", address = "" ;
        
        sql = "SELECT * FROM users WHERE NIC = '"+nic+"'";
        rs = stat.executeQuery(sql);
        if(rs.next()){
        UNAME = rs.getString("Name");
        GENDER = rs.getString("Gender");
        DOB = rs.getString("DOB");
        Email = rs.getString("Email");
        City = rs.getString("City");
        District = rs.getString("District");
        profile = rs.getString("profile");
        address = rs.getString("Address");
        }
        
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
  String Agee =  diff1.getYears() + " Years";
  
  String Pname = "", Ptype = "", Pgender = "", Page = "", Colour = "", Des = "", Thumb = "" ;
  
  sql2 = "SELECT * from shelter WHERE petID = '"+pid+"'";
  rs = stat.executeQuery(sql2);
  if(rs.next()){
      Pname = rs.getString("Name");
      Ptype = rs.getString("Type");
      Page = rs.getString("Age");
      Colour = rs.getString("Colour");
      Des = rs.getString("Description");
      Thumb = rs.getString("Thumb");
      Pgender = rs.getString("Gender");
  }
        %>
        
        <div class="gradientBackground">
	      <h2><%=Pname%> & <%=UNAME%></h2>
	      <div class="primary-content col">
                  <h3><%=Pname%> - <%=Ptype%></h3>
            <figure class="fade">
                <img src="public/data/shelter/<%=Thumb%>" alt=""  width="300px" height="300px">
                <br><br><br>
                <figcaption class="callback" style="color:white;font-weight: bold"><%=Page%></figcaption>
            </figure>
            <h4>Colour : <%=Colour%>  Gender : <%=Pgender%></h4>
            <p>
            <%=Des%>
            </p>
	      </div>
	      <div class="secondary-content col">
	        <h3><%=UNAME%></h3>
	        <figure class="fade">
                    <img src="public/data/users/profile/<%=profile%>" width="300px" height="300px">
                <br><br><br>
	        	<figcaption class="callback" style="color:white;font-weight: bold"><%=Agee%></figcaption>
	        </figure>
                
                        <h4>Gender : <%=GENDER%> <br> Home :  <%=City%> <%=District%></h4>
	        <p>
	        E- Mail : <%=Email%>
                </p>
	      </div>
                <form method="post" action="genreport" >
                    <input type="hidden" name="AID" value="<%=aid%>">
                    <input type="hidden" name="CName" value="<%=UNAME%>">
                    <input type="hidden" name="Address" value="<%=address%>">
                    <input type="hidden" name="City" value="<%=City%>">
                    <input type="hidden" name="District" value="<%=District%>">
                    <input type="hidden" name="PName" value="<%=Pname%>">
                    <input type="hidden" name="Type" value="<%=Ptype%>">
                    <input type="hidden" name="Gender" value="<%=Pgender%>">
                    <input type="hidden" name="Age" value="<%=Page%>">
                    <input type="hidden" name="Colour" value="<%=Colour%>">
                    <input type="hidden" name="Des" value="<%=Des%>">
                    <input type="hidden" name="email" value="<%=Email%>"
                    <input type="hidden" name="Thumb" value="<%=Thumb%>">
                    <input type="submit" value="Accept">
                </form>
                <button onclick="window.location.href='acceptapp.jsp'">Cancel</button>
                
	    </div>
	  
	  </div>
	  <script >
/* Hiding the two pictures, so if javascript is disabled the 
user still sees the pics */

$(".fade, .callback").hide();

/* Creating a function and a callback
that will fade the pictuer in first
and then fade in the caption. */


$(".fade").fadeIn(2000, function() {
	$(".callback").fadeIn(2500);
});


      </script>
    </body>
</html>