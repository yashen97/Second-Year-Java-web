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
            if(session.getAttribute("mail") == null){
             response.sendRedirect(request.getContextPath()+"/forget.jsp");
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
.wrap {
  box-sizing: border-box;
  border: 1px solid rgba(0, 0, 0, 0.2);
  display: flex;
  width: 192px;
  height: 58px;
  position: relative;
}

.display {
  box-sizing: border-box;
  border-right: 1px solid rgba(0, 0, 0, 0.2);
  display: flex;
  flex: 1;
  align-items: center;
  justify-content: center;
  font-size: 32px;
  position: relative;
}

.display:last-child {
  border-right: none;
}

.input {
  position: absolute;
  border: none;
  font-size: 32px;
  text-align: center;
  background-color: transparent;
  outline: none;
}

.shadows {
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  right: 0;
  box-shadow: 0 0 0 4px rgba(58, 151, 212, 0.28);
}
        </style>

        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
        <script type="text/javascript">
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
        </script>

    </head>
    <body>
      <div id="root"></div>
        <div>

    </div>&nbsp;&nbsp;&nbsp;&nbsp;
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="panel panel-default">
                      <div class="panel-body">
                        <div class="text-center">
                          <h3><i class="fa fa-unlock-alt fa-4x"></i></h3>
                          <h2 class="text-center">Reset Your Password!</h2>
                          <p>You can reset your password here.</p>
                          <div class="panel-body">
            
                              <form id="register-form" role="form" action="reset" autocomplete="off" class="form" method="post">
            
                              <div class="form-group">
                                <div class="input-group">
                                  <span class="input-group-addon"><i class="fa fa-key"></i></span>
                                  <input id="txtPassword" minlength='6' name="password" placeholder="new password" class="form-control"  type="password" required>
                                </div>
                              </div>

                              <div class="form-group">
                                <div class="input-group">
                                  <span class="input-group-addon"><i class="fa fa-key"></i></span>
                                  <input id="txtConfirmPassword" minlength='6' name="cpassword" placeholder="confirm password" class="form-control"  type="password" required>
                                </div>
                              </div>

                              <div class="form-group">
                                <button type="submit" id="btnSubmit" class="btn btn-primary">
                                    <i class="fa fa-btn fa-refresh"></i>Reset Password
                                </button>
                               
                              </div>
                              
                             
                            </div>
                         </div>
                     </div>
                </div>
            </div>
        </div>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
        
    </body>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/16.7.0/umd/react.production.min.js"></script> 
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react-dom/16.7.0/umd/react-dom.production.min.js"></script> 
    </html>

