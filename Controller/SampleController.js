var sampleDb = require('../Repos/sampleRepos');
var express = require('express');
var router = express.Router();

router.get('/', (req, res) => {
    sampleDb.loadBacsi().then(rows => {
        res.json(rows.recordsets)
        res.end(200);
    })
})

module.exports = router;