<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="org.apache.http.*" %>
<%@ page import="org.apache.http.client.methods.*" %>
<%@ page import="org.apache.http.impl.client.*" %>
<%@ page import="org.apache.http.message.*" %>
<%@ page import="org.apache.http.client.entity.*" %>
<%@ page import="org.apache.http.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration System</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>    
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
<!--    <link rel="stylesheet" type="text/css" href="src/styles/style.css" />  -->

</head>
<style>
          /* Reset and base styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #f8f9fa, #e3f2fd);
            min-height: 100vh;
        }
        
        /* Header & Sidebar setup */
        :root { 
            --sidebar-width: 280px; 
            --header-height: 70px; 
        }
        
        /* Header */
        .header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: var(--header-height);
            background: linear-gradient(135deg, #2c3e50, #3498db);
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 20px;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .logo {
            display: flex;
            align-items: center;
            font-size: 20px;
            font-weight: bold;
        }
        
        .logo i {
            color: #3498db;
            margin-right: 10px;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #3498db;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
        
        .logout-btn {
            background: rgba(255,255,255,0.2);
            border: none;
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .logout-btn:hover {
            background: rgba(255,255,255,0.3);
        }
        
        /* Sidebar */
        .sidebar {
            position: fixed;
            top: var(--header-height);
            left: 0;
            height: calc(100vh - var(--header-height));
            width: var(--sidebar-width);
            background: #2c3e50;
            overflow-y: auto;
            z-index: 999;
            transition: transform 0.3s ease-in-out;
        }
        
        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            color: #bdc3c7;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .sidebar-menu a.active,
        .sidebar-menu a:hover {
            background: #3498db;
            color: #fff;
        }
        
        .sidebar-menu i {
            width: 20px;
            margin-right: 15px;
        }
        
        /* Main content area */
        .main-content {
            margin-top: var(--header-height);
            margin-left: var(--sidebar-width);
            padding: 20px;
            transition: margin-left 0.3s ease;
            min-height: calc(100vh - var(--header-height));
        }
        
        /* Container */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }
        
        /* Page header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 4px solid #3498db;
        }
        
        .page-title {
            font-size: 25px;
            margin: 0;
            color: #2c3e50;
        }
        
        .button-class {
            padding: 8px 16px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.3s ease-in-out;
            text-decoration: none;
            display: inline-block;
        }
        
        .button-class:hover {
            background: #2980b9;
            color: white;
            text-decoration: none;
        }
        
        /* Form Section */
        .form-section {
            background: #f1f8ff;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 30px;
            border-left: 6px solid #3498db;
            box-shadow: 0px 3px 10px rgba(0, 0, 0, 0.05);
        }
        
        .form-section h3 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        
        /* Form Layout */
        .form-row {
            display: flex;
            flex-wrap: wrap;
            margin: 0 -10px;
        }
        
        .form-group {
            flex: 1 0 calc(33.333% - 20px);
            margin: 0 10px 15px;
            min-width: 250px;
        }
        
        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #34495e;
            font-size: 14px;
        }
        
        /* Input, Select & Textarea */
        input, select, textarea {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: all 0.3s;
            background: #f9f9f9;
        }
        
        input:focus, select:focus, textarea:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
            background: #fff;
        }
        
        input[readonly] {
            background: #e9ecef;
            cursor: not-allowed;
        }
        
        /* Button Styling */
        .btn-section {
            text-align: center;
            margin-top: 20px;
        }
        
        button {
            padding: 12px 24px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: all 0.3s ease-in-out;
            box-shadow: 0px 3px 10px rgba(0, 0, 0, 0.1);
            margin: 0 5px;
        }
        
        button:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }
        
        button i {
            margin-right: 8px;
        }
        
        button:disabled {
            background: #b0c4de;
            cursor: not-allowed;
        }
        
        /* Preview Section */
        .preview-section {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 25px;
            margin-top: 20px;
            border-left: 6px solid #28a745;
        }
        
        .preview-section h3 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        
        /* Table Styling */
        .table-responsive {
            overflow-x: auto;
            margin-top: 15px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        th, td {
            border: 1px solid #e6e6e6;
            padding: 12px;
            text-align: left;
            font-size: 14px;
        }
        
        th {
            background: #3498db;
            color: white;
            font-weight: bold;
            text-transform: uppercase;
        }
        
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        tr:hover {
            background-color: #f1f1f1;
            transition: background 0.3s;
        }
        
        /* Input groups */
        .input-group {
            display: flex;
        }
        
        .input-group input {
            border-radius: 5px 0 0 5px;
        }
        
        .input-group-btn {
            display: flex;
        }
        
        .input-group-btn .btn {
            border-radius: 0 5px 5px 0;
            border-left: none;
        }
        
        /* Alert styling */
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            border-left: 6px solid;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border-left-color: #28a745;
        }
        
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border-left-color: #dc3545;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .form-group {
                flex: 1 0 calc(50% - 20px);
            }
            
            .page-header {
                flex-direction: column;
                gap: 15px;
            }
        }
        
        @media (max-width: 576px) {
            .form-group {
                flex: 1 0 100%;
                margin: 0 0 15px;
            }
            
            .container {
                padding: 20px;
            }
        }
</style>

<%
// Check if user is logged in
Boolean isLoggedIn = (Boolean) session.getAttribute("loggedIn");
String userEmail = (String) session.getAttribute("userEmail");
if (isLoggedIn == null || !isLoggedIn) {
    response.sendRedirect("login.jsp?");
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

    <!-- Sidebar -->
    <nav class="sidebar" id="sidebar">
        <ul class="sidebar-menu">
            <li>
                <a href="index.jsp" class="active">
                    <i class="fas fa-hospital-user"></i>
                    <span>Sales Data Mapping</span>
                </a>
            </li>
            <li>
                <a href="dms.jsp">
                    <i class="fas fa-file-invoice-dollar"></i>
                    <span>DMS</span>
                </a>
            </li>
            <li>
                <a href="salesmetrics.jsp">
                    <i class="fas fa-exchange-alt"></i>
                    <span>Sales Gap Analyzer </span>
                </a>
            </li>
              <li>
                <a href="Dms_Compliance.jsp" target="_blank">
                    <i class="fas fa-exchange-alt"></i>
                    <span>DMS Compliance </span>
                </a>
            </li>
        </ul>
    </nav>

    <!-- Main Content -->
    <div class="main-content">
       <div class="container">
    <div class="page-header">
        <h1 class="page-title"><i class="fas fa-hospital-user"></i> Customer Registration System</h1>
        <button onclick="window.location.href='getAllCustomers.jsp'" class="button-class">Customer List</button>
    </div>
    <div id="messageContainer"></div>
    
    <!-- Form Section -->
    <div class="form-section">
        <h3 style="font-size: 20px"><i class="fas fa-user-plus"></i> Add New Customer</h3>
        <form id="customerForm">
            <div class="form-row">
<div class="form-group">
    <label for="erpCode">ERP Code (Unique)</label>
    <div class="input-group">
        <input type="text" id="erpCode" name="erpCode" placeholder="Enter ERP code" required>
        <span class="input-group-btn">
            <button class="btn btn-info" type="button" onclick="fetchBillingNameByERPCode()">
                <i class="fas fa-search"></i> Search
            </button>
        </span>
    </div>
</div>
<div class="form-group">
    <label for="erpBillingName">ERP Billing Name</label>
    <div class="input-group">
        <input type="text" id="erpBillingName" name="erpBillingName" placeholder="Billing name will appear here" required>
         <span class="input-group-btn">
                            <button class="btn btn-info" type="button" onclick="checkERPCode()">
                                <i class="fas fa-check"></i> Check
                            </button>
                        </span>

    </div>
         
</div>


                   <div class="form-group">
                    <label for="globalcode">Global Code</label>
                    <div class="input-group">
                        <input type="text" id="globalcode" name="globalcode" placeholder="Enter global code" required>
                        <span class="input-group-btn">
                            <button class="btn btn-primary" type="button" onclick="fetchSalesforceData()">
                                <i class="fas fa-search"></i> Fetch
                            </button>
                        </span>
                    </div>
                </div>
              
            </div>
            <div class="form-row">
                  <div class="form-group">
                    <label for="hospitalName">Account Name</label>
                    <input type="text" id="hospitalName" name="hospitalName" placeholder="Enter hospital name" readonly>
                </div>
            
  <div class="form-group">
                    <label for="city">City</label>
                    <input type="text" id="city" name="city" placeholder="Enter city" required readonly>
                </div>
                 <div class="form-group">
                    <label for="state">State</label>
                    <input type="text" id="state" name="state" placeholder="Enter state" required readonly>
                </div>
              
                <div style="display: none" class="form-group">
                    <label for="ffcode">FF Code</label>
                    <input type="text" id="ffcode" name="ffcode" placeholder="Enter FF code" required readonly>
                </div>
                
            </div>
            <div class="form-row">
                <div  style="display: none" class="form-group">
                    <label for="matrixcode">Matrix Code</label>
                    <input type="text" id="matrixcode" name="matrixcode" placeholder="Enter matrix code" required>
                </div>
                <div  style="display: none" class="form-group">
                    <label for="customerCategory">Customer Category</label>
                    <input type="text" id="customerCategory" name="customerCategory" placeholder="Enter customer category" required>
                </div>
               
            </div>
            <div  class="form-row">
                <div   style="display: none"class="form-group">
                    <label for="rglobalcode">R Global Code</label>
                    <input type="text" id="rglobalcode" name="rglobalcode" placeholder="Enter R global code" readonly>
                </div>
                <div class="form-group">
                    <label for="sf_id">SF ID</label>
                    <input type="text" id="sf_id" name="sf_id" placeholder="Enter SF ID" readonly>
                </div>
                <div style="display: none" class="form-group">
                    <label for="sf_Account_status">SF Account Status</label>
                    <input type="text" id="sf_Account_status" name="sf_Account_status" value="SFA" readonly>
                </div>
            </div>
         <div class="btn-section">
    <button type="button" onclick="previewData()">
        <i class="fas fa-eye"></i> Preview
    </button>
 <button type="button" onclick="resetFormOnly()">
    <i class="fas fa-undo"></i> Reset
</button>

</div>

        </form>
    </div>
    <!-- Preview Table (Moved inside form-section) -->
<div class="preview-section" style="display:none;">
    <h3><i class="fas fa-list"></i> Customer Preview</h3>
    <div class="table-responsive">
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>City</th>
                    <th>Global Code</th>
                    <th>Hospital Name</th>
                    <th>ERP Code</th>
                    <th>ERP Billing Name</th>
                    <th>FF Code</th>
                    <th>State</th>
                    <th>R Global Code</th>
                    <th>SF ID</th>
                    <th>SF Account Status</th>
                </tr>
            </thead>
            <tbody id="previewTableBody">
               
            </tbody>
              
        </table>
    </div>
    <button type="button" class="btn btn-success" onclick="saveCustomer()">Confirm & Save</button>
</div>

    <!-- Loading spinner overlay -->
    <div id="loadingOverlay" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:1000;">
        <div style="position:absolute; top:50%; left:50%; transform:translate(-50%,-50%);">
            <div class="spinner-border text-light" role="status" style="width:3rem; height:3rem;">
                <span class="sr-only">Loading...</span>
            </div>
            <div class="text-light mt-2">Processing request...</div>
        </div>
    </div>
</div>
    </div>

    <!-- Loading spinner overlay -->
    <div id="loadingOverlay" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:1000;">
        <div style="position:absolute; top:50%; left:50%; transform:translate(-50%,-50%); text-align:center;">
            <div class="spinner-border text-light" role="status" style="width:3rem; height:3rem;">
                <span class="sr-only">Loading...</span>
            </div>
            <div class="text-light mt-2">Processing request...</div>
        </div>
    </div>

<script>
function logout() {
    window.location.href = 'logout.jsp';
}

let previewList = [];
let editIndex = -1;

const previewFields = [
    "city", "globalcode", "hospitalName", "erpCode", "erpBillingName",
    "ffcode", "state", "rglobalcode", "sf_id", "sf_Account_status"
];

function previewData() {
    let customer = {};
    previewFields.forEach(field => {
        customer[field] = $("#" + field).val();
    });

    if (editIndex === -1) {
        previewList.push(customer);
    } else {
        previewList[editIndex] = customer;
        editIndex = -1;
    }
    renderPreviewTable();
    $(".preview-section").show();
    $("#customerForm")[0].reset();
    $("#sf_Account_status").val("SFA");
}



// 3. Render the preview table with all previewed customers
function renderPreviewTable() {
    let tbody = $("#previewTableBody");
    tbody.empty();

    previewList.forEach(customer => {
        let row = "<tr>";
        previewFields.forEach(field => {
            row += "<td>" + (customer[field] || "") + "</td>";
        });
        row += "</tr>";
        tbody.append(row);
    });
}


function resetFormOnly() {
    $("#customerForm")[0].reset();
    $("#sf_Account_status").val("SFA");
}


function fetchSalesforceData() {
    const globalCode = $("#globalcode").val().trim();
    
    if (!globalCode) {
        Swal.fire({
            icon: 'warning',
            title: 'Input Required',
            text: 'Please enter a Global Code to search',
            confirmButtonColor: '#f39c12'
        });
        return;
    }
    
    $("#loadingOverlay").show();
    $("#loadingOverlay div div.text-light").text("Fetching data from Salesforce...");
    
    $.ajax({
        url: "getajaxcall/getSalesforceAccount.jsp",
        type: "GET",
        data: { globalcode: globalCode },
        dataType: "json", 
        success: function(data) {
           
            if (data.success) {
              
                const account = data.account;
                
                $("#ffcode").val(account.ffcode);
                $("#hospitalName").val(account.name);
                $("#state").val(account.state);
                $("#city").val(account.city);
                $("#sf_id").val(account.id);

                if (!$("#erpBillingName").val()) {
                    $("#erpBillingName").val(account.name);
                }
                
                $("#rglobalcode").val(account.name);
                
                // Show success message
                Swal.fire({
                    icon: 'success',
                    title: 'Data Retrieved',
                    text: 'Successfully fetched data from Salesforce. You can modify the ERP Billing Name if needed.',
                    confirmButtonColor: '#28a745'
                });
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'Not Found',
                    text: data.message || 'No account found with that Global Code',
                    confirmButtonColor: '#d33'
                });
            }
            $("#loadingOverlay").hide();
        },
        error: function(xhr, status, error) {
            $("#loadingOverlay").hide();
            console.error("Ajax error:", xhr.responseText);
            Swal.fire({
                icon: 'error',
                title: 'Salesforce Error',
                text: 'Failed to connect to Salesforce: ' + error,
                confirmButtonColor: '#d33'
            });
        }
    });
}
// Save customer data via AJAX

function saveCustomer() {
    if (previewList.length === 0) {
        Swal.fire({
            icon: 'warning',
            title: 'No Data',
            text: 'Please preview at least one customer before saving.',
            confirmButtonColor: '#f39c12'
        });
        return;
    }
    
    $.ajax({
        url: "getajaxcall/insertCustomer.jsp",
        type: "POST",
        data: { customers: JSON.stringify(previewList) },
        success: function(response) {
            console.log("Server response:", response); // Debug log
            
            // Check if response contains both success and warning messages
            if (response.includes("Success:") && response.includes("Warning:")) {
                // Partial success - some inserted, some skipped
                Swal.fire({
                    icon: 'warning',
                    title: 'Partial Success',
                    html: response.replace(/\n/g, '<br>'),
                    confirmButtonColor: '#f39c12',
                    confirmButtonText: 'OK'
                }).then(() => {
                    // Reset form and preview after user acknowledges
                    resetAfterSave();
                });
            } 
            else if (response.includes("Success:")) {
                // Full success
                Swal.fire({
                    icon: 'success',
                    title: 'Customers Saved!',
                    text: response,
                    showConfirmButton: false,
                    timer: 3000
                });
                resetAfterSave();
            }
            else if (response.includes("Warning:") || response.includes("Error:")) {
                // All failed or error occurred
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    html: response.replace(/\n/g, '<br>'),
                    confirmButtonColor: '#d33'
                });
                // Don't reset form in case of complete failure - user might want to fix issues
            }
            else {
                // Unknown response format
                Swal.fire({
                    icon: 'info',
                    title: 'Response',
                    text: response,
                    confirmButtonColor: '#17a2b8'
                });
            }
        },
        error: function(xhr, status, error) {
            console.error("Ajax error:", xhr.responseText);
            Swal.fire({
                icon: 'error',
                title: 'Error Saving Customers',
                text: 'Failed to save customers: ' + error,
                confirmButtonColor: '#d33'
            });
        }
    });
}



function resetAfterSave() {
    $("#customerForm")[0].reset();
    $("#sf_Account_status").val("SFA");
    previewList = [];
    renderPreviewTable();
    $(".preview-section").hide();
}

// Helper function to reset form and preview after successful save
function resetAfterSave() {
    $("#customerForm")[0].reset();
    $("#sf_Account_status").val("SFA");
    previewList = [];
    renderPreviewTable();
    $(".preview-section").hide();
}

// When Hospital Name changes, update ERP Billing Name to match
$(document).on('input', '#hospitalName', function() {
    $("#erpBillingName").val($(this).val());
});

// Hide preview section initially
$(document).ready(function() {
    $(".preview-section").hide();
    
    // Set default value for SF Account Status
    $("#sf_Account_status").val("SFA");
    
    // Add event listener for Global Code field - autofetch when user tabs out
    $("#globalcode").on("blur", function() {
        if ($(this).val().trim() !== "") {
            fetchSalesforceData();
        }
    });
    
    // Add event listener for ERP Code field - check when user tabs out
$("#erpCode").on("blur", function() {
    if ($(this).val().trim() !== "") {
        fetchBillingNameByERPCode();
    }
});
});



// Function to extract code from search results and populate the ERP code field
function populateERPCodeFromSearchResults(searchResult) {

    
    if (searchResult && searchResult.includes("Code:")) {
        // Extract the code part
        const codeMatch = searchResult.match(/Code:\s*([^,]+)/);
        
        if (codeMatch && codeMatch[1]) {
            const erpCode = codeMatch[1].trim();
            
            // Set the value in the ERP code input field
            $("#erpCode").val(erpCode);
            
            // Optionally, trigger the checkERPCode function to validate and show details
            checkERPCode();
            
            return true;
        }
    }
    
    return false;
}

// Modify the searchByERPBillingName function to use the extracted code
function fetchBillingNameByERPCode() {
    const erpCode = $("#erpCode").val().trim();
    
    if (!erpCode) {
        Swal.fire({
            icon: 'warning',
            title: 'Input Required',
            text: 'Please enter an ERP Code to search',
            confirmButtonColor: '#f39c12'
        });
        return;
    }
    
    $("#loadingOverlay").show();
    $("#loadingOverlay div div.text-light").text("Fetching billing name for ERP Code...");
    
    $.ajax({
        url: "getajaxcall/GetErpcode.jsp",
        type: "GET",
        data: { erpCode: erpCode },
        dataType: "text",
        success: function(data) {
            $("#loadingOverlay").hide();
            
            console.log("Response from server:", data); // Debug log
            
            if (data.startsWith("EXISTS:")) {
                // Parse the response: EXISTS:code:billingName
                const parts = data.split(":");
                if (parts.length >= 3) {
                    const billingName = parts.slice(2).join(":"); // Join in case billing name contains ":"
                    
                    // Populate the billing name field
                    $("#erpBillingName").val(billingName);
                    
                    // Show success message without showing the billing name again
                    Swal.fire({
                        icon: 'success',
                        title: 'ERP Code Found',
                        text: 'Billing name has been populated successfully.',
                        confirmButtonColor: '#28a745',
                        timer: 2000,
                        showConfirmButton: false
                    });
                } else {
                    // If parsing fails, still try to extract billing name
                    const billingName = data.replace("EXISTS:", "").split(":").slice(1).join(":");
                    $("#erpBillingName").val(billingName);
                }
            } else if (data === "NEW") {
                // Clear billing name field
                $("#erpBillingName").val("");
                
                Swal.fire({
                    icon: 'info',
                    title: 'New ERP Code',
                    text: 'This ERP Code is not found in the database. You can proceed with a new entry.',
                    confirmButtonColor: '#17a2b8'
                });
            } else if (data.startsWith("ERROR:")) {
                $("#erpBillingName").val(""); // Clear field on error
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: data,
                    confirmButtonColor: '#d33'
                });
            } else {
                // For any other response, try to populate the field and show debug info
                $("#erpBillingName").val(data);
                console.log("Unexpected response format:", data);
            }
        },
        error: function(xhr, status, error) {
            $("#loadingOverlay").hide();
            console.error("Ajax error:", xhr.responseText);
            
            Swal.fire({
                icon: 'error',
                title: 'Error Fetching Billing Name',
                text: 'Failed to fetch billing name: ' + error,
                confirmButtonColor: '#d33'
            });
        }
    });
}


function checkERPCode() {
    const erpCode = $("#erpCode").val().trim();
    
    if (!erpCode) {
        Swal.fire({
            icon: 'warning',
            title: 'Input Required',
            text: 'Please enter an ERP Code to check',
            confirmButtonColor: '#f39c12'
        });
        return;
    }
    
    $("#loadingOverlay").show();
    $("#loadingOverlay div div.text-light").text("Checking ERP Code availability...");
    
    $.ajax({
        url: "getajaxcall/checkERPCodeExists.jsp",
        type: "GET",
        data: { erpCode: erpCode },
        dataType: "text",
        success: function(data) {
            $("#loadingOverlay").hide();
            
            if (data.trim() === "EXISTS") {
                Swal.fire({
                    icon: 'error',
                    title: 'ERP Code Already Exists',
                    text: 'This ERP Code is already registered in the system. Please use a different ERP Code.',
                    confirmButtonColor: '#d33'
                });
            } else if (data.trim() === "AVAILABLE") {
                Swal.fire({
                    icon: 'success',
                    title: 'ERP Code Available',
                    text: 'This ERP Code is available for registration.',
                    confirmButtonColor: '#28a745',
                    timer: 2000,
                    showConfirmButton: false
                });
            } else {
                Swal.fire({
                    icon: 'info',
                    title: 'Check Result',
                    text: data,
                    confirmButtonColor: '#17a2b8'
                });
            }
        },
        error: function(xhr, status, error) {
            $("#loadingOverlay").hide();
            console.error("Ajax error:", xhr.responseText);
            
            Swal.fire({
                icon: 'error',
                title: 'Connection Error',
                text: 'Failed to check ERP Code: ' + error,
                confirmButtonColor: '#d33'
            });
        }
    });
}
// Optional: Function to validate ERP code format (if needed)
function validateERPCode(code) {
    // Add your validation logic here
    // Example: return code.length > 0 && /^[A-Z0-9]+$/.test(code);
    return code.length > 0;
}
//
//// Form validation function
//function validateForm() {
//    const requiredFields = [
//        { id: 'erpCode', name: 'ERP Code' },
//        { id: 'erpBillingName', name: 'ERP Billing Name' },
//        { id: 'globalcode', name: 'Global Code' },
//        { id: 'hospitalName', name: 'Hospital Name' },
//        { id: 'city', name: 'City' },
//        { id: 'state', name: 'State' }
//    ];
//    
//    let isValid = true;
//    let errorMessages = [];
//    
//    requiredFields.forEach(field => {
//        const value = $("#" + field.id).val().trim();
//        if (!value) {
//            isValid = false;
//            errorMessages.push(field.name + " is required");
//            $("#" + field.id).addClass('is-invalid');
//        } else {
//            $("#" + field.id).removeClass('is-invalid');
//        }
//    });
//    
//    if (!isValid) {
//        Swal.fire({
//            icon: 'error',
//            title: 'Validation Error',
//            html: errorMessages.join('<br>'),
//            confirmButtonColor: '#d33'
//        });
//    }
//    
//    return isValid;
//}

//// Enhanced preview function with validation
//function previewData() {
//    if (!validateForm()) {
//        return;
//    }
//    
//    let customer = {};
//    previewFields.forEach(field => {
//        customer[field] = $("#" + field).val().trim();
//    });
//    
//    // Check for duplicate ERP codes in preview list
//    const existingERPCodes = previewList.map(c => c.erpCode);
//    if (editIndex === -1 && existingERPCodes.includes(customer.erpCode)) {
//        Swal.fire({
//            icon: 'error',
//            title: 'Duplicate ERP Code',
//            text: 'This ERP Code is already in the preview list.',
//            confirmButtonColor: '#d33'
//        });
//        return;
//    }
//    
//    if (editIndex === -1) {
//        previewList.push(customer);
//    } else {
//        previewList[editIndex] = customer;
//        editIndex = -1;
//    }
//    
//    renderPreviewTable();
//    $(".preview-section").show();
//    $("#customerForm")[0].reset();
//    $("#sf_Account_status").val("SFA");
//    
//    Swal.fire({
//        icon: 'success',
//        title: 'Data Added to Preview',
//        text: 'Customer data has been added to the preview list.',
//        timer: 2000,
//        showConfirmButton: false
//    });
//}

//// Enhanced table rendering with action buttons
//function renderPreviewTable() {
//    let tbody = $("#previewTableBody");
//    tbody.empty();
//    
//    previewList.forEach((customer, index) => {
//        let row = "<tr>";
//        previewFields.forEach(field => {
//            row += "<td>" + (customer[field] || "") + "</td>";
//        });
//  
//        row += "</tr>";
//        tbody.append(row);
//    });
//    
//
//}

//// Edit customer function
//function editCustomer(index) {
//    const customer = previewList[index];
//    
//    previewFields.forEach(field => {
//        $("#" + field).val(customer[field] || "");
//    });
//    
//    editIndex = index;
//    
//    Swal.fire({
//        icon: 'info',
//        title: 'Edit Mode',
//        text: 'Customer data loaded for editing. Make your changes and click Preview to update.',
//        confirmButtonColor: '#17a2b8'
//    });
//}

//// Delete customer function
//function deleteCustomer(index) {
//    Swal.fire({
//        title: 'Are you sure?',
//        text: 'Do you want to remove this customer from the preview list?',
//        icon: 'warning',
//        showCancelButton: true,
//        confirmButtonColor: '#d33',
//        cancelButtonColor: '#6c757d',
//        confirmButtonText: 'Yes, delete it!'
//    }).then((result) => {
//        if (result.isConfirmed) {
//            previewList.splice(index, 1);
//            renderPreviewTable();
//            
//            if (previewList.length === 0) {
//                $(".preview-section").hide();
//            }
//            
//            Swal.fire({
//                icon: 'success',
//                title: 'Deleted!',
//                text: 'Customer has been removed from the preview list.',
//                timer: 2000,
//                showConfirmButton: false
//            });
//        }
//    });
//}

//// Clear all preview data
//function clearPreviewData() {
//    Swal.fire({
//        title: 'Clear All Preview Data?',
//        text: 'This will remove all customers from the preview list.',
//        icon: 'warning',
//        showCancelButton: true,
//        confirmButtonColor: '#d33',
//        cancelButtonColor: '#6c757d',
//        confirmButtonText: 'Yes, clear all!'
//    }).then((result) => {
//        if (result.isConfirmed) {
//            previewList = [];
//            renderPreviewTable();
//            $(".preview-section").hide();
//            
//            Swal.fire({
//                icon: 'success',
//                title: 'Cleared!',
//                text: 'All preview data has been cleared.',
//                timer: 2000,
//                showConfirmButton: false
//            });
//        }
//    });
//}

// Auto-save functionality (optional)
//function autoSaveToLocalStorage() {
//    if (previewList.length > 0) {
//        localStorage.setItem('customerPreviewData', JSON.stringify(previewList));
//    }
//}

// Load from local storage on page load
//function loadFromLocalStorage() {
//    const savedData = localStorage.getItem('customerPreviewData');
//    if (savedData) {
//        try {
//            previewList = JSON.parse(savedData);
//            if (previewList.length > 0) {
//                renderPreviewTable();
//                $(".preview-section").show();
//            }
//        } catch (e) {
//            console.error("Error loading saved data:", e);
//        }
//    }
//}

//// Initialize page
//$(document).ready(function() {
//    // Set default SF Account Status
//    $("#sf_Account_status").val("SFA");
//    
//    // Load any saved preview data
//    loadFromLocalStorage();
//    
//    // Auto-save preview data when changed
//    setInterval(autoSaveToLocalStorage, 30000); // Save every 30 seconds
//    
//    // Add Enter key support for search functions
//    $("#erpCode").keypress(function(e) {
//        if (e.which == 13) {
//            fetchBillingNameByERPCode();
//        }
//    });
//    
//    $("#globalcode").keypress(function(e) {
//        if (e.which == 13) {
//            fetchSalesforceData();
//        }
//    });
//    
//    // Add input validation styling
//    $("input[required]").on('blur', function() {
//        if ($(this).val().trim() === '') {
//            $(this).addClass('is-invalid');
//        } else {
//            $(this).removeClass('is-invalid');
//        }
//    });
//    
//    // Add CSS for invalid inputs
//    $('<style>')
//        .prop('type', 'text/css')
//        .html('.is-invalid { border-color: #dc3545 !important; box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25) !important; }')
//        .appendTo('head');
//});

// Sidebar toggle for mobile
function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    const mainContent = document.querySelector('.main-content');
    
    if (sidebar.style.transform === 'translateX(0px)' || sidebar.style.transform === '') {
        sidebar.style.transform = 'translateX(-100%)';
        mainContent.style.marginLeft = '0';
    } else {
        sidebar.style.transform = 'translateX(0px)';
        mainContent.style.marginLeft = '280px';
    }
}

// Add mobile menu button to header (if needed)
//if (window.innerWidth <= 768) {
//    const header = document.querySelector('.header .logo');
//    const menuButton = document.createElement('button');
//    menuButton.innerHTML = '<i class="fas fa-bars"></i>';
//    menuButton.className = 'btn btn-link text-white mr-3';
//    menuButton.onclick = toggleSidebar;
//    header.parentNode.insertBefore(menuButton, header);
//}
//
//// Window resize handler
//window.addEventListener('resize', function() {
//    if (window.innerWidth > 768) {
//        document.getElementById('sidebar').style.transform = 'translateX(0px)';
//        document.querySelector('.main-content').style.marginLeft = '280px';
//    }
//});
</script>

</body>
</html>