<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/mycss/loginowner.css">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="wrapper">

            <div class="back">
                <a href="${pageContext.request.contextPath}/myhtml/home_page.html"><i class="fa-solid fa-arrow-left"></i> Back to Home</a>
            </div>

            <div class="container">

                <div class="heading-area">
                    <h1>Welcome Back</h1>
                    <p>Login to your account to continue</p>
                </div>

                <!-- USER + OWNER ICONS -->
                <div class="role-icons">
                    <a href="myhtml/login_user.html" class="role-box ">
                        <div class="role-grid">
                            <i class="fa-solid fa-user"></i>
                            <span>User</span>
                        </div>
                    </a>

                    <a href="myhtml/login_owner.html" class="role-box active-role">
                        <div class="role-grid">
                            <i class="fa-solid fa-store"></i>
                            <span>Restaurant Owner</span>
                        </div>
                    </a>
                </div>
                <% if (request.getAttribute("msg") != null) {%>
                <p style="color:red;"><%= request.getAttribute("msg")%></p>
                <% }%>
                <form action="/FoodOrderProject/loginowner">

                    <div class="input-box">
                        <label>Email</label>
                        <input type="text" name="email" placeholder="Enter your email">
                    </div>

                    <div class="input-box">
                        <label>Password</label>
                        <input type="password" name="pass" placeholder="Enter your password">
                    </div>

                    <button class="login-btn">Login</button>

                </form>
               <div class="other">
                    Don't have an account?
                    <a href="myhtml/signup_owner.html" class="signup-link">Sign up here</a>
                </div>
            </div>

        </div>
    </body>
</html>
