function autocomplete(words) {

    var request = require('request');

    // var options = {
    //     url: 'http://localhost:8080/' + words,

    // };

    // function callback(error, response, body) {
    //     if (error) {
    //         // console.error(error);
    //         return error;
    //     }
    //     if (!error && response.statusCode == 200) {
    //         // console.log(body)
    //         return body;
    //     }
    // }

    // return request(options, callback);
    return "wordA;wordB;wordC;wordD"
}

console.log(autocomplete("I_want"))
console.log(autocomplete("I_wan_"))
console.log(autocomplete("Stan_"))
console.log(autocomplete("Compute"))
// autocomplete("!exit")
