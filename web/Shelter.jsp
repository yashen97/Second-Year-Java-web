<%@page import="java.sql.*"%>
<%@page import="model.Connections"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
     <link href="https://fonts.googleapis.com/css?family=Open+Sans|Pacifico" rel="stylesheet"> 
  <title>iPet</title>
</head>
<link href="public/assets/css/shelter.css" rel="stylesheet" type="text/css"/>
<body>

  <header>
    <div>

     <i class="fa fa-paw" aria-hidden="true"></i>

     <a href="index.jsp" style="text-decoration:none;color: yellow"><p>iPet</p></a>
    </div>
    
   <%
       String show = "";
       String hide = "";
       String qry = "";
       String home = "";
       if(session.getAttribute("NIC")==null){
       show = "block";
       hide = "none";
       qry = "where isHere='1'";
       home = "";
       }
       else if(session.getAttribute("NIC")!=null){
     if(session.getAttribute("Type").equals("user")){
       show = "none";
       hide = "block";
       home = "userEvents.jsp";
       qry = "where isHere='1'";
     }
     else if(session.getAttribute("Type").equals("admin")){
        qry = "";
        home = "admin.jsp";
        show = "none";
       hide = "block";
         }  
   }
  
   
   %>
      
    <nav  style="display:<%=show%>">
      <ul>
        <li><a href="allEvents.jsp">Events</a></li>
        <li><a style="background-color:rgba(255,255,255,0.8); color:black;" href="Shelter.jsp">Shelter</a></li>
        <li><a href="register.jsp">Sign up</a></li>
        <li><a  href="login.jsp">Sign in</a></li>
      </ul>
    </nav>
   <nav style="display:<%=hide%>">
      <ul>
          <li><a href="<%=home%>">My Profile</a></li>
        <li><a href="allEvents.jsp">Events</a></li>
        <li><a style="background-color:rgba(255,255,255,0.8); color:black;" href="Shelter.jsp">Shelter</a></li>
        <li ><a style="background-color:rgba(255,0,0,0.5); color:white" href="login.jsp">Log out</a></li>
      </ul>
    </nav>
  </header>
    <section class="titles">

    <h1>Animal Shelter</h1>
    <p>We will use only animal-friendly, fair-trade yarn. Only the best!</p>

  </section>
      <main class="page-content">
  <%
  Connection conn;
    Statement stat;
    ResultSet rs;
    String sql;
        
        Connections log = new Connections();
        log.Connect();
        conn = log.con;
        stat = log.qry;
        
        sql = "SELECT * from shelter "+qry+" ";
        
        rs = stat.executeQuery(sql);
        while(rs.next()){
            int pid = rs.getInt("petID");
            String Name = rs.getString("Name");
            String Type = rs.getString("Type");
            String Gender = rs.getString("Gender");
            String Age= rs.getString("Age");
            String Thumb = rs.getString("Thumb");
            
  %>

      <!--TO BE CONTINUED after making add animal to shelter-->
      <div class="card" style="background-image: url('public/data/shelter/<%=Thumb%>');"> 
        <div class="content">
            <h2 class="title"><%=Name%> - <%=Type%></h2>
            <p class="copy">Gender : <%=Gender%><br>Age : <%=Age%></p><button class="btn" onclick="window.location.href='OneShelter.jsp?PID=<%=pid%>'">View More</button></div>
    </div>
      <%}%>
</main>

</body>

</html>