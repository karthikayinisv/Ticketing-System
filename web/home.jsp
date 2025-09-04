<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>--%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    
    
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Salesdata Mapping Dashboard</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
     <!-- Shared Styles for layout -->
    <style>
        /* Header & Sidebar setup */
        :root { --sidebar-width: 280px; --header-height: 70px; }
        * {margin:0; padding:0; box-sizing:border-box;}
        body {font-family:Arial,sans-serif; background:#f9f9f9; min-height:100vh;}
        .header {
            position:fixed; top:0; left:0; right:0; height:var(--header-height);
            background: linear-gradient(135deg,#2c3e50,#3498db); color:#fff;
            display:flex; align-items:center; justify-content:space-between;
            padding:0 20px; z-index:1000;
        }
        .logo i { color:#3498db; margin-right:10px; }
        .user-info { display:flex; align-items:center; gap:15px; }
        .user-avatar {
            width:40px; height:40px; border-radius:50%;
            background:#3498db; display:flex; align-items:center;
            justify-content:center; font-weight:bold;
        }
        .logout-btn {
            background:rgba(255,255,255,0.2); border:none;
            color:white; padding:8px 16px; border-radius:20px;
            cursor:pointer;
        }
        .logout-btn:hover { background:rgba(255,255,255,0.3); }
.sidebar {
    position: fixed;
    top: var(--header-height);
    left: 0;
    height: calc(100vh - var(--header-height));
    background: #2c3e50;
    overflow-y: auto;
    z-index: 999;
    width: var(--sidebar-width);
    transition: transform 0.3s ease-in-out;
}

        .sidebar-menu { list-style:none; }
        .sidebar-menu a {
            display:flex; align-items:center; padding:15px 20px;
            color:#bdc3c7; text-decoration:none;
        }
        .sidebar-menu a.active, .sidebar-menu a:hover {
            background:#3498db; color:#fff;
        }
        .sidebar-menu i { width:20px; margin-right:15px; }
        /* Toggle Button */
.toggle-btn {
    position: fixed;
    top: 15px;
    left: 15px;
    background: #3498db;
    border: none;
    color: white;
    font-size: 20px;
    padding: 10px;
    border-radius: 5px;
    z-index: 1000;
    cursor: pointer;
}

/* Sidebar hidden class */
.sidebar.collapsed {
    transform: translateX(-100%);
    transition: transform 0.3s ease-in-out;
}


        .main-content {
            margin-top:var(--header-height);
            margin-left:var(--sidebar-width);
            padding:20px;
            transition:margin-left 0.3s ease;
        }
        .main-content.expanded { margin-left:0; }

        /* DataTable styling overrides */
        h2 { text-align:center; color:#333; margin-bottom:20px; }
        table.dataTable thead th { background:#007BFF; color:#fff; text-align:center; }
        .dataTables_wrapper .dataTables_filter input { margin-left:0.5em; }
        .dataTables_wrapper .dataTables_paginate .paginate_button {
            padding:0.2em 0.8em; margin:2px;
        }
        .dataTables_wrapper .dataTables_length select { padding:2px; }
        table.dataTable tbody tr:hover { background:#f1f1f1; }
        table.dataTable tbody td, .dataTables_wrapper, table.dataTable {
            text-align:center; width:100% !important;
        }
    </style>
</head>

<%
// Check if user is logged in
Boolean isLoggedIn = (Boolean) session.getAttribute("loggedIn");
String userEmail = (String) session.getAttribute("userEmail");
if (isLoggedIn == null || !isLoggedIn) {
    response.sendRedirect("login.jsp");
    return;
}

// Get user's first name for display
String firstName = userEmail != null ? userEmail.split("@")[0] : "User";
String userInitial = firstName.length() > 0 ? firstName.substring(0, 1).toUpperCase() : "U";
%>

<body>
    <!-- Header -->
    <header class="header">
        <div class="logo">
            <i class="fas fa-chart-line"></i>
            Salesdata Mapping Dashboard
        </div>
       <div class="user-info">
    <div class="user-avatar"><%= userInitial %></div>
    <span>Welcome, <%= firstName %></span>
    <button class="logout-btn" onclick="logout()">
        <i class="fas fa-sign-out-alt"></i> Logout
    </button>
</div>
    </header>

<!--
<button id="toggleSidebar" class="toggle-btn">
    <i class="fas fa-bars"></i>
</button>-->
    <!-- Sidebar -->
    <nav class="sidebar" id="sidebar">
        <ul class="sidebar-menu">
          
            <li>
                <a href="index.jsp" onclick="showPage('customer')">
                    <i class="fas fa-hospital-user"></i>
                    <span>Sales Data Mapping </span>
                </a>
            </li>
            <li>
                <a href="Billcount.jsp" onclick="showPage('raymedibillcount')">
                    <i class="fas fa-file-invoice-dollar"></i>
                    <span>DMS</span>
                </a>
            </li>
            <li>
                <a href="#" onclick="showPage('erptoraymedibillcount')">
                    <i class="fas fa-exchange-alt"></i>
                    <span>ERP to Raymedi Bill Count</span>
                </a>
            </li>
          
        </ul>
    </nav>


<script>
    function logout() {
        // Redirect to logout.jsp
        window.location.href = 'logout.jsp';
    }
</script>



<!--    <script>
    document.getElementById("toggleSidebar").addEventListener("click", function () {
        const sidebar = document.getElementById("sidebar");
        sidebar.classList.toggle("collapsed");
    });
</script>-->
