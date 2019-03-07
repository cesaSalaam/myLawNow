// server.js
    // set up ========================
    var express  = require('express');
    var app      = express();
    var accountSid = 'AC5334081dfb4c5325ae73834f63186332'; //This are found in the twilio account. Becareful to never upload these keys to github.
    var authToken = 'ed09956518657bf159211bcc0ff0c0d0';
//Twilio
    var twilio = require('twilio')(accountSid, authToken);

  app.set('port', (process.env.PORT || 5000));

app.get('/verify/sms', function(req, res) {
    //This end points returns and 4 digit code. Right now it's letters and numbers.
    //Example of how to hit this endpoint http://localhost:8100/verify/sms?number=2025538298

    var stringGen = function(len)
    {
      var text = "";

      var charset = "abcdefghijklmnopqrstuvwxyz0123456789";

      for( var i=0; i < len; i++ )
      text += charset.charAt(Math.floor(Math.random() * charset.length));

      return text;
    };

    var rand = stringGen(4);
    console.log(req.query);

    if(req.query.number){

      twilio.messages.create({
      to: req.query.number,
      from: "+12027938486",
      body: "Your MyLawNow code is: " + rand
    }, function(err, message) {

    if(err){
      //Send a status 400 if there is an error with twilio.
      res.status(400);
      res.send("BAD REQUEST");
      console.log(err);
      console.log("this is a twiio err");

    }else{
      res.status(200);
      res.json({
      status: "SUCCESS",
      code: rand});
    }
  });

  }else{
    //Send a status 400 if there is an error with the parameters.
    res.status(400);
    res.send("BAD REQUEST");
    console.log("this is a params err");
  }

});

app.get('/call/room', function(req, res) {
    //This end points returns and 4 digit code. Right now it's letters and numbers.
    //Example of how to hit this endpoint http://localhost:8100/call/room?number=GruveoRocks

    console.log(req.query);

    if(req.query.id){

      twilio.messages.create({
      to: "+12025538298",
      from: "+12027938486",
      body: "Your MyLawNow meeting link: " + req.query.id + ". Please call in now."
    }, function(err, message) {

    if(err){
      //Send a status 400 if there is an error with twilio.
      res.status(400);
      res.send("BAD REQUEST");
      console.log(err);
      console.log("this is a twiio err");

    }else{
      res.status(200);
      res.json({
      status: "SUCCESS",
      code: rand});
    }
  });

  }else{
    //Send a status 400 if there is an error with the parameters.
    res.status(400);
    res.send("BAD REQUEST");
    console.log("this is a params err");
  }

});


app.get('/*', function(req, res) { //route all other  requests here
          res.status(200);
          res.send("<b>THE SERVER IS RUNNING</b>");
}).listen(app.get('port'), function() {
    console.log('App is running, server is listening on port ', app.get('port'));
});
module.exports = app;
