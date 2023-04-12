package ajax;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("validate")
public class ValidationServlet extends HttpServlet{

	private ServletContext context;
	private HashMap<String, String> accounts = new HashMap<>();
	
	public void init(ServletConfig config) throws ServletException {
		this.context = config.getServletContext();
		accounts.put("greg", "account data");
		accounts.put("duke", "account data");
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		String targetId = request.getParameter("id");
		
		if((targetId != null) && accounts.containsKey(targetId.trim())) {
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<valid>true</valid>");
		} else {
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<valid>false</valid>");
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		String targetId = request.getParameter("id");
		if ((targetId != null) && !accounts.containsKey(targetId.trim())) {
			accounts.put(targetId.trim(), "account data");
			request.setAttribute("targetId", targetId);
			context.getRequestDispatcher("/success.jsp").forward(request, response);
		} else {
			context.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}
}
