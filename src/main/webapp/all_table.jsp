
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ilyarudenko.weblab2.TableRow" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.text.DecimalFormat" %>
<table id="result_table" border="1" cellpadding="0" cellspacing="0" width="100%" class="results"style="
    margin-top: 50px;
    margin-bottom: 10px;
    margin-left: 50px;
    /*margin-right: 50px;*/
    width: 50%;
    border: 2px solid black;
">
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
        LinkedList<TableRow> table = (LinkedList<TableRow>) application.getAttribute("table");
        double scale = Math.pow(10, 3);
        if (table != null) {
            for (TableRow row : table) {
    %>
    <tr>
        <td class="x" style="padding-left: 10px"><%=Math.round(row.X*scale)/scale%>
        </td>
        <td class="y" style="padding-left: 10px"><%=Math.round(row.Y*scale)/scale%>
        </td>
        <td class="r" style="padding-left: 10px"><%=row.R%>
        </td>
        <td class="hit" style='color:<%=(row.hitFact? "lime" : "red")%>; padding-left: 10px'>
            <%= row.hitFact ? "hit" : "miss" %>
        </td>
        <td style="padding-left: 10px"><%=row.time%>
        </td>
        <td style="padding-left: 10px"><%=row.scriptTime%>
        </td>
    </tr>
    <%
            }
        }
    %>

    </tbody>
</table>
