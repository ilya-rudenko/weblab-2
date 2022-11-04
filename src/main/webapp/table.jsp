<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ilyarudenko.weblab2.TableRow" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.LinkedList" %>
<table id="result_table" border="1" cellpadding="0" cellspacing="0" width="100%" class="results"style="margin-top: 600px">
    <!-- <tr id="table_header"> -->

    <thead>
    <th >X</th>
    <th >Y</th>
    <th >R</th>
    <th >Hit fact</th>
    <th >Current time</th>
    <th >Script running time, ms</th>
    </thead>
    <tbody>
    <%
        double scale = Math.pow(10,3);
        TableRow row = ((LinkedList<TableRow>) application.getAttribute("table")).getFirst();
    %>
    <tr>
        <td class="x"><%=Math.round(row.X*scale)/scale%>
        </td>
        <td class="y"><%=Math.round(row.Y*scale)/scale%>
        </td>
        <td class="r"><%=row.R%>
        </td>
        <td class="hit" style='color:<%=(row.hitFact? "lime" : "red")%>'>
            <%= row.hitFact ? "hit" : "miss" %>
        </td>
        <td><%=row.time%>
        </td>
        <td><%=row.scriptTime%>
        </td>
    </tr>

    </tbody>
</table>
