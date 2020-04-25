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
  
  <!--  Styles  -->
  <style type="text/css">
    body {
      font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
    }

    svg {
      background: #f7f7f7;
    }

    #india {
      /*    fill: #00BCD4;
      opacity: .7; */
      stroke: #101010;
      stroke-width: .6;
    }

    div.tooltip {
      position: absolute;
      text-align: center;
      padding: 0.5em;
      font-size: 10px;
      color: #222;
      background: #FFF;
      border-radius: 2px;
      pointer-events: none;
      box-shadow: 0px 0px 2px 0px #a6a6a6;
    }

    .key path {
        display: none;
    }

    .key line {
        stroke: #000;
        shape-rendering: crispEdges;
    }

    .key text {
        font-size: 10px;
    }

    .key rect{
      stroke-width: .4;
    }

  </style>
</head>

<body>
	<nav class="navbar navbar-dark bg-dark justify-content-between">
	  <a class="navbar-brand"><span style = "color: white">COVID-19 Analysis</span></a>
	  <form class="form-inline">
	    <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
	    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
	  </form>
	</nav>
	<div class = "container">
		<center>
			<div id="chart"></div>
		</center>	
	</div>
	
  <script src="http://d3js.org/d3.v3.min.js"></script>
  <script src="http://d3js.org/topojson.v1.min.js"></script>

  <script src="d3.geo.min.js"></script>
  
  <script type="text/javascript">
    var w = 600;
    var h = 650;
    var proj = d3.geo.mercator();
    var path = d3.geo.path().projection(proj);
    var buckets = 9,
      colors = ["#FDE2E2", "#FDD4D4", "#FFC0C0", "#FFADAD", "#FE9393", "#FC8787", "#FC6D6D", "#FE4E4E", "#FC1F1F"]; 

    var map = d3.select("#chart").append("svg")
      .attr("width", w)
      .attr("height", h)
      .attr("viewBox","0 0 "+w+" "+h)
      .attr("preserveAspectRatio","xMidYMid meet")
      //.call(d3.behavior.zoom().on("zoom", redraw))
      .call(initialize);

    var india = map.append("g")
      .attr("id", "india");

    var div = d3.select("body").append("div")
      .attr("class", "tooltip")
      .style("opacity", 0);

    d3.json("tamilnadu_testing.json", function (json) {

      var maxTotal = d3.max(json.features, function (d) { return d.cases });

      var colorScale = d3.scale.quantile()
        .domain(d3.range(buckets).map(function (d) { return (d / buckets) * maxTotal }))
        .range(colors);


      var y = d3.scale.linear()
        .domain([0, 10000])
        .range([0,8000]);

      var yAxis = d3.svg.axis()
          .scale(y)
          .tickValues(colorScale.domain())
          .orient("right");


      india.selectAll("path")
        .data(json.features)
        .enter()
        .append("path")
        .attr("d", path)
        .style("fill", colors[0])
        .style("opacity", 1)

        .on('mouseenter', function (d, i) {
          div.transition().duration(300)
            .style("opacity", 1)
          div.html("District: "+d.properties.district + "<br>"+" Cases: " + d.cases)
            .style("background-color","#A3B6EB")
            .style("left", (d3.event.pageX) + "px")
            .style("top", (d3.event.pageY - 30) + "px");
        })

        .on('click', function (d, i) {
          console.log(d.properties.st_nm);
          let url = "Indiacovid19/" + encodeURIComponent(d.properties.st_nm);
          console.log(url);
          //window.location.href = url;
        })

        .on('mouseleave', function (d, i) {
          d3.select(this).transition().duration(300)
            .style("opacity", 1);
          div.transition().duration(300)
            .style("opacity", 0);
        });

      india.selectAll("path").transition().duration(1000)
        .style("fill", function (d) { return colorScale(d.cases); });



      //Adding legend for our Choropleth

     
      var g = india.append("g")
                .attr("class", "key")
                .attr("transform", "translate(435, 335)")
                .call(yAxis);

            g.selectAll("rect")
                .data(colorScale.range().map(function(d, i) {
                    return {
                        y0: i ? y(colorScale.domain()[i - 1]) : y.range()[0],
                        y1: i < colorScale.domain().length ? y(colorScale.domain()[i]) : y.range()[1],
                        z: d
                    };
                }))
                .enter().append("rect")
                    .attr("width", 8)
                    .attr("y", function(d) { return d.y0; })
                    .attr("height", function(d) { return d.y1 - d.y0; })
                    .style("fill", function(d) { return d.z; });


    });

    function initialize() {
      proj.scale(6700);
      proj.translate([-1200, 550]);
    }
  </script>
</body>

</html>