var express = require('express'),
    bodyParser = require('body-parser'),
    morgan = require('morgan');
var cors = require('cors');
app = express();
app.use(express.static('Public'));
app.use(morgan('dev'));
app.use(bodyParser.json());
app.use(cors());
var port = process.env.PORT || 8088;
var http = require('http').Server(app);


http.listen(port, () => {
    console.log('Connected at port:' + port);
})