function radioClicked() {
        console.log("fff")
        fetch("http://localhost:3000/toggle", { credentials: 'same-origin' })
          .then((response) => {
            if (!response.ok) throw Error(response.statusText);
            console.log("manage to toggle")
          })
          .catch(error => console.log(error)); // eslint-disable-line no-console
      }


// var exec = require('child_process').exec;
// var shell = require('shelljs');
// shell.config.execPath = shell.which('node')
// // exec('pwd', function callback(error, stdout, stderr){
// //     let myNotification = new Notification('Autocompletion', {
// //                 body: stdout
// //               })
// // });
// shell.cd('~/autocomplete_copy_version/');

// shell.exec('export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.6/site-packages')

// exec('export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.6/site-packages', function callback(error, stdout, stderr){

//     let myNotification = new Notification('Autocompletion', {
//                 body: "loading model"
//               })
//     console.log("finish")
//     exec('./autocompletion-init.sh', function callback(error, stdout, stderr){
//         console.log(stdout)
//         console.log(stderr)
//         // let myNotification = new Notification('Autocompletion', {
//         //     body: stderr
//         //   })
//     });
    
// });

