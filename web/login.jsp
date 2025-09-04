<%@page import="Database_conn.Database_Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>


<%
    // Check if form is submitted
    String empId = request.getParameter("empId");
    String password = request.getParameter("password");
    String errorMessage = null;
    
    if (empId != null && password != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = Database_Connection.getConnection();
            String sql = "SELECT  u.Username, u.EmployeeNumber, u.Email, u.Division, d.DivisionName " +
                        "FROM UserMaster1 u LEFT JOIN DivisionMaster d ON u.Division = d.DivisionID " +
                        "WHERE u.EmployeeNumber = ? AND u.Password = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, empId);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                // Login successful - store user info in session
       
                session.setAttribute("username", rs.getString("Username"));
                session.setAttribute("empId", rs.getString("EmployeeNumber"));
                session.setAttribute("email", rs.getString("Email"));
                session.setAttribute("division", rs.getInt("Division"));
                session.setAttribute("divisionName", rs.getString("DivisionName"));
                session.setAttribute("isLoggedIn", true);
                
                response.sendRedirect("admin_dashboard.jsp");
                return;
            } else {
                errorMessage = "Invalid Employee ID or Password!";
            }
        } catch (Exception e) {
            errorMessage = "Database error: " + e.getMessage();
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticketing System - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
      <link rel="stylesheet" href="./src/styles/login.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .login-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .login-header {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        .login-form {
            padding: 2rem;
        }
        .form-control {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }
        .btn-login {
            background: linear-gradient(135deg, #007bff, #0056b3);
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 123, 255, 0.4);
        }
        .input-group-text {
            background: #f8f9fa;
            border: 2px solid #e9ecef;
            border-right: none;
            border-radius: 10px 0 0 10px;
        }
        .input-group .form-control {
            border-left: none;
            border-radius: 0 10px 10px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="login-container">
                    <div class="login-header">
                        <i class="fas fa-ticket-alt fa-3x mb-3"></i>
                        <h2>Ticketing System</h2>
                        <p class="mb-0">Please login with your credentials</p>
                    </div>
                    
                    <div class="login-form">
                        <% if (errorMessage != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                <%= errorMessage %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        <% } %>
                        
<form method="post" action="">
    <div class="mb-4">
        <label for="empId" class="form-label fw-bold">Employee ID</label>
        <div class="input-group">
            <span class="input-group-text">
                <i class="fas fa-user"></i>
            </span>
            <input type="text" class="form-control" id="empId" name="empId" 
                   placeholder="Enter your Employee ID" required>
        </div>
    </div>
    
    <div class="mb-4">
        <label for="password" class="form-label fw-bold">Password</label>
        <div class="input-group">
            <span class="input-group-text">
                <i class="fas fa-lock"></i>
            </span>
            <input type="password" class="form-control" id="password" name="password" 
                   placeholder="Enter your password" required>
        </div>
    </div>
    
    <div class="d-grid">
        <button type="submit" class="btn btn-primary btn-login">
            <i class="fas fa-sign-in-alt me-2"></i>Login
        </button>
    </div>
</form>

                        
                        <div class="text-center mt-4">
                            <small class="text-muted">
                                <i class="fas fa-info-circle me-1"></i>
                                Contact IT support if you forgot your credentials
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
