<%@page import="java.sql.*"%>
<%@page import="model.Connections"%>
<%@page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://kit.fontawesome.com/85bcb2089a.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"> 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="public/assets/js/profile.js" defer="" type="text/javascript"></script>
    <link href="public/assets/css/profilePg.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

    <%
        
        if(session.getAttribute("NIC")==null){
        response.sendRedirect(request.getContextPath()+"/login.jsp");
        }
        else{
           
            
    Connection conn;
    Statement stat;
    ResultSet rs,rs2;
    String sql,sql3;
     System.out.println("Name " + session.getAttribute("NIC"));
        Connections log = new Connections();
        log.Connect();
        conn = log.con;
        stat = log.qry;
        
        sql3 = "SELECT count(NIC) FROM appoint WHERE NIC = '"+session.getAttribute("NIC")+"'";
        rs2 = stat.executeQuery(sql3);
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
        cover = rs.getString("cover");
        profile = rs.getString("profile");
        City = rs.getString("City");
        District = rs.getString("District");
    %>
    <title><%=Name%> [ Admin ]</title>
</head>
<body>
   
    <div class="cover-photo"  style="background-image: url(public/data/users/cover/<%=cover%>); background-repeat: no-repeat;"><a id="coverbtn" >
    </div>
    <div class="body">
        <section class="left-col user-info">
            <div class="profile-avatar" style="background-image: url(public/data/users/profile/<%=profile%>); background-repeat: no-repeat;
                background-size: 216px 216px;">
                <div class="inner">
                    
                
                </div>
            </div>
            <div class="lef-col-con">
                <h1 style="font-size:14pt"><%="@" + Name%></h1>
                <div class="meta">
                    <b>[Administrator Account]</b><br><br>
                    <p><i class="fa fa-fw fa-map-marker"></i> <%=City%>, <%=District%></p>
                    <p><i class="fa fa-fw fa-id-card-o"></i> <%=NIC%></p>
                </div>
                
            </div>
        </section>
      
       <section class="section center-col content">
       
           
                <div class="mt-3" style="width: 1000px;">
                    <button class="btn active" onclick="window.location.href='admin.jsp'">Due Events</button>
                    <button class="btn" onclick="window.location.href='addEvent.jsp'">Create New Event</button>
                    <button class="btn" onclick="window.location.href='Shelter.jsp'">Shelter</button>
                    <button class="btn" onclick="window.location.href='addShelter.jsp'">Add Pet To Shelter</button>
                    <button class="btn" onclick="window.location.href='acceptapp.jsp'">Shelter Requests</button>
                    <button class="btn-lg btn-danger ml-5" onclick="window.location.href='login.jsp'">Log Out</button>
                             
                  </div>
      
                <hr>
                   <%}%>
                <% 
                    String sql2 = "Select * from events";
                       rs = stat.executeQuery(sql2);
                       while(rs.next()){
                           
            int eid = rs.getInt("EID");
            String Title = rs.getString("Title");
            String Date = rs.getString("Date");
            String Time = rs.getString("Time");
            String Place= rs.getString("Place");
            String Type = rs.getString("Type");
            String Descr = rs.getString("Descr");
            String Thumb = rs.getString("Thumbnail");
            
                           %>
                       
               <div class="card mb-3" style="max-width: 80rem;">
                <div class="row no-gutters">
                  <div class="col-md-4">
                      
                    <img src="public/data/events/<%=Thumb%>" class="card-img" alt="..." style="width: 95%; height: 90%; padding-left: 5%; padding-top: 7%;" >
                  </div>
                  <div class="col-md-8">
                    <div class="card-body" style="font-size: calc(.2vh + 12px);">
                      <h5 class="card-title"><%=Title%></h5>
                      <span style="color: crimson;">Type : <%=Type%></span></br>
                      
                      <span style="color:indigo">Location : <%=Place%></span></br>

                      <p class="card-text"><%= Descr%> </p>

                      
                      <p class="card-text"><small class="text-muted">Startes on <%=Date%> at <%=Time%></small></p>
                      <button class="btn btn-warning" onclick="window.location.href='OneEvent.jsp?EID=<%=eid%>'">More Details</button>
                    </div>
                  </div>
                </div>
            </div>
                <% }} %> 

                
               </section>
    </div>
    <!-- form for change password -->


    <script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/67239/masonry.pkgd.min.js"></script>
    <script type="text/javascript" src="//use.typekit.net/psm0wvc.js"></script>
    <script type="text/javascript">try{Typekit.load();}catch(e){}</script>

    
</body>
</html>

