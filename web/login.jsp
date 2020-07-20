<!DOCTYPE html>
<html lang="en">
<head>
	<title>Login I Pet </title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="public/assets/css/signin.css" rel="stylesheet" type="text/css"/>
         <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans|Pacifico" rel="stylesheet"> 
        <!--<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">-->
</head>
<body>
	<%
            if(session.getAttribute("NIC")!=null){
                HttpSession ses = request.getSession();
                ses.invalidate();
            }
            String change = "none";
        if(request.getQueryString()!=null){
        change = "block";
        }
        %>
	<header>
            <a href="index.jsp" style="text-decoration: none; color: yellow"><div>
     <i class="fa fa-paw" aria-hidden="true"></i>

      <p style="color: yellow; font-size: 14pt">iPet</p>
                </div></a>
    <nav>
      <ul>
         <li><a href="allEvents.jsp">Events</a></li>
        <li><a href="Shelter.jsp">Shelter</a></li>
        <li><a href="register.jsp">Sign up</a></li>
        <li><a style="background-color: rgba(255,255,255,0.5);color:black" href="login.jsp">Sign in</a></li>
      </ul>
    </nav>
  </header>
        
        <div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form-title" style="background-image: url(public/assets/images/signin.jpg);">
					<section class="titles">

    <h1>Log In</h1>
  </section>
				</div>
                            <kbd  style="text-align: center; color:#FF0060; background-color:yellow; font-weight: bolder;  display: <%=change%>">Sorry, Your username or password is incorrect</kbd>
                            <form method="POST" action="login" class="login100-form validate-form">
					<div class="wrap-input100 validate-input m-b-26" data-validate="Username is required">
						<span class="label-input100">NIC</span>
                                                <input class="input100" name="nic" type="text" required name="username" placeholder="Enter username">
						<span class="focus-input100"></span>
					</div>

					<div class="wrap-input100 validate-input m-b-18" data-validate = "Password is required">
						<span class="label-input100">Password</span>
                                                <input class="input100" name="pwd" type="password" required name="pass" placeholder="Enter password">
						<span class="focus-input100"></span>
					</div>

					<div class="flex-sb-m w-full p-b-30">
						<div class="contact100-form-checkbox">
							<input class="input-checkbox100" id="ckb1" type="checkbox" name="remember-me">
							<label class="label-checkbox100" for="ckb1">
								Remember me
							</label>
						</div>

						<div>
							<a href="forget.jsp" class="txt1">
								Forgot Password?
							</a>
						</div>
					</div>

					<div class="container-login100-form-btn">
						<button class="login100-form-btn">
							Login
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

</body>
</html>