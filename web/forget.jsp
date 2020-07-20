<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
 

        <!-- Required meta tags -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css" rel='stylesheet' type='text/css'> 
        <link href="https://fonts.googleapis.com/css?family=Lato:100,300,400,700" rel='stylesheet' type='text/css'> 
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel='stylesheet' type='text/css'> 
        <title>iPET Reset</title>
        <style>
            
            <%
                String nic = "";
            if(request.getQueryString()!=null){
            nic = request.getParameter("nic");
            }
            %>

body {
background: #2980B9;  /* fallback for old browsers */
background: -webkit-linear-gradient(to bottom, #FFFFFF, #6DD5FA, #2980B9);  /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(to bottom, #FFFFFF, #6DD5FA, #2980B9); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */

  font-family: 'Lato';
}

.fa-btn {
  margin-right: 6px;
}
        </style>
    
    </head>
    <body>
        <div>

    </div>&nbsp;&nbsp;&nbsp;&nbsp;
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="panel panel-default">
                      <div class="panel-body">
                        <div class="text-center">
                          <h3><i class="fa fa-lock fa-4x"></i></h3>
                          <h2 class="text-center">Forgot Password?</h2>
                          <p>You can reset your password here.</p>
                          <div class="panel-body">
            
                              <form  action="forget" role="form" autocomplete="off" class="form" method="post">
            
                              <div class="form-group">
                                <div class="input-group">
                                  <span class="input-group-addon"><i class="glyphicon glyphicon-user color-blue"></i></span>
                                  <input name="nic" placeholder="NIC" value="<%=nic%>" maxlength="12" minlength="10" required class="form-control"  type="text">
                                </div>
                              </div>
                              <div class="form-group">
                                <input name="recover-submit" class="btn btn-lg btn-primary btn-block" value="Request OTP" type="submit">
                              </div>
                            </form>
                            </div>
                         </div>
                     </div>
                </div>
            </div>
        </div>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
        
    </body>
    </html>

