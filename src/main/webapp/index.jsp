<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  isELIgnored="false"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="en">

<head>
  <!-- India State Map  -->
  <title>India Map</title>

  <!-- CDN Links -->
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  	<link href="https://unpkg.com/tabulator-tables@4.6.2/dist/css/tabulator.min.css" rel="stylesheet">
	<script type="text/javascript" src="https://unpkg.com/tabulator-tables@4.6.2/dist/js/tabulator.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.6.0/leaflet.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.6.0/leaflet.js"></script>
  
  <!--  Styles  -->
  <link rel = "stylesheet" href = "<c:url value="/resources/css/index.css" />">
  
  <!-- Fonts -->
</head>

<body onload = "resizefunc()">
	<nav class="navbar navbar-dark bg-dark justify-content-between">
	  <a class="navbar-brand"><span style = "color: white">COVID-19 Analysis</span></a>
	  <form class="form-inline">
	    <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
	    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
	  </form>
	</nav>
	<div class = "row">
		<div class = "col-sm-6" id = "contentbox">
			
		</div>
		<div class = "col-sm-6" id = "mapbox">
			<div class = "container" style = "padding: 1%">
				<div id = "info">
					<h2 style = "font-family: archia">COVID-19 Cases</h2>
					<h2 style = "font-family: archia; font-size: 25px; padding: 1px; font-weight: bold" id = "stateid">Hover over a State</h2>
					<div class= "row">
						<div class = "col-sm-3">
							<div style = "opacity: 1; background-color: rgba(255,7,58,.12549); border-radius: 10px; ">
							    <h5 style = "font-family: archia; color: #800000; opacity: 1; text-align: center; font-weight: bold">Cases Confirmed: </h5>
							    <h5 id = "span-confirmed"  style = "font-family: archia; color: #800000; text-align: center;"></h5>
							</div>
						</div>
						<div class = "col-sm-3">
							<div style = "opacity: 1; background-color: rgba(0,123,255,.0627451); border-radius: 10px;">
							    <h5 style = "font-family: archia; color:#000066; text-align: center; font-weight: bold">Active Cases: </h5>
							    <h5 id = "span-active"  style = "font-family: archia; color: #000066; text-align: center;"></h5>
							</div>
						</div>
						<div class = "col-sm-3">
							<div style = "opacity: 1; background-color: rgba(40,167,69,.12549); border-radius: 10px;">
							    <h5 style = "font-family: archia; color: #006600; text-align: center; font-weight: bold">Recovered Cases: </h5>
							    <h5 id = "span-recovered"  style = "font-family: archia; color: #006600; text-align: center;"></h5>
							</div>
						</div>
						<div class = "col-sm-3">
							<div style = "opacity: 1; background-color: rgba(108,117,125,.0627451); border-radius: 10px;">
							    <h5 style = "font-family: archia; color: #333333; text-align: center; font-weight: bold">Death Cases: </h5>
							    <h5 id = "span-death"  style = "font-family: archia; color: #333333; text-align: center;"></h5>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id = "map"></div>
		</div>
	</div>
	<div class = "container">
		<div class = "row">
			<div class = "col-sm-6">
				<canvas id = "line-confirmed"></canvas>
			</div>
			<div class = "col-sm-6">
				<canvas id = "line-active"></canvas>
			</div>
		</div>
		<div class = "row">
			<div class = "col-sm-6">
				<canvas id = "line-recovered"></canvas>
			</div>
			<div class = "col-sm-6">
				<canvas id = "line-death"></canvas>
			</div>
		</div>
		<div class = "row">
			
		</div>
	</div>
	
	<div class = "container">
		<div id="covid-table"></div>
	</div>
	
	
  <script src="http://d3js.org/d3.v3.min.js"></script>
  <script src="http://d3js.org/topojson.v1.min.js"></script>
  <script src = "https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>
  <script src="<c:url value="/resources/js/d3.geo.min.js" />"></script>
  
  <script type="text/javascript">
  var tabledata = ${tableData} ;
  var table = new Tabulator("#covid-table", {
	  	height: 450,
	 	data:tabledata, 
	 	layout:"fitColumns", 
	 	columns:[ 
		 	{title:"State/UT", field:"state", hozAlign:"center"},
		 	{title:"Confirmed", field:"confirmed", hozAlign:"center"},
		 	{title:"Active", field:"active",hozAlign:"center"},
		 	{title:"Deaths", field:"deaths",hozAlign:"center"},
		 	{title:"Recovered", field:"recovered",hozAlign:"center"},
	 	]});
  </script>
	<script src="<c:url value="/resources/js/index.js" />"></script>
</body>
</html>