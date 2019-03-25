var express = require('express'),
    bodyParser = require('body-parser'),
    morgan = require('morgan');
var cors = require('cors');

//example
var sampleController = require('./Controller/SampleController');
//patient
var patientController = require('./Controller/PatientController');


app = express();
app.use(express.static('Public'));
app.use(morgan('dev'));
app.use(bodyParser.json());
app.use(cors());
var port = process.env.PORT || 8088;
var http = require('http').Server(app);

//routing
app.use('/test', sampleController);
app.use('/patient',patientController);
http.listen(port, () => {
    console.log('Connected at port:' + port);
})