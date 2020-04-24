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
           this._div.innerHTML = '<h4 style = "font-family: archia">Covid-19 Cases</h4>' +  (json ?
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

   //highlighting the features in map
   function highlightFeature(e) {
       var layer = e.target;

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