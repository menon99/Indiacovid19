//function to handle contentbox and mapbox size
  function resizefunc(){
        if(screen.width>1000){
            document.getElementById("contentbox").removeAttribute("class");
            document.getElementById("mapbox").removeAttribute("class");
            document.getElementById("contentbox").setAttribute("class","col-sm-5");
            document.getElementById("mapbox").setAttribute("class","col-sm-7");
        }
        else{
            document.getElementById("contentbox").removeAttribute("class");
            document.getElementById("mapbox").removeAttribute("class");
            document.getElementById("contentbox").setAttribute("class","col-sm-4");
            document.getElementById("mapbox").setAttribute("class","col-sm-8");
        }
    }
// initialize the map and other variables
   var map = L.map('map',{
	   center:[10.5,78.67], 
	   zoom:7, 
	   scrollWheelZoom: false
	   });
   var geojson;
   var info;
   var state_json;
   map.dragging.disable();
   //updating json data to the map
   d3.json("./resources/json/tamilnadu_testing.json", function (json){
	   state_json = json;
	   console.log(state_json.features.cases);
	   geojson = L.geoJson(json, {
           style: style,
           onEachFeature: onEachFeature
       });
       geojson.addTo(map);
       info = L.control();

       info.onAdd = function (map) {
           this._div = L.DomUtil.create('div', 'info'); // create a div with a class "info"
           this.update();
           return this._div;
       };
       info.update = function (json,data) {
           this._div.innerHTML = '<h4 style = "font-family: archia;">Covid-19 Cases</h4>' +  (json ?
               '<b style = "font-family: archia">District: ' + json.properties.district + '</b><br /><span style = "color: red; font-family: archia">Cases confirmed:' + json.cases + '</span><br>'
               + '<span style = "color: blue;font-family: archia">Active: '+'some number'+'</span><br>'+'<span style = "color: green;font-family: archia">Recovered: '+'some number'+'</span><br>'
               +'<span style = "color: grey;font-family: archia">Death: '+'some number'+'</span>'
               : 'Hover over a state');
       };
       info.addTo(map);
   });
   
   //getting the color values for filling the map
   function getColor(d) {
	   let max = 0;
	   
	   //console.log(max);
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

   var data_cases = { "Ramanathapuram" :{ 
	   'y-confirmed' :[1,2,3,6,8,14,30,50,80,89],
	   'y-active' :[1,2,3,6,7,11,23,35,68,79],
	   'y-recovered' :[0,1,2,2,4,5,7,13,16,30],
	   'y-death' :[1,2,3,6,8,14,30,50,80,89],
   		}, 
	   "Thiruvallur" :{ 
		   'y-confirmed' :[7,9,13,16,28,34,40,58,78,90],
		   'y-active' :[1,2,3,6,8,14,30,50,80,89],
		   'y-recovered' :[3,4,7,7,8,10,16,20,30,40],
		   'y-death' :[3,3,4,5,8,8,20,30,38,50],
   		},
   		"Chennai" :{ 
 		 'y-confirmed' :[17,29,39,56,78,94,114,135,178,250], 
 		 'y-active' :[15,26,35,55,78,94,112,125,168,230],
 		 'y-recovered' :[1,2,3,6,8,14,30,50,80,89],
 		 'y-death' :[13,12,13,36,48,54,73,105,118,138],
    	}
   		};
   //highlighting the features in map
   function highlightFeature(e) {
       var layer = e.target;
       //console.log(data_cases);
       lineChart(layer.feature.properties.district,data_cases);

       layer.setStyle({
           weight: 5,
           color: '#ff3300',
           dashArray: '',
           fillOpacity: 0.7
       });

       if (!L.Browser.ie && !L.Browser.opera && !L.Browser.edge) {
           layer.bringToFront();
       }

       info.update(layer.feature);
   }

   //reset function for highlight
   function resetHighlight(e) {
       geojson.resetStyle(e.target);
       info.update();
   }

   //leaflet zoom feature on click function
   function zoomToFeature(e) {
       map.fitBounds(e.target.getBounds());
   }

   //function governing each feature
   function onEachFeature(feature, layer) {
       layer.on({
           mouseover: highlightFeature,
           mouseout: resetHighlight
           //click: zoomToFeature  --  with this, we will redirect to the individual state map
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
   
   
   //generic line chart making function
   function lineChart(district_name,data_cases){
	   
	   var dates=["03/19/2020","03/20/2020","03/21/2020","03/23/2020","03/24/2020","03/27/2020","03/30/2020","04/01/2020","04/14/2020","04/19/2020"];
	   
	   var dataset_y_confirmed = data_cases.hasOwnProperty(district_name)?data_cases[district_name]['y-confirmed']:data_cases["Chennai"]['y-confirmed'];
	   //for i in 
	   genericlinechart("line-confirmed",dates,dataset_y_confirmed,"#ff0000","Confirmed Cases");
	   var dataset_y_active = data_cases.hasOwnProperty(district_name)?data_cases[district_name]['y-active']:data_cases["Chennai"]['y-active'];
	   genericlinechart("line-active",dates,dataset_y_active,"#0000ff","Active Cases");
	   var dataset_y_recovered = data_cases.hasOwnProperty(district_name)?data_cases[district_name]['y-recovered']:data_cases["Chennai"]['y-recovered'];
	   genericlinechart("line-recovered",dates ,dataset_y_recovered, "#00ff99","Recovered Cases" );
	   var dataset_y_death = data_cases.hasOwnProperty(district_name)?data_cases[district_name]['y-death']:data_cases["Chennai"]['y-death'];
	   genericlinechart("line-death",dates,dataset_y_death,"#bfbfbf","Death Cases");
	   //confirmed cases #ff0000
	   
   }
   
   function genericlinechart(canvasid,dataset_x,dataset_y,bordercolor,label){
		var myLineChart = new Chart(document.getElementById(canvasid), {
		    type: 'line',
		    data: {
		    	labels: dataset_x,
		    	datasets:[{
		    		label: label,
		    		data: dataset_y,
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
	                }]
	            }
		    }
		});
	}
   
   var state_coords_zoom = {
		   "Andaman and Nicobar Islands" : {
			    "coords": [10.498614480162155,92.548828125],
			    "zoom": 7
			    },
			"Andhra Pradesh" : {
			    "coords": [15.982453522973508,81],
			    "zoom": 7
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
			"Chattisgarh" : {
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
			    "coords": [22.857194700969636,72.24609375],
			    "zoom": 7
			    },
			"Haryana" : {
			    "coords": [29.084976575985912,76.387939453125],
			    "zoom": 7
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
			    "coords": [23.53377298325595,79.211669921875],
			    "zoom": 7
			    },
			"Maharashtra" : {
			    "coords": [19.145168196205297,77],
			    "zoom": 7
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
			"Orissa" : {
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
			    "zoom": 7
			    },
			"Sikkim" : {
			    "coords": [27.595934774495056,88.48388671874999],
			    "zoom": 9
			    },
			"Tamil Nadu" : {
			    "coords": [10.5,78.67],
			    "zoom": 7
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
			    "zoom": 7
			    },
			"West Bengal" : {
			    "coords": [23.8,88.077392578125],
			    "zoom": 7
			    },
			}