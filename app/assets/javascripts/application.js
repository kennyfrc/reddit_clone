// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap

var blocmetrics = {}; // we want to namespace this because we don't want it to "collide" with other code
  blocmetrics.report = function(eventName){
    var event = { name: eventName}; // you had an event object earlier. assign eventname to the name attribute
    var request = new XMLHttpRequest(); // instantiate a new XMLHttpRequest. This is
                                  // an API that provides client funcitonality for transferring data
                                  // between a client and a server
    request.open("POST", "http://localhost:8080/api/events", true); // sends a POST request to a specific url. true is for performign the task asynchronously
    request.setRequestHeader('Content-Type', 'application/json'); // sets the value of a request header as part of a SET OF RULES (protocol) in the HTTP framework for sending and receving HTTP
    request.send(JSON.stringify(event)); // send the request (stringified)
  };

