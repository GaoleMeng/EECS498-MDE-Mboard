function autocomplete(words) {

    var request = require('request');
    var deasync = require("deasync");
    var options = {
        url: 'http://localhost:8080/' + words,

    };

    var result;
    function callback(error, response, body) {
        if (error) {
            
            // console.error(error);
            return error;
        }
        if (!error && response.statusCode == 200) {
            // console.log(body)
            result = body;
        }
    }
    request(options, callback);
    while ((result == null)) {
        deasync.runLoopOnce()
    }
    
    return result
    // return "wordA;wordB;wordC;wordD"
}

// console.log(autocomplete("I_want"))
// console.log(autocomplete("I_wan"))
// console.log(autocomplete("Stan_"))
// console.log(autocomplete("Compute_"))
// autocomplete("!exit")
