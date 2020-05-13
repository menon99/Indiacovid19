package servlet;

import java.io.File;
import java.io.IOException;
import java.util.concurrent.ExecutionException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import utils.CallbackFuture;
import utils.GetJSON;
import utils.GetTrends;
import utils.StringFormatter;

public class StateServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String state = request.getParameter("state");
		state = StringFormatter.capitalizeWord(state);

		GetJSON gj = new GetJSON();
		CallbackFuture f1, f2;
		JSONArray j1 = null, j2 = null;
		try {
			f1 = gj.getResponse("https://api.covid19india.org/v2/state_district_wise.json");
			f2 = gj.getResponse("https://api.covid19india.org/zones.json");
			j1 = gj.getJSONArrayAsync(f1);
			j2 = gj.getJSONAsync(f2).getJSONArray("zones");
		} catch (InterruptedException | ExecutionException | IOException e) {
			e.printStackTrace();
		}
		
		int start_index = 0, end_index;
		while (!state.equalsIgnoreCase(j2.getJSONObject(start_index).getString("state")))
			start_index++;
		end_index = start_index + 1;
		while (state.equalsIgnoreCase(j2.getJSONObject(end_index).getString("state")))
			end_index++;
		end_index -=1;
		
		JSONArray districts = new JSONArray();

		for (int i = 0; i < j1.length(); i++) {
			if (state.equalsIgnoreCase(j1.getJSONObject(i).getString("state"))) {

				JSONArray data = j1.getJSONObject(i).getJSONArray("districtData");
				int c = 0, a = 0, r = 0, d = 0;

				for (int k = 0; k < data.length(); k++) {

					JSONObject obj = data.getJSONObject(k);
					if (!obj.getString("district").equalsIgnoreCase("Unknown")) {
						for(int kk = start_index; kk <= end_index;kk++) {
							if(obj.getString("district").equalsIgnoreCase(j2.getJSONObject(kk).getString("district"))) {
								obj.put("zone", j2.getJSONObject(kk).get("zone"));
								break;
							}
						}
						districts.put(obj);
					}

					c += obj.getInt("confirmed");
					r += obj.getInt("recovered");
					d += obj.getInt("deceased");
					a += obj.getInt("active");
				}

				JSONObject total = new JSONObject();
				total.put("district", "total");
				total.put("active", a);
				total.put("recovered", r);
				total.put("confirmed", c);
				total.put("deceased", d);

				districts.put(total);
				break;
			}
		}
		request.setAttribute("tabledata", districts);

		GetTrends gt = new GetTrends();
		JSONObject trends = gt.getTrends();
		JSONArray dates = gt.getDates();

		request.setAttribute("dates", dates);
		request.setAttribute("trends", trends.getJSONObject(state));

		String[] parts = state.toLowerCase().split(" ");
		String jsonName = String.join("", parts) + ".json";

		ServletContext ctx = request.getServletContext();

		String path = ctx.getRealPath("/resources/json/" + jsonName); // Deployment

		File file = new File(path);
		String content = FileUtils.readFileToString(file, "utf-8");

		JSONObject stateCoord = new JSONObject(content);

		request.setAttribute("stateCoords", stateCoord);
		request.setAttribute("sname", state);

		RequestDispatcher rd = request.getRequestDispatcher("states.jsp");
		rd.forward(request, response);
	}
}