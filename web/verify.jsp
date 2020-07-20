<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
 

        <!-- Required meta tags -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css" rel='stylesheet' type='text/css'> 
        <link href="https://fonts.googleapis.com/css?family=Lato:100,300,400,700" rel='stylesheet' type='text/css'> 
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel='stylesheet' type='text/css'> 
        <title>Verify Passcode</title>
        <style>
            <%
                String email = "";
            if(session.getAttribute("otp")== null || session.getAttribute("mail")== null){
            response.sendRedirect(request.getContextPath() + "/forget.jsp");
            }
            else{
            email = (String) session.getAttribute("mail");
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
        
        <script>
function restrictAlphabets(e){
				var x=e.which||e.keycode;
				if((x>=48 && x<=57) || x==8 ||
					(x>=35 && x<=40)|| x==46)
					return true;
				else
					return false;
			}
        </script>
    
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
                          <h3><i class="fa fa-key fa-4x"></i></h3>
                          <h3>Please enter the 6-digit verification code we sent to <span style='color: #FF0060; font-size: 12pt'><%=email%></span></h3>
                          <span>(we want to make sure it's you)</span>
                          <div class="panel-body">
            
                              <form id="register-form" action="verify" role="form" autocomplete="off" class="form" method="post">
            
                              <div class="form-group">
                                <div class="input-group">
                                  <span class="input-group-addon"><i class="fa fa-lock" aria-hidden="true"></i>
                                  </span>
                                  <input id="txtchar" name="passcode" placeholder="enter 6-Digit Verify Code" class="form-control" type="text"  min="0" maxlength="6" onkeypress='return restrictAlphabets(event)'>
                                </div>
                              </div>
                              <div class="form-group">
                                <input name="verify-submit" class="btn btn-lg btn-primary btn-block" value="Verify" type="submit">
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/16.7.0/umd/react.production.min.js"></script> 
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react-dom/16.7.0/umd/react-dom.production.min.js"></script> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    </html>