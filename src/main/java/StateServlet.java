import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StateServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String [] parts = request.getRequestURI().split("/");
		if(parts.length == 4) {
			String state = URLDecoder.decode(parts[3], StandardCharsets.UTF_8.toString());
			System.out.println("state is " + state);
		}
		response.getWriter().append("Served at: ").append(request.getRequestURI());
	}
}