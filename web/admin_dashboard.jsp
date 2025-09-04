<%@page import="Database_conn.Database_Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    // Check if user is logged in
    if (session.getAttribute("isLoggedIn") == null || !(Boolean)session.getAttribute("isLoggedIn")) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get user division for filtering projects
    Integer userDivision = (Integer) session.getAttribute("division");
    String username = (String) session.getAttribute("username");
    String divisionName = (String) session.getAttribute("divisionName");
    
    // Fetch dashboard statistics
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    int totalProjects = 0;
    int totalTasks = 0;
    int completedTasks = 0;
    int pendingTasks = 0;
    int myTasks = 0;
    
    List<Map<String, Object>> recentTasks = new ArrayList<Map<String, Object>>();
    List<Map<String, Object>> projectList = new ArrayList<Map<String, Object>>();
    
    try {
        conn = Database_Connection.getConnection();
        
        // Get total projects for user's division
        String projectSql = "SELECT COUNT(*) as count FROM DivisionMaster WHERE DivisionName = ? OR DivisionName IS NULL";
        pstmt = conn.prepareStatement(projectSql);
        pstmt.setInt(1, userDivision);
        rs = pstmt.executeQuery();
        if (rs.next()) totalProjects = rs.getInt("count");
        rs.close(); pstmt.close();
        
        // Get total tasks
        String taskSql = "SELECT COUNT(*) as count FROM TaskMaster";
        pstmt = conn.prepareStatement(taskSql);
        rs = pstmt.executeQuery();
        if (rs.next()) totalTasks = rs.getInt("count");
        rs.close(); pstmt.close();
        
        // Get completed tasks
        String completedSql = "SELECT COUNT(*) as count FROM TaskMaster WHERE Status = 'Completed'";
        pstmt = conn.prepareStatement(completedSql);
        rs = pstmt.executeQuery();
        if (rs.next()) completedTasks = rs.getInt("count");
        rs.close(); pstmt.close();
        
        // Get pending tasks
        String pendingSql = "SELECT COUNT(*) as count FROM TaskMaster WHERE Status IN ('Pending', 'In Progress')";
        pstmt = conn.prepareStatement(pendingSql);
        rs = pstmt.executeQuery();
        if (rs.next()) pendingTasks = rs.getInt("count");
        rs.close(); pstmt.close();
        
        // Get my assigned tasks
        String myTasksSql = "SELECT COUNT(DISTINCT t.TaskID) as count FROM TaskMaster t " +
                           "INNER JOIN TaskAssignees ta ON t.TaskID = ta.TaskID " +
                           "WHERE ta.AssigneeID = ?";
        pstmt = conn.prepareStatement(myTasksSql);
        pstmt.setInt(1, (Integer)session.getAttribute("userId"));
        rs = pstmt.executeQuery();
        if (rs.next()) myTasks = rs.getInt("count");
        rs.close(); pstmt.close();
        
        // Get recent tasks (last 5)
        String recentTasksSql = "SELECT  t.TaskID, t.TaskName, t.TaskDesc, t.Status, t.Priority, " +
                               "t.DueDate, p.ProjectName, t.ProgressPercent " +
                               "FROM TaskMaster t " +
                               "LEFT JOIN ProjectMaster p ON t.ProjectID = p.ProjectID " +
                               "ORDER BY t.CreatedDate DESC";
        pstmt = conn.prepareStatement(recentTasksSql);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            Map<String, Object> task = new HashMap<String, Object>();
            task.put("taskId", rs.getInt("TaskID"));
            task.put("taskName", rs.getString("TaskName"));
            task.put("taskDesc", rs.getString("TaskDesc"));
            task.put("status", rs.getString("Status"));
            task.put("priority", rs.getString("Priority"));
            task.put("dueDate", rs.getDate("DueDate"));
            task.put("projectName", rs.getString("ProjectName"));
            task.put("progress", rs.getInt("ProgressPercent"));
            recentTasks.add(task);
        }
        rs.close(); pstmt.close();
        
        // Get projects for user's division
        String projectListSql = "SELECT ProjectId, ProjectName, ProjectDesc FROM ProjectMaster " +
                               "WHERE Division = ? OR Division IS NULL ORDER BY ProjectName";
        pstmt = conn.prepareStatement(projectListSql);
        pstmt.setInt(1, userDivision);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            Map<String, Object> project = new HashMap<String, Object>();
            project.put("projectId", rs.getInt("ProjectId"));
            project.put("projectName", rs.getString("ProjectName"));
            project.put("projectDesc", rs.getString("ProjectDesc"));
            projectList.add(project);
        }
        
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - TaskFlow Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="./src/styles/admin.css" rel="stylesheet">
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="header.jsp">
        <jsp:param name="currentPage" value="dashboard" />
    </jsp:include>
    
    <div class="wrapper">
        <!-- Include Sidebar -->
        <jsp:include page="sidebar.jsp">
            <jsp:param name="currentPage" value="dashboard" />
        </jsp:include>
        <% if (session.getAttribute("message") != null) { %>
    <div class="alert alert-info alert-dismissible fade show" role="alert">
        <%= session.getAttribute("message") %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% session.removeAttribute("message"); %>
<% } %>

        <!-- Main Content -->
        <div class="main-content">
            <div class="content-wrapper">
                <!-- Page Header -->
                <div class="page-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h1 class="page-title">
                                <i class="fas fa-tachometer-alt me-3"></i>Dashboard
                            </h1>
                            <p class="page-subtitle">Welcome back, <%= username %>! Here's your overview.</p>
                        </div>
                        <div class="page-actions">
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#quickTaskModal">
                                <i class="fas fa-plus me-2"></i>Quick Task
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Statistics Cards -->
                <div class="row g-4 mb-4">
                    <div class="col-xl-3 col-md-6">
                        <div class="stats-card stats-primary">
                            <div class="stats-icon">
                                <i class="fas fa-project-diagram"></i>
                            </div>
                            <div class="stats-content">
                                <h3><%= totalProjects %></h3>
                                <p>Total Projects</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-3 col-md-6">
                        <div class="stats-card stats-success">
                            <div class="stats-icon">
                                <i class="fas fa-tasks"></i>
                            </div>
                            <div class="stats-content">
                                <h3><%= totalTasks %></h3>
                                <p>Total Tasks</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-3 col-md-6">
                        <div class="stats-card stats-warning">
                            <div class="stats-icon">
                                <i class="fas fa-clock"></i>
                            </div>
                            <div class="stats-content">
                                <h3><%= pendingTasks %></h3>
                                <p>Pending Tasks</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-3 col-md-6">
                        <div class="stats-card stats-info">
                            <div class="stats-icon">
                                <i class="fas fa-user-check"></i>
                            </div>
                            <div class="stats-content">
                                <h3><%= myTasks %></h3>
                                <p>My Tasks</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Main Dashboard Content -->
                <div class="row g-4">
                    <!-- Projects Section -->
                    <div class="col-xl-8">
                        <div class="card dashboard-card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">
                                    <i class="fas fa-project-diagram me-2"></i>Available Projects
                                </h5>
                                <a href="projects.jsp" class="btn btn-sm btn-outline-primary">
                                    View All <i class="fas fa-arrow-right ms-1"></i>
                                </a>
                            </div>
                            <div class="card-body">
                                <% if (projectList.isEmpty()) { %>
                                    <div class="empty-state text-center py-4">
                                        <i class="fas fa-project-diagram fa-3x text-muted mb-3"></i>
                                        <h6 class="text-muted">No projects available</h6>
                                        <p class="text-muted small">Contact your administrator to get access to projects.</p>
                                    </div>
                                <% } else { %>
                                    <div class="row g-3">
                                        <% for (Map<String, Object> project : projectList) { %>
                                            <div class="col-md-6">
                                                <div class="project-card">
                                                    <div class="project-header">
                                                        <h6 class="project-title"><%= project.get("projectName") %></h6>
                                                        <div class="project-actions">
                                                            <button class="btn btn-sm btn-primary" 
                                                                    onclick="createTaskForProject(<%= project.get("projectId") %>)">
                                                                <i class="fas fa-plus"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                    <p class="project-desc">
                                                        <%= project.get("projectDesc") != null ? project.get("projectDesc") : "No description available" %>
                                                    </p>
                                                </div>
                                            </div>
                                        <% } %>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Recent Tasks Section -->
                    <div class="col-xl-4">
                        <div class="card dashboard-card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">
                                    <i class="fas fa-history me-2"></i>Recent Tasks
                                </h5>
                                <a href="createtask.jsp" class="btn btn-sm btn-outline-primary">
                                    View All <i class="fas fa-arrow-right ms-1"></i>
                                </a>
                            </div>
                            <div class="card-body">
                                <% if (recentTasks.isEmpty()) { %>
                                    <div class="empty-state text-center py-4">
                                        <i class="fas fa-tasks fa-3x text-muted mb-3"></i>
                                        <h6 class="text-muted">No recent tasks</h6>
                                        <a href="createtask.jsp" class="btn btn-sm btn-primary mt-2">
                                            <i class="fas fa-plus me-1"></i>Create First Task
                                        </a>
                                    </div>
                                <% } else { %>
                                    <div class="task-list">
                                        <% for (Map<String, Object> task : recentTasks) { %>
                                            <div class="task-item">
                                                <div class="task-info">
                                                    <h6 class="task-title"><%= task.get("taskName") %></h6>
                                                    <p class="task-project">
                                                        <i class="fas fa-folder me-1"></i>
                                                        <%= task.get("projectName") != null ? task.get("projectName") : "No Project" %>
                                                    </p>
                                                </div>
                                                <div class="task-meta">
                                                    <span class="badge status-<%= ((String)task.get("status")).toLowerCase().replace(" ", "-") %>">
                                                        <%= task.get("status") %>
                                                    </span>
                                                    <div class="task-progress mt-2">
                                                        <div class="progress progress-sm">
                                                            <div class="progress-bar" style="width: <%= task.get("progress") %>%"></div>
                                                        </div>
                                                        <small class="text-muted"><%= task.get("progress") %>% complete</small>
                                                    </div>
                                                </div>
                                            </div>
                                        <% } %>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Actions Section -->
                <div class="row g-4 mt-2">
                    <div class="col-12">
                        <div class="card dashboard-card">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <i class="fas fa-bolt me-2"></i>Quick Actions
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="row g-3">
                                    <div class="col-md-3">
                                        <a href="create_task.jsp" class="quick-action-card">
                                            <div class="quick-action-icon bg-primary">
                                                <i class="fas fa-plus"></i>
                                            </div>
                                            <h6>Create Task</h6>
                                            <p>Add a new task to any project</p>
                                        </a>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <a href="tasks.jsp" class="quick-action-card">
                                            <div class="quick-action-icon bg-success">
                                                <i class="fas fa-list-check"></i>
                                            </div>
                                            <h6>View Tasks</h6>
                                            <p>Manage and track all tasks</p>
                                        </a>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <a href="projects.jsp" class="quick-action-card">
                                            <div class="quick-action-icon bg-info">
                                                <i class="fas fa-project-diagram"></i>
                                            </div>
                                            <h6>Projects</h6>
                                            <p>View and manage projects</p>
                                        </a>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <a href="task_reports.jsp" class="quick-action-card">
                                            <div class="quick-action-icon bg-warning">
                                                <i class="fas fa-chart-bar"></i>
                                            </div>
                                            <h6>Reports</h6>
                                            <p>Generate task reports</p>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Task Modal -->
    <div class="modal fade" id="quickTaskModal" tabindex="-1" aria-labelledby="quickTaskModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="quickTaskModalLabel">
                        <i class="fas fa-plus-circle me-2"></i>Create Quick Task
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="process_quick_task.jsp" method="post" id="quickTaskForm">
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-12">
                                <label for="taskName" class="form-label">Task Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="taskName" name="taskName" required>
                            </div>
                            
                            <div class="col-md-12">
                                <label for="taskDesc" class="form-label">Description</label>
                                <textarea class="form-control" id="taskDesc" name="taskDesc" rows="3"></textarea>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="projectId" class="form-label">Project</label>
                                <select class="form-select" id="projectId" name="projectId">
    <option value="">Select Project</option>
    <% for (Map<String, Object> project : projectList) { %>
        <option value="<%= project.get("projectId") %>">
            <%= project.get("projectName") %>
        </option>
    <% } %>
</select>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="priority" class="form-label">Priority</label>
                                <select class="form-select" id="priority" name="priority">
                                    <option value="Low">Low</option>
                                    <option value="Medium" selected>Medium</option>
                                    <option value="High">High</option>
                                    <option value="Critical">Critical</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="dueDate" class="form-label">Due Date</label>
                                <input type="date" class="form-control" id="dueDate" name="dueDate">
                            </div>
                            
                            <div class="col-md-6">
                                <label for="estimatedHours" class="form-label">Estimated Hours</label>
                                <input type="number" class="form-control" id="estimatedHours" name="estimatedHours" min="0" step="0.5">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Create Task
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Set minimum date to today for due date field
        document.addEventListener('DOMContentLoaded', function() {
            var today = new Date().toISOString().split('T')[0];
            document.getElementById('dueDate').setAttribute('min', today);
        });

        // Function to create task for specific project
        function createTaskForProject(projectId) {
            // Open the modal
            var modal = new bootstrap.Modal(document.getElementById('quickTaskModal'));
            modal.show();
            
            // Set the project selection
            document.getElementById('projectId').value = projectId;
        }

        // Form validation
        document.getElementById('quickTaskForm').addEventListener('submit', function(e) {
            var taskName = document.getElementById('taskName').value.trim();
            
            if (taskName === '') {
                e.preventDefault();
                alert('Please enter a task name.');
                document.getElementById('taskName').focus();
                return false;
            }
            
            return true;
        });

        // Auto-refresh dashboard every 5 minutes
        setInterval(function() {
            location.reload();
        }, 300000); // 5 minutes in milliseconds
    </script>
</body>a<!-- Success Message -->
        <% if (session.getAttribute("message") != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                <%= session.getAttribute("message") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("message"); %>
        <% } %>
        
        <!-- Error Message -->
        <% if (session.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>
                <%= session.getAttribute("errorMessage") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("errorMessage"); %>
        <% } %>
</html>
