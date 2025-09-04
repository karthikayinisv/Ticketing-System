<%@ page import="Database_conn.Database_Connection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
    String taskId = request.getParameter("taskId");
    Map<String, String> task = new HashMap<String, String>(); // Explicit generic type (no diamond operator)
    List<Map<String, String>> projectList = new ArrayList<Map<String, String>>(); // Explicit generic type

    Connection con = null;
    try {
        con = Database_Connection.getConnection();

        // Get Project List
        Statement st1 = con.createStatement();
        ResultSet rs1 = st1.executeQuery("SELECT ProjectId, ProjectName FROM ProjectMaster WHERE Status='Open'");
        while (rs1.next()) {
            Map<String, String> p = new HashMap<String, String>(); // Explicit type
            p.put("id", rs1.getString("ProjectId"));
            p.put("name", rs1.getString("ProjectName"));
            projectList.add(p);
        }

        // Get Task Details
        PreparedStatement ps = con.prepareStatement("SELECT * FROM TaskMaster WHERE TaskId=?");
        ps.setString(1, taskId);
        ResultSet rs2 = ps.executeQuery();
        if (rs2.next()) {
            task.put("taskId", rs2.getString("TaskId"));
            task.put("projectId", rs2.getString("ProjectId"));
            task.put("taskName", rs2.getString("TaskName"));
            task.put("taskDesc", rs2.getString("TaskDescription"));
            task.put("reporterId", rs2.getString("ReporterId"));
            task.put("startDate", rs2.getString("StartDate"));
            task.put("dueDate", rs2.getString("DueDate"));
            task.put("priority", rs2.getString("Priority"));
            task.put("estimatedHours", rs2.getString("EstimatedHours"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (con != null) con.close();
    }

    request.setAttribute("projectList", projectList);
    request.setAttribute("task", task);
%>

<html>
<head>
    <meta charset="utf-8" />
    <title>Update Task</title>
    <link rel="stylesheet" type="text/css" href="../styles/core.css" />
    <link rel="stylesheet" type="text/css" href="../styles/admin.css" />
</head>
<body>

<div class="main-container">
    <div class="pd-ltr-20">
        <div class="card-box p-4">
            <h4 class="text-center mb-4">Update Task</h4>
            <form id="updateTaskForm">
                <input type="hidden" name="taskId" value="${task.taskId}"/>

                <div class="form-group">
                    <label>Project</label>
                    <select name="projectId" class="form-control" required>
                        <c:forEach items="${projectList}" var="p">
                            <option value="${p.id}" ${p.id == task.projectId ? "selected" : ""}>${p.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>Task Name</label>
                    <input type="text" name="taskName" class="form-control" value="${task.taskName}" required />
                </div>

                <div class="form-group">
                    <label>Task Description</label>
                    <textarea name="taskDesc" class="form-control" rows="3">${task.taskDesc}</textarea>
                </div>

                <div class="form-group">
                    <label>Reporter ID</label>
                    <input type="text" name="reporterId" class="form-control" value="${task.reporterId}" />
                </div>

                <div class="form-group">
                    <label>Start Date</label>
                    <input type="date" name="startDate" class="form-control" value="${task.startDate}" required />
                </div>

                <div class="form-group">
                    <label>Due Date</label>
                    <input type="date" name="dueDate" class="form-control" value="${task.dueDate}" required />
                </div>

                <div class="form-group">
                    <label>Priority</label>
                    <select name="priority" class="form-control">
                        <option value="Low" ${task.priority == 'Low' ? "selected" : ""}>Low</option>
                        <option value="Medium" ${task.priority == 'Medium' ? "selected" : ""}>Medium</option>
                        <option value="High" ${task.priority == 'High' ? "selected" : ""}>High</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Estimated Hours</label>
                    <input type="number" name="estimatedHours" step="0.1" class="form-control" value="${task.estimatedHours}" />
                </div>

                <button type="submit" class="btn btn-primary btn-block">Update Task</button>
            </form>
        </div>
    </div>
</div>

<script src="vendors/scripts/core.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    $(document).ready(function () {
        $('#updateTaskForm').submit(function (e) {
            e.preventDefault();
            var formData = $(this).serialize();

            $.ajax({
                url: '../web/getajaxcall/update_task_action.jsp',
                type: 'POST',
                data: formData,
                success: function () {
                    Swal.fire({
                        icon: 'success',
                        title: 'Task Updated!',
                        text: 'Task details have been successfully updated.',
                        timer: 2000,
                        showConfirmButton: false
                    }).then(() => {
                        window.location.href = 'task_list.jsp';
                    });
                },
                error: function () {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Failed to update task.'
                    });
                }
            });
        });
    });
</script>

</body>
</html>
