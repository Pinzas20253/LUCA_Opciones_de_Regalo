<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    // Invalida la sesión actual
    session.invalidate();

    // Redirige al login
    response.sendRedirect("login.jsp");
%>
