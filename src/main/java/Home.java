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
import org.json.JSONArray;
import org.json.JSONObject;

import utils.CallbackFuture;
import utils.GetJSON;

public class Home extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		GetJSON gj = new GetJSON();
		JSONObject j1 = null,j2 = null;
		CallbackFuture f1;
		
		try {
			f1 = gj.getResponse("https://api.covid19india.org/data.json");
			j1 = gj.getJSONAsync(f1);
		} catch (InterruptedException | ExecutionException | IOException e) {
			e.printStackTrace();
		}
		
		try {
			f1 = gj.getResponse("https://api.covid19india.org/state_test_data.json");
			j2 = gj.getJSONAsync(f1);
		}catch (InterruptedException | ExecutionException | IOException e) {
			e.printStackTrace();
		}
		
		JSONArray tabledata = j1.getJSONArray("statewise");
		JSONArray testingData = j2.getJSONArray("states_tested_data");
		
//		System.out.println("table data is ");
//		System.out.println(tabledata);
//		System.out.println("Testing data is ");
//		System.out.println(testingData);
		
		int k = 0; long total = 0;
		while(k != testingData.length()) {
			
			String state = testingData.getJSONObject(k).getString("state");
			int totalTested = Integer.parseInt(testingData.getJSONObject(k).getString("totaltested"));
			
			while(k != testingData.length() - 1 && state.equalsIgnoreCase(testingData.getJSONObject(k + 1).getString("state"))) {
				try {
				totalTested += Integer.parseInt(testingData.getJSONObject(k + 1).getString("totaltested"));
				}catch (NumberFormatException e){
					//
				}
				total += totalTested;
				k++;
			}
			
			String testedOn = testingData.getJSONObject(k).getString("updatedon");
			
			for(int i = 1; i < tabledata.length(); i ++) {
				if(state.equalsIgnoreCase(tabledata.getJSONObject(i).getString("state"))) {
					tabledata.getJSONObject(i).put("tested", totalTested);
					tabledata.getJSONObject(i).put("updatedOn", testedOn);
					break;
				}
			}
			
			k++;
		}
		
		tabledata.getJSONObject(0).put("tested", total); 
		
		ServletContext ctx = request.getServletContext();
		
		String path = ctx.getRealPath("/resources/json/india_states_final.json"); //Deployment
		
		File file = new File(path);
		String content = FileUtils.readFileToString(file, "utf-8");
		
		JSONObject indiaStates = new JSONObject(content);
		
		request.setAttribute("india", indiaStates);
		request.setAttribute("tableData", tabledata);
		
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		rd.forward(request, response);
	}
}