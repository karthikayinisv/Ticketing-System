<%-- header.jsp - Reusable Header Component --%>
<%
    // Check if user is logged in
    Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
    if (isLoggedIn == null || !isLoggedIn) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String username = (String) session.getAttribute("username");
    String empId = (String) session.getAttribute("empId");
    String divisionName = (String) session.getAttribute("divisionName");
    
    // Get first letter of username for avatar
    String userInitial = (username != null && username.length() > 0) ? 
                        username.substring(0, 1).toUpperCase() : "U";
%>

<header class="header">
    <div class="header-left">
        <button class="sidebar-toggle" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i>
        </button>
        <div class="header-title">
            <i class="fas fa-ticket-alt me-2"></i>
            Ticketing System
        </div>
    </div>
    
    <div class="header-right">
        <div class="user-info">
            <div class="user-avatar">
                <%= userInitial %>
            </div>
            <div class="user-details">
                <div style="font-weight: 600; font-size: 0.9rem;"><%= username %></div>
                <div style="font-size: 0.75rem; opacity: 0.8;">
                    <%= empId %> | <%= divisionName != null ? divisionName : "No Division" %>
                </div>
            </div>
        </div>
        
        <a href="logout.jsp" class="logout-btn">
            <i class="fas fa-sign-out-alt me-1"></i>
            Logout
        </a>
    </div>
</header>

<script>
function toggleSidebar() {
    const sidebar = document.querySelector('.sidebar');
    const mainContent = document.querySelector('.main-content');
    
    sidebar.classList.toggle('collapsed');
    mainContent.classList.toggle('expanded');
    
    // Store sidebar state in sessionStorage for persistence
    const isCollapsed = sidebar.classList.contains('collapsed');
    sessionStorage.setItem('sidebarCollapsed', isCollapsed);
}

// Restore sidebar state on page load
document.addEventListener('DOMContentLoaded', function() {
    const isCollapsed = sessionStorage.getItem('sidebarCollapsed') === 'true';
    if (isCollapsed) {
        document.querySelector('.sidebar').classList.add('collapsed');
        document.querySelector('.main-content').classList.add('expanded');
    }
});
</script>