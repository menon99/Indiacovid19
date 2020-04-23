import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.concurrent.ExecutionException;

import org.json.JSONObject;

import utils.CallbackFuture;
import utils.GetJSON;
import utils.UpdateIndiaStates;

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
		
		System.out.println("j1 is " + j1);
		
		ServletContext ctx = request.getServletContext();
		String today = LocalDate.now().toString();
		
		String path = ctx.getRealPath("/resources/json/lastUpdated.txt"); //Deployment
//		String path = "/home/akash/eclipse-workspace/Indiacovid19/src/main"
//				+ "/webapp/resources/json/lastUpdated.txt";
//		System.out.println("path is " + path);
		
		FileReader fr = new FileReader(path);
		BufferedReader br = new BufferedReader(fr);
		String lastUpdated = br.readLine();
		br.close();
		
//		System.out.println("lastUpdated is " + lastUpdated);

		if (lastUpdated == null || !lastUpdated.equalsIgnoreCase(today)) {
			
			UpdateIndiaStates up = new UpdateIndiaStates();
			up.updateIndiaStates(j1, ctx);
			
			Writer fileWriter = new FileWriter(path);
			fileWriter.write(today);
			fileWriter.flush();
			fileWriter.close();
		}
		
		request.setAttribute("tableData", j1.getJSONArray("statewise"));
		request.setAttribute("name", "akash");
		
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		rd.forward(request, response);
	}
}