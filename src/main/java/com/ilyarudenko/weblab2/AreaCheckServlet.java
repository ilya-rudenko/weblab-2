package com.ilyarudenko.weblab2;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.LinkedList;

@WebServlet(name = "AreaCheckServlet",urlPatterns = "/check")
public class AreaCheckServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long startTime = System.nanoTime();

        String x = req.getParameter("X");
        String y = req.getParameter("Y");
        String r = req.getParameter("R");

        System.out.println(x+ " "+y+" "+" "+r);
        double xValue,yValue,rValue;
        try{
            if(x==null || x.equals("")) throw new WrongDataException("x not set");
            if(y==null || y.equals("")) throw  new WrongDataException("y not set");
            if(r==null || r.equals("")) throw  new WrongDataException("r not set");

            x = x.trim();
            y = y.trim();
            r = r.trim();
            xValue = validateX(x);
            yValue = validateY(y);
            rValue = validateR(r);

            boolean isInside =  insideCircle(xValue, yValue, rValue) ||
                    insideTriangle(xValue, yValue, rValue) ||
                    insideRectangle(xValue, yValue, rValue);

            OffsetDateTime currentTimeObject = OffsetDateTime.now(ZoneOffset.UTC);
            String currentTime;
            try {
                currentTimeObject = currentTimeObject.minusMinutes(Long.parseLong(req.getParameter("timezone")));
                currentTime = currentTimeObject.format(DateTimeFormatter.ofPattern("HH:mm:ss"));
            } catch (Exception exception) {
                currentTime = "no info";
            }
            String executionTime = String.format("%.3f",(Double)((System.nanoTime() - startTime)/1_000_000.0));

            LinkedList<TableRow> Table = (LinkedList<TableRow>) getServletContext().getAttribute("table");
            Table.addFirst(new TableRow(xValue,yValue,rValue,isInside, executionTime, currentTime));
            getServletContext().setAttribute("table", Table);

            req.getSession().setAttribute("table", Table);
            req.getSession().setAttribute("check", new TableRow(xValue,yValue,rValue,isInside, executionTime, currentTime));

            getServletContext().getRequestDispatcher("/result_page.jsp").forward(req, resp);
        } catch (WrongDataException e){
            req.setAttribute("error_message", e.getMessage());
            getServletContext().getRequestDispatcher("/wrong_data.jsp").forward(req, resp);
        }
    }

    private double validateX(String x) throws  WrongDataException{
        System.out.println("X: "+ x);
        float dx;
        try{
            dx = Float.parseFloat(x);
            System.out.println(dx);
//            if(dx>3||dx<-5) throw new WrongDataException("x is wrong format: " + dx);
        } catch (NumberFormatException e){
            System.out.println(e);
            throw new WrongDataException("x is wrong format");
        }
        return dx;
    }

    private double validateY(String y) throws WrongDataException{
        System.out.println("Y: "+ y);
        double dy;
        try{
            dy = Double.parseDouble(y);
            System.out.println(dy);
//            if(dy>5 || dy<-3) throw new WrongDataException("y is wrong format: " + dy );
        } catch (NumberFormatException e){
            throw new WrongDataException("y is wrong format");
        }
        return dy;
    }

    private double validateR(String r) throws WrongDataException{
        System.out.println("R: "+ r);
        double dr;
        try{
            dr = Integer.parseInt(r);
            if(dr<=0) throw new WrongDataException("r is wrong format");
        } catch (NumberFormatException e){
            throw new WrongDataException("r is wrong format");
        }
        return  dr;
    }

    private boolean insideCircle(double x, double y, double r){
        return x >= 0 && y >= 0 && x*x + y*y <= r*r;
    }

    private boolean insideTriangle(double x, double y, double r){
        return x <= 0 && y >= 0 && y<=0.5*x+r/2;
    }

    private boolean insideRectangle(double x, double y, double r){
        return x >= 0 && y <= 0 && x<=r && y>=-r;
    }
}
