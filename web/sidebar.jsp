<%-- sidebar.jsp - Reusable Sidebar Component --%>
<%
    String currentPage = request.getParameter("currentPage");
    if (currentPage == null) {
        // Try to determine current page from request URI
        String requestURI = request.getRequestURI();
        if (requestURI.contains("admin_dashboard")) currentPage = "dashboard";
        else if (requestURI.contains("projects")) currentPage = "projects";
        else if (requestURI.contains("tasks")) currentPage = "tasks";
        else if (requestURI.contains("reports")) currentPage = "reports";
        else if (requestURI.contains("settings")) currentPage = "settings";
        else currentPage = "dashboard";
    }
%>

<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <div class="d-flex align-items-center">
            <i class="fas fa-ticket-alt fa-2x text-primary me-3"></i>
            <div>
                <h4 class="mb-0">TaskFlow</h4>
                <small class="text-muted">Management System</small>
            </div>
        </div>
        <button class="btn btn-link sidebar-toggle d-lg-none" onclick="toggleSidebar()">
            <i class="fas fa-times"></i>
        </button>
    </div>

    <div class="user-info">
        <div class="d-flex align-items-center">
            <div class="user-avatar">
                <i class="fas fa-user"></i>
            </div>
            <div class="ms-3">
                <h6 class="mb-0"><%= session.getAttribute("username") != null ? session.getAttribute("username") : "User" %></h6>
                <small class="text-muted">
                    <%= session.getAttribute("divisionName") != null ? session.getAttribute("divisionName") : "Division" %>
                </small>
            </div>
        </div>
    </div>

    <nav class="sidebar-nav">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link <%= "dashboard".equals(currentPage) ? "active" : "" %>" href="admin_dashboard.jsp">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link <%= "projects".equals(currentPage) ? "active" : "" %>" href="projects.jsp">
                    <i class="fas fa-project-diagram"></i>
                    <span>Projects</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link <%= "tasks".equals(currentPage) ? "active" : "" %>" href="tasks.jsp">
                    <i class="fas fa-tasks"></i>
                    <span>Tasks</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link <%= "create-task".equals(currentPage) ? "active" : "" %>" href="create_task.jsp">
                    <i class="fas fa-plus-circle"></i>
                    <span>Create Task</span>
                </a>
            </li>
            
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="reportsDropdown" role="button" data-bs-toggle="collapse" data-bs-target="#reportsSubmenu" aria-expanded="false">
                    <i class="fas fa-chart-bar"></i>
                    <span>Reports</span>
                </a>
                <div class="collapse" id="reportsSubmenu">
                    <ul class="nav flex-column ms-3">
                        <li class="nav-item">
                            <a class="nav-link <%= "task-reports".equals(currentPage) ? "active" : "" %>" href="task_reports.jsp">
                                <i class="fas fa-file-alt"></i>
                                <span>Task Reports</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link <%= "project-reports".equals(currentPage) ? "active" : "" %>" href="project_reports.jsp">
                                <i class="fas fa-clipboard-list"></i>
                                <span>Project Reports</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </li>
            
            <li class="nav-item">
                <a class="nav-link <%= "team".equals(currentPage) ? "active" : "" %>" href="team.jsp">
                    <i class="fas fa-users"></i>
                    <span>Team</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link <%= "calendar".equals(currentPage) ? "active" : "" %>" href="calendar.jsp">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Calendar</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link <%= "settings".equals(currentPage) ? "active" : "" %>" href="settings.jsp">
                    <i class="fas fa-cog"></i>
                    <span>Settings</span>
                </a>
            </li>
        </ul>
    </nav>

    <div class="sidebar-footer">
        <div class="d-grid gap-2">
            <a href="profile.jsp" class="btn btn-outline-primary btn-sm">
                <i class="fas fa-user-circle me-2"></i>Profile
            </a>
            <a href="logout.jsp" class="btn btn-outline-danger btn-sm">
                <i class="fas fa-sign-out-alt me-2"></i>Logout
            </a>
        </div>
    </div>
</div>

<script>
function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    const mainContent = document.querySelector('.main-content');
    
    sidebar.classList.toggle('sidebar-collapsed');
    if (mainContent) {
        mainContent.classList.toggle('content-expanded');
    }
}

// Auto-collapse sidebar on mobile
function checkScreenSize() {
    const sidebar = document.getElementById('sidebar');
    if (window.innerWidth < 992) {
        sidebar.classList.add('sidebar-mobile');
    } else {
        sidebar.classList.remove('sidebar-mobile');
    }
}

window.addEventListener('resize', checkScreenSize);
document.addEventListener('DOMContentLoaded', checkScreenSize);
</script>