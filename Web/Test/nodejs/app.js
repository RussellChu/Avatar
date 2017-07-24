var express = require('express');
var app = express();

var http = require('http');
var fs = require('fs');

fs.readFile('./index.html', function (err, html) {
    if (err) {
        throw err; 
    }       
    // http.createServer(function(request, response) {  
        // response.writeHeader(200, {"Content-Type": "text/html"});  
        // response.write(html);  
        // response.end();  
    // }).listen(8000);

	app.get('/', function (req, res) {
	  res.writeHeader(200, {"Content-Type": "text/html"});
	  res.write(html);
	  res.end();
	});
	
	app.listen(5123, function () {
	  console.log('Example app listening on port 5123!');
	});
});

