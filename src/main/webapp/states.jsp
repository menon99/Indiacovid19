<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  isELIgnored="false"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="en">

<head>
  <!-- India State Map  -->
  <title>Covid19 ${sname}</title>

  <!-- CDN Links -->
  	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  	<link href="https://unpkg.com/tabulator-tables@4.6.2/dist/css/tabulator.min.css" rel="stylesheet">
	<script type="text/javascript" src="https://unpkg.com/tabulator-tables@4.6.2/dist/js/tabulator.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.6.0/leaflet.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.6.0/leaflet.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Roboto+Slab&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@600&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
	<!-- Bootstrap core CSS -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">
	<!-- Material Design Bootstrap -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.16.0/css/mdb.min.css" rel="stylesheet">
	<!-- JQuery -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<!-- Bootstrap tooltips -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.min.js"></script>
	<!-- MDB core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.16.0/js/mdb.min.js"></script>
  
  <!--  Styles  -->
  <link rel = "stylesheet" href = "<c:url value="/resources/css/index.css" />">
  <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@600&display=swap" rel="stylesheet">
  
  <style>
  html,body{
  	width: 100%;
    margin: 0px;
    padding: 0px;
    overflow-x: hidden; 
  }
  	#covid-table{
	    background-color:#ccc;
	    border: none;
	    border-radius: 10px;
	}
  	/*Theme the header*/
	#covid-table .tabulator-header {
	    background-color:#ffffff;
	    color:#000;
	}
	
	.tabulator-col-title{
		text-align: center;
	}
	
	/*Allow column header names to wrap lines*/
	#covid-table .tabulator-header .tabulator-col,
	#covid-table .tabulator-header .tabulator-col-row-handle {
	    white-space: normal;
	}
	
	/*Color the table rows*/
	#covid-table .tabulator-tableHolder .tabulator-table .tabulator-row:nth-child(odd){
	    color:#fff;
	    background-color: #666;
	}
	
	#covid-table .tabulator-tableHolder .tabulator-table .tabulator-row:nth-child(odd):hover{
		color: white;
		opacity: 0.4;
		
	}
	
	/*Color even rows*/
	    #covid-table .tabulator-tableHolder .tabulator-table .tabulator-row:nth-child(even) {
	    color: #fff;
	    background-color: #444;
	}
	
	#covid-table .tabulator-tableHolder .tabulator-table .tabulator-row:nth-child(even):hover{
		color: white;
		opacity: 0.4;
		
	}
	
	#covid-table .tabulator-tableHolder .tabulator-table{
		padding-bottom: 0px;
	}
	
	.tabulator-col.tabulator-sortable, .tabulator-cell{
		border-radius:10px;
	}
	
	#confirmed-cases-block:hover,#active-cases-block:hover,#recovered-cases-block:hover,#death-cases-block:hover{
		cursor: pointer;
	}
	
  </style>
</head>

<body onload = "resizefunc()" onresize = "resizefunc()">
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	  <h2><a class="navbar-brand" href = "/home"><span style = "color: white; font-family: 'Source Sans Pro', sans-serif; font-size: 24px;">COVID-19 Analysis</span></a></h2>
	  <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navb">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	  <div class="collapse navbar-collapse" id="navb">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item">
	        <a class="nav-link" href="/about.jsp" style = "font-family: 'Source Sans Pro', sans-serif; font-size: 20px;">About Us</a>
	      </li>
	    </ul>
	  </div>
	</nav>
	<div class = "container-fluid" style="max-width:1420px">
		<div class = "row">
			<div class = "col-sm-6" id = "contentbox" style = "margin-top: 2%"> <!--  style = "margin-right: -5%; margin-left: 5%" -->
				<div id = "info" class = 'animated fadeInLeft'>
					<h1 id = "main-title" style = "font-family: 'Source Sans Pro', sans-serif; text-align: center; color: #3366ff ">${sname}</h1>
					<h2 style = "font-family: 'Source Sans Pro', sans-serif; font-size: 35px; padding: 2%; text-align: center;" id = "districtid">Hover over a District</h2>
					<div class= "row" style = "padding: 1%;">
						<div id = "confirmed-cases-block" class = "col-sm-4" style = "height: 100px; padding:1%; opacity: 1; background-color: rgba(255,7,58,.12549); border-radius: 10px;" onclick = "caseStatusUpdate('confirmed', this)">
						    <h5 id = "confirmed-cases-title" style = "margin-top: 3%; font-family: 'Source Sans Pro', sans-serif; color: #800000; opacity: 1; text-align: center; font-weight: bold; font-size: 23px;">Confirmed </h5>
						    <h5 id = "span-confirmed"  style = "font-family: 'Source Sans Pro', sans-serif; color: #800000; text-align: center; font-size: 26px;"></h5>
						</div>
						<div id = "active-cases-block" class = "col-sm-3" style = "height: 80px; padding:1%; opacity: 1; background-color: rgba(0,123,255,.0627451); border-radius: 10px;" onclick = "caseStatusUpdate('active', this)">
						    <h5 id = "active-cases-title" style = "font-family: 'Source Sans Pro', sans-serif; color:#000066; text-align: center; font-weight: bold; font-size: 22px;">Active </h5>
						    <h5 id = "span-active"  style = "font-family: 'Source Sans Pro', sans-serif; color: #000066; text-align: center; font-size: 26px;"></h5>
						</div>
						<div id = "recovered-cases-block" class = "col-sm-3" style = "height: 80px; padding:1%; opacity: 1; background-color: rgba(40,167,69,.12549); border-radius: 10px;" onclick = "caseStatusUpdate('recovered', this)">
						    <h5 id = "recovered-cases-title" style = "font-family: 'Source Sans Pro', sans-serif; color: #006600; text-align: center; font-weight: bold; font-size: 23px;">Recovered </h5>
						    <h5 id = "span-recovered"  style = "font-family: 'Source Sans Pro', sans-serif; color: #006600; text-align: center; font-size: 26px;"></h5>
						</div>
						<div id = "death-cases-block" class = "col-sm-2" style = "height: 80px; padding:1%; opacity: 1; background-color: rgba(108,117,125,.0627451); border-radius: 10px;" onclick = "caseStatusUpdate('death', this)">
						    <h5 id = "death-cases-title" style = "font-family: 'Source Sans Pro', sans-serif; color: #333333; text-align: center; font-weight: bold; font-size: 23px;">Death </h5>
						    <h5 id = "span-death"  style = "font-family: 'Source Sans Pro', sans-serif; color: #333333; text-align: center; font-size: 26px;"></h5>
						</div>
					</div>
				</div>
				<div class = "row animated fadeInLeft" style = "font-weight: 500; text-align: center; margin-top: 3%; margin-bottom:2%; font-family: 'Source Sans Pro', sans-serif;">
					<div class = "col-sm-2"></div>
					<div class = "col-sm-8">
						<button id = "containment-button" class = "btn btn-outline-danger" onclick = "caseStatusUpdate('containment',this)" style = "font-weight: 500;"><span style = "font-size: 20px;">View District Zones</span></button>
					</div>
					<div class = "col-sm-2"></div>
				</div>
				<div class = "row" id = "map-holder">
					<div class = "animated fadeInLeft" id = "map" style = "margin-top: 5%;"></div>
				</div>
				<div class = "row animated fadeInLeft" style = "margin-top: 5%; width: 90%; margin-left: 5%" id = "pie-chart">
					<canvas id = "pie-chart-cases"></canvas>
				</div>
			</div>
			<div class = "col-sm-6 animated fadeInRight" id = "mapbox" style = "margin-right: -20%"> <!--  style = "margin-left: -3%" -->
				<br>
				<div class = "row animated fadeInRight" id = "trend-chart-title">
					<div class = "col-sm-1"></div>
					<div class = "col-sm-10">
						<h1 style = "font-family: 'Source Sans Pro', sans-serif; text-align: center; color: #3366ff ">Trends - ${sname}</h1>
					</div>
					<div class = "col-sm-1"></div>
				</div>
				<div class = "row animated fadeInRight" style = "margin-top: 5%; width: 90%; margin-left: 5%" id = "line-confirmed-class">
					<canvas id = "line-confirmed"></canvas>
				</div>
				<div class = "row animated fadeInRight" style = "margin-top: 5%; width: 90%; margin-left: 5%" id = "line-active-class">
					<canvas id = "line-active"></canvas>
				</div>
				<div class = "row animated fadeInRight" style = "margin-top: 5%; width: 90%; margin-left: 5%" id = "line-recovered-class">
					<canvas id = "line-recovered"></canvas>
				</div>
				<div class = "row animated fadeInRight" style = "margin-top: 5%; width: 90%; margin-left: 5%" id = "line-death-class">
					<canvas id = "line-death"></canvas>
				</div>
				<div class = "row animated fadeInRight" style = "font-family: 'Source Sans Pro', sans-serif; margin-left: 2%; margin-top: 3%" id = "timeline-charts">
					<div class = "col-sm-3">
						<button class = "btn btn-primary waves-effect waves-light" onclick = "check('beginning')" id = "beginning">Start</button>
					</div>
					<div class = "col-sm-3">
						<button class = "btn btn-outline-primary waves-effect waves-light" onclick = "check('1-month')" id = "1-month">1Month</button>
					</div>
					<div class = "col-sm-3">
						<button class = "btn btn-outline-primary waves-effect waves-light" onclick = "check('2-weeks')" id = "2-weeks">2Weeks</button>
					</div>
					<div class = "col-sm-3">
						<button class = "btn btn-outline-primary waves-effect waves-light" onclick = "check('1-week')" id = "1-week">1Week</button>
					</div>	
				</div>
			</div>
		</div>
		<div class = "row" style = "margin-left: 16%;" id = "table-content">
			<div class = "row animated fadeInLeft" style = "margin-top: 5%; margin-left: 15%">
				<div class = "col-sm-3" style = "opacity: 1; border-radius: 10px;">
				    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #800000; opacity: 1; text-align: center; font-weight: bold; font-size: 23px;">Confirmed </h5>
				    <h5 id = "span-static-confirmed"  style = "font-family: 'Source Sans Pro', sans-serif; color: #800000; text-align: center; font-size: 26px;"></h5>
				</div>
				<div class = "col-sm-3" style = "opacity: 1; border-radius: 10px; transform: translate(30%,0)">
				    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color:#000066; text-align: center; font-weight: bold; font-size: 22px;">Active </h5>
				    <h5 id = "span-static-active"  style = "font-family: 'Source Sans Pro', sans-serif; color: #000066; text-align: center; font-size: 26px;"></h5>
				</div>
				<div class = "col-sm-3" style = "opacity: 1; border-radius: 10px; transform: translate(30%,0)">
				    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #006600; text-align: center; font-weight: bold; font-size: 23px;">Recovered </h5>
				    <h5 id = "span-static-recovered"  style = "font-family: 'Source Sans Pro', sans-serif; color: #006600; text-align: center; font-size: 26px;"></h5>
				</div>
				<div class = "col-sm-3" style = "opacity: 1; border-radius: 10px; transform: translate(30%,0)">
				    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #333333; text-align: center; font-weight: bold; font-size: 23px;">Death </h5>
				    <h5 id = "span-static-death"  style = "font-family: 'Source Sans Pro', sans-serif; color: #333333; text-align: center; font-size: 26px;"></h5>
				</div>
			</div>
			<div class = "row animated fadeInLeft" style = "margin-top: 2%; margin-left: 15%">
				<div class = "col-sm-12" id = "cd">
					<div class = "animated fadeInLeft" id="covid-table" style = "margin-left: 0%; font-size: 20px; margin-top: 2%; font-family: 'Source Sans Pro', sans-serif; width: fit-content; height: fit-content;"></div>
				</div>
			</div>
		</div>
		<div class = "row" style = "margin-top:3%;">
			<div class = "col-sm-3"></div>
			<div class = "col-sm-6">
				<h1 class = "animate bounceIn" style = "font-family: 'Source Sans Pro', sans-serif; text-align: center;" id = "analysis-title">Analysis and Forecasts</h1>
			</div>
			<div class = "col-sm-3"></div>
		</div>
		<div class = "row" id = "analysis-sub-title" style = "margin-top: 1%;">
			<div class = "col-sm-4"></div>
			<div class = "col-sm-4">
				<h2 class = "animate slideInRight" style = "font-family: 'Source Sans Pro', sans-serif; text-align: center;">Growth Rate</h2>
			</div>
			<div class = "col-sm-4"></div>
		</div>
		<div class = "row animate slideInRight" style = "margin-top: 3%; width: 100%; margin-left: 4%; margin-top: 1%; text-align: center;">
			<div class = "animate slideInLeft" style = " background-color: rgba(0,123,255,.0627451); margin-right: 2%; border-radius: 10px; width: 30%;">
				<h3 style = "font-family: 'Source Sans Pro', sans-serif;">Before Lockdown on 24th March:</h3>
				<h2 style = "font-family: 'Source Sans Pro', sans-serif; " id = "g1-value"></h2>
			</div>
			<div class = "animate slideInUp" style = "background-color: rgba(108,117,125,.0627451); margin-right: 2%; border-radius: 10px; width: 30%">
				<h3 style = "font-family: 'Source Sans Pro', sans-serif; ">Before Lockdown on 14th April:</h3>
				<h2 style = "font-family: 'Source Sans Pro', sans-serif; " id = "g2-value"></h2>
			</div>
			<div class = "animate slideInRight" style = "background-color: rgba(40,167,69,.12549); margin-right: 2%; border-radius: 10px; width: 30%">
				<h3 style = "font-family: 'Source Sans Pro', sans-serif; ">Current Growth:</h3>
				<h2 style = "font-family: 'Source Sans Pro', sans-serif; " id = "current-value"></h2>
			</div>
		</div>
		<div class = "row animate slideInRight" style = "margin-top: 3%">
			<div class = "col-sm-4"></div>
			<div class = "col-sm-4">
				<h3 class = "animate slideInRight" style = "font-family: 'Source Sans Pro', sans-serif; text-align: center;" id = "arima-graph-title">ARIMA Predictions</h3>
			</div>
			<div class = "col-sm-4"></div>
		</div>
		<canvas id = "arima-graph" class = "animate slideInRight"></canvas>
		<div class = "row aniimate slideInRight" style = "margin-top: 3%;">
			<div class = "col-sm-4"></div>
			<div class = "col-sm-4">
				<h3 style = "font-family: 'Source Sans Pro', sans-serif; text-align: center" id = "line-area-title">Real-time R0</h3>
			</div>
			<div class = "col-sm-4"></div>
		</div>
		<div class = "row" style = "width: 90%; margin-left: 4%; margin-top: 3%">
			<div class = "col-sm-12" style = "width: 100%;">
				<canvas id = "line-area-graph" height = '500'></canvas>
			</div>
			<div id = "custom-legend" class = "row" style = "font-family: 'Source Sans Pro', sans-serif; transform: translate(800%,-555%); width: 10%; margin-top: 2%; margin-bottom: 1%">
				<div style = "margin-right: 5%">
					<div style = "width: 20px; height: 20px; background-color: #ff3333;"></div><div style = "margin-top: -23px; margin-left: 30px">1.5+</div>
				</div>
				<div style = "margin-right: 5%">
					<div style = "width: 20px; height: 20px; background-color: #ff6666;"></div><div style = "margin-top: -23px; margin-left: 30px">1.5-1</div>
				</div>
				<div style = "margin-right: 5%">
					<div style = "width: 20px; height: 20px; background-color: #ff9999;"></div><div style = "margin-top: -23px; margin-left: 30px">1-0.5</div>
				</div>
				<div style = "margin-right: 5%">
					<div style = "width: 20px; height: 20px; background-color: #ffcccc;"></div><div style = "margin-top: -23px; margin-left: 30px">0.5-0</div>
				</div>
			</div>
		</div>
	</div>
  <script src = "https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script type="text/javascript">
  var tabledata = ${tabledata} ;
  var json = ${stateCoords};
  var state_name = '${sname}';
  $("#map-title").html = state_name+" Map";
  var table = new Tabulator("#covid-table", {
	  	height: false,
	 	data:tabledata.slice(0,tabledata.length-1), 
	 	movableColumns:false,
	 	responsiveLayout:false,
	 	layout:"fitDataFill", 
	 	columns:[ 
		 	{title:"District", field:"district", hozAlign:"center"},
		 	{title:"Confirmed", field:"confirmed", hozAlign:"center"},
		 	{title:"Active", field:"active",hozAlign:"center"},
		 	{title:"Deaths", field:"deceased",hozAlign:"center"},
		 	{title:"Recovered", field:"recovered",hozAlign:"center"},
		 	{title:"Zone", field:"zone",hozAlign:"center",width:100},
	 	],
	 	rowClick: (e,row) => {
	 		 document.getElementById("pie-chart").innerHTML = "";
	  	     document.getElementById("pie-chart").innerHTML = "<canvas id = 'pie-chart-cases'></canvas>";
	  	   	 pieChart(row._row.data.district,[]);
	  	   $('html, body').animate({
		         scrollTop: $("#pie-chart").offset().top
		     }, 1000);
	 	},
	 	rowTap: (e, row) => {
	 		e.preventDefault();
	 	}
	 	});
  	document.getElementById("span-static-confirmed").innerHTML = tabledata[tabledata.length-1]['confirmed']==null?0:tabledata[tabledata.length-1]['confirmed'];
	document.getElementById("span-static-active").innerHTML = tabledata[tabledata.length-1]['active']==null?0:tabledata[tabledata.length-1]['active'];
	document.getElementById("span-static-recovered").innerHTML = tabledata[tabledata.length-1]['recovered']==null?0:tabledata[tabledata.length-1]['recovered'];
	document.getElementById("span-static-death").innerHTML = tabledata[tabledata.length-1]['deceased']==null?0:tabledata[tabledata.length-1]['deceased'];
	document.getElementById("span-confirmed").innerHTML = tabledata[tabledata.length-1]['confirmed']==null?0:tabledata[tabledata.length-1]['confirmed'];
	document.getElementById("span-active").innerHTML = tabledata[tabledata.length-1]['active']==null?0:tabledata[tabledata.length-1]['active'];
	document.getElementById("span-recovered").innerHTML = tabledata[tabledata.length-1]['recovered']==null?0:tabledata[tabledata.length-1]['recovered'];
	document.getElementById("span-death").innerHTML = tabledata[tabledata.length-1]['deceased']==null?0:tabledata[tabledata.length-1]['deceased'];
  	
  	var status = "beginning";
  	var data_cases = ${trends};
  	lineChart(data_cases);
  	var state_coords_zoom = {
 		   "Andaman and Nicobar Islands" : {
 			    "coords": [10.498614480162155,92.548828125],
 			    "zoom": 7
 			    },
 			"Andhra Pradesh" : {
 			    "coords": [15.982453522973508,81],
 			    "zoom": 6
 			    },
 			"Arunachal Pradesh" : {
 			    "coords": [28.14950321154457,95.185546875],
 			    "zoom": 7
 			    },
 			"Assam" : {
 			    "coords": [25.8,93.01025390625],
 			    "zoom": 7
 			    },
 			"Bihar" : {
 			    "coords": [25.849336891707605,86.06689453125],
 			    "zoom": 7
 			    },
 			"Chandigarh" : {
 			    "coords": [30.730031843442763,76.77932739257812],
 			    "zoom": 12
 			    },
 			"Chhattisgarh" : {
 			    "coords": [21,83.0458984375],
 			    "zoom": 7
 			    },
 			"Dadra and Nagar Haveli" : {
 			    "coords": [20.188746184002486,73.0810546875],
 			    "zoom": 12
 			    },
 			"Delhi" : {
 			    "coords": [28.65323575209858,77.1295166015625],
 			    "zoom": 10
 			    },
 			"Goa" : {
 			    "coords": [15.343788940043282,74.04098510742188],
 			    "zoom": 10
 			    },
 			"Gujarat" : {
 			    "coords": [21.857194700969636,71.54609375],
 			    "zoom": 7
 			    },
 			"Haryana" : {
 			    "coords": [29.084976575985912,76.387939453125],
 			    "zoom": 8
 			    },
 			"Himachal Pradesh" : {
 			    "coords": [32.091882620021806,77.266845703125],
 			    "zoom": 7
 			    },
 			"Jammu and Kashmir" : {
 			    "coords": [33.687781758439364,74.87182617187499],
 			    "zoom": 7
 			    },
 			"Jharkhand" : {
 			    "coords": [23.53377298325595,85.660400390625],
 			    "zoom": 7
 			    },
 			"Karnataka" : {
 			    "coords": [14.836738848907621,76.53076171875],
 			    "zoom": 7
 			    },
 			"Kerala" : {
 			    "coords": [9.784851250750604,76.75048828125],
 			    "zoom": 7
 			    },
 			"Ladakh" : {
 			    "coords": [34.27083595165,76.7724609375],
 			    "zoom": 7
 			    },
 			"Lakshadweep" : {
 			    "coords": [10.784851250750604,73.004150390625],
 			    "zoom": 9
 			    },
 			"Madhya Pradesh" : {
 			    "coords": [23.23377298325595,78.211669921875],
 			    "zoom": 6.5
 			    },
 			"Maharashtra" : {
 			    "coords": [19.145168196205297,77],
 			    "zoom": 6
 			    },
 			"Manipur" : {
 			    "coords": [24.8,93.91113281249999],
 			    "zoom": 9
 			    },
 			"Meghalaya" : {
 			    "coords": [25.48295117535531,91.5],
 			    "zoom": 8
 			    },
 			"Mizoram" : {
 			    "coords": [23.33216830631147,92.83447265624999],
 			    "zoom": 8
 			    },
 			"Nagaland" : {
 			    "coords": [26.244156283890756,94.58129882812499],
 			    "zoom": 8
 			    },
 			"Odisha" : {
 			    "coords": [20.324023603422518,84.803466796875],
 			    "zoom": 7
 			    },
 			"Puducherry" : {
 			    "coords": [11.361567960696178,79.771728515625],
 			    "zoom": 9
 			    },
 			"Punjab" : {
 			    "coords": [30.9,75.531005859375],
 			    "zoom": 8
 			    },
 			"Rajasthan" : {
 			    "coords": [26.667095801104814,74.168701171875],
 			    "zoom": 6
 			    },
 			"Sikkim" : {
 			    "coords": [27.595934774495056,88.48388671874999],
 			    "zoom": 9
 			    },
 			"Tamil Nadu" : {
 			    "coords": [10.5,78.67],
 			    "zoom": 7,
 			    },
 			"Telangana" : {
 			    "coords": [17.936928637549443,79.1015625],
 			    "zoom": 7
 			    },
 			"Tripura" : {
 			    "coords": [23.71998271844965,91.77703857421875],
 			    "zoom": 9
 			    },
 			"Uttarakhand" : {
 			    "coords": [30.240086360983426,79.22241210937499],
 			    "zoom": 8
 			    },
 			"Uttar Pradesh" : {
 			    "coords": [26.88288045572338,80.74951171875],
 			    "zoom": 6.5
 			    },
 			"West Bengal" : {
 			    "coords": [23.8,88.077392578125],
 			    "zoom": 7
 			    },
 			}
  	
  	var coords = state_coords_zoom[state_name]['coords'];
  	var zoom = state_coords_zoom[state_name]['zoom'];
  	var case_status = "confirmed";
  	var map = L.map('map',{
    	   center:coords, 
    	   zoom:zoom, 
    	   zoomSnap: 0.25,
    	   scrollWheelZoom: false
    	   });
  	var geojson = L.geoJson(json, {
        style: style,
        onEachFeature: onEachFeature
    });
    geojson.addTo(map);
    var legend = L.control({position: 'bottomright'});
  	
  	const getPieData  = (num) =>{
		
		let l = data_cases["y-confirmed"].length;
		let A = data_cases["y-confirmed"][l-1];
		let B = 0;
		if(num != 0)
			B = data_cases["y-confirmed"][l - num];
		const confirmed = A - B;
		l = data_cases["y-active"].length;
		A = data_cases["y-active"][l-1];
		if (num == 0)
			B = 0;
		else
			B = data_cases["y-active"][l - num];
		const active = A - B;
		l = data_cases["y-recovered"].length;
		A = data_cases["y-recovered"][l-1];
		if (num == 0)
			B = 0;
		else
			B = data_cases["y-recovered"][l - num];
		const recovered = A - B;
		l = data_cases["y-death"].length;
		A = data_cases["y-death"][l-1];
		if (num == 0)
			B = 0;
		else
			B = data_cases["y-death"][l - num];
		const death = A - B;
		return [confirmed,active,recovered,death]; 
	}
  	var dataset_val;
  	function check(e){
  		status = e;
  		if(e == 'beginning'){
            document.getElementById('1-week').removeAttribute('class');
            document.getElementById('1-week').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('2-weeks').removeAttribute('class');
            document.getElementById('2-weeks').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('1-month').removeAttribute('class');
            document.getElementById('1-month').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('beginning').removeAttribute('class');
            document.getElementById('beginning').setAttribute("class","btn btn-primary waves-effect waves-light");
            dataset_val = getPieData(0);
        }
        else if(e == '1-month'){
            document.getElementById('beginning').removeAttribute('class');
            document.getElementById('beginning').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('2-weeks').removeAttribute('class');
            document.getElementById('2-weeks').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('1-week').removeAttribute('class');
            document.getElementById('1-week').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('1-month').removeAttribute('class');
            document.getElementById('1-month').setAttribute("class","btn btn-primary waves-effect waves-light");
            dataset_val = getPieData(30);
        }
        else if(e == '1-week'){
            document.getElementById('beginning').removeAttribute('class');
            document.getElementById('beginning').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('2-weeks').removeAttribute('class');
            document.getElementById('2-weeks').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('1-month').removeAttribute('class');
            document.getElementById('1-month').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('1-week').removeAttribute('class');
            document.getElementById('1-week').setAttribute("class","btn btn-primary waves-effect waves-light");
            dataset_val = getPieData(7);
        }
        else if(e == '2-weeks'){
            document.getElementById('beginning').removeAttribute('class');
            document.getElementById('beginning').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('1-week').removeAttribute('class');
            document.getElementById('1-week').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('1-month').removeAttribute('class');
            document.getElementById('1-month').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('2-weeks').removeAttribute('class');
            document.getElementById('2-weeks').setAttribute("class","btn btn-primary waves-effect waves-light");
            dataset_val = getPieData(14);
        }
  		document.getElementById("line-confirmed-class").innerHTML = "";
  	     document.getElementById("line-confirmed-class").innerHTML = "<canvas id = 'line-confirmed'></canvas>";
  	     document.getElementById("line-active-class").innerHTML = "";
  	     document.getElementById("line-active-class").innerHTML = "<canvas id = 'line-active'></canvas>";
  	     document.getElementById("line-recovered-class").innerHTML = "";
  	     document.getElementById("line-recovered-class").innerHTML = "<canvas id = 'line-recovered'></canvas>";
  	     document.getElementById("line-death-class").innerHTML = "";
  	     document.getElementById("line-death-class").innerHTML = "<canvas id = 'line-death'></canvas>";
  	   document.getElementById("pie-chart").innerHTML = "";
	     document.getElementById("pie-chart").innerHTML = "<canvas id = 'pie-chart-cases'></canvas>";
  		lineChart(data_cases);
  		pieChart(state_name,dataset_val);
   	}
  	
  	map.dragging.disable();
  	function resizefunc(){
        if(screen.width<900){
            document.getElementById("contentbox").removeAttribute("class");
            document.getElementById("mapbox").removeAttribute("class");
            document.getElementById("contentbox").setAttribute("class","col-sm-12");
            document.getElementById("mapbox").setAttribute("class","col-sm-12");
            document.getElementById("mapbox").style.marginTop = "7%";
            document.getElementById("map").style.marginLeft = "0%";
            document.getElementById("map").width = "100%";
            document.getElementById("main-title").style.textAlign = 'center';
            document.getElementById("table-content").style.marginLeft = "0";
            document.getElementById("contentbox").removeAttribute("style");
            document.getElementById("covid-table").style.marginLeft = "-5%";
            //document.getElementById("timeline-charts").removeAttribute("style");
            //document.getElementById("timeline-charts").style.marginTop = "3%";
            //document.getElementById("timeline-charts").style.marginLeft = "35%";
            //document.getElementById("timeline-charts").style.transform = "translate(52%,0)";
            //document.getElementById("1-week").style.marginLeft = "35%";
            document.getElementsByClassName("leaflet-bottom leaflet-right")[0].style.marginRight = "5%";
            document.getElementsByClassName("info legend leaflet-control")[0].style.width = "110%";
            document.getElementsByClassName("info legend leaflet-control")[0].style.fontSize = "16px";
            //document.getElementById("analysis-title").style.transform = "translate(50%,0)";
            //document.getElementById("analysis-sub-title").style.transform = "translate(-30%, 0)";
            //document.getElementById("analysis-sub-title").style.marginTop = '7%';
            //document.getElementById("arima-graph-title").style.transform = "translate(100%,0)";
            //document.getElementById("line-area-title").style.transform = "translate(150%,0)";
            document.getElementById("custom-legend").style.width = "11%";
            document.getElementById("custom-legend").style.marginTop = "5%";
            //document.getElementById("line-area-graph").style.width = "130%";
            //document.getElementById("line-area-graph").style.marginLeft = "-15%";
        }
    }
  
  	function caseStatusUpdate(e,f){
   	 document.getElementById("map-holder").innerHTML = "";
   	 document.getElementById("map-holder").innerHTML = '<div class = "animated fadeInLeft" id = "map" style = "margin-top: 5%;"></div>';
   	 if(screen.width<900){
   		 document.getElementById("map").style.marginLeft = "5%";
   	 }
   	 case_status = e;
   	 if(e == "confirmed"){
  		 	f.setAttribute("class","col-sm-4");
  		 	f.style.height = '100px';
  		 	document.getElementById("confirmed-cases-title").style.marginTop = "3%";
	   		document.getElementById("active-cases-title").style.marginTop = "0%";
  			document.getElementById("recovered-cases-title").style.marginTop = "0%";
  			document.getElementById("death-cases-title").style.marginTop = "0%";
  		 	document.getElementById("active-cases-block").style.height = "80px";
  		 	document.getElementById("recovered-cases-block").style.height = "80px";
  		 	document.getElementById("death-cases-block").style.height = "80px";
  		 	document.getElementById("active-cases-block").setAttribute("class","col-sm-3");
			document.getElementById("recovered-cases-block").setAttribute("class","col-sm-3");
			document.getElementById("death-cases-block").setAttribute("class","col-sm-2");
			document.getElementById("containment-button").setAttribute("class","btn btn-outline-danger");
  		}
  		else if(e == "active"){
  			f.setAttribute("class","col-sm-4");
  			f.style.height = '100px';
  		 	document.getElementById("active-cases-title").style.marginTop = "3%";
  		 	document.getElementById("recovered-cases-title").style.marginTop = "0%";
  			document.getElementById("confirmed-cases-title").style.marginTop = "0%";
  			document.getElementById("death-cases-title").style.marginTop = "0%";
  		 	document.getElementById("confirmed-cases-block").style.height = "80px";
  		 	document.getElementById("recovered-cases-block").style.height = "80px";
  		 	document.getElementById("death-cases-block").style.height = "80px";
     		document.getElementById("confirmed-cases-block").setAttribute("class","col-sm-3");
  			document.getElementById("recovered-cases-block").setAttribute("class","col-sm-3");
  			document.getElementById("death-cases-block").setAttribute("class","col-sm-2");
  			document.getElementById("containment-button").setAttribute("class","btn btn-outline-danger");
  		}
  		else if(e == "recovered"){
  			f.setAttribute("class","col-sm-4");
  			f.style.height = '100px';
  		 	document.getElementById("recovered-cases-title").style.marginTop = "3%";
  		 	document.getElementById("active-cases-title").style.marginTop = "0%";
  			document.getElementById("confirmed-cases-title").style.marginTop = "0%";
  			document.getElementById("death-cases-title").style.marginTop = "0%";
  		 	document.getElementById("active-cases-block").style.height = "80px";
  		 	document.getElementById("confirmed-cases-block").style.height = "80px";
  		 	document.getElementById("death-cases-block").style.height = "80px";
  		 	document.getElementById("active-cases-block").setAttribute("class","col-sm-3");
			document.getElementById("confirmed-cases-block").setAttribute("class","col-sm-3");
			document.getElementById("death-cases-block").setAttribute("class","col-sm-2");
			document.getElementById("containment-button").setAttribute("class","btn btn-outline-danger");
  		}
  		else if(e == "death"){
  			f.setAttribute("class","col-sm-3");
  			f.style.height = '100px';
  		 	document.getElementById("death-cases-title").style.marginTop = "3%";
  		 	document.getElementById("active-cases-title").style.marginTop = "0%";
  			document.getElementById("confirmed-cases-title").style.marginTop = "0%";
  			document.getElementById("recovered-cases-title").style.marginTop = "0%";
  			document.getElementById("active-cases-block").style.height = "80px";
  		 	document.getElementById("confirmed-cases-block").style.height = "80px";
  		 	document.getElementById("recovered-cases-block").style.height = "80px";
  			document.getElementById("active-cases-block").setAttribute("class","col-sm-3");
  			document.getElementById("confirmed-cases-block").setAttribute("class","col-sm-3");
  			document.getElementById("recovered-cases-block").setAttribute("class","col-sm-3");
  			document.getElementById("containment-button").setAttribute("class","btn btn-outline-danger");
  		}
  		else if(e == "containment"){
  			document.getElementById("active-cases-title").style.marginTop = "0%";
  		 	document.getElementById("recovered-cases-title").style.marginTop = "0%";
  			document.getElementById("confirmed-cases-title").style.marginTop = "0%";
  			document.getElementById("death-cases-title").style.marginTop = "0%";
  		 	document.getElementById("confirmed-cases-block").style.height = "80px";
  		 	document.getElementById("active-cases-block").style.height = "80px";
  		 	document.getElementById("recovered-cases-block").style.height = "80px";
  		 	document.getElementById("death-cases-block").style.height = "80px";
     		document.getElementById("confirmed-cases-block").setAttribute("class","col-sm-3");
  			document.getElementById("recovered-cases-block").setAttribute("class","col-sm-3");
  			document.getElementById("death-cases-block").setAttribute("class","col-sm-3");
  			f.setAttribute("class","btn btn-danger");
  		}
   	 map = L.map('map',{
   	  	   center:coords,
   	  	   zoomSnap: 0.25,
   	  	   zoom:zoom, 
   	  	   scrollWheelZoom: false
   	  	   });
   	 geojson =  L.geoJson(json, {
            style: style,
            onEachFeature: onEachFeature
        });
        geojson.addTo(map);
        map.dragging.disable();
        legend.onAdd = function (map) {
    		if(case_status == "confirmed"){
        	 var max_confirmed=0;
        	 for(i in tabledata.slice(1,tabledata.length)){
        		 if(max_confirmed<parseInt(tabledata[i].confirmed))
        			 max_confirmed = parseInt(tabledata[i].confirmed);
        	 }
        	 var x = Math.log10(max_confirmed);
        	 x=parseInt(x);
        	 var y=5**x;
             var div = L.DomUtil.create('div', 'info legend'),
                 grades = [0, y, 2*y, 3*y, 4*y, 5*y, 6*y, 7*y],
                 labels = [];

             // loop through our density intervals and generate a label with a colored square for each interval
             for (var i = 0; i < grades.length; i++) {
                 div.innerHTML +=
                     '<i style="background:' + getColor(grades[i] + 1) + '"></i> ' +
                     grades[i] + (grades[i + 1] ? '&ndash;' + grades[i + 1] + '<br><br>' : '+');
             }
    		}
    		else if(case_status == "active"){
    			var max_confirmed=0;
    	    	 for(i in tabledata.slice(1,tabledata.length)){
    	    		 if(max_confirmed<parseInt(tabledata[i].active))
    	    			 max_confirmed = parseInt(tabledata[i].active);
    	    	 }
    	    	 var x = Math.log10(max_confirmed);
    	    	 x=parseInt(x);
    	    	 var y=Math.round(4.5**x);
    	         var div = L.DomUtil.create('div', 'info legend'),
    	             grades = [0, y, 2*y, 3*y, 4*y, 5*y, 6*y, 7*y],
    	             labels = [];

    	         // loop through our density intervals and generate a label with a colored square for each interval
    	         for (var i = 0; i < grades.length; i++) {
    	             div.innerHTML +=
    	                 '<i style="background:' + getColor(grades[i] + 1) + '"></i> ' +
    	                 grades[i] + (grades[i + 1] ? '&ndash;' + grades[i + 1] + '<br><br>' : '+');
    	         }
    		}
    		else if(case_status == "recovered"){
    			var max_confirmed=0;
    	    	 for(i in tabledata.slice(1,tabledata.length)){
    	    		 if(max_confirmed<parseInt(tabledata[i].recovered))
    	    			 max_confirmed = parseInt(tabledata[i].recovered);
    	    	 }
    	    	 var x = Math.log10(max_confirmed);
    	    	 x=parseInt(x);
    	    	 var y=5**x;
    	         var div = L.DomUtil.create('div', 'info legend'),
    	             grades = [0, y, 2*y, 3*y, 4*y, 5*y, 6*y, 7*y],
    	             labels = [];

    	         // loop through our density intervals and generate a label with a colored square for each interval
    	         for (var i = 0; i < grades.length; i++) {
    	             div.innerHTML +=
    	                 '<i style="background:' + getColor(grades[i] + 1) + '"></i> ' +
    	                 grades[i] + (grades[i + 1] ? '&ndash;' + grades[i + 1] + '<br><br>' : '+');
    	         }
    		}
    		else if(case_status == "death"){
    			var max_confirmed=0;
    	    	 for(i in tabledata.slice(1,tabledata.length)){
    	    		 if(max_confirmed<parseInt(tabledata[i].deceased))
    	    			 max_confirmed = parseInt(tabledata[i].deceased);
    	    	 }
    	    	 var x = Math.log10(max_confirmed);
    	    	 x=parseInt(x);
    	    	 var y=3**x;
    	         var div = L.DomUtil.create('div', 'info legend'),
    	             grades = [0, y, 2*y, 3*y, 4*y, 5*y, 6*y, 7*y],
    	             labels = [];

    	         // loop through our density intervals and generate a label with a colored square for each interval
    	         for (var i = 0; i < grades.length; i++) {
    	             div.innerHTML +=
    	                 '<i style="background:' + getColor(grades[i] + 1) + '"></i> ' +
    	                 grades[i] + (grades[i + 1] ? '&ndash;' + grades[i + 1] + '<br><br>' : '+');
    	         }
    		}
    		else if(case_status == "containment"){
    			var div = L.DomUtil.create('div', 'info legend'),
	             grades = [],
	             labels = ['Green','Orange','Red'];

	         // loop through our density intervals and generate a label with a colored square for each interval
	         for (var i = 0; i < grades.length; i++) {
	             div.innerHTML +=
	                 '<i style="background:' + getColor(grades[i] + 1) + '"></i> ' +
	                 grades[i] + (grades[i + 1] ? '&ndash;' + grades[i + 1] + '<br><br>' : '+');
	         }
    		}

             return div;
         };
         legend.addTo(map);
         if(screen.width<900){
        	 document.getElementsByClassName("leaflet-bottom leaflet-right")[0].style.marginRight = "5%";
         }
    } 
  	
  	//getting the color values for filling the map
     function getColor(d) {
    	 if(case_status == "confirmed"){
	    	 var max_confirmed=0;
	    	 for(i in tabledata.slice(0,tabledata.length-1)){
	    		 if(max_confirmed<parseInt(tabledata[i].confirmed))
	    			 max_confirmed = parseInt(tabledata[i].confirmed);
	    	 }
	    	 
	    	 var x = Math.log10(max_confirmed);
	    	 x=parseInt(x);
	    	 var y=5**x;
	    	 
	         return d > 7*y ? '#800026' :
	             d > 6*y  ? '#BD0026' :
	             d > 5*y  ? '#E31A1C' :
	             d > 4*y  ? '#FC4E2A' :
	             d > 3*y   ? '#FD8D3C' :
	             d > 2*y   ? '#FEB24C' :
	             d > y  ? '#FED976' :
	                         '#FFEDA0';
    	 }
    	 else if(case_status == "active"){
    		 var max_confirmed=0;
	    	 for(i in tabledata.slice(0,tabledata.length-1)){
	    		 if(max_confirmed<parseInt(tabledata[i].active))
	    			 max_confirmed = parseInt(tabledata[i].active);
	    	 }
	    	 
	    	 var x = Math.log10(max_confirmed);
	    	 x=parseInt(x);
	    	 var y=Math.round(4.5**x);
	    	 
	         return d > 7*y ? '#000066' :
	             d > 6*y  ? '#000099' :
	             d > 5*y  ? '#0000b3' :
	             d > 4*y  ? '#0000e6' :
	             d > 3*y   ? '#1a1aff' :
	             d > 2*y   ? '#4d4dff' :
	             d > y  ? '#8080ff' :
	                         '#b3b3ff';
    	 }
    	 else if(case_status == "recovered"){
    		 var max_confirmed=0;
	    	 for(i in tabledata.slice(0,tabledata.length-1)){
	    		 if(max_confirmed<parseInt(tabledata[i].recovered))
	    			 max_confirmed = parseInt(tabledata[i].recovered);
	    	 }
	    	 
	    	 var x = Math.log10(max_confirmed);
	    	 x=parseInt(x);
	    	 var y=5**x;
	    	 
	         return d > 7*y ? '#194d19' :
	             d > 6*y  ? '#267326' :
	             d > 5*y  ? '#339933' :
	             d > 4*y  ? '#40bf40' :
	             d > 3*y   ? '#66cc66' :
	             d > 2*y   ? '#8cd98c' :
	             d > y  ? '#b3e6b3' :
	                         '#d9f2d9';
    	 }
    	 else if(case_status == "death"){
    		 var max_confirmed=0;
	    	 for(i in tabledata.slice(0,tabledata.length-1)){
	    		 if(max_confirmed<parseInt(tabledata[i].deceased))
	    			 max_confirmed = parseInt(tabledata[i].deceased);
	    	 }
	    	 
	    	 var x = Math.log10(max_confirmed);
	    	 x=parseInt(x);
	    	 var y=3**x;
	    	 
	         return d > 7*y ? '#404040' :
	             d > 6*y  ? '#595959' :
	             d > 5*y  ? '#737373' :
	             d > 4*y  ? '#8c8c8c' :
	             d > 3*y   ? '#a6a6a6' :
	             d > 2*y   ? '#bfbfbf' :
	             d > y  ? '#d9d9d9' :
	                         '#f2f2f2';
    	 }
    	 else if(case_status == "containment"){
    		 if(d == "Orange")
    			 return '#FF9933';
    		 else if(d == "Red")
    			 return "#DC143C";
    		 else
    			 return "#228B22";
    	 }
     }

     //styling map
     function style(features) {
    	 var color;
    	 var opacity = 0.7;
    	 if(case_status == "confirmed"){
    		 for(i in tabledata){
        		 if(tabledata[i].district == features.properties.district){
        	 		color = parseInt(tabledata[i].confirmed);
        		 }
        	 }
    	 }
    	 else if(case_status == "active"){
    		 for(i in tabledata){
        		 if(tabledata[i].district == features.properties.district){
        	 		color = parseInt(tabledata[i].active);
        		 }
        	 }
    	 }
    	 else if(case_status == "recovered"){
    		 for(i in tabledata){
        		 if(tabledata[i].district == features.properties.district){
        	 		color = parseInt(tabledata[i].recovered);
        		 }
        	 }
    	 }
    	 else if(case_status == "death"){
    		 for(i in tabledata){
        		 if(tabledata[i].district == features.properties.district){
        	 		color = parseInt(tabledata[i].deceased);
        		 }
        	 }
    	 }
    	 else if(case_status == "containment"){
    		 for(i in tabledata){
        		 if(tabledata[i].district == features.properties.district){
        	 		color = tabledata[i].zone;
        		 }
        	 }
    		 opacity = 1;
    	 }
         return {
             fillColor: getColor(color),
             weight: 2,
             opacity: 1,
             color: 'white',
             dashArray: '3',
             fillOpacity: opacity
         };
     }
	
     //highlighting the features in map
     function highlightFeature(e) {
         var layer = e.target;
         var flag = 0;
         document.getElementById("districtid").innerHTML = "District: "+e.target.feature.properties.district;
         var district_name_confirmed;
         for(i in tabledata){
        	 if(tabledata[i]['district'] == e.target.feature.properties.district){
        		 document.getElementById("span-confirmed").innerHTML = tabledata[i]['confirmed'] == null ? 0 : tabledata[i]['confirmed'];
        		 document.getElementById("span-active").innerHTML = tabledata[i]['active'] == null ? 0 : tabledata[i]['active'];
        		 document.getElementById("span-recovered").innerHTML = tabledata[i]['recovered'] == null ? 0 : tabledata[i]['recovered'];
        		 document.getElementById("span-death").innerHTML = tabledata[i]['deceased'] == null ? 0 : tabledata[i]['deceased'];
        		 flag = 1;
        		 district_name_confirmed = e.target.feature.properties.district
        	 }
         }
         if(flag == 0){
    		 document.getElementById("span-confirmed").innerHTML = "0";
    		 document.getElementById("span-active").innerHTML = "0";
    		 document.getElementById("span-recovered").innerHTML = "0";
    		 document.getElementById("span-death").innerHTML = "0";
    		 console.log(e.target.feature.properties.district);
    	 }
         else{
        	 document.getElementById("pie-chart").innerHTML = "";
	  	     document.getElementById("pie-chart").innerHTML = "<canvas id = 'pie-chart-cases'></canvas>";
        	 pieChart(e.target.feature.properties.district,[]);
         }

         layer.setStyle({
             weight: 5,
             color: '#ff3300',
             dashArray: '',
             fillOpacity: 0.7
         });

         if (!L.Browser.ie && !L.Browser.opera && !L.Browser.edge) {
             layer.bringToFront();
         }
     }
     //reset function for highlight
     function resetHighlight(e) {
         geojson.resetStyle(e.target);
         document.getElementById("districtid").innerHTML = "Hover over a District";
         document.getElementById("span-confirmed").innerHTML = tabledata[tabledata.length-1]['confirmed']==null?0:tabledata[tabledata.length-1]['confirmed'];
         document.getElementById("span-active").innerHTML = tabledata[tabledata.length-1]['active']==null?0:tabledata[tabledata.length-1]['active'];
         document.getElementById("span-recovered").innerHTML = tabledata[tabledata.length-1]['recovered']==null?0:tabledata[tabledata.length-1]['recovered'];
         document.getElementById("span-death").innerHTML = tabledata[tabledata.length-1]['deceased']==null?0:tabledata[tabledata.length-1]['deceased'];
     }

     //leaflet zoom feature on click function
     function zoomToFeature(e) {
         map.fitBounds(e.target.getBounds());
     }

     //function governing each feature
     function onEachFeature(feature, layer) {
         layer.on({
             mouseover: highlightFeature,
             mouseout: resetHighlight,
             click: highlightFeature  //with this, we will redirect to the individual state map
         });
     }

     //adding legend to the map
     
     legend.onAdd = function (map) {
		 
    	 var max_confirmed=0;
    	 for(i in tabledata.slice(0,tabledata.length-1)){
    		 if(max_confirmed<tabledata[i].confirmed)
    			 max_confirmed = tabledata[i].confirmed;
    	 }
    	 var x = Math.log10(max_confirmed);
    	 x=parseInt(x);
    	 var y=5**x;
         var div = L.DomUtil.create('div', 'info legend'),
             grades = [0, y, 2*y, 3*y, 4*y, 5*y, 6*y, 7*y],
             labels = [];

         // loop through our density intervals and generate a label with a colored square for each interval
         for (var i = 0; i < grades.length; i++) {
             div.innerHTML +=
                 '<i style="background:' + getColor(grades[i] + 1) + '"></i> ' +
                 grades[i] + (grades[i + 1] ? '&ndash;' + grades[i + 1] + '<br><br>' : '+');
         }

         return div;
     };
     legend.addTo(map);
     
     function trimData(data){
    	 if(status == "1-month"){
    		 return data.slice(data.length-30,data.length);
    	 }
    	 if(status == "2-weeks"){
    		 return data.slice(data.length-14,data.length);
    	 }
    	 else if(status == "1-week"){
    		 return data.slice(data.length-7,data.length);
    	 }
    	 else{
    		 return data.slice(0,data.length);
    	 }
     }
       
  	   function lineChart(data_cases){
  		   var dates=${dates};
	  	   var i;
	   	   for(i=0;i<dates.length;i++){
	   		   var date = dates[i].split('/')[1];
	   		   var month = dates[i].split('/')[0];
	   		   var year = dates[i].split('/')[2];
	   		   if(month == "null"){
	   			   month = "09";
	   			   dates[i] = month+"/"+date+"/"+year;
	   		   }
	   	   }
    	   var dataset_y_confirmed = trimData(data_cases['y-confirmed']);
    	   genericlinechart("line-confirmed",trimData(dates),dataset_y_confirmed,"#ff0000","Confirmed Cases","rgba(255,7,58,.12549)");
    	   
    	   var dataset_y_active = trimData(data_cases['y-active']);
    	   genericlinechart("line-active",trimData(dates),dataset_y_active,"#0000ff","Active Cases","rgba(0,123,255,.0627451)");
    	   
    	   var dataset_y_recovered = trimData(data_cases['y-recovered']);
    	   genericlinechart("line-recovered",trimData(dates),dataset_y_recovered, "#006600","Recovered Cases","rgba(40,167,69,.12549)");
    	   
    	   var dataset_y_death = trimData(data_cases['y-death']);
    	   genericlinechart("line-death",trimData(dates),dataset_y_death,"#595959","Death Cases","rgba(108,117,125,.0627451)");
  	   }
     
  	 function genericlinechart(canvasid,dataset_x,dataset_y,bordercolor,label,backgroundcolor){
     	var ctx = document.getElementById(canvasid);
     	ctx.height = 270;
     	ctx.width = 800;
     	ctx.style.backgroundColor = backgroundcolor;
     	var myLineChart;
     	myLineChart = new Chart(ctx, {
   		    type: 'line',
   		    data: {
   		    	labels: dataset_x,
   		    	datasets:[{
   		    		label: label,
   		    		data: dataset_y,
   		    		fill: false,
   		    		lineTension: 0.1,
   		    		backgroundColor: bordercolor,
   	                borderColor: bordercolor,
   	                borderWidth: 3,
   	              	pointRadius: 2,
   					pointRadiusOnHover: 3,
   		    	}]
   		    },
   		    options: {
   		    	responsive: true,
   	            maintainAspectRatio: false,
   	            legend:{
   	            	labels:{
   	            		fontSize: 15,
   	            	}
   	            },
   	            scales: {
   	                xAxes: [{
   	                	gridLines:{
   	                		color: "rgba(0, 0, 0, 0)",
   	                	},
   	                    type: 'time',
   	                	ticks:{
   	                		autoSkip: true,
   	                		maxTicksLimit: 4,
   	                		maxRotation: 0,
   	                      	minRotation: 0
   	                	},
   	                    distribution: 'linear',
   	                    time: {
   	                    	unit: 'day',
   	                        displayFormats: {
   	                            day: 'MMM D'
   	                        }
   	                    }
   	                }],
   		    		yAxes: [{
   		    			gridLines:{
   		    				//color: "rgba(0, 0, 0, 0)",
   		    			},
   		    			ticks: {
   	                        autoSkip: true,
   	                        maxTicksLimit: 6
   	                    },
   		    		}],
   	            },
 	  		  tooltips:{
 	    			titleFontSize: 20,
 	    			bodyFontSize: 20,
 	    			intersect: false,
 	    			callbacks:{
 	    				title: function(tooltipItem, data){
 	    					return "Date: "+ moment(tooltipItem[0].xLabel).format("MMM D");
 	    				},
 	    				label: function(tooltipItem,data){
 	    					return data.datasets[tooltipItem.datasetIndex].label+": "+tooltipItem.yLabel;
 	    				}
 	    			}
 	    		},
   		    }
   		});
     	Chart.defaults.LineWithLine = Chart.defaults.line;
    	Chart.controllers.LineWithLine = Chart.controllers.line.extend({
    	   draw: function(ease) {
    	      Chart.controllers.line.prototype.draw.call(this, ease);

    	      if (this.chart.tooltip._active && this.chart.tooltip._active.length) {
    	         var activePoint = this.chart.tooltip._active[0],
    	             ctx = this.chart.ctx,
    	             x = activePoint.tooltipPosition().x,
    	             topY = this.chart.legend.bottom,
    	             bottomY = this.chart.chartArea.bottom;

    	         // draw line
    	         ctx.save();
    	         ctx.beginPath();
    	         ctx.moveTo(x, topY);
    	         ctx.lineTo(x, bottomY);
    	         ctx.lineWidth = 2;
    	         ctx.strokeStyle = '#07C';
    	         ctx.stroke();
    	         ctx.restore();
    	      }
    	   }
    	});
   	}
     $.getJSON('https://covid19-api-django.herokuapp.com/growth/'+state_name,function(data){
    	 $("#g1-value").html(data.g1.toFixed(3));
    	 $("#g2-value").html(data.g2.toFixed(3));
    	 $("#current-value").html(data.current.toFixed(3));
      });
     
     $.getJSON("https://covid19-api-django.herokuapp.com/arima/"+state_name,function(data){
     	var dates_analysis = data.dates;
     	for(i in data.dp)
     		dates_analysis.push(data.dp[i]);
     	var ctx = document.getElementById("arima-graph");
     	ctx.height = 200;
     	var temp = data.pred;
     	var max_val = temp.reduce(function(a, b) {
     	    return Math.max(a, b);
     	});
     	var predict_coords = [];
     	var actual_coords = [];
     	for(i in data.pred){
     		predict_coords[i] = {'x': data.dp[i], 'y' : data.pred[i] };
     	}
     	for(i in data.actual){
     		actual_coords[i] = {'x': data.dates[i], 'y' : data.actual[i] };
     	}
     	var arimaChart = new Chart(ctx,{
     		type: 'line',
     		data: {
     			label: dates_analysis,
     			datasets: [{
     				label: 'Prediction for next 10 Days',
     				data: predict_coords,
     				fill: false,
     				lineTension: 0.1,
     				borderWidth: 3,
     				backgroundColor: '#9967FF',
     				borderColor: '#9967FF',
     				pointRadius: 1.5,
     				pointRadiusOnHover: 3,
     			},{
     				label: 'Actual Cases',
     				data: actual_coords,
     				fill: false,
     				lineTension: 0.1,
     				borderWidth: 3,
     				backgroundColor: '#F26384',
     				borderColor: '#F26384',
     				pointRadius: 1.5,
     				pointRadiusOnHover: 3,
     			}]
     		},
     		options: {
     			legend:{
  	            	labels:{
  	            		fontSize: 20, //now try...
  	            	}
  	            },
   		    	responsive: true,
   	            maintainAspectRatio: true,
   	            scales: {
   	                xAxes: [{
   	                	gridLines:{
   	                		color: "rgba(0, 0, 0, 0)",
   	                	},
   	                    type: 'time',
   	                    ticks: {
   	                        autoSkip: true,
   	                        maxTicksLimit: 6
   	                    },
   	                    distribution: 'linear',
   	                    time: {
   	                    	unit: 'day',
   	                        displayFormats: {
   	                            day: 'MMM D'
   	                        }
   	                    }
   	                }],
   		    		yAxes: [{
   		    			gridLines:{
   		    				//color: "rgba(0, 0, 0, 0)",
   		    			},
   		    			scaleLabel:{
  		    				display: true,
  		    				labelString: 'Cumulative confirmed cases',
  		    				fontSize: 20,
  		    			},
   		    			ticks: {
   	                        autoSkip: true,
   	                     	stepSize: max_val/4,
   	                     	precision: 0,
   	                     	suggestedMax: max_val+5
   	                    },
   		    		}],
   		    		title: {
   		              display: true,
   		              text: 'ARIMA Predictions',
   		              position: 'top',
   		          }
   	            },
 	  		  tooltips:{
 	    			titleFontSize: 20,
 	    			bodyFontSize: 20,
 	    			intersect: false,
 	    			callbacks:{
 	    				title: function(tooltipItem, data){
 	    					return "Date: "+ moment(tooltipItem[0].xLabel).format("MMM D");
 	    				},
 	    				label: function(tooltipItem,data){
 	    					var y = tooltipItem.yLabel;
 	    					y = y.toFixed(0); 
 	    					return data.datasets[tooltipItem.datasetIndex].label+": "+y;
 	    				}
 	    			}
 	    		},
   		    }
     	});
     	Chart.defaults.LineWithLine = Chart.defaults.line;
    	Chart.controllers.LineWithLine = Chart.controllers.line.extend({
    	   draw: function(ease) {
    	      Chart.controllers.line.prototype.draw.call(this, ease);

    	      if (this.chart.tooltip._active && this.chart.tooltip._active.length) {
    	         var activePoint = this.chart.tooltip._active[0],
    	             ctx = this.chart.ctx,
    	             x = activePoint.tooltipPosition().x,
    	             topY = this.chart.legend.bottom,
    	             bottomY = this.chart.chartArea.bottom;

    	         // draw line
    	         ctx.save();
    	         ctx.beginPath();
    	         ctx.moveTo(x, topY);
    	         ctx.lineTo(x, bottomY);
    	         ctx.lineWidth = 2;
    	         ctx.strokeStyle = '#07C';
    	         ctx.stroke();
    	         ctx.restore();
    	      }
    	   }
    	});
      });
     
     $.getJSON('https://covid19-api-django.herokuapp.com/rnaught/'+state_name,function(data){
         var ctx = document.getElementById('line-area-graph');
         ctx.height = 500;
		 var colors = [];
         var temp = data.high;
         var max_val = temp.reduce(function(a, b) {
      	    return Math.max(a, b);
      	});
         var config = {              
             type: 'line',
             data: {
                 labels: data.date,
                 datasets: [{
                     label: "Min",
                     backgroundColor: 'rgba(211,211,211,  0.2)',
                     borderColor: '#d9d9d9',
                     pointBackgroundColor: '#d9d9d9',
                     pointRadius: 1,
      				 pointRadiusOnHover: 2,
                     fill: false,  //no fill here
                     data: data.low,
                 },
                 {
                     label: "Max",
                     backgroundColor: 'rgba(211,211,211, 0.2)',
                     borderColor: '#d9d9d9',
                     pointBackgroundColor: '#d9d9d9',
                     pointRadius: 1,
      				 pointRadiusOnHover: 1,
                     fill: '-1', //fill until previous dataset
                     data: data.high,
                 },
                 {
                     type:'line',
                     label:'Most Likely',
                     data:data.ml,
                     pointBackgroundColor: colors,
                     fill:'none',
                     borderColor:'rgba(0,0,0,0.7)',
                     backgroundColor:'rgba(0,0,0,0.7)',
                     borderWidth:3,
                     pointRadius: 5,
      				 pointRadiusOnHover: 6,
                 }]
             },
             options: {
            	 legend:{
   	            	labels:{
   	            		fontSize: 20, //now try...
   	            	}
   	            },
 		    	responsive: true,
 	            maintainAspectRatio: false,
 	            scales: {
 	                xAxes: [{
 	                	gridLines:{
 	                		color: "rgba(0, 0, 0, 0)",
 	                	},
 	                    type: 'time',
 	                    ticks: {
 	                        autoSkip: true,
 	                        maxTicksLimit: 6
 	                    },
 	                    distribution: 'linear',
 	                    time: {
 	                    	unit: 'day',
 	                        displayFormats: {
 	                            day: 'MMM D'
 	                        }
 	                    }
 	                }],
 		    		yAxes: [{
 		    			gridLines:{
 		    				//color: "rgba(0, 0, 0, 0)",
 		    			},
 		    			ticks: {
 	                        autoSkip: true,
 	                     	stepSize: max_val/4,
 	                     	precision: 0,
 	                    },
 		    		}],
 	            },
	  		  tooltips:{
	    			titleFontSize: 20,
	    			bodyFontSize: 20,
	    			intersect: false,
	    			callbacks:{
	    				title: function(tooltipItem, data){
	    					return "Date: "+ moment(tooltipItem[0].xLabel).format("MMM D");
	    				},
	    				label: function(tooltipItem,data){
	    					var y = tooltipItem.yLabel;
	    					y = y.toFixed(3); 
	    					return data.datasets[tooltipItem.datasetIndex].label+" Value: "+y;
	    				}
	    			}
	    		}
         	}
         };
         
         var chart = new Chart(ctx, config);
         for(let i = 0; i<chart.data.datasets[0].data.length; i++){
				if(chart.data.datasets[2].data[i]>1.5){
					colors.push("#ff3333");
				}
				else if(chart.data.datasets[2].data[i]>1 && chart.data.datasets[2].data[i]<1.5){
					colors.push("#ff6666");
				}
				else if(chart.data.datasets[2].data[i]>0.5 && chart.data.datasets[2].data[i]<1){
					colors.push("#ff9999");
				}
				else{
					colors.push("#ffcccc");
				}
			}
         chart.update();
         Chart.defaults.LineWithLine = Chart.defaults.line;
     	Chart.controllers.LineWithLine = Chart.controllers.line.extend({
     	   draw: function(ease) {
     	      Chart.controllers.line.prototype.draw.call(this, ease);

     	      if (this.chart.tooltip._active && this.chart.tooltip._active.length) {
     	         var activePoint = this.chart.tooltip._active[0],
     	             ctx = this.chart.ctx,
     	             x = activePoint.tooltipPosition().x,
     	             topY = this.chart.legend.bottom,
     	             bottomY = this.chart.chartArea.bottom;

     	         // draw line
     	         ctx.save();
     	         ctx.beginPath();
     	         ctx.moveTo(x, topY);
     	         ctx.lineTo(x, bottomY);
     	         ctx.lineWidth = 2;
     	         ctx.strokeStyle = '#07C';
     	         ctx.stroke();
     	         ctx.restore();
     	      }
     	   }
     	});
     });
     
     function pieChart(district_name,dataset){
    	 var pie_colors = {red: "rgb(255, 99, 132)",
   	    	 orange: "rgb(255, 159, 64)",
   	    		 yellow: "rgb(255, 205, 86)",
   	    		 green: "rgb(75, 192, 192)",
   	    		 blue: "rgb(54, 162, 235)",
   	    		 purple: "rgb(153, 102, 255)",
   	    		 grey: "rgb(201, 203, 207)"}
    	 var dataset_val;
    	 if(district_name == state_name)
    		 dataset_val = dataset;
    	 else{
    		 for(i in tabledata){
    			 if(tabledata[i].district == district_name){
    				 dataset_val = [parseInt(tabledata[i].confirmed),parseInt(tabledata[i].active),parseInt(tabledata[i].recovered),parseInt(tabledata[i].deceased)];
    			 }
    		 }
    	 }
   	     var piechart = new Chart(document.getElementById("pie-chart-cases"),{
   	    	type: "pie",
   	    	data: {
   	    		labels: ['Confirmed', 'Active', 'Recovered', 'Deaths'],
   	    		datasets:[{
   	    			data: dataset_val,
   	    			label: 'Cases in '+district_name,
   	    			backgroundColor:[pie_colors.red,pie_colors.blue,pie_colors.green,pie_colors.grey]
   	    		}]
   	    	},
   	    	options:{
   	    		responsive: true,
   	    		legend: {
   	    			display: true,
   	    			position: 'top',
   	    			labels:{
   	    				fontSize: 16,
   	    			}
   	    		},
   	    		title:{
   	    			display: true,
   	    			text: 'Covid-19 Cases in '+district_name,
   	    			fontSize: 24,
   	    		},
   	    		animation:{
   	    			animateScale: true,
   	    			animateRotate: true
   	    		},
   	    		tooltips:{
   	    			titleFontSize: 20,
	    			bodyFontSize: 20,
   	    		}
   	    	}
   	     });
     }
     document.getElementById("pie-chart").innerHTML = "";
	 document.getElementById("pie-chart").innerHTML = "<canvas id = 'pie-chart-cases'></canvas>";
     pieChart(state_name,getPieData(0));
  </script>
</body>
</html>