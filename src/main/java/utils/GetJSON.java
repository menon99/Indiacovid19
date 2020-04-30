package utils;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

import org.json.JSONArray;
import org.json.JSONObject;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class GetJSON {

	public CallbackFuture getResponse(String link) throws InterruptedException, ExecutionException, IOException {
		CallbackFuture future = new CallbackFuture();
		OkHttpClient client = new OkHttpClient();
		Request rq = new Request.Builder().url(link).build();
		client.newCall(rq).enqueue(future);
		return future;
	}

	private JSONObject getJSON(Response res) throws IOException {
		String responseBody = res.body().string();
		JSONObject j = new JSONObject(responseBody);
		return j;
	}
	
	private JSONArray getJSONArray(Response res) throws IOException {
		String responseBody = res.body().string();
		JSONArray j = new JSONArray(responseBody);
		return j;
	}

	public JSONObject getJSONAsync(CallbackFuture future) throws InterruptedException, ExecutionException {
		JSONObject j1 = (JSONObject) future.thenApply(res -> {
			try {
				return this.getJSON(res);
			} catch (IOException e) {
				e.printStackTrace();
			}
			return 0;
		}).get();
		return j1;
	}
	
	public JSONArray getJSONArrayAsync(CallbackFuture future) throws InterruptedException, ExecutionException {
		JSONArray j1 = (JSONArray) future.thenApply(res -> {
			try {
				return this.getJSONArray(res);
			} catch (IOException e) {
				e.printStackTrace();
			}
			return 0;
		}).get();
		return j1;
	}
}
