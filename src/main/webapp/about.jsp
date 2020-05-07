<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  isELIgnored="false"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="en">

<head>
  <!-- India State Map  -->
  <title>India Map</title>

  <!-- CDN Links -->
  	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
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
  html,body{
  	width: 100%;
    margin: 0px;
    padding: 0px;
    overflow-x: hidden;
  }
  .ans{
  	color: #007bff;
  }
  
  </style>
</head>

<body>
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
	<div class = "container animate fadeInUp" style = "font-family: 'Source Sans Pro', sans-serif;">
		<div class = "row" style = "text-align: left; margin-top: 2%;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ques">Are we official?</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row"  style = "text-align: left; margin-bottom: 2%;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ans">No</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row" style = "text-align: left;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ques">What are our sources? From where do we get the data?</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row"  style = "text-align: left; margin-bottom: 2%;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ans">The data is validated by a group of volunteers and published into a Google sheet and an API. API is available for all at api.covid19india.org.</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row" style = "text-align: left;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ques">Who are we?</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row"  style = "text-align: left; margin-bottom: 2%;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ans">We are just two enthusiastic developers and rookie data analysts who wanted to do their bit to help the fight against covid. </h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row" style = "text-align: left;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ques">Is the project open sourced?</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row"  style = "text-align: left; margin-bottom: 2%;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ans">Yes! The project is completely open sourced. You can find the link to the Github Repo below.</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row" style = "text-align: left;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ques">Is the data updated daily?</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row"  style = "text-align: left; margin-bottom: 2%;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ans">Yes! Every time our server recieves a request, the latest data available in the API is fetched and rendered.</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row" style = "text-align: left;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ques">Are the ARIMA predictions accurate and to be believed?</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row"  style = "text-align: left; margin-bottom: 2%;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ans">We have made an effort at trying to predict the confirmed cases over the next ten days. But we aren't specialists in epidemiology so there are bound to be differences between what is actual and what is predicted.
These predictions are only meant to be taken as a worst case scenario and with a lot of caution. The assumptions made do not take into consideration public health interventions or any other parameters as such.</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row" style = "text-align: left;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ques">What is R0? What can i infer from it?</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row"  style = "text-align: left; margin-bottom: 2%;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ans">In any epidemic,  𝑅𝑡  is the measure known as the effective reproduction number. It's the number of people who become infected per infectious person at time 𝑡 . The most well-known version of this number is the basic reproduction number: 𝑅0, when  𝑡=0 . However,  𝑅0  is a single measure that does not adapt with changes in behavior and restrictions.As a pandemic evolves, increasing restrictions (or potential releasing of restrictions) changes  𝑅𝑡 . Knowing the current  𝑅𝑡  is essential. When  𝑅≫1 , the pandemic will spread through a large part of the population. If  𝑅𝑡<1 , the pandemic will slow quickly before it has a chance to infect many people. The lower the  𝑅𝑡 : the more manageable the situation. In general, any  𝑅𝑡<1  means things are under control.</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row" style = "text-align: left;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ques">Why isn't R0 being calculated on a National level?</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row"  style = "text-align: left; margin-bottom: 2%;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ans">It is not useful to understand  𝑅𝑡  at a national level. Instead, to manage this crisis effectively, we need a local (state, county and/or city) granularity of  𝑅𝑡 .</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row" style = "text-align: left;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ques">What does Max, Min and Most likely mean in the R0 graph?</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row"  style = "text-align: left; margin-bottom: 2%;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ans">Max and Min indicate the range of values R0 could have been on that particular day. This range is huge at the beginning of an epidemic as we do not have much data about it. But as we gather more data, we can see that the area between the Max and Min lines start becoming narrow and begin to coincide with Most Likely R0 plot.</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row" style = "text-align: left;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ques">What is the methodology being used to calculate R0?</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row"  style = "text-align: left; margin-bottom: 2%;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ans">It's a modified version of a solution created by Bettencourt & Ribeiro in 2008 to estimate real-time  𝑅𝑡  using a Bayesian approach. We have used this model to estimate a time-varying  𝑅𝑡 .</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row" style = "text-align: left;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ques">What are the tools being used for the backend?</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row"  style = "text-align: left; margin-bottom: 2%;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ans">Java sevlets powered by maven is being used as a backend for our project along with jsp as a templating engine. It runs on a tomcat server and is hosted on heroku. Thank you @heroku!.</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row" style = "text-align: left;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ques">What are the tools being used for the forntend?</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row"  style = "text-align: left; margin-bottom: 2%;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<h3 class = "ans">We love Bootstrap4 as other web devs do and have used it as our main layout engine. Chart.js is used for all the graphs. Leaflet.js has been used to render the maps.</h3>
			</div>
			<div class = "col-sm-2"></div>
		</div>
		<div class = "row" style = "text-align: center; margin-bottom: 2%;">
			<div class = "col-sm-2"></div>
			<div class = "col-sm-8">
				<button class = "btn btn-dark">
					<i class="fab fa-github" style = "font-size: 30px; margin-left: -5%; margin-right: 5%;"></i>
					<span>
						<a href = "https://github.com/menon99/Indiacovid19" style = "color: white; font-family: 'Source Sans Pro', sans-serif; text-decoration: none; font-size: 24px;">OPEN SOURCED ON GITHUB</a>
					</span>
				</button>
			</div>
			<div class = "col-sm-2"></div>
		</div>
	</div>
</body>
</html>