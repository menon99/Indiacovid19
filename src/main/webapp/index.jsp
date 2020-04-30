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

<body onload = "resizefunc()">
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	  <h2><a class="navbar-brand"><span style = "color: white; font-family: 'Source Sans Pro', sans-serif; font-size: 24px;">COVID-19 Analysis</span></a></h2>
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
		<div class = "col-sm-6" id = "contentbox" style = "margin-right: -5%; margin-left: 5%">
			<div class = "container">
				<div class = "row" style = "padding: 2%">
					<div class = "col-sm-2" id = "div-static-confirmed">
						<div style = "opacity: 1; border-radius: 10px; ">
						    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #800000; opacity: 1; text-align: center; font-weight: bold; font-size: 23px;">Confirmed </h5>
						    <h5 id = "span-static-confirmed"  style = "font-family: 'Source Sans Pro', sans-serif; color: #800000; text-align: center; font-size: 26px;"></h5>
						</div>
					</div>
					<div class = "col-sm-2">
						<div style = "opacity: 1; border-radius: 10px;">
						    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color:#000066; text-align: center; font-weight: bold; font-size: 22px;">Active </h5>
						    <h5 id = "span-static-active"  style = "font-family: 'Source Sans Pro', sans-serif; color: #000066; text-align: center; font-size: 26px;"></h5>
						</div>
					</div>
					<div class = "col-sm-2" id = "div-static-recovered">
						<div style = "opacity: 1; border-radius: 10px;">
						    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #006600; text-align: center; font-weight: bold; font-size: 23px;">Recovered </h5>
						    <h5 id = "span-static-recovered"  style = "font-family: 'Source Sans Pro', sans-serif; color: #006600; text-align: center; font-size: 26px;"></h5>
						</div>
					</div>
					<div class = "col-sm-2">
						<div style = "opacity: 1; border-radius: 10px;">
						    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #333333; text-align: center; font-weight: bold; font-size: 23px;">Death </h5>
						    <h5 id = "span-static-death"  style = "font-family: 'Source Sans Pro', sans-serif; color: #333333; text-align: center; font-size: 26px;"></h5>
						</div>
					</div>
					<div class = "col-sm-2">
						<div style = "opacity: 1; border-radius: 10px;">
						    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #b366ff; text-align: center; font-weight: bold; font-size: 23px;">Tested </h5>
						    <h5 id = "span-static-testing"  style = "font-family: 'Source Sans Pro', sans-serif; color: #b366ff; text-align: center; font-size: 26px;"></h5>
						</div>
					</div>
				</div>
				<div id="covid-table" style = "font-size: 20px; margin-top: 2%; font-family: 'Source Sans Pro', sans-serif; width: fit-content; height: fit-content;"></div>
			</div>
		</div>
		<div class = "col-sm-6" id = "mapbox" style = "margin-left: -3%">
			<div class = "container" style = "padding: 1%">
				<div id = "info">
					<h1 style = "font-family: 'Source Sans Pro', sans-serif; text-align: center; color: #3366ff ">INDIA Map</h1>
					<h2 style = "font-family: 'Source Sans Pro', sans-serif; font-size: 35px; padding: 2%;" id = "stateid">Hover over a State</h2>
					<div class= "row" style = "padding: 1%">
						<div class = "col-sm-2" id = "div-confirmed">
							<div style = "opacity: 1; background-color: rgba(255,7,58,.12549); border-radius: 10px; ">
							    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #800000; opacity: 1; text-align: center; font-weight: bold; font-size: 23px;">Confirmed </h5>
							    <h5 id = "span-confirmed"  style = "font-family: 'Source Sans Pro', sans-serif; color: #800000; text-align: center; font-size: 26px;"></h5>
							</div>
						</div>
						<div class = "col-sm-2">
							<div style = "opacity: 1; background-color: rgba(0,123,255,.0627451); border-radius: 10px;">
							    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color:#000066; text-align: center; font-weight: bold; font-size: 22px;">Active </h5>
							    <h5 id = "span-active"  style = "font-family: 'Source Sans Pro', sans-serif; color: #000066; text-align: center; font-size: 26px;"></h5>
							</div>
						</div>
						<div class = "col-sm-2" id = "div-recovered">
							<div style = "opacity: 1; background-color: rgba(40,167,69,.12549); border-radius: 10px;">
							    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #006600; text-align: center; font-weight: bold; font-size: 23px;">Recovered </h5>
							    <h5 id = "span-recovered"  style = "font-family: 'Source Sans Pro', sans-serif; color: #006600; text-align: center; font-size: 26px;"></h5>
							</div>
						</div>
						<div class = "col-sm-2">
							<div style = "opacity: 1; background-color: rgba(108,117,125,.0627451); border-radius: 10px;">
							    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #333333; text-align: center; font-weight: bold; font-size: 23px;">Death </h5>
							    <h5 id = "span-death"  style = "font-family: 'Source Sans Pro', sans-serif; color: #333333; text-align: center; font-size: 26px;"></h5>
							</div>
						</div>
						<div class = "col-sm-2">
							<div style = "opacity: 1; background-color: rgba(32,26,162,.12549); border-radius: 10px;">
							    <h5 style = "font-family: 'Source Sans Pro', sans-serif; color: #b366ff; text-align: center; font-weight: bold; font-size: 23px;">Tested </h5>
							    <h5 id = "span-testing"  style = "font-family: 'Source Sans Pro', sans-serif; color: #b366ff; text-align: center; font-size: 26px;"></h5>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id = "map" style = "margin-top: 5%"></div>
			<div class = "row" style = "margin-top: 5%; margin-right: 5%; width: auto">
				<canvas id = "line-confirmed" ></canvas>
			</div>
			<div class = "row" style = "margin-top: 5%; margin-right: 5%; width: auto">
				<canvas id = "line-active" ></canvas>
			</div>
			<div class = "row" style = "margin-top: 5%; margin-right: 5%; width: auto">
				<canvas id = "line-recovered" ></canvas>
			</div>
			<div class = "row" style = "margin-top: 5%; margin-right: 5%; width: auto">
				<canvas id = "line-death" ></canvas>
			</div>
			<div class = "row" style = "margin-top: 5%; margin-right: 5%; width: auto">
				<canvas id = "line-testing" ></canvas>
			</div>
			<div class = "row" style = "transform: translate(50%,0)">
				<button class = "btn btn-outline-primary" onclick = "check()" id = "beginning" style = "margin-right: 2%">Beginning</button>
				<button class = "btn btn-outline-primary" onclick = "check()" id = "1-month" style = "margin-right: 2%">1 Month</button>
				<button class = "btn btn-outline-primary" onclick = "check()" id = "2-weeks" style = "margin-right: 2%">2 Weeks</button>
				<button class = "btn btn-outline-primary" onclick = "check()" id = "1-week" style = "margin-right: 2%">1 Week</button>
			</div>
	</div>
	<div class = "container">
		<div class = "row">
			<h1 style = "font-family: 'Source Sans Pro', sans-serif; text-align: center;">Analysis and Forecasts</h1>
			<div class = "row">
				<div class = "col-sm-6">
					<canvas id = "arima-graph"></canvas>
				</div>
				<div class = "col-sm-6">
					<canvas id = "2nd-graph"></canvas>
				</div>
			</div>
		</div>
	</div>

  <script src="http://d3js.org/d3.v3.min.js"></script>
  <script src="http://d3js.org/topojson.v1.min.js"></script>
  <script src = "https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>
  
  <script type="text/javascript">
  var tabledata = ${tableData} ;
  console.log(tabledata);
  var json = ${india};
  var table = new Tabulator("#covid-table", {
	  	height: 1490,
	 	data:tabledata, 
	 	movableColumns:false,
	 	responsiveLayout:true,
	 	layout:"fitDataFill", 
	 	columns:[ 
		 	{title:"State/UT", field:"state", hozAlign:"center", width: 300},
		 	{title:"Confirmed", field:"confirmed", hozAlign:"center"},
		 	{title:"Active", field:"active",hozAlign:"center"},
		 	{title:"Deaths", field:"deaths",hozAlign:"center"},
		 	{title:"Recovered", field:"recovered",hozAlign:"center"},
	 	]});
 	document.getElementById("span-static-confirmed").innerHTML = tabledata[0]['confirmed'];
 	document.getElementById("span-static-active").innerHTML = tabledata[0]['active'];
  	document.getElementById("span-static-recovered").innerHTML = tabledata[0]['recovered'];
  	document.getElementById("span-static-death").innerHTML = tabledata[0]['deaths'];
  	document.getElementById("span-confirmed").innerHTML = tabledata[0]['confirmed'];
  	document.getElementById("span-active").innerHTML = tabledata[0]['active'];
  	document.getElementById("span-recovered").innerHTML = tabledata[0]['recovered'];
  	document.getElementById("span-death").innerHTML = tabledata[0]['deaths'];
  	document.getElementById("span-testing").innerHTML = tabledata[0]['tested'];
  	
  	var coords = [23.0, 80.1015625];
  	
  	var status = "beginning";
  	function check(){
  		document.getElementById("beginning").onclick = function(){
  			status = "beginning";
  		}
  		document.getElementById("1-month").onclick = function(){
  			status = "1-month";
  		}
  		document.getElementById("2-weeks").onclick = function(){
  			status = "2-weeks";
  		}
  		document.getElementById("1-week").onclick = function(){
  			status = "1-week";
  		}
  	}
  	
    function resizefunc(){
          if(screen.width>900){
              document.getElementById("contentbox").removeAttribute("class");
              document.getElementById("mapbox").removeAttribute("class");
              document.getElementById("contentbox").setAttribute("class","col-sm-6");
              document.getElementById("mapbox").setAttribute("class","col-sm-6");
              coords = [23.0, 80.1015625];
          }
          else{
              document.getElementById("contentbox").removeAttribute("class");
              document.getElementById("mapbox").removeAttribute("class");
              document.getElementById("div-confirmed").removeAttribute("class");
              document.getElementById("div-recovered").removeAttribute("class");
              coords = [23,82.1];
              document.getElementById("contentbox").setAttribute("class","col-sm-12");
              document.getElementById("mapbox").setAttribute("class","col-sm-12");
              document.getElementById("mapbox").style.marginTop = "7%";
              document.getElementById("div-confirmed").setAttribute("class","col-sm-3");
              document.getElementById("div-recovered").setAttribute("class","col-sm-3");
              document.getElementById("div-static-confirmed").setAttribute("class","col-sm-3");
              document.getElementById("div-static-recovered").setAttribute("class","col-sm-3");
              document.getElementById("contentbox").removeAttribute("style");
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
         return d > 5000 ? '#800026' :
             d > 4000  ? '#BD0026' :
             d > 3000  ? '#E31A1C' :
             d > 2000  ? '#FC4E2A' :
             d > 1000   ? '#FD8D3C' :
             d > 500   ? '#FEB24C' :
             d > 250   ? '#FED976' :
                         '#FFEDA0';
     }

     //styling map
     function style(features) {
         return {
             fillColor: getColor(features.cases),
             weight: 2,
             opacity: 1,
             color: 'white',
             dashArray: '3',
             fillOpacity: 0.7
         };
     }
	
     var data_cases = ${trends};
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
     //reset function for highlight
     function resetHighlight(e) {
         geojson.resetStyle(e.target);
         document.getElementById("stateid").innerHTML ="Hover over a State";
         document.getElementById("span-confirmed").innerHTML = tabledata[0]['confirmed'];
       	document.getElementById("span-active").innerHTML = tabledata[0]['active'];
       	document.getElementById("span-recovered").innerHTML = tabledata[0]['recovered'];
       	document.getElementById("span-death").innerHTML = tabledata[0]['deaths'];
       	document.getElementById("span-testing").innerHTML = tabledata[0]['tested'];
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
             //click: highlightFeature  //with this, we will redirect to the individual state map
         });
     }

     //adding legend to the map
     var legend = L.control({position: 'bottomright'});
     legend.onAdd = function (map) {

         var div = L.DomUtil.create('div', 'info legend'),
             grades = [0, 250, 500, 1000, 2000, 3000, 4000, 5000],
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
  	   
  	   check();
  	   var dataset_y_confirmed = data_cases.hasOwnProperty(state_name)?trimData(data_cases[state_name]['y-confirmed']):trimData(data_cases["Total"]['y-confirmed']);
  	   genericlinechart("line-confirmed",trimData(dates),dataset_y_confirmed,"#ff0000","Confirmed Cases","rgba(255,7,58,.12549)");
  	   
  	   var dataset_y_active = data_cases.hasOwnProperty(state_name)?trimData(data_cases[state_name]['y-active']):trimData(data_cases["Total"]['y-active']);
  	   genericlinechart("line-active",trimData(dates),dataset_y_active,"#0000ff","Active Cases","rgba(0,123,255,.0627451)");
  	   
  	   var dataset_y_recovered = data_cases.hasOwnProperty(state_name)?trimData(data_cases[state_name]['y-recovered']):trimData(data_cases["Total"]['y-recovered']);
  	   genericlinechart("line-recovered",trimData(dates),dataset_y_recovered, "#006600","Recovered Cases","rgba(40,167,69,.12549)");
  	   
  	   var dataset_y_death = data_cases.hasOwnProperty(state_name)?trimData(data_cases[state_name]['y-death']):trimData(data_cases["Total"]['y-death']);
  	   genericlinechart("line-death",trimData(dates),dataset_y_death,"#595959","Death Cases","rgba(108,117,125,.0627451)");
  	   
  	   //genericlinechart("line-testing") - for testing graph...
     }
     
     function genericlinechart(canvasid,dataset_x,dataset_y,bordercolor,label,backgroundcolor){
    	var x = document.getElementById(canvasid);
    	x.height = 230;
    	x.style.backgroundColor = backgroundcolor;
  		var myLineChart = new Chart(document.getElementById(canvasid), {
  		    type: 'line',
  		    data: {
  		    	labels: dataset_x,
  		    	datasets:[{
  		    		label: label,
  		    		data: dataset_y,
  		    		fill: false,
  		    		lineTension: 0.1,
  	                borderColor: bordercolor,
  	                borderWidth: 1
  		    	}]
  		    },
  		    options: {
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
  	                        maxTicksLimit: 6
  	                    },
  		    		}],
  		    		tooltips:{
  		    			callbacks:{
  		    				beforeLabel: "Date: ",
  		    				label: function(tooltipItem){
  		    					console.log(tooltipItem);
  		    					return tooltipItem;
  		    				}
  		    			}
  		    		}
  	            }
  		    }
  		});
  	}
     
    var arimaChart = new Chart(document.getElementById(),{
    	type: 'line',
        data: {
            labels: [1, 2, 3, 4],
            datasets: [{
                label: "Min",
                backgroundColor: 'rgba(55, 173, 221,  0.6)',
                borderColor: 'rgba(55, 173, 221, 1.0)',
                fill: false,  //no fill here
                data: [5, 5, 3, 2] // data with the low values will come here
            },
            {
                label: "Max",
                backgroundColor: 'rgba(55, 173, 221, 0.6)',
                borderColor: 'rgba(55, 173, 221, 1.0)',
                fill: '-1', //fill until previous dataset
                data: [8, 7, 6, 5] // data with high values will come here
            },
            {
                type:'line',
                label:'Line Dataset',
                data:[2,3,7,6], // data with the optimal values will come here, also for the optimal values thing, i can even change the color of point based on the value...
                fill:'none',
                borderColor:'black',
            }]
        },
        options: {
            maintainAspectRatio: false,
            spanGaps: false,
            elements: {
                line: {
                    tension: 0.000001
                }
            },
            plugins: {
                filler: {
                    propagate: false
                }
            },
            scales: {
                xAxes: [{
                    ticks: {
                        autoSkip: false
                    }
                }]
            }
        }
    });
    
    //i'll put code for chart with changing colors based on value of point in comments, so then we can use it for changing to our liking later
    /*
    
    var colors = [];
	    var myLineChart = new Chart(document.getElementById("line-confirmed"), {
		    type: 'line',
		    data: {
		    	labels: data_cases["Total"]['x'],
		    	datasets:[{
                    label:'cases',
		    		data: data_cases["Total"]['y'],
		    		lineTension: 0.1,
                    borderColor: "#00ff00",
					pointBackgroundColor: colors,
                    borderWidth: 1,
					fill: false
		    	}]
		    },
		    options: {
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
  	                        maxTicksLimit: 6
  	                    },
  		    		}],
  		    		tooltips:{
  		    			title: function(tooltipItems, data){
							  console.log(tooltipItems);
							  return 'Date: '+tooltipItems.xLabel;
						  }
  		    		}
  	            }
		    }
		});
		for(let i = 0; i<myLineChart.data.datasets[0].data.length; i++){
			if(myLineChart.data.datasets[0].data[i]>180){
				colors.push("#ff3333");
			}
			else if(myLineChart.data.datasets[0].data[i]>100 && myLineChart.data.datasets[0].data[i]<180){
				colors.push("#ff6666");
			}
			else if(myLineChart.data.datasets[0].data[i]>50 && myLineChart.data.datasets[0].data[i]<100){
				colors.push("#ff9999");
			}
			else{
				colors.push("#ffcccc");
			}
		}

		myLineChart.update();
    
    */
  </script>
</body>
</html>