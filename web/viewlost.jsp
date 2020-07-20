<%@page import="model.Connections"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie-edge">

    <title>Lost Pets</title>

   <!--BootStrap and other links-->
   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" > 
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
   <link href="public/assets/css/events.css" rel="stylesheet" type="text/css"/>
   <link href="public/assets/css/allevent.css" rel="stylesheet" type="text/css"/>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.3/jquery.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick.min.js"></script>
   <link href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick-theme.min.css" rel="stylesheet" />
   <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
   
</head>
<body >
    <header>
    
      <%
        String show = "block";
       String hide = "none";
   if(session.getAttribute("NIC")!=null){
       show = "none";
       hide = "block";
   }
   
   %>
        
     <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
     <link href="https://fonts.googleapis.com/css?family=Open+Sans|Pacifico" rel="stylesheet">
         <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
     <link href="https://fonts.googleapis.com/css?family=Open+Sans|Pacifico" rel="stylesheet"> 
     <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
   <link href="public/assets/css/allevent.css" rel="stylesheet" type="text/css"/>
   <a style="text-decoration: none; color: yellow" href="index.jsp" ><div>
   <i class="fa fa-paw fa-2x" aria-hidden="true"></i>
   <p>I Pet</p>
    </div></a>
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
        <li><a style="text-decoration: none; background-color: rgba(255,255,255,0.3);color:black" href="viewlost.jsp">View Lost</a></li>
        <li><a style="text-decoration: none" href="Shelter.jsp">Shelter</a></li>
        <li ><a style="background-color:rgba(255,0,0,0.8); text-decoration: none; color:white" href="login.jsp">Log out</a></li>
      </ul>
    </nav>
  </header>
    <section class="titles">
    <h1> Lost Pets</h1>
  </section>
    <div class="container">
        <div class="row">
                <!-- Bootstrap card -->
                <% 
    Connection conn;
    Statement stat;
    ResultSet rs;
    String sql;
        
        Connections log = new Connections();
        log.Connect();
        conn = log.con;
        stat = log.qry;
        sql = "SELECT * from lost where isFound = 0 ";
        
        rs = stat.executeQuery(sql);
        while(rs.next()){
            int lid = rs.getInt("LID");
            String Title = rs.getString("Name");
            String Age = rs.getString("Age");
            String Colour = rs.getString("Colour");
            String Place= rs.getString("LSLoc");
            String Type = rs.getString("Type");
            String Descr = rs.getString("Dis");
            String Thumb = rs.getString("Thumbnail");
            
                %> 
            <div class="col-4-lg">
                <div class="card" style="width: 20rem; height: 31rem;">
                    <img src="public/data/lost/<%=Thumb%>" height="225px" alt="Card One" class="card-img-top">
                    <div class="card-body">
                        <h5 class="card-title"><%=Title%></h5>
                        <span style="color: rgb(255, 0, 98); font-weight: bold;"><%=Type%></span></br>
                        <span style="color: limegreen;"><%=Place%></span></br>
                        <% int leng = Descr.length();
                            String text="";
                        
                        if(leng>=100){
                           text = Descr.substring(0, 49);
                           text = text + "...";
                        }
                        else{
                            text = Descr;
                        }
                        %>
                        
                        <p class="card-text" style="margin-top: 5%;font-size:8pt;"><%=text%></p>
                        <p class="card-text"><small class="text-muted">Age : <%=Age%> <br> Colour : <%=Colour%></small></p>
                        <a href="OneLost.jsp?LID=<%=lid%>" class="btn btn-primary">More</a>
                         
                    </div>
                </div>
                
            </div> <% } %>
            
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" ></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
 <br><br>
</body>
</html>