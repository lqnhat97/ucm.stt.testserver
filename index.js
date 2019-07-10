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
});
app.use('/expert',(req,res)=>{
    res.render('./barcode');
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

global.io = require('socket.io')(http);
io.on("connection", (socket) => {
    console.log(socket.id);
    socket.on("genarateBarcode",(msg)=>{
        console.log(`msg: ${msg}`);
        socket.broadcast.emit("execBarcode",msg)
    })
    
})