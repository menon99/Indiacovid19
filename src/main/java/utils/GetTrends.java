package utils;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.concurrent.ExecutionException;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class GetTrends {
	
	private JSONObject state_mapping = new JSONObject();
	
	private HashMap<String, String> abbr = new HashMap<String, String>();
	
	private JSONArray dates = new JSONArray();
	
	private String getDate(String date) {
		String[] parts = date.split("-");
		String d = abbr.get(parts[1]) + '/' + parts[0] + "/2020";
		return d;
	}
	
	public  JSONArray getDates() {
		return dates;
	}
	
	public JSONObject getTrends(){
		GetJSON gj = new GetJSON();
		
		CallbackFuture f1 = null,f2 = null;
		
		try {
			f1 = gj.getResponse("https://api.covid19india.org/v2/state_district_wise.json");
			f2 = gj.getResponse("https://api.covid19india.org/states_daily.json");
		} catch (InterruptedException | ExecutionException | IOException e1) {
			e1.printStackTrace();
		}
		
		JSONArray j1= null;
		JSONArray j2 = null;
		
		try {
			j1 = gj.getJSONArrayAsync(f1);
		} catch (InterruptedException | ExecutionException e) {
			e.printStackTrace();
		}
		
		try {
			j2 = gj.getJSONAsync(f2).getJSONArray("states_daily");
		}catch (InterruptedException | ExecutionException e) {
			e.printStackTrace();
		}
		
		JSONObject trends = new JSONObject();
		
		for(int i = 0 ; i < j1.length(); i ++) {
			
			String state = j1.getJSONObject(i).getString("state");
			String code = j1.getJSONObject(i).getString("statecode");
			
			JSONObject arrays = new JSONObject();
			arrays.put("y-confirmed", new JSONArray());
			arrays.put("y-recovered", new JSONArray());
			arrays.put("y-death", new JSONArray());
			arrays.put("y-active", new JSONArray());
			
			trends.put(state,arrays);
			state_mapping.put(code.toLowerCase(),state);
		}
		
		state_mapping.put("tt","total");
		
		JSONObject arrays = new JSONObject();
		arrays.put("y-confirmed", new JSONArray());
		arrays.put("y-recovered", new JSONArray());
		arrays.put("y-death", new JSONArray());
		arrays.put("y-active", new JSONArray());
		
		trends.put("total",arrays);
		
		abbr.put("Mar", "03");
		abbr.put("Apr", "04");
		abbr.put("May" , "05");
		abbr.put("Jun", "06");
		abbr.put("Jul", "07");
		abbr.put("Aug", "08");
		abbr.put("Sep", "09");
		abbr.put("Oct", "10");
		abbr.put("Nov", "11");
		abbr.put("Dec", "12");
		
		for(int i = 0; i < j2.length(); i ++) {
			
			JSONObject day = j2.getJSONObject(i);
			String status = day.getString("status");
			String date = getDate(day.getString("date"));
			
			day.remove("status");
			day.remove("date");
			
			if(status.equalsIgnoreCase("Confirmed")) {
				dates.put(date);
				Iterator<String> e = day.keys();
				while(e.hasNext()) {
					String code = e.next();
					int val;
					try {
						val = Integer.parseInt(day.getString(code));
					}catch (NumberFormatException r) {
						val = 0;
					}
					
					try {
						String state = state_mapping.getString(code);
						JSONArray c = trends.getJSONObject(state).getJSONArray("y-confirmed");
						int prev;
						if(c.length() == 0)
							prev = 0;
						else
							prev = c.getInt(c.length() -1);
						trends.getJSONObject(state).getJSONArray("y-confirmed").put(val + prev);
					}catch (JSONException err) {
						continue;
					}
				}
			}
			else if(status.equalsIgnoreCase("Recovered")) {
				Iterator<String> e = day.keys();
				while(e.hasNext()) {
					String code = e.next();
					int val = Integer.parseInt(day.getString(code));
					try {
						String state = state_mapping.getString(code);
						JSONArray c = trends.getJSONObject(state).getJSONArray("y-recovered");
						int prev;
						if(c.length() == 0)
							prev = 0;
						else
							prev = c.getInt(c.length() -1);
						trends.getJSONObject(state).getJSONArray("y-recovered").put(val + prev);
					}catch (JSONException err) {
						continue;
					}
				}
			}
			else if(status.equalsIgnoreCase("Deceased")) {
				Iterator<String> e = day.keys();
				while(e.hasNext()) {
					String code = e.next();
					int val = Integer.parseInt(day.getString(code));
					try {
						String state = state_mapping.getString(code);
						JSONArray d = trends.getJSONObject(state).getJSONArray("y-death");
						int prev;
						if(d.length() == 0)
							prev = 0;
						else
							prev = d.getInt(d.length() -1);
						trends.getJSONObject(state).getJSONArray("y-death").put(val + prev);
						int death = prev + val;
						JSONArray c = trends.getJSONObject(state).getJSONArray("y-confirmed");
						JSONArray r = trends.getJSONObject(state).getJSONArray("y-recovered");
						int confirmed = c.getInt(c.length() - 1);
						int recovered = r.getInt(r.length() - 1);
						trends.getJSONObject(state).getJSONArray("y-active").put((confirmed - recovered - death));
					}catch (JSONException err) {
						continue;
					}
				}
			}
		}
		return trends;
	}
}
