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
    <link href="https://fonts.googleapis.com/css2?family=Roboto+Slab&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@600&display=swap" rel="stylesheet">
  
  <!--  Styles  -->
  <link rel = "stylesheet" href = "<c:url value="/resources/css/index.css" />">
  
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
	        <a class="nav-link" href="" style = "font-family: 'Source Sans Pro', sans-serif; font-size: 20px;">About Us</a>
	      </li>
	    </ul>
	    <form class="form-inline my-2 my-lg-0">
	      <input class="form-control mr-sm-2" type="text" placeholder="Search">
	      <button class="btn btn-success my-2 my-sm-0" type="button">Search</button>
	    </form>
	  </div>
	</nav>
	<div class = "row">
		<div class = "col-sm-6" id = "contentbox"> <!--  style = "margin-right: -5%; margin-left: 5%" -->
			<div class = "container">
				<div class = "row" style = "margin-top: 3%">
					<div style = "opacity: 1; border-radius: 10px; width: 15%; margin-left: 5%; margin-right: 1.5%; ">
					    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #800000; opacity: 1; text-align: center; font-weight: bold; font-size: 23px;">Confirmed </h5>
					    <h5 id = "span-static-confirmed"  style = "font-family: 'Source Sans Pro', sans-serif; color: #800000; text-align: center; font-size: 26px;"></h5>
					</div>
					<div style = "opacity: 1; border-radius: 10px; width: 15%; margin-left: 1.5%; margin-right: 1.5%; ">
					    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color:#000066; text-align: center; font-weight: bold; font-size: 22px;">Active </h5>
					    <h5 id = "span-static-active"  style = "font-family: 'Source Sans Pro', sans-serif; color: #000066; text-align: center; font-size: 26px;"></h5>
					</div>
					<div style = "opacity: 1; border-radius: 10px; width: 15%; margin-left: 1.5%; margin-right: 1.5%; ">
					    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #006600; text-align: center; font-weight: bold; font-size: 23px;">Recovered </h5>
					    <h5 id = "span-static-recovered"  style = "font-family: 'Source Sans Pro', sans-serif; color: #006600; text-align: center; font-size: 26px;"></h5>
					</div>
					<div style = "opacity: 1; border-radius: 10px; width: 15%; margin-left: 1.5%; margin-right: 1.5%; ">
					    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #333333; text-align: center; font-weight: bold; font-size: 23px;">Death </h5>
					    <h5 id = "span-static-death"  style = "font-family: 'Source Sans Pro', sans-serif; color: #333333; text-align: center; font-size: 26px;"></h5>
					</div>
					<div style = "opacity: 1; border-radius: 10px; width: 20%; margin-left: 1.5%; margin-right: 1%; ">
					    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #b366ff; text-align: center; font-weight: bold; font-size: 23px;">Tested </h5>
					    <h5 id = "span-static-testing"  style = "font-family: 'Source Sans Pro', sans-serif; color: #b366ff; text-align: center; font-size: 26px;"></h5>
					</div>
				</div>
					<div id="covid-table" style = "margin-left: 0%; font-size: 20px; margin-top: 2%; font-family: 'Source Sans Pro', sans-serif; width: fit-content; height: fit-content;"></div>
			</div>
		</div>
		<div class = "col-sm-6" id = "mapbox"> <!--  style = "margin-left: -3%" -->
			<div class = "container" style = "padding: 1%">
				<div id = "info">
					<h1 style = "font-family: 'Source Sans Pro', sans-serif; text-align: center; color: #3366ff ">INDIA Map</h1>
					<h2 style = "font-family: 'Source Sans Pro', sans-serif; font-size: 35px; padding: 2%;" id = "stateid">Hover over a State</h2>
					<div class= "row" style = "padding: 1%">
						<div style = "opacity: 1; background-color: rgba(255,7,58,.12549); width: 15%; margin-left: 1%; margin-right: 1.5%; border-radius: 10px; ">
						    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #800000; opacity: 1; text-align: center; font-weight: bold; font-size: 23px;">Confirmed </h5>
						    <h5 id = "span-confirmed"  style = "font-family: 'Source Sans Pro', sans-serif; color: #800000; text-align: center; font-size: 26px;"></h5>
						</div>
						<div style = "opacity: 1; background-color: rgba(0,123,255,.0627451); border-radius: 10px; width: 15%; margin-left: 1.5%; margin-right: 1.5%;">
						    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color:#000066; text-align: center; font-weight: bold; font-size: 22px;">Active </h5>
						    <h5 id = "span-active"  style = "font-family: 'Source Sans Pro', sans-serif; color: #000066; text-align: center; font-size: 26px;"></h5>
						</div>
						<div style = "opacity: 1; background-color: rgba(40,167,69,.12549); border-radius: 10px; width: 15%; margin-left: 1.5%; margin-right: 1.5%;">
						    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #006600; text-align: center; font-weight: bold; font-size: 23px;">Recovered </h5>
						    <h5 id = "span-recovered"  style = "font-family: 'Source Sans Pro', sans-serif; color: #006600; text-align: center; font-size: 26px;"></h5>
						</div>
						<div style = "opacity: 1; background-color: rgba(108,117,125,.0627451); border-radius: 10px; width: 15%; margin-left: 1.5%; margin-right: 1.5%;">
						    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #333333; text-align: center; font-weight: bold; font-size: 23px;">Death </h5>
						    <h5 id = "span-death"  style = "font-family: 'Source Sans Pro', sans-serif; color: #333333; text-align: center; font-size: 26px;"></h5>
						</div>
						<div style = "opacity: 1; background-color: rgba(32,26,162,.12549); border-radius: 10px; width: 20%; margin-left: 1.5%; margin-right: 1%;">
						    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #b366ff; text-align: center; font-weight: bold; font-size: 23px;">Tested </h5>
						    <h5 id = "span-testing"  style = "font-family: 'Source Sans Pro', sans-serif; color: #b366ff; text-align: center; font-size: 26px;"></h5>
						</div>
					</div>
				</div>
			</div>
			<div id = "map" style = "margin-top: 5%"></div>
			<div class = "row" style = "margin-top: 5%; width: 90%; margin-left: 5%" id = "line-confirmed-class">
				<canvas id = "line-confirmed"></canvas>
			</div>
			<div class = "row" style = "margin-top: 5%; width: 90%; margin-left: 5%" id = "line-active-class">
				<canvas id = "line-active"></canvas>
			</div>
			<div class = "row" style = "margin-top: 5%; width: 90%; margin-left: 5%" id = "line-recovered-class">
				<canvas id = "line-recovered"></canvas>
			</div>
			<div class = "row" style = "margin-top: 5%; width: 90%; margin-left: 5%" id = "line-death-class">
				<canvas id = "line-death"></canvas>
			</div>
			<div class = "row" style = "transform: translate(40%,0); margin-top: 3%" id = "timeline-charts">
				<button class = "btn btn-primary" onclick = "check('beginning',this)" id = "beginning" style = "margin-right: 2%">Beginning</button>
				<button class = "btn btn-outline-primary" onclick = "check('1-month',this)" id = "1-month" style = "margin-right: 2%">1 Month</button>
				<button class = "btn btn-outline-primary" onclick = "check('2-weeks',this)" id = "2-weeks" style = "margin-right: 2%">2 Weeks</button>
				<button class = "btn btn-outline-primary" onclick = "check('1-week',this)" id = "1-week" style = "margin-right: 2%">1 Week</button>
			</div>
	</div>
	</div>
	<div class = "row" style = "margin-top: 3%; margin-bottom: 5%">
		<h1 style = "font-family: 'Source Sans Pro', sans-serif; transform:translate(150%,0);" id = "analysis-title">Analysis and Forecasts</h1>
		<br>
		<h2 style = "font-family: 'Source Sans Pro', sans-serif; transform:translate(175%,0); margin-top: 4%" id = "analysis-sub-title">Growth Rate</h2>
		<br>
		<div class = "row" style = "margin-top: 3%; width: 100%; margin-left: 4%; margin-top: 1%; text-align: center;">
			<div style = " background-color: rgba(0,123,255,.0627451); margin-right: 2%; border-radius: 10px; width: 30%;">
				<h3 style = "font-family: 'Source Sans Pro', sans-serif;">Before Lockdown on 24th March:</h3>
				<h2 style = "font-family: 'Source Sans Pro', sans-serif; " id = "g1-value"></h2>
			</div>
			<div style = "background-color: rgba(108,117,125,.0627451); margin-right: 2%; border-radius: 10px; width: 30%">
				<h3 style = "font-family: 'Source Sans Pro', sans-serif; ">Before Lockdown on 14th April:</h3>
				<h2 style = "font-family: 'Source Sans Pro', sans-serif; " id = "g2-value"></h2>
			</div>
			<div style = "background-color: rgba(40,167,69,.12549); margin-right: 2%; border-radius: 10px; width: 30%">
				<h3 style = "font-family: 'Source Sans Pro', sans-serif; ">Current Growth:</h3>
				<h2 style = "font-family: 'Source Sans Pro', sans-serif; " id = "current-value"></h2>
			</div>
		</div>
		<div class = "row" style = "width: 90%; margin-left: 4%; margin-top: 3%">
			<h3 style = "font-family: 'Source Sans Pro', sans-serif; transform:translate(250%,0); margin-bottom: 1%;" id = "arima-graph-title">ARIMA Predictions</h3>
			<canvas id = "arima-graph"></canvas>
		</div>
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
  console.log(tabledata);
  var data_cases = ${trends};
  var json = ${india};
  
  var table = new Tabulator("#covid-table", {
	  	height: 1450,
	 	data:tabledata.slice(1,tabledata.length), 
	 	movableColumns:false,
	 	layout:"fitDataFill", 
	 	columns:[ 
		 	{title:"State/UT", field:"state", hozAlign:"center", width: 300},
		 	{title:"Confirmed", field:"confirmed", hozAlign:"center"},
		 	{title:"Active", field:"active",hozAlign:"center"},
		 	{title:"Deaths", field:"deaths",hozAlign:"center"},
		 	{title:"Recovered", field:"recovered",hozAlign:"center"},
	 	],
	    rowClick:function(e, row){
		    //e - the click event object
		    //row - row component
		    document.getElementById("line-confirmed-class").innerHTML = "";
	  	     document.getElementById("line-confirmed-class").innerHTML = "<canvas id = 'line-confirmed'></canvas>";
	  	     document.getElementById("line-active-class").innerHTML = "";
	  	     document.getElementById("line-active-class").innerHTML = "<canvas id = 'line-active'></canvas>";
	  	     document.getElementById("line-recovered-class").innerHTML = "";
	  	     document.getElementById("line-recovered-class").innerHTML = "<canvas id = 'line-recovered'></canvas>";
	  	     document.getElementById("line-death-class").innerHTML = "";
	  	     document.getElementById("line-death-class").innerHTML = "<canvas id = 'line-death'></canvas>";
	  	   
	  	     if(row._row.data.state == 'Total')
				lineChart(row._row.data.state.toLowerCase(),data_cases);
			else
				lineChart(row._row.data.state,data_cases);
	  	   //document.getElementById("line-confirmed-class").scrollIntoView();
		  	 $('html, body').animate({
		         scrollTop: $("#line-confirmed-class").offset().top
		     }, 1000);
		    e.preventDefault(); // prevent the browsers default context menu form appearing.
		    },
		rowTap:function(e,row){
			document.getElementById("line-confirmed-class").innerHTML = "";
	  	     document.getElementById("line-confirmed-class").innerHTML = "<canvas id = 'line-confirmed'></canvas>";
	  	     document.getElementById("line-active-class").innerHTML = "";
	  	     document.getElementById("line-active-class").innerHTML = "<canvas id = 'line-active'></canvas>";
	  	     document.getElementById("line-recovered-class").innerHTML = "";
	  	     document.getElementById("line-recovered-class").innerHTML = "<canvas id = 'line-recovered'></canvas>";
	  	     document.getElementById("line-death-class").innerHTML = "";
	  	     document.getElementById("line-death-class").innerHTML = "<canvas id = 'line-death'></canvas>";
	  	   if(row._row.data.state == 'Total')
				lineChart(row._row.data.state.toLowerCase(),data_cases);
			else
				lineChart(row._row.data.state,data_cases);
	  	   
	  	 $('html, body').animate({
	         scrollTop: $("#line-confirmed-class").offset().top
	     }, 1000);
	  	 //document.getElementById("line-confirmed").scrollIntoView();
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
  	
  	var coords = [23.0, 82.1015625];
  	
    function resizefunc(){
          if(screen.width>900){
              document.getElementById("contentbox").removeAttribute("class");
              document.getElementById("mapbox").removeAttribute("class");
              document.getElementById("contentbox").setAttribute("class","col-sm-6");
              document.getElementById("mapbox").setAttribute("class","col-sm-6");
              coords = [23.0, 80.1015625];
          }
          else if(screen.width>1600){
        	  document.getElementById("covid-table").style.marginLeft = "6%";
        	  document.getElementById("analysis-title").style.transform = "translate(190%,0)";
        	  document.getElementById("analysis-sub-title").style.transform = "translate(265%,0)";
        	  document.getElementById("arima-graph-title").style.transform = "translate(340%,0)";
          }
          else{
              document.getElementById("contentbox").removeAttribute("class");
              document.getElementById("mapbox").removeAttribute("class");
              coords = [23,82.1];
              document.getElementById("contentbox").setAttribute("class","col-sm-12");
              document.getElementById("mapbox").setAttribute("class","col-sm-12");
              document.getElementById("mapbox").style.marginTop = "7%";
              document.getElementById("contentbox").removeAttribute("style");
              document.getElementById("covid-table").style.marginLeft = "-5%";
              document.getElementById("timeline-charts").removeAttribute("style");
              document.getElementById("timeline-charts").style.marginTop = "3%";
              document.getElementById("timeline-charts").style.transform = "translate(52%,0)";
              document.getElementsByClassName("leaflet-bottom leaflet-right")[0].style.marginRight = "5%";
              document.getElementsByClassName("info legend leaflet-control")[0].style.width = "110%";
              document.getElementsByClassName("info legend leaflet-control")[0].style.fontSize = "16px";
              document.getElementById("analysis-title").style.transform = "translate(80%,0)";
              document.getElementById("analysis-sub-title").style.transform = "translate(20%,0)";
              document.getElementById("arima-graph-title").style.transform = "translate(170%,0)";
          }
      }
    
     var map = L.map('map',{
  	   center:coords, 
  	   zoom:5, 
  	   scrollWheelZoom: false
  	   });
  
     //updating json data to the map
     var geojson = L.geoJson(json, {
         style: style,
         onEachFeature: onEachFeature
     });
     geojson.addTo(map);
     var info;
     map.dragging.disable();
     
     
     //getting the color values for filling the map
     function getColor(d) {
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

     //styling map
     function style(features) {
    	 //console.log(features.properties.st_nm);
    	 var color;
    	 for(i in tabledata){
    		 if(tabledata[i].state == features.properties.st_nm){
    	 		color = parseInt(tabledata[i].confirmed);
    		 }
    	 }
         return {
             fillColor: getColor(color),
             weight: 2,
             opacity: 1,
             color: 'white',
             dashArray: '3',
             fillOpacity: 0.7
         };
     }
     
     var status = "beginning";
   	var cur_state = "total";
   	function check(e,f){
  		status = e;
  		if(f.innerHTML == 'Beginning'){
            document.getElementById('1-week').removeAttribute('class');
            document.getElementById('1-week').setAttribute('class','btn btn-outline-primary');
            document.getElementById('2-weeks').removeAttribute('class');
            document.getElementById('2-weeks').setAttribute('class','btn btn-outline-primary');
            document.getElementById('1-month').removeAttribute('class');
            document.getElementById('1-month').setAttribute('class','btn btn-outline-primary');
            f.removeAttribute('class');
            f.setAttribute("class","btn btn-primary");
        }
        else if(f.innerHTML == '1 Month'){
            document.getElementById('beginning').removeAttribute('class');
            document.getElementById('beginning').setAttribute('class','btn btn-outline-primary');
            document.getElementById('2-weeks').removeAttribute('class');
            document.getElementById('2-weeks').setAttribute('class','btn btn-outline-primary');
            document.getElementById('1-week').removeAttribute('class');
            document.getElementById('1-week').setAttribute('class','btn btn-outline-primary');
            f.removeAttribute('class');
            f.setAttribute("class","btn btn-primary");
        }
        else if(f.innerHTML == '1 Week'){
            document.getElementById('beginning').removeAttribute('class');
            document.getElementById('beginning').setAttribute('class','btn btn-outline-primary');
            document.getElementById('2-weeks').removeAttribute('class');
            document.getElementById('2-weeks').setAttribute('class','btn btn-outline-primary');
            document.getElementById('1-month').removeAttribute('class');
            document.getElementById('1-month').setAttribute('class','btn btn-outline-primary');
            f.removeAttribute('class');
            f.setAttribute("class","btn btn-primary");
        }
        else if(f.innerHTML == '2 Weeks'){
            document.getElementById('beginning').removeAttribute('class');
            document.getElementById('beginning').setAttribute('class','btn btn-outline-primary');
            document.getElementById('1-week').removeAttribute('class');
            document.getElementById('1-week').setAttribute('class','btn btn-outline-primary');
            document.getElementById('1-month').removeAttribute('class');
            document.getElementById('1-month').setAttribute('class','btn btn-outline-primary');
            f.removeAttribute('class');
            f.setAttribute("class","btn btn-primary");
        }
  		document.getElementById("line-confirmed-class").innerHTML = "";
  	     document.getElementById("line-confirmed-class").innerHTML = "<canvas id = 'line-confirmed'></canvas>";
  	     document.getElementById("line-active-class").innerHTML = "";
  	     document.getElementById("line-active-class").innerHTML = "<canvas id = 'line-active'></canvas>";
  	     document.getElementById("line-recovered-class").innerHTML = "";
  	     document.getElementById("line-recovered-class").innerHTML = "<canvas id = 'line-recovered'></canvas>";
  	     document.getElementById("line-death-class").innerHTML = "";
  	     document.getElementById("line-death-class").innerHTML = "<canvas id = 'line-death'></canvas>";
  		lineChart(cur_state,data_cases);
   	}
     
     document.getElementById("line-confirmed-class").innerHTML = "";
     document.getElementById("line-confirmed-class").innerHTML = "<canvas id = 'line-confirmed'></canvas>";
     document.getElementById("line-active-class").innerHTML = "";
     document.getElementById("line-active-class").innerHTML = "<canvas id = 'line-active'></canvas>";
     document.getElementById("line-recovered-class").innerHTML = "";
     document.getElementById("line-recovered-class").innerHTML = "<canvas id = 'line-recovered'></canvas>";
     document.getElementById("line-death-class").innerHTML = "";
     document.getElementById("line-death-class").innerHTML = "<canvas id = 'line-death'></canvas>";
     lineChart("total",data_cases);
     //highlighting the features in map
     function highlightFeature(e) {
         var layer = e.target;
         
         document.getElementById("stateid").innerHTML = "State: "+e.target.feature.properties.st_nm;
         for(i in tabledata){
        	 if(tabledata[i]['state'] == e.target.feature.properties.st_nm){
        		 document.getElementById("span-confirmed").innerHTML = tabledata[i]['confirmed'];
        		 document.getElementById("span-active").innerHTML = tabledata[i]['active'];
        		 document.getElementById("span-recovered").innerHTML = tabledata[i]['recovered'];
        		 document.getElementById("span-death").innerHTML = tabledata[i]['deaths'];
        		 document.getElementById("span-testing").innerHTML = tabledata[i]['tested'];
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
         
         cur_state = layer.feature.properties.st_nm;
         lineChart(layer.feature.properties.st_nm,data_cases);

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
        console.log("reached here state is ", state);
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
     var legend = L.control({position: 'bottomright'});
     legend.onAdd = function (map) {
			
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
     //generic line chart making function
     function lineChart(state_name,data_cases){
  	   
  	   var dates = ${dates};
  	   //console.log(dates);
  	   
  	   var dataset_y_confirmed = data_cases.hasOwnProperty(state_name)?trimData(data_cases[state_name]['y-confirmed']):trimData(data_cases["Total"]['y-confirmed']);
  	   genericlinechart("line-confirmed",trimData(dates),dataset_y_confirmed,"#ff0000","Confirmed Cases","rgba(255,7,58,.12549)");
  	   
  	   var dataset_y_active = data_cases.hasOwnProperty(state_name)?trimData(data_cases[state_name]['y-active']):trimData(data_cases["Total"]['y-active']);
  	   genericlinechart("line-active",trimData(dates),dataset_y_active,"#0000ff","Active Cases","rgba(0,123,255,.0627451)");
  	   
  	   var dataset_y_recovered = data_cases.hasOwnProperty(state_name)?trimData(data_cases[state_name]['y-recovered']):trimData(data_cases["Total"]['y-recovered']);
  	   genericlinechart("line-recovered",trimData(dates),dataset_y_recovered, "#006600","Recovered Cases","rgba(40,167,69,.12549)");
  	   
  	   var dataset_y_death = data_cases.hasOwnProperty(state_name)?trimData(data_cases[state_name]['y-death']):trimData(data_cases["Total"]['y-death']);
  	   genericlinechart("line-death",trimData(dates),dataset_y_death,"#595959","Death Cases","rgba(108,117,125,.0627451)");
  	   
     }
     
     function genericlinechart(canvasid,dataset_x,dataset_y,bordercolor,label,backgroundcolor){
    	var x = document.getElementById(canvasid);
    	x.height = 270;
    	x.style.backgroundColor = backgroundcolor;
    	var myLineChart;
    	if(myLineChart){
       		myLineChart.destroy();
       	}
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
  		    			ticks: {
  	                        autoSkip: true,
  	                        maxTicksLimit: 6
  	                    },
  		    		}],
  	            },
	  		  tooltips:{
	    			titleFontSize: 20,
	    			bodyFontSize: 20,
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
  	}
    
     //arima graph
     $.getJSON("https://covid19-api-django.herokuapp.com/arima/india",function(data){
    	var dates_analysis = data.dates;
    	for(i in data.d2)
    		dates_analysis.push(data.d2[i]);
    	dates_analysis.push(data.db[data.db.length-1]);
    	var x = document.getElementById("arima-graph");
    	x.height = 600;
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
    	var arimaChart = new Chart(x,{
    		type: 'line',
    		data: {
    			label: dates_analysis,
    			datasets: [{
    				label: 'Prediction before lockdown',
    				data: predict_coords,
    				fill: false,
    				lineTension: 0.1,
    				borderWidth: 3,
    				backgroundColor: '#9967FF',
    				borderColor: '#9967FF',
    				pointRadius: 1.5,
    				pointRadiusOnHover: 3,
    			},{
    				label: 'Prediction after lockdown 1',
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
  	            maintainAspectRatio: false,
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
	    			callbacks:{
	    				title: function(tooltipItem, data){
	    					return "Date: "+ moment(tooltipItem[0].xLabel).format("MMM D");
	    				},
	    				label: function(tooltipItem,data){
	    					//console.log(Object.keys(tooltipItem) + ":" + Object.values(tooltipItem)+ " " + Object.keys(data) + ":" + data.datasets[0].label);
	    					var y = tooltipItem.yLabel;
	    					y = y.toFixed(0); 
 	    					return data.datasets[tooltipItem.datasetIndex].label+" value: "+y;
	    				}
	    			}
	    		},
  		    }
    	});
     });
  </script>
</body>
</html>