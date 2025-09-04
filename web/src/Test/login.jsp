<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TicketFlow - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4f46e5;
            --primary-dark: #3730a3;
            --secondary-color: #f8fafc;
            --accent-color: #06b6d4;
            --text-dark: #1e293b;
            --text-light: #64748b;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .login-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            max-width: 450px;
            width: 100%;
            overflow: hidden;
        }
        
        .login-header {
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: white;
            padding: 2rem;
            text-align: center;
        }
        
        .login-header h1 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        
        .login-header p {
            opacity: 0.9;
            margin: 0;
        }
        
        .login-body {
            padding: 2rem;
        }
        
        .form-floating {
            margin-bottom: 1rem;
        }
        
        .form-control {
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(79, 70, 229, 0.25);
        }
        
        .btn-login {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            border: none;
            border-radius: 12px;
            padding: 0.75rem;
            font-size: 1rem;
            font-weight: 600;
            color: white;
            width: 100%;
            transition: all 0.3s ease;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(79, 70, 229, 0.3);
        }
        
        .login-type-tabs {
            background: #f8fafc;
            border-radius: 12px;
            padding: 0.25rem;
            margin-bottom: 1.5rem;
        }
        
        .login-type-tabs .nav-link {
            border-radius: 8px;
            color: var(--text-light);
            font-weight: 500;
            text-align: center;
            border: none;
            transition: all 0.3s ease;
        }
        
        .login-type-tabs .nav-link.active {
            background: var(--primary-color);
            color: white;
        }
        
        .alert {
            border-radius: 12px;
            border: none;
            margin-bottom: 1rem;
        }
        
        .forgot-password {
            text-align: center;
            margin-top: 1rem;
        }
        
        .forgot-password a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }
        
        .forgot-password a:hover {
            text-decoration: underline;
        }
        
        .icon-input {
            position: relative;
        }
        
        .icon-input i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-light);
            z-index: 5;
        }
        
        .icon-input .form-control {
            padding-left: 3rem;
        }
        
        @media (max-width: 576px) {
            .login-card {
                margin: 1rem;
            }
            
            .login-header {
                padding: 1.5rem;
            }
            
            .login-body {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <i class="fas fa-ticket-alt fa-3x mb-3"></i>
                <h1>TicketFlow</h1>
                <p>Streamlined Ticket Management System</p>
            </div>
            
            <div class="login-body">
                <!-- Login Type Selection -->
                <ul class="nav nav-pills login-type-tabs" id="loginTypeTabs" role="tablist">
                    <li class="nav-item" role="presentation" style="flex: 1;">
                        <button class="nav-link active w-100" id="user-tab" data-bs-toggle="pill" 
                                data-bs-target="#user-login" type="button" role="tab">
                            <i class="fas fa-user me-2"></i>User Login
                        </button>
                    </li>
                    <li class="nav-item" role="presentation" style="flex: 1;">
                        <button class="nav-link w-100" id="admin-tab" data-bs-toggle="pill" 
                                data-bs-target="#admin-login" type="button" role="tab">
                            <i class="fas fa-shield-alt me-2"></i>Admin Login
                        </button>
                    </li>
                </ul>
                
                <!-- Error/Success Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                    </div>
                </c:if>
                
                <c:if test="${not empty success}">
                    <div class="alert alert-success" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${success}
                    </div>
                </c:if>
                
                <!-- Login Forms -->
                <div class="tab-content" id="loginTabContent">
                    <!-- User Login Form -->
                    <div class="tab-pane fade show active" id="user-login" role="tabpanel">
                        <form action="UserAuthController" method="post" id="userLoginForm">
                            <input type="hidden" name="action" value="login">
                            
                            <div class="form-floating mb-3">
                                <select class="form-select" id="division" name="division" required>
                                    <option value="">Select Division</option>
                                    <option value="1">Finance</option>
                                    <option value="2">IT</option>
                                    <option value="3">HR</option>
                                    <option value="4">Operations</option>
                                    <option value="5">Marketing</option>
                                </select>
                                <label for="division">
                                    <i class="fas fa-building me-2"></i>Division
                                </label>
                            </div>
                            
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="username" name="username" 
                                       placeholder="Username" required>
                                <label for="username">
                                    <i class="fas fa-user me-2"></i>Username
                                </label>
                            </div>
                            
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="employeeNumber" name="employeeNumber" 
                                       placeholder="Employee Number" required>
                                <label for="employeeNumber">
                                    <i class="fas fa-id-badge me-2"></i>Employee Number
                                </label>
                            </div>
                            
                            <div class="form-floating mb-3">
                                <input type="password" class="form-control" id="password" name="password" 
                                       placeholder="Password" required>
                                <label for="password">
                                    <i class="fas fa-lock me-2"></i>Password
                                </label>
                            </div>
                            
                            <button type="submit" class="btn btn-login">
                                <i class="fas fa-sign-in-alt me-2"></i>Sign In as User
                            </button>
                        </form>
                    </div>
                    
                    <!-- Admin Login Form -->
                    <div class="tab-pane fade" id="admin-login" role="tabpanel">
                        <form action="AdminAuthController" method="post" id="adminLoginForm">
                            <input type="hidden" name="action" value="login">
                            
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="adminUsername" name="username" 
                                       placeholder="Admin Username" required>
                                <label for="adminUsername">
                                    <i class="fas fa-user-shield me-2"></i>Admin Username
                                </label>
                            </div>
                            
                            <div class="form-floating mb-4">
                                <input type="password" class="form-control" id="adminPassword" name="password" 
                                       placeholder="Admin Password" required>
                                <label for="adminPassword">
                                    <i class="fas fa-key me-2"></i>Admin Password
                                </label>
                            </div>
                            
                            <button type="submit" class="btn btn-login">
                                <i class="fas fa-shield-alt me-2"></i>Sign In as Admin
                            </button>
                        </form>
                    </div>
                </div>
                
                <div class="forgot-password">
                    <a href="#" data-bs-toggle="modal" data-bs-target="#forgotPasswordModal">
                        <i class="fas fa-question-circle me-1"></i>Forgot Password?
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Forgot Password Modal -->
    <div class="modal fade" id="forgotPasswordModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-key me-2"></i>Reset Password
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="forgotPasswordForm">
                        <div class="mb-3">
                            <label for="resetEmail" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="resetEmail" 
                                   placeholder="Enter your email address" required>
                        </div>
                        <div class="mb-3">
                            <label for="resetEmployeeNumber" class="form-label">Employee Number</label>
                            <input type="text" class="form-control" id="resetEmployeeNumber" 
                                   placeholder="Enter your employee number" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary">
                        <i class="fas fa-paper-plane me-2"></i>Send Reset Link
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation and enhancement
        document.addEventListener('DOMContentLoaded', function() {
            // Add loading state to login buttons
            const loginForms = document.querySelectorAll('form');
            loginForms.forEach(form => {
                form.addEventListener('submit', function() {
                    const submitBtn = form.querySelector('button[type="submit"]');
                    const originalText = submitBtn.innerHTML;
                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Signing In...';
                    submitBtn.disabled = true;
                    
                    // Re-enable button after 3 seconds (in case of error)
                    setTimeout(() => {
                        submitBtn.innerHTML = originalText;
                        submitBtn.disabled = false;
                    }, 3000);
                });
            });
            
            // Auto-hide alerts after 5 seconds
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                setTimeout(() => {
                    alert.style.opacity = '0';
                    setTimeout(() => alert.remove(), 300);
                }, 5000);
            });
            
            // Forgot password form handling
            document.querySelector('#forgotPasswordModal .btn-primary').addEventListener('click', function() {
                const email = document.getElementById('resetEmail').value;
                const empNumber = document.getElementById('resetEmployeeNumber').value;
                
                if (email && empNumber) {
                    // Here you would typically make an AJAX call to send reset email
                    alert('Password reset link has been sent to your email address.');
                    bootstrap.Modal.getInstance(document.getElementById('forgotPasswordModal')).hide();
                } else {
                    alert('Please fill in all fields.');
                }
            });
        });
    </script>
</body>
</html>