package utils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import javax.servlet.ServletContext;

import org.apache.commons.io.FileUtils;
import org.json.JSONArray;
import org.json.JSONObject;

public class UpdateIndiaStates {
	public void updateIndiaStates(JSONObject latest, ServletContext ctx) throws IOException {
		
		String path = ctx.getRealPath("/resources/json/india_states_final.json"); //Deployment
//		String path = "/home/akash/eclipse-workspace/Indiacovid19/src/main"
//				+ "/webapp/resources/json/india_states_final.json";
//		System.out.println(path);
		
		File file = new File(path);
		String content = FileUtils.readFileToString(file, "utf-8");
		
		JSONObject indiaStates = new JSONObject(content);
		JSONArray statesArray = indiaStates.getJSONArray("features");
		
		JSONArray stateWise = latest.getJSONArray("statewise");
		
		for(int i = 1; i < stateWise.length(); i++) {
			for(int j = 0; j < statesArray.length(); j ++) {
				String stateName = statesArray.getJSONObject(j).getJSONObject("properties")
						.getString("st_nm");
				if(stateName.equalsIgnoreCase(stateWise.getJSONObject(i).getString("state"))) {
					statesArray.getJSONObject(j).put("cases", Integer.parseInt
							(stateWise.getJSONObject(i).getString("confirmed")));
					break;
				}
			}
		}
		
//		for(int i = 0 ; i < statesArray.length(); i++) {
//			System.out.println(indiaStates.getJSONArray("features").getJSONObject(i).
//					getJSONObject("properties").getString("st_nm"));
//			System.out.println(indiaStates.getJSONArray("features").
//					getJSONObject(i).get("cases"));
//		}
		
		BufferedWriter writer = Files.newBufferedWriter(Paths.get(path));
	    indiaStates.write(writer);
	    writer.close();
	}
}