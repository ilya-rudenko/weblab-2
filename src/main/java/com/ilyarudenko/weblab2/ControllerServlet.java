package com.ilyarudenko.weblab2;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;

import java.util.LinkedList;

@WebServlet( name = "ControllerServlet",urlPatterns = "/control")
public class ControllerServlet extends HttpServlet {

    private String message;

    @Override
    public void init() {
        getServletContext().setAttribute("table", new LinkedList<TableRow>());

        LinkedList<TableRow> Table = (LinkedList<TableRow>) getServletContext().getAttribute("table");
//        Table.addFirst(new TableRow(1,2,3,true, "0.16","LocalDateTime.now()"));
        getServletContext().setAttribute("table", Table);
        message = "Hello World!";
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        // Hello
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>" + "No way bro, get out" + "</h1>");
        out.println("</body></html>");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println(req.getParameter("X"));
        System.out.println(req.getParameter("Y"));
        System.out.println(req.getParameter("R"));

        System.out.println("Success");
        if(req.getParameter("X") != null && req.getParameter("Y") != null
                && req.getParameter("R") != null) {
            System.out.println("REDIRECTED TO AreaCheckServlet");
            getServletContext().getNamedDispatcher("AreaCheckServlet").forward(req, resp);
        }
        else if (req.getParameter("clear") != null){
            getServletContext().setAttribute("table", new LinkedList<TableRow>());
            getServletContext().getRequestDispatcher("/index.jsp").forward(req, resp);
        }
        else {
            getServletContext().getRequestDispatcher("/index.jsp").forward(req, resp);
        }
    }
}
