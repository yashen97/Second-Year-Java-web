<%@page import="model.Connections"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shelter Infomation</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link href="public/assets/css/detail.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    <header>
    <div>
     <i class="fa fa-paw" aria-hidden="true"></i>

        
     <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
     <link href="https://fonts.googleapis.com/css?family=Open+Sans|Pacifico" rel="stylesheet">
     <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
   <link href="public/assets/css/shelter.css" rel="stylesheet" type="text/css"/>
      <p>iPet</p>
    </div>
     <%
       String show = "";
       String hide = "";
       String qry = "";
       String home = "";
       String btn1 = "";
       String btn2 = "";
       if(session.getAttribute("NIC")==null){
        btn1 = "block";
        btn2 = "none";
        show = "block";
        hide = "none";
        qry = "where isHere='1'";
       }
       else if(session.getAttribute("NIC")!=null){
      
        if(session.getAttribute("Type").equals("admin")){
        qry = "";
        btn1 = "none";
        btn2 = "block"; 
        home = "admin.jsp";
        show = "none";
        hide = "block";
   }
      else if(session.getAttribute("Type").equals("user")){
        show = "none";
        hide = "block";
        home = "userEvents.jsp";
        qry = "where isHere='1'";
        btn1 = "block";
        btn2 = "none"; 
   }
        
   }
  
   
   %>
      
    <nav  style="display:<%=show%>">
        <ul style="padding-top:10px">
        <li><a style="text-decoration:none" href="allEvents.jsp">Events</a></li>
        <li><a style="text-decoration:none; background-color:rgba(255,255,255,0.8); color:black;" href="Shelter.jsp">Shelter</a></li>
        <li><a style="text-decoration:none" href="register.jsp">Sign up</a></li>
        <li><a style="text-decoration:none"  href="login.jsp">Sign in</a></li>
      </ul>
    </nav>
   <nav style="display:<%=hide%>">
      <ul  style="padding-top:10px">
          <li><a style="text-decoration:none" href="<%=home%>">My Profile</a></li>
        <li><a style="text-decoration:none" href="allEvents.jsp">Events</a></li>
        <li><a style="background-color:rgba(255,255,255,0.8); color:black; text-decoration:none" href="Shelter.jsp">Shelter</a></li>
        <li ><a style="background-color:rgba(255,0,0,0.5); text-decoration: none; color:white" href="login.jsp">Log out</a></li>
      </ul>
    </nav>
  </header>
  <%    String pid = "";
      if(request.getQueryString()==null){
          response.sendRedirect(request.getContextPath()+"/allEvents.jsp");
      }
      else{
      pid = request.getParameter("PID");
      }
      

  %>
    <div class="container mb-5">
   <% 
    Connection conn;
    Statement stat;
    ResultSet rs;
    String sql;
    
        Connections log = new Connections();
        log.Connect();
        conn = log.con;
        stat = log.qry;
        sql = "SELECT * from shelter WHERE petID='"+pid+"'";
        
        rs = stat.executeQuery(sql);
        while(rs.next()){
            String Name = rs.getString("Name");
            String Type = rs.getString("Type");
            String Gender = rs.getString("Gender");
            String Age= rs.getString("Age");
            String Colour = rs.getString("Colour");
            String Descr = rs.getString("Description");
            String Thumb = rs.getString("Thumb");
                %> 
        <h1 class="font-weight-bolder text-light text-center text-lg-middle mt-4 mb-0"><%=Name%></h1><hr>
        <div class="row justify-content-between">
            <div class="col-6"><img src="public/data/shelter/<%=Thumb%>" style="padding:1px;border:thin solid black;"  width="400px" height="400px"></div>
            <div class="col-6">
                <div style="color: crimson; font-weight: bold; font-size: 24pt;">TYPE :- <%= Type%>
                <div style="color:yellow; font-weight: bold; font-size: large; margin-top: 5%;" >Gender :- <%=Gender%></div>
                <kbd>Age :- <%=Age%></kbd>
                <kbd class="bg-warning text-dark" >Colour :- <%=Colour%></kbd>
                <div style="font-size: 24pt; margin-top: 5%;">Description</div><hr>
                <p style="color:white; font-size: 14pt;"><%=Descr%></p>
                
                <form style="display:<%=btn1%>" action="appoint" method="post">
                    <input type="hidden" name="pid" value="<%=pid%>">
                    <button type="submit" class="btn" style="color:yellow" >Make an Appointment</button>
                </form>
                 <form style="display:<%=btn2%>" action="eventdel" method="post">
                    <input type="hidden" name="pid" value="<%=pid%>">
                    <button type="submit" class="btn" style="color:red" >Remove Pet</button>
                </form>  
                    
                </div>
                    <hr> </div>
        </div>
    </div>

              <%}%>
     

    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>