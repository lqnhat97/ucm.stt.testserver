var express = require('express'),
    bodyParser = require('body-parser'),
    morgan = require('morgan');
var cors = require('cors');

//example
var sampleController = require('./Controller/SampleController');
//patient
var patientController = require('./Controller/PatientController');
//clinic
var clinicController = require('./Controller/ClinicController');
//history
var historyController = require('./Controller/HistoryController');
app = express();

//use public folder
app.use(express.static('BarcodeService'));
app.set("view engine", "ejs");
app.set('views','./BarcodeService');
app.use('/home',(req,res)=>{
    res.render('./barcodeExample');
})
app.use(express.static('Public'));
app.use(morgan('dev'));
app.use(bodyParser.json());
app.use(cors());
var port = process.env.PORT || 8088;
var http = require('http').Server(app);

//routing
app.use('/test', sampleController);
app.use('/patient',patientController);
app.use('/clinic',clinicController);
app.use('/history',historyController);

http.listen(port, () => {
    console.log('Connected at port:' + port);
})