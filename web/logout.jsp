<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// Clear all session attributes
session.invalidate();

// Redirect to login page with success message
response.sendRedirect("login.jsp?success=You+have+been+successfully+logged+out");
%>