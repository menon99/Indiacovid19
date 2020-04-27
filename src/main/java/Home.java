import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.concurrent.ExecutionException;

import org.apache.commons.io.FileUtils;
import org.json.JSONObject;

import utils.CallbackFuture;
import utils.GetJSON;

public class Home extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		GetJSON gj = new GetJSON();
		JSONObject j1 = null;
		CallbackFuture f1;
		try {
			f1 = gj.getResponse("https://api.covid19india.org/data.json");
			j1 = gj.getJSONAsync(f1);
		} catch (InterruptedException | ExecutionException | IOException e) {
			e.printStackTrace();
		}
		
		ServletContext ctx = request.getServletContext();
		
		String path = ctx.getRealPath("/resources/json/india_states_final.json"); //Deployment
		
		File file = new File(path);
		String content = FileUtils.readFileToString(file, "utf-8");
		
		JSONObject indiaStates = new JSONObject(content);
		
		request.setAttribute("india", indiaStates);
		request.setAttribute("tableData", j1.getJSONArray("statewise"));
		
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		rd.forward(request, response);
	}
}