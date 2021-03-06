<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.net.InetAddress" %>

<%!
    String hostname = "n/a";
    String user_name = "n/a";
    String nodeName = System.getProperty("jboss.jvmRoute");
    boolean doInvalidation = false;
%>

<%
    //    response.setHeader("Cache-Control", "no-cache");

    response.setHeader("X-ClusterNode", nodeName);

    // Touch the session to ensure cookie is sent
    session.getId();

    doInvalidation = false;
    String action = request.getParameter("action");
    String key = request.getParameter("key"), val = request.getParameter("value");
    if (action != null && action.equals("Invalidate Session"))
    {
        doInvalidation = true;
    }
    else if (key != null)
    {
        if (val == null || val.trim().length() == 0)
        {
            session.removeAttribute(key);
        }
        else
        {
            System.out.println("adding " + key + "=" + val);
            session.setAttribute(key, val);
        }
    }
%>

<%
    try
    {
        hostname = InetAddress.getLocalHost().getHostName();
    }
    catch (Throwable t)
    {
    }
    try
    {
        user_name = System.getProperty("user.name", "n/a");
    }
    catch (Throwable t)
    {
    }
%>

<html>

<head>
    <title> Session information</title>
</head>

<body bgcolor="white">
<hr>

<br/>

<%!
    int number_of_attrs = 0;
    int total_size = 0;
%>

<%
    number_of_attrs = total_size = 0;
    for (Enumeration en = session.getAttributeNames(); en.hasMoreElements(); )
    {
        String attr_name = (String) en.nextElement();
        number_of_attrs++;
        String value = (String) session.getAttribute(attr_name);
    }
%>

Session information (user=<%=user_name%>, host=<%=hostname%>):
<br/>
<br/>
Session ID: <%= session.getId() %>
<br/>
Created: <%= new java.util.Date(session.getCreationTime())%>
<br/>
Last accessed: <%= new java.util.Date(session.getLastAccessedTime())%>
<br/>
Served From: <%= request.getServerName() %>:<%= request.getServerPort() %>
<br/>
Executed From Server: <%= java.net.InetAddress.getLocalHost().getHostName() %>
    (<%= java.net.InetAddress.getLocalHost().getHostAddress() %>)
<br/>
Session will go inactive in <%= session.getMaxInactiveInterval() %> seconds
<br/>
Attributes: <%= number_of_attrs%>
<br/>

<br/>

<%
    ServletContext ctx = session.getServletContext();
    Integer hits = (Integer) ctx.getAttribute("hits");
    if (hits == null)
    {
        hits = new Integer(0);
        ctx.setAttribute("hits", hits);
    }
    ctx.setAttribute("hits", new Integer(hits.intValue() + 1));
%>

<%=hits%> hits
<br/>
<br/>

<hr>
<br>
<B>Data retrieved from the HttpSession: </B>
<%
    java.util.Enumeration valueNames = session.getAttributeNames();
    if (!valueNames.hasMoreElements())
    {
    }
    else
    {
        out.println("<UL>");
        while (valueNames.hasMoreElements())
        {
            String param = (String) valueNames.nextElement();
            String value = session.getAttribute(param).toString();
            out.println("<LI>" + param + " = " + value + "</LI>");
        }
        out.println("</UL>");
    }
%>
<hr/>
<br/>

<%
    if (doInvalidation)
    {
        session.invalidate();
        out.println("<br/>Session was invalidated - reload to get new session<br/><br/>");
    }
%>


<B> Add to current session: </B><BR>
<FORM ACTION="index.jsp" METHOD="POST" NAME="AddForm">
    Name: <INPUT TYPE="text" SIZE="20" NAME="key">
    <BR>
    Value: <INPUT TYPE="text" SIZE="20" NAME="value">
    <br/><br/>
    <INPUT TYPE="submit" NAME="action" VALUE="Add to session">
    <INPUT TYPE="submit" NAME="action" VALUE="Invalidate Session">
</FORM>

</body>
</html>
