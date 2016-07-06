<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Set" %>

<!DOCTYPE html>
<head>
    <style>
        body {
            font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
        }
        table, th, td {
            border: 1px solid black;
        }
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
        th, td {
            border-bottom: 1px solid #ddd;
        }
        tr:hover {background-color: #f5f5f5}
        tr:nth-child(even) {background-color: #f2f2f2}
        th {
            background-color: #FFAF50;
            color: white;
        }
    </style>
</head>
<body bgcolor="white">
<h1> Request Information </h1>
JSP Request Method: <%= request.getMethod() %>
<br>
Request URI: <%= request.getRequestURI() %>
<br>
Request Protocol: <%= request.getProtocol() %>
<br>
Servlet path: <%= request.getServletPath() %>
<br>
Path info: <%= request.getPathInfo() %>
<br>
Query string: <%= request.getQueryString() %>
<br>
Content length: <%= request.getContentLength() %>
<br>
Content type: <%= request.getContentType() %>
<br>
Server name: <%= request.getServerName() %>
<br>
Server port: <%= request.getServerPort() %>
<br>
Remote user: <%= request.getRemoteUser() %>
<br>
Remote address: <%= request.getRemoteAddr() %>
<br>
Remote host: <%= request.getRemoteHost() %>
<br>
Authorization scheme: <%= request.getAuthType() %>
<br>
Locale: <%= request.getLocale() %>
<hr>
The browser you are using is
<%= request.getHeader("User-Agent") %>
<hr>
<section>
    <table>
        <caption>All Attributes</caption>
        <thead>
        <tr>
            <th>Key</th>
            <th>Value</th>
        </tr>
        </thead>
        <tbody>
        <%
            Enumeration<String> e = request.getAttributeNames();

            while (e.hasMoreElements())
            {
                String key = e.nextElement();
                Object val = request.getAttribute(key);
        %>
        <tr>
            <th><%= key %>
            </th>
            <td><%= val.toString() %>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</section>

<hr>

<section>
    <div style="overflow-x:auto;">
    <table>
        <caption>All Environment Variables</caption>
        <thead>
        <tr>
            <th>Key</th>
            <th>Value</th>
        </tr>
        </thead>
        <tbody>
        <%
            Map<String, String> env = System.getenv();

            Set<String> keys = env.keySet();
            for (String key : keys)
            {
                Object val = env.get(key);
        %>
        <tr>
            <th><%= key %>
            </th>
            <td><%= val.toString() %>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    </div>
</section>
</body>
</html>
