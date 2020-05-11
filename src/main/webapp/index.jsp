<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  isELIgnored="false"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="en">

<head>
  <!-- India State Map  -->
  <title>Covid-19 India</title>

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
  
  <style>
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
	
	#confirmed-cases-block:hover,#active-cases-block:hover,#recovered-cases-block:hover,#death-cases-block:hover,#tested-cases-block:hover{
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
					<div class = "row">
						<div class = "col-sm-4"></div>
						<div class = "col-sm-4">
							<h1 id = "main-title" style = "font-family: 'Source Sans Pro', sans-serif; text-align: center; color: #3366ff ">INDIA</h1>
						</div>
						<div class = "col-sm-4"></div>
					</div>
					<h2 style = "font-family: 'Source Sans Pro', sans-serif; font-size: 35px; padding: 2%; text-align: center;" id = "stateid">Hover over a State</h2>
					<div class= "row" style = "padding: 1%;">
						<div id = "confirmed-cases-block" class = "col-sm-4" style = "height: 100px; padding:1%; opacity: 1; background-color: rgba(255,7,58,.12549); border-radius: 10px; margin-right: 5%" onclick = "caseStatusUpdate('confirmed', this)">
						    <h5 id = "confirmed-cases-title" style = "margin-top: 3%; font-family: 'Source Sans Pro', sans-serif; color: #800000; opacity: 1; text-align: center; font-weight: bold; font-size: 23px;">Confirmed </h5>
						    <h5 id = "span-confirmed"  style = "font-family: 'Source Sans Pro', sans-serif; color: #800000; text-align: center; font-size: 26px;"></h5>
						</div>
						<div id = "active-cases-block" class = "col-sm-3" style = "height: 80px; padding:1%; opacity: 1; background-color: rgba(0,123,255,.0627451); border-radius: 10px; margin-right: 5%" onclick = "caseStatusUpdate('active', this)">
						    <h5 id = "active-cases-title" style = "font-family: 'Source Sans Pro', sans-serif; color:#000066; text-align: center; font-weight: bold; font-size: 22px;">Active </h5>
						    <h5 id = "span-active"  style = "font-family: 'Source Sans Pro', sans-serif; color: #000066; text-align: center; font-size: 26px;"></h5>
						</div>
						<div id = "recovered-cases-block" class = "col-sm-3" style = "height: 80px; padding:1%; opacity: 1; background-color: rgba(40,167,69,.12549); border-radius: 10px;" onclick = "caseStatusUpdate('recovered', this)">
						    <h5 id = "recovered-cases-title" style = "font-family: 'Source Sans Pro', sans-serif; color: #006600; text-align: center; font-weight: bold; font-size: 23px;">Recovered </h5>
						    <h5 id = "span-recovered"  style = "font-family: 'Source Sans Pro', sans-serif; color: #006600; text-align: center; font-size: 26px;"></h5>
						</div>
						<div id = "death-cases-block" class = "col-sm-2" style = "height: 80px; padding:1%; opacity: 1; background-color: rgba(108,117,125,.0627451); border-radius: 10px; margin-top: 3%; margin-right: 5%; margin-left: 20%;" onclick = "caseStatusUpdate('death', this)">
						    <h5 id = "death-cases-title" style = "font-family: 'Source Sans Pro', sans-serif; color: #333333; text-align: center; font-weight: bold; font-size: 23px;">Death </h5>
						    <h5 id = "span-death"  style = "font-family: 'Source Sans Pro', sans-serif; color: #333333; text-align: center; font-size: 26px;"></h5>
						</div>
						<div id = "tested-cases-block" class = "col-sm-3" style = "height: 80px; padding:1%; opacity: 1; background-color: rgba(32,26,162,.12549); border-radius: 10px; margin-top: 3%" onclick = "caseStatusUpdate('tested', this)">
						    <h5 id = "tested-cases-title" style = "font-family: 'Source Sans Pro', sans-serif; color: #b366ff; text-align: center; font-weight: bold; font-size: 23px;">Tested </h5>
						    <h5 id = "span-testing"  style = "font-family: 'Source Sans Pro', sans-serif; color: #b366ff; text-align: center; font-size: 26px;"></h5>
						</div>
					</div>
				</div>
				<div class = "row" id = "map-holder">
					<div class = "animated fadeInLeft" id = "map" style = "margin-top: 5%;"></div>
				</div>
				<div class = "row">
					<div class = "col-sm-4"></div>
					<div class = "col-sm-4">
						<h5 class = "animated fadeInLeft" style = "font-family: 'Source Sans Pro', sans-serif; text-align: center;">Note: Click/Touch on a state to view respective District Map</h5>
					</div>
					<div class = "col-sm-4"></div>
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
						<h1 id = "trends-title" style = "font-family: 'Source Sans Pro', sans-serif; color: #3366ff; text-align: center; ">Trends - India</h1>
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
						<button class = "btn btn-primary waves-effect waves-light" onclick = "check('Beginning')" id = "Beginning">Start</button>
					</div>
					<div class = "col-sm-3">
						<button class = "btn btn-outline-primary waves-effect waves-light" onclick = "check('1-Month')" id = "1-Month">1Month</button>
					</div>
					<div class = "col-sm-3">
						<button class = "btn btn-outline-primary waves-effect waves-light" onclick = "check('2-Weeks')" id = "2-Weeks">2Weeks</button>
					</div>
					<div class = "col-sm-3">
						<button class = "btn btn-outline-primary waves-effect waves-light" onclick = "check('1-Week')" id = "1-Week">1Week</button>
					</div>	
				</div>
			</div>
		</div>
		<div class = "row" style = "margin-left: 16%;" id = "table-content">
			<div class = "row animated fadeInLeft" style = "margin-top: 5%; margin-left: 2%">
				<div class ="col-sm-1"></div>
				<div class = "col-sm-2" style = "opacity: 1; border-radius: 10px;">
				    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #800000; opacity: 1; text-align: center; font-weight: bold; font-size: 23px;">Confirmed </h5>
				    <h5 id = "span-static-confirmed"  style = "font-family: 'Source Sans Pro', sans-serif; color: #800000; text-align: center; font-size: 26px;"></h5>
				</div>
				<div class = "col-sm-2" style = "opacity: 1; border-radius: 10px;">
				    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color:#000066; text-align: center; font-weight: bold; font-size: 22px;">Active </h5>
				    <h5 id = "span-static-active"  style = "font-family: 'Source Sans Pro', sans-serif; color: #000066; text-align: center; font-size: 26px;"></h5>
				</div>
				<div class = "col-sm-2" style = "opacity: 1; border-radius: 10px;">
				    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #006600; text-align: center; font-weight: bold; font-size: 23px;">Recovered </h5>
				    <h5 id = "span-static-recovered"  style = "font-family: 'Source Sans Pro', sans-serif; color: #006600; text-align: center; font-size: 26px;"></h5>
				</div>
				<div class = "col-sm-2" style = "opacity: 1; border-radius: 10px;">
				    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #333333; text-align: center; font-weight: bold; font-size: 23px;">Death </h5>
				    <h5 id = "span-static-death"  style = "font-family: 'Source Sans Pro', sans-serif; color: #333333; text-align: center; font-size: 26px;"></h5>
				</div>
				<div class = "col-sm-2" style = "opacity: 1; border-radius: 10px;">
				    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #b366ff; text-align: center; font-weight: bold; font-size: 23px; transform: translate(35%,0)">Tested </h5>
				    <h5 id = "span-static-testing"  style = "font-family: 'Source Sans Pro', sans-serif; color: #b366ff; text-align: center; font-size: 26px;"></h5>
				</div>
				<div class ="col-sm-1"></div>
			</div>
			<div id = "table-note" class = "animated fadeInLeft" style = "width: 100%; margin-top: 2%;">
				<h5 style = "font-family: 'Source Sans Pro', sans-serif;">Note: Click on a state to view respective trend charts</h5>
			</div>
		</div>
		<div class = "row animated fadeInLeft" style = "margin-left: 15%">
			<div class = "animated fadeInLeft" id="covid-table" style = "margin-left: 0%; font-size: 20px; margin-top: 2%; font-family: 'Source Sans Pro', sans-serif; width: fit-content; height: fit-content;"></div>
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
		<div class = "row" style = "margin-top: 3%; width: 100%; margin-left: 4%; margin-top: 1%; text-align: center;">
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
		<div class = "row" style = "margin-top: 3%;">
			<div class = "col-sm-4"></div>
			<div class = "col-sm-4">
				<h3 class = "animate slideInRight" style = "font-family: 'Source Sans Pro', sans-serif; text-align: center;" id = "arima-graph-title">ARIMA Predictions</h3>
			</div>
			<div class = "col-sm-4"></div>
		</div>
		<canvas id = "arima-graph" class = "animate slideInRight"></canvas>
	</div>
  <script src = "https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  
  <script type="text/javascript">
  $.getJSON('https://covid19-api-django.herokuapp.com/growth/india',function(data){
	 $("#g1-value").html(data.g1.toFixed(3));
	 $("#g2-value").html(data.g2.toFixed(3));
	 $("#current-value").html(data.current.toFixed(3));
  });
  var tabledata = ${tableData} ;
  var data_cases = ${trends};
  var json = ${india};
  var status = "Beginning";
 	var cur_state = "total";
 	var rowclickfunc = (e, row)=> {
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
 	   
 	     document.getElementById("trends-title").innerHTML = "Trends - "+row._row.data.state;
 	     console.log("desktop");
 	     cur_state = row._row.data.state;
		 lineChart(row._row.data.state,data_cases);
		 if(status == "1-Month")
       	 pieChart(getPieData(row._row.data.state,30)); 
        else if(status == "1-Week")
       	 pieChart(getPieData(row._row.data.state,7));
        else if(status == "2-Weeks")
       	 pieChart(getPieData(row._row.data.state,14));
        else if(status == "Beginning")
       	 pieChart(getPieData(row._row.data.state,0));
 	   //document.getElementById("line-confirmed-class").scrollIntoView();
	  	 $('html, body').animate({
	         scrollTop: $("#trend-chart-title").offset().top
	     }, 1000);
	    e.preventDefault();
    }
 	function resizefunc(){
	  	if(screen.width<900){
	  		  document.getElementById("contentbox").removeAttribute("class");
	            document.getElementById("mapbox").removeAttribute("class");
	            coords = [23,82.1];
	            document.getElementById("contentbox").setAttribute("class","col-sm-12");
	            document.getElementById("mapbox").setAttribute("class","col-sm-12");
	            document.getElementById("mapbox").style.marginTop = "7%";
	            document.getElementById("covid-table").style.marginLeft = "-10%";
	            document.getElementById("map").style.marginLeft = "5%";
	            document.getElementById("info").style.marginLeft = "10%";
	            document.getElementById("table-content").style.marginLeft = "10%";
	            document.getElementById("table-note").style.display = 'none';
	            document.getElementById("main-title").style.textAlign = 'left';
	            document.getElementById("contentbox").removeAttribute("style");
	            //document.getElementById("covid-table").style.marginRight = "10%";
	            //document.getElementById("timeline-charts").removeAttribute("style");
	            //document.getElementById("timeline-charts").style.marginTop = "3%";
	            //document.getElementById("timeline-charts").style.marginLeft = "35%";
	            //document.getElementById("1-Week").style.marginLeft = "35%";
	            // document.getElementById("timeline-charts").style.transform = "translate(152%,0)";
	            document.getElementsByClassName("leaflet-bottom leaflet-right")[0].style.marginRight = "5%";
	            document.getElementsByClassName("info legend leaflet-control")[0].style.width = "110%";
	            document.getElementsByClassName("info legend leaflet-control")[0].style.fontSize = "16px";
	            //document.getElementById("analysis-title").style.transform = "translate(50%,0)";
	            //document.getElementById("analysis-sub-title").style.transform = "translate(-30%, 0)";
	            //document.getElementById("analysis-sub-title").style.marginTop = '7%';
	            //document.getElementById("arima-graph-title").style.transform = "translate(100%,0)";
	            //map.dragging.enable();
	  	}
	  	else{
	  		document.getElementById("table-note").style.display = 'block';
	  	}
	    }
  
  var table = new Tabulator("#covid-table", {
	  	height: 1450,
	 	data:tabledata.slice(1,tabledata.length), 
	 	movableColumns:false,
	 	layout:"fitDataFill", 
	 	columns:[ 
		 	{title:"State/UT", field:"state", hozAlign:"center"},
		 	{title:"Confirmed", field:"confirmed", hozAlign:"center"},
		 	{title:"Active", field:"active",hozAlign:"center"},
		 	{title:"Deaths", field:"deaths",hozAlign:"center"},
		 	{title:"Recovered", field:"recovered",hozAlign:"center"},
	 	],
	    rowClick:rowclickfunc,
	    rowTap: (e,row) => {
	    	e.preventDefault();
	    }
  	});
 	document.getElementById("span-static-confirmed").innerHTML = tabledata[0]['confirmed'];
 	document.getElementById("span-static-active").innerHTML = tabledata[0]['active'];
  	document.getElementById("span-static-recovered").innerHTML = tabledata[0]['recovered'];
  	document.getElementById("span-static-death").innerHTML = tabledata[0]['deaths'];
  	document.getElementById("span-static-testing").innerHTML = tabledata[0]['tested'];
  	document.getElementById("span-confirmed").innerHTML = tabledata[0]['confirmed'];
  	document.getElementById("span-active").innerHTML = tabledata[0]['active'];
  	document.getElementById("span-recovered").innerHTML = tabledata[0]['recovered'];
  	document.getElementById("span-death").innerHTML = tabledata[0]['deaths'];
  	document.getElementById("span-testing").innerHTML = tabledata[0]['tested'];
  	
  	var coords = [20.5, 82.7015625];
  	var case_status = "confirmed";
     var map = L.map('map',{
  	   center:coords,
  	   zoomSnap: 0.25,
  	   zoom:4.75, 
  	   scrollWheelZoom: false
  	   });
    	    
     //updating json data to the map
     var geojson =  L.geoJson(json, {
         style: style,
         onEachFeature: onEachFeature
     });
     geojson.addTo(map);;
     map.dragging.disable();
     
     //legend variable
     var legend = L.control({position: 'bottomright'});
     
     
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
   			document.getElementById("tested-cases-title").style.marginTop = "0%";
   		 	document.getElementById("active-cases-block").style.height = "80px";
   		 	document.getElementById("recovered-cases-block").style.height = "80px";
   		 	document.getElementById("death-cases-block").style.height = "80px";
		 	document.getElementById("tested-cases-block").style.height = "80px";
   		 	document.getElementById("active-cases-block").setAttribute("class","col-sm-3");
			document.getElementById("recovered-cases-block").setAttribute("class","col-sm-3");
			document.getElementById("death-cases-block").setAttribute("class","col-sm-2");
			document.getElementById("tested-cases-block").setAttribute("class","col-sm-3");
   		}
   		else if(e == "active"){
   			f.setAttribute("class","col-sm-4");
   			f.style.height = '100px';
   		 	document.getElementById("active-cases-title").style.marginTop = "3%";
   		 	document.getElementById("recovered-cases-title").style.marginTop = "0%";
   			document.getElementById("confirmed-cases-title").style.marginTop = "0%";
   			document.getElementById("death-cases-title").style.marginTop = "0%";
   			document.getElementById("tested-cases-title").style.marginTop = "0%";
   		 	document.getElementById("confirmed-cases-block").style.height = "80px";
   		 	document.getElementById("recovered-cases-block").style.height = "80px";
   		 	document.getElementById("death-cases-block").style.height = "80px";
		 	document.getElementById("tested-cases-block").style.height = "80px";
      		document.getElementById("confirmed-cases-block").setAttribute("class","col-sm-3");
   			document.getElementById("recovered-cases-block").setAttribute("class","col-sm-3");
   			document.getElementById("death-cases-block").setAttribute("class","col-sm-2");
   			document.getElementById("tested-cases-block").setAttribute("class","col-sm-3");
   		}
   		else if(e == "recovered"){
   			f.setAttribute("class","col-sm-4");
   			f.style.height = '100px';
   		 	document.getElementById("recovered-cases-title").style.marginTop = "3%";
   		 	document.getElementById("active-cases-title").style.marginTop = "0%";
   			document.getElementById("confirmed-cases-title").style.marginTop = "0%";
   			document.getElementById("death-cases-title").style.marginTop = "0%";
   			document.getElementById("tested-cases-title").style.marginTop = "0%";
   		 	document.getElementById("active-cases-block").style.height = "80px";
   		 	document.getElementById("confirmed-cases-block").style.height = "80px";
   		 	document.getElementById("death-cases-block").style.height = "80px";
   		 	document.getElementById("tested-cases-block").style.height = "80px";
   		 	document.getElementById("active-cases-block").setAttribute("class","col-sm-3");
			document.getElementById("confirmed-cases-block").setAttribute("class","col-sm-3");
			document.getElementById("death-cases-block").setAttribute("class","col-sm-2");
			document.getElementById("tested-cases-block").setAttribute("class","col-sm-3");
   		}
   		else if(e == "death"){
   			f.setAttribute("class","col-sm-3");
   			f.style.height = '100px';
   		 	document.getElementById("death-cases-title").style.marginTop = "3%";
   		 	document.getElementById("active-cases-title").style.marginTop = "0%";
   			document.getElementById("confirmed-cases-title").style.marginTop = "0%";
   			document.getElementById("recovered-cases-title").style.marginTop = "0%";
   			document.getElementById("tested-cases-title").style.marginTop = "0%";
   			document.getElementById("active-cases-block").style.height = "80px";
   		 	document.getElementById("confirmed-cases-block").style.height = "80px";
   		 	document.getElementById("recovered-cases-block").style.height = "80px";
   		 	document.getElementById("tested-cases-block").style.height = "80px";
   			document.getElementById("active-cases-block").setAttribute("class","col-sm-3");
   			document.getElementById("confirmed-cases-block").setAttribute("class","col-sm-3");
   			document.getElementById("recovered-cases-block").setAttribute("class","col-sm-3");
   		 	document.getElementById("tested-cases-block").setAttribute("class","col-sm-3");
   		}
   		else if(e == "tested"){
   			f.setAttribute("class","col-sm-4");
   			f.style.height = '100px';
   		 	document.getElementById("tested-cases-title").style.marginTop = "3%";
   		 	document.getElementById("active-cases-title").style.marginTop = "0%";
   			document.getElementById("confirmed-cases-title").style.marginTop = "0%";
   			document.getElementById("recovered-cases-title").style.marginTop = "0%";
   			document.getElementById("death-cases-title").style.marginTop = "0%";
   			document.getElementById("active-cases-block").style.height = "80px";
   		 	document.getElementById("confirmed-cases-block").style.height = "80px";
   		 	document.getElementById("recovered-cases-block").style.height = "80px";
   		 	document.getElementById("death-cases-block").style.height = "80px";
   			document.getElementById("active-cases-block").setAttribute("class","col-sm-3");
   			document.getElementById("confirmed-cases-block").setAttribute("class","col-sm-3");
   			document.getElementById("recovered-cases-block").setAttribute("class","col-sm-3");
   		 	document.getElementById("death-cases-block").setAttribute("class","col-sm-2");
   		}
    	 map = L.map('map',{
    	  	   center:coords,
    	  	   zoomSnap: 0.25,
    	  	   zoom:4.75, 
    	  	   scrollWheelZoom: false
    	  	   });
    	 geojson =  L.geoJson(json, {
             style: style,
             onEachFeature: onEachFeature
         });
         geojson.addTo(map);
         legend.onAdd = function (map) {
     		if(case_status == "confirmed"){
         	 var max_confirmed=0;
         	 for(i in tabledata.slice(1,tabledata.length)){
         		 if(max_confirmed<parseInt(tabledata[i].confirmed))
         			 max_confirmed = parseInt(tabledata[i].confirmed);
         	 }
         	 document.getElementsByClassName("leaflet-bottom leaflet-right")[0].style.marginRight = "25%";
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
     	    	 document.getElementsByClassName("leaflet-bottom leaflet-right")[0].style.marginRight = "25%";
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
     		else if(case_status == "recovered"){
     			var max_confirmed=0;
     	    	 for(i in tabledata.slice(1,tabledata.length)){
     	    		 if(max_confirmed<parseInt(tabledata[i].recovered))
     	    			 max_confirmed = parseInt(tabledata[i].recovered);
     	    	 }
     	    	 document.getElementsByClassName("leaflet-bottom leaflet-right")[0].style.marginRight = "25%";
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
     	    		 if(max_confirmed<parseInt(tabledata[i].deaths))
     	    			 max_confirmed = parseInt(tabledata[i].deaths);
     	    	 }
     	    	 document.getElementsByClassName("leaflet-bottom leaflet-right")[0].style.marginRight = "25%";
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
     		else if(case_status == "tested"){
     			var max_confirmed=0;
    	    	 for(i in tabledata.slice(1,tabledata.length)){
    	    		 if(max_confirmed<parseInt(tabledata[i].tested))
    	    			 max_confirmed = parseInt(tabledata[i].tested);
    	    	 }
    	    	 document.getElementsByClassName("leaflet-bottom leaflet-right")[0].style.marginRight = "25%";
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

              return div;
          };
          legend.addTo(map);
     }
     
     //getting the color values for filling the map
     function getColor(d) {
    	 if(case_status == "confirmed"){
	    	 var max_confirmed=0;
	    	 for(i in tabledata.slice(1,tabledata.length)){
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
	    	 for(i in tabledata.slice(1,tabledata.length)){
	    		 if(max_confirmed<parseInt(tabledata[i].active))
	    			 max_confirmed = parseInt(tabledata[i].active);
	    	 }
	    	 
	    	 var x = Math.log10(max_confirmed);
	    	 x=parseInt(x);
	    	 var y=5**x;
	    	 
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
	    	 for(i in tabledata.slice(1,tabledata.length)){
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
	    	 for(i in tabledata.slice(1,tabledata.length)){
	    		 if(max_confirmed<parseInt(tabledata[i].deaths))
	    			 max_confirmed = parseInt(tabledata[i].deaths);
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
    	 else if(case_status == "tested"){
    		 var max_confirmed=0;
	    	 for(i in tabledata.slice(1,tabledata.length)){
	    		 if(max_confirmed<parseInt(tabledata[i].tested))
	    			 max_confirmed = parseInt(tabledata[i].tested);
	    	 }
	    	 
	    	 var x = Math.log10(max_confirmed);
	    	 x=parseInt(x);
	    	 var y=5**x;
	    	 
	         return d > 7*y ? '#330066' :
	             d > 6*y  ? '#400080' :
	             d > 5*y  ? '#5900b3' :
	             d > 4*y  ? '#7300e6' :
	             d > 3*y   ? '#8c1aff' :
	             d > 2*y   ? '#a64dff' :
	             d > y  ? '#bf80ff' :
	                         '#d9b3ff';
    	 }
     }

     //styling map
     function style(features) {
    	 var color;
    	 if(case_status == "confirmed"){
    		 for(i in tabledata){
        		 if(tabledata[i].state == features.properties.st_nm){
        	 		color = parseInt(tabledata[i].confirmed);
        		 }
        	 }
    	 }
    	 else if(case_status == "active"){
    		 for(i in tabledata){
        		 if(tabledata[i].state == features.properties.st_nm){
        	 		color = parseInt(tabledata[i].active);
        		 }
        	 }
    	 }
    	 else if(case_status == "recovered"){
    		 for(i in tabledata){
        		 if(tabledata[i].state == features.properties.st_nm){
        	 		color = parseInt(tabledata[i].recovered);
        		 }
        	 }
    	 }
    	 else if(case_status == "death"){
    		 for(i in tabledata){
        		 if(tabledata[i].state == features.properties.st_nm){
        	 		color = parseInt(tabledata[i].deaths);
        		 }
        	 }
    	 }
    	 else if(case_status == "tested"){
    		 for(i in tabledata){
        		 if(tabledata[i].state == features.properties.st_nm){
        	 		color = parseInt(tabledata[i].tested);
        		 }
        	 }
    	 }
         return {
             fillColor: getColor(color),
             weight: 2,
             opacity: 1,
             color: 'white',
             dashArray: '3',
             fillOpacity: 0.8
         };
     }
   	
   	const getPieData  = (state,num) =>{
   		
   		let l = data_cases[state]["y-confirmed"].length;
   		let A = data_cases[state]["y-confirmed"][l-1];
   		let B = 0;
   		if(num != 0)
   			B = data_cases[state]["y-confirmed"][l - num];
   		const confirmed = A - B;
   		l = data_cases[state]["y-active"].length;
   		A = data_cases[state]["y-active"][l-1];
   		if (num == 0)
   			B = 0;
   		else
   			B = data_cases[state]["y-active"][l - num];
   		const active = A - B;
   		l = data_cases[state]["y-recovered"].length;
   		A = data_cases[state]["y-recovered"][l-1];
   		if (num == 0)
   			B = 0;
   		else
   			B = data_cases[state]["y-recovered"][l - num];
   		const recovered = A - B;
   		l = data_cases[state]["y-death"].length;
   		A = data_cases[state]["y-death"][l-1];
   		if (num == 0)
   			B = 0;
   		else
   			B = data_cases[state]["y-death"][l - num];
   		const death = A - B;
   		return [confirmed,active,recovered,death]; 
   	}

   	function check(e){
  		status = e;
  		let pieValues = [];
  		if(e == 'Beginning'){
            document.getElementById('1-Week').removeAttribute('class');
            document.getElementById('1-Week').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('2-Weeks').removeAttribute('class');
            document.getElementById('2-Weeks').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('1-Month').removeAttribute('class');
            document.getElementById('1-Month').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('Beginning').removeAttribute('class');
            document.getElementById('Beginning').setAttribute("class","btn btn-primary waves-effect waves-light");
            pieValues = getPieData(cur_state,0);
        }
        else if(e == '1-Month'){
            document.getElementById('Beginning').removeAttribute('class');
            document.getElementById('Beginning').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('2-Weeks').removeAttribute('class');
            document.getElementById('2-Weeks').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('1-Week').removeAttribute('class');
            document.getElementById('1-Week').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('1-Month').removeAttribute('class');
            document.getElementById('1-Month').setAttribute("class","btn btn-primary waves-effect waves-light");
            pieValues = getPieData(cur_state,30);
        }
        else if(e == '1-Week'){
            document.getElementById('Beginning').removeAttribute('class');
            document.getElementById('Beginning').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('2-Weeks').removeAttribute('class');
            document.getElementById('2-Weeks').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('1-Month').removeAttribute('class');
            document.getElementById('1-Month').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('1-Week').removeAttribute('class');
            document.getElementById('1-Week').setAttribute("class","btn btn-primary waves-effect waves-light");
            pieValues = getPieData(cur_state,7);
        }
        else if(e == '2-Weeks'){
            document.getElementById('Beginning').removeAttribute('class');
            document.getElementById('Beginning').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('1-Week').removeAttribute('class');
            document.getElementById('1-Week').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('1-Month').removeAttribute('class');
            document.getElementById('1-Month').setAttribute('class','btn btn-outline-primary waves-effect waves-light');
            document.getElementById('2-Weeks').removeAttribute('class');
            document.getElementById('2-Weeks').setAttribute("class","btn btn-primary waves-effect waves-light");
            pieValues = getPieData(cur_state,14);// i need to do a small change in that linechart fn then, give a min
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
  		lineChart(cur_state,data_cases);
  		pieChart(pieValues); //sometimes it is soo annoying becuz there is no autofill, lol
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
     lineChart("total",data_cases); //data cases from Beginning ryt?, yea, then based on the check fn, we will get trimmed data and redraw the charts ok
     var dataset_val = [tabledata[0]['confirmed'],tabledata[0]['active'],tabledata[0]['recovered'],tabledata[0]['deaths']];
     pieChart(dataset_val);
     
     //highlighting the features in map
     function highlightFeature(e) {
         var layer = e.target;
         
         document.getElementById("stateid").innerHTML = "State: "+e.target.feature.properties.st_nm;
         document.getElementById("trends-title").innerHTML = "Trends - "+e.target.feature.properties.st_nm;
         for(i in tabledata){
        	 if(tabledata[i]['state'] == e.target.feature.properties.st_nm){
        		 document.getElementById("span-confirmed").innerHTML = tabledata[i]['confirmed'] == null ? 0 : tabledata[i]['confirmed'];
        		 document.getElementById("span-active").innerHTML = tabledata[i]['active'] == null ? 0 : tabledata[i]['active'];
        		 document.getElementById("span-recovered").innerHTML = tabledata[i]['recovered'] == null ? 0 : tabledata[i]['recovered'];
        		 document.getElementById("span-death").innerHTML = tabledata[i]['deaths'] == null ? 0 : tabledata[i]['deaths'];
        		 document.getElementById("span-testing").innerHTML = tabledata[i]['tested'] == null ? 0 : tabledata[i]['tested'];
        	 }
         }
         
         //var trimmedData = trimDataset(data_cases);
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
         
         cur_state = layer.feature.properties.st_nm;
         lineChart(layer.feature.properties.st_nm,data_cases); 
         if(status == "1-Month")
        	 pieChart(getPieData(cur_state,30)); 
         else if(status == "1-Week")
        	 pieChart(getPieData(cur_state,7));
         else if(status == "2-Weeks")
        	 pieChart(getPieData(cur_state,14));
         else if(status == "Beginning")
        	 pieChart(getPieData(cur_state,0)); //i think that's all what about reset highlight
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
     
     //redirect to state page
     function redirect(e) {
        let state = e.target.feature.properties.st_nm;
        var form = document.createElement("form");
        var element1 = document.createElement("input");

        form.method = "GET";
        form.action = "state";

        element1.value = state;
        element1.name = "state";
        form.appendChild(element1);

        document.body.appendChild(form);

        form.submit();
    }
     //reset function for highlight
     function resetHighlight(e) {
         geojson.resetStyle(e.target);
         document.getElementById("stateid").innerHTML ="Hover over a State";
         document.getElementById("span-confirmed").innerHTML = tabledata[0]['confirmed'];
       	document.getElementById("span-active").innerHTML = tabledata[0]['active'];
       	document.getElementById("span-recovered").innerHTML = tabledata[0]['recovered'];
       	document.getElementById("span-death").innerHTML = tabledata[0]['deaths'];
       	document.getElementById("span-testing").innerHTML = tabledata[0]['tested'];
       	//lineChart("total",data_cases);
       	//pieChart("India"); 
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
             click: redirect
         });
     }

     //adding legend to the map
     legend.onAdd = function (map) {
		if(case_status == "confirmed"){
    	 var max_confirmed=0;
    	 for(i in tabledata.slice(1,tabledata.length)){
    		 if(max_confirmed<parseInt(tabledata[i].confirmed))
    			 max_confirmed = parseInt(tabledata[i].confirmed);
    	 }
    	 document.getElementsByClassName("leaflet-bottom leaflet-right")[0].style.marginRight = "25%";
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
	    	 document.getElementsByClassName("leaflet-bottom leaflet-right")[0].style.marginRight = "25%";
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
		else if(case_status == "recovered"){
			var max_confirmed=0;
	    	 for(i in tabledata.slice(1,tabledata.length)){
	    		 if(max_confirmed<parseInt(tabledata[i].recovered))
	    			 max_confirmed = parseInt(tabledata[i].recovered);
	    	 }
	    	 document.getElementsByClassName("leaflet-bottom leaflet-right")[0].style.marginRight = "25%";
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
	    		 if(max_confirmed<parseInt(tabledata[i].deaths))
	    			 max_confirmed = parseInt(tabledata[i].deaths);
	    	 }
	    	 document.getElementsByClassName("leaflet-bottom leaflet-right")[0].style.marginRight = "25%";
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

         return div;
     };
     legend.addTo(map);
     
     function trimData(data){
    	 if(status == "1-Month"){
    		 return data.slice(data.length-30,data.length);
    	 }
    	 if(status == "2-Weeks"){
    		 return data.slice(data.length-14,data.length);
    	 }
    	 else if(status == "1-Week"){
    		 return data.slice(data.length-7,data.length);
    	 }
    	 else{
    		 return data.slice(0,data.length);
    	 }
     }
     //generic line chart making function
     function lineChart(state_name,data_cases){
  	   
    	
  	   var dates = ${dates}; //these are the dates u give from server
  	   var dataset_y_confirmed = trimData(data_cases[state_name]['y-confirmed']);
  	   genericlinechart("line-confirmed",trimData(dates),dataset_y_confirmed,"#ff0000","Confirmed Cases","rgba(255,7,58,.12549)");
  	   
  	   var dataset_y_active = trimData(data_cases[state_name]['y-active']);
  	   genericlinechart("line-active",trimData(dates),dataset_y_active,"#0000ff","Active Cases","rgba(0,123,255,.0627451)");
  	   
  	   var dataset_y_recovered = trimData(data_cases[state_name]['y-recovered']);
  	   genericlinechart("line-recovered",trimData(dates),dataset_y_recovered, "#006600","Recovered Cases","rgba(40,167,69,.12549)");
  	   
  	   var dataset_y_death = trimData(data_cases[state_name]['y-death']);
  	   genericlinechart("line-death",trimData(dates),dataset_y_death,"#595959","Death Cases","rgba(108,117,125,.0627451)");
  	   
     }
     
     function genericlinechart(canvasid,dataset_x,dataset_y,bordercolor,label,backgroundcolor){
    	var ctx = document.getElementById(canvasid);
    	ctx.height = 270;
    	ctx.width = 800;
    	ctx.style.backgroundColor = backgroundcolor;
    	var myLineChart;
    	myLineChart = new Chart(document.getElementById(canvasid), {
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
    
     //pie chart
     function pieChart(dataset){
    	 var pie_colors = {red: "rgb(255, 99, 132)",
   	    	 orange: "rgb(255, 159, 64)",
   	    		 yellow: "rgb(255, 205, 86)",
   	    		 green: "rgb(75, 192, 192)",
   	    		 blue: "rgb(54, 162, 235)",
   	    		 purple: "rgb(153, 102, 255)",
   	    		 grey: "rgb(201, 203, 207)"}
    	 var dataset_val = dataset;// we will need some variable for getting current state name, so that i can put it here... cur_state is there no as global use that, okay
   	     var disp_name;
    	 if(cur_state == "total")
   	    	 disp_name = "India";
	     else
	    	 disp_name = cur_state;
    	 var piechart = new Chart(document.getElementById("pie-chart-cases"),{
   	    	type: "pie",
   	    	data: {
   	    		labels: ['Confirmed', 'Active', 'Recovered', 'Deaths'],
   	    		datasets:[{
   	    			data: dataset_val,
   	    			label: 'Cases in '+disp_name, //initially is it India?, i will have to pput it as india, first it will be total la
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
   	    			text: 'Covid-19 Cases in '+disp_name+" ("+status+")",
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
     
     //arima graph
     $.getJSON("https://covid19-api-django.herokuapp.com/arima/india",function(data){
    	var dates_analysis = data.dates;
    	for(i in data.d2)
    		dates_analysis.push(data.d2[i]);
    	dates_analysis.push(data.db[data.db.length-1]);
    	var ctx = document.getElementById("arima-graph");
    	ctx.height = 200;
    	ctx.style.marginBottom = "5%";
    	var predict_coords = [];
    	var predict_coords1 = [];
    	var predict_coords_current = [];
    	var actual_coords = [];
    	for(i in data.pb){
    		predict_coords[i] = {'x': data.db[i], 'y' : data.pb[i] };
    	}
    	for(i in data.p1){
    		predict_coords1[i] = {'x': data.d1[i], 'y' : data.p1[i] };
    	}
    	for(i in data.p2){
    		predict_coords_current[i] = {'x': data.d2[i], 'y' : data.p2[i] };
    	}
    	for(i in data.actual){
    		actual_coords[i] = {'x': data.dates[i], 'y' : data.actual[i] };
    	}
    	var arimaChart = new Chart(ctx,{
    		type: 'line',
    		data: {
    			label: dates_analysis,
    			datasets: [{
    				label: 'Before lockdown on 24th March',
    				data: predict_coords,
    				fill: false,
    				lineTension: 0.1,
    				borderWidth: 3,
    				backgroundColor: '#9967FF',
    				borderColor: '#9967FF',
    				pointRadius: 1.5,
    				pointRadiusOnHover: 3,
    			},{
    				label: 'Before lockdown on 14th April',
    				data: predict_coords1,
    				fill: false,
    				lineTension: 0.1,
    				borderWidth: 3,
    				backgroundColor: '#42A2EB',
    				borderColor: '#42A2EB',
    				pointRadius: 1.5,
    				pointRadiusOnHover: 3,
    			},{
    				label: 'Current Prediction',
    				data: predict_coords_current,
    				fill: false,
    				lineTension: 0.1,
    				borderWidth: 3,
    				backgroundColor: '#4BC0C0',
    				borderColor: '#4BC0C0',
    				pointRadius: 1.5,
    				pointRadiusOnHover: 3,
    			},{
    				label: 'Actual',
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
  		    	responsive: true,
  	            maintainAspectRatio: true,
  	            legend:{
	            	labels:{
	            		fontSize: 20, //now try...
	            	}
	            },
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
  	                        autoSkip: false,
  	                      	stepSize: 50000,
  	                        maxTicksLimit: 6
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
 	    					return data.datasets[tooltipItem.datasetIndex].label+" value: "+y;
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
  </script>
</body>
</html>