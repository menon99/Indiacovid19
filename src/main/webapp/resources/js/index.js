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
	   center:[23.0, 83.1015625], 
	   zoom:5, 
	   scrollWheelZoom: false
	   });
   var geojson;
   var info;
   map.dragging.disable();
   //updating json data to the map
   d3.json("./resources/json/india_states_final.json", function (json){
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
               '<b style = "font-family: archia">State: ' + json.properties.st_nm + '</b><br /><span style = "color: red; font-family: archia">Cases confirmed:' + json.cases + '</span><br>'
               + '<span style = "color: blue;font-family: archia">Active: '+'some number'+'</span><br>'+'<span style = "color: green;font-family: archia">Recovered: '+'some number'+'</span><br>'
               +'<span style = "color: grey;font-family: archia">Death: '+'some number'+'</span>'
               : 'Hover over a state');
       };
       info.addTo(map);
   });

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

   var data_cases = { "Delhi" :{ 
	   'y-confirmed' :[1,2,3,6,8,14,30,50,80,89],
	   'y-active' :[1,2,3,6,7,11,23,35,68,79],
	   'y-recovered' :[0,1,2,2,4,5,7,13,16,30],
	   'y-death' :[1,2,3,6,8,14,30,50,80,89],
   		}, 
	   "Jammu and Kashmir" :{ 
		   'y-confirmed' :[7,9,13,16,28,34,40,58,78,90],
		   'y-active' :[1,2,3,6,8,14,30,50,80,89],
		   'y-recovered' :[3,4,7,7,8,10,16,20,30,40],
		   'y-death' :[3,3,4,5,8,8,20,30,38,50],
   		},
   		"Total" :{ 
 		 'y-confirmed' :[17,29,39,56,78,94,114,135,178,250], 
 		 'y-active' :[15,26,35,55,78,94,112,125,168,230],
 		 'y-recovered' :[1,2,3,6,8,14,30,50,80,89],
 		 'y-death' :[13,12,13,36,48,54,73,105,118,138],
    	}
   		};
   //highlighting the features in map
   function highlightFeature(e) {
       var layer = e.target;
       console.log(data_cases);
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
   function lineChart(state_name,data_cases){
	   
	   var dates=["03/19/2020","03/20/2020","03/21/2020","03/23/2020","03/24/2020","03/27/2020","03/30/2020","04/01/2020","04/14/2020","04/19/2020"];
	   
	   var dataset_y_confirmed = data_cases.hasOwnProperty(state_name)?data_cases[state_name]['y-confirmed']:data_cases["Total"]['y-confirmed'];
	   //for i in 
	   genericlinechart("line-confirmed",dates,dataset_y_confirmed,"#ff0000","Confirmed Cases");
	   var dataset_y_active = data_cases.hasOwnProperty(state_name)?data_cases[state_name]['y-active']:data_cases["Total"]['y-active'];
	   genericlinechart("line-active",dates,dataset_y_active,"#0000ff","Active Cases");
	   var dataset_y_recovered = data_cases.hasOwnProperty(state_name)?data_cases[state_name]['y-recovered']:data_cases["Total"]['y-recovered'];
	   genericlinechart("line-recovered",dates ,dataset_y_recovered, "#00ff99","Recovered Cases" );
	   var dataset_y_death = data_cases.hasOwnProperty(state_name)?data_cases[state_name]['y-death']:data_cases["Total"]['y-death'];
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