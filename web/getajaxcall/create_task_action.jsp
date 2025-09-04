<%@page import="java.sql.*"%>
<%@page import="Database_conn.Database_Connection"%>

<%
    String taskId = request.getParameter("taskId");
    String projectId = request.getParameter("projectId");
    String taskName = request.getParameter("taskName");
    String taskDesc = request.getParameter("taskDesc");
    String reporterId = request.getParameter("reporterId");
    String startDate = request.getParameter("startDate");
    String dueDate = request.getParameter("dueDate");
    String priority = request.getParameter("priority");
    String estimatedHours = request.getParameter("estimatedHours");

    Connection con = null;
    PreparedStatement ps = null;
    try {
        con = Database_Connection.getConnection();
        String sql = "UPDATE TaskMaster SET ProjectId=?, TaskName=?, TaskDescription=?, ReporterId=?, StartDate=?, DueDate=?, Priority=?, EstimatedHours=? WHERE TaskId=?";
        ps = con.prepareStatement(sql);
        ps.setString(1, projectId);
        ps.setString(2, taskName);
        ps.setString(3, taskDesc);
        ps.setString(4, reporterId);
        ps.setString(5, startDate);
        ps.setString(6, dueDate);
        ps.setString(7, priority);
        ps.setString(8, estimatedHours);
        ps.setString(9, taskId);
        ps.executeUpdate();
        out.print("success");
    } catch (Exception e) {
        e.printStackTrace();
        response.setStatus(500);
    } finally {
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>
