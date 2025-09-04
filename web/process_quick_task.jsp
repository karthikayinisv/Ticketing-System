<%@ page import="java.sql.*" %>
<%@ page import="Database_conn.Database_Connection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    // ✅ Check if user is logged in
    if (session.getAttribute("isLoggedIn") == null || !(Boolean)session.getAttribute("isLoggedIn")) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = Database_Connection.getConnection();

        // ✅ Get form values
        String taskName = request.getParameter("taskName");
        String taskDesc = request.getParameter("taskDesc");
        String projectIdStr = request.getParameter("projectId");
        String priority = request.getParameter("priority");
        String dueDateStr = request.getParameter("dueDate");
        String estimatedHoursStr = request.getParameter("estimatedHours");

        Integer projectId = (projectIdStr != null && !projectIdStr.isEmpty()) ? Integer.parseInt(projectIdStr) : null;
        Double estimatedHours = (estimatedHoursStr != null && !estimatedHoursStr.isEmpty()) ? Double.parseDouble(estimatedHoursStr) : 0.0;

        int reporterId = (Integer) session.getAttribute("userId");
        String createdBy = (String) session.getAttribute("username");

        // ✅ Insert Task into TaskMaster
        String insertTaskSql = "INSERT INTO TaskMaster " +
                               "(ProjectID, TaskName, TaskDesc, ReporterID, StartDate, DueDate, Status, " +
                               "Priority, EstimatedHours, ActualHours, ProgressPercent, CreatedBy, CreatedDate) " +
                               "VALUES (?, ?, ?, ?, GETDATE(), ?, ?, ?, ?, 0, 0, ?, GETDATE())";

        pstmt = conn.prepareStatement(insertTaskSql, Statement.RETURN_GENERATED_KEYS);
        if (projectId != null) {
            pstmt.setInt(1, projectId);
        } else {
            pstmt.setNull(1, java.sql.Types.INTEGER);
        }
        pstmt.setString(2, taskName);
        pstmt.setString(3, taskDesc);
        pstmt.setInt(4, reporterId);
        if (dueDateStr != null && !dueDateStr.isEmpty()) {
            pstmt.setDate(5, java.sql.Date.valueOf(dueDateStr));
        } else {
            pstmt.setNull(5, java.sql.Types.DATE);
        }
        pstmt.setString(6, "Pending");  // Default Status
        pstmt.setString(7, priority);
        pstmt.setDouble(8, estimatedHours);
        pstmt.setString(9, createdBy);

        int rowsInserted = pstmt.executeUpdate();

        int newTaskId = 0;
        if (rowsInserted > 0) {
            rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                newTaskId = rs.getInt(1);
            }
            rs.close();
        }
        pstmt.close();

        // ✅ (Optional) Assign task to current user in TaskAssignees
        if (newTaskId > 0) {
            String assignSql = "INSERT INTO TaskAssignees (TaskID, AssigneeID) VALUES (?, ?)";
            pstmt = conn.prepareStatement(assignSql);
            pstmt.setInt(1, newTaskId);
            pstmt.setInt(2, reporterId);
            pstmt.executeUpdate();
            pstmt.close();
        }

        session.setAttribute("message", "✅ Task created successfully!");
        response.sendRedirect("dashboard.jsp");

    } catch (Exception e) {
        e.printStackTrace();
        session.setAttribute("message", "❌ Error while creating task: " + e.getMessage());
        response.sendRedirect("dashboard.jsp");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
