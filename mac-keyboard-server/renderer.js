// the server running on the mac
//import { autocomplete } from './autocompletion.js'
// ../autocompletion/
const express = require('express')
const app = express()
const robot = require("robotjs")
const ip = require("ip")
// import { }
// 
var keyEnable = false
var bodyParser = require("body-parser");
app.use(bodyParser.json());


app.set('toggle', false)
app.set('mousedown', false)
app.set('ip', ip.address())



//var tools = require('./autocompletion.js')

/*function autocomplete(words) {
    console.log(words)
    //var request = require('request');

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
    return "wordA;wordB;wordC"
}*/

/*app.get('/pred/:char', (req, res) => {
    res_data = {
        "pred": "wordA;wordB;wordC"
    }
    res.json(res_data)
})*/

app.get('/pred/:char', (req, res) => {
    //console.log("xxxx")
    let start = app.get('toggle')
    let string = req.params.char
    console.log(string)

    robot.mouseToggle("up")
    //console.log("yyyy")
    //res.json(res_data)

    fetch('http://localhost:8080/' + string, {
          method: 'GET',
          headers: new Headers({
            'Content-Type': 'application/json'
          })
        })
      .then((response) => {
        if (!response.ok) throw Error(response.statusText);
        console.log(response.body)
        return response.json()
      })
      .then((data) => {
        console.log(this.a)
        console.log(data)
        res.json(data)
        // this.result = data
        // return data
        // console.log("sended")
        // console.log(data)
      })
      .catch(error => console.log(error)) // eslint-disable-line no-console
})

app.get('/input/:char', (req, res) => {
    // let string = req.params.char
    // robot.typeString("abc")
    // console.log(keyboard)
    // if ()
    console.log("trigger")

    robot.mouseToggle("up")

    let start = app.get('toggle')
    if (start){
        robot.setKeyboardDelay(0)
        let string = req.params.char

        if (string == "key_space") {
            robot.keyTap("space")
        }
        else if (string == "key_delete") {
            robot.keyTap("backspace")
        }
        else if (string == "up" || string == "down" || string == "right" || string == "left") {
            robot.keyTap(string)
        }
        else if (string == "key_newline") {
            robot.keyTap("enter")
        }
        else if (string == "key_quotation") {
            robot.typeString("\"")
        }
        else if (string == "key_question") {
            robot.typeString("?")
        }
        else if (string == "key_less") {
            robot.typeString("<")
        }
        else if (string == "key_more") {
            robot.typeString(">")
        }
        else if (string == "key_lbracket") {
            robot.typeString("{")
        }
        else if (string == "key_rbracket") {
            robot.typeString("}")
        }
        else if (string == "key_slash") {
            robot.typeString("/")
        }
        else if (string == "key_percent") {
            robot.typeString("%")
        }
        else if (string == "key_exclam") {
            robot.typeString("!")
        }
        else if (string == "key_hashtag") {
            robot.typeString("#")
        }
        else{
            let string_list = string.split("_")
            console.log(string_list)
            if (string_list.length == 1) {
                robot.typeString(string)
            } 
            else {
                robot.typeString(string_list[0] + " ")
            }
        }
        res.send("keyboard type")

    }
    else {
        res.send("the keyboard is off")
    }
})


// app.post('/api/move', (req, res) => {
//     // let string = req.params.char
//     // robot.typeString("abc")
//     // console.log(keyboard)
//     // if ()

//     let start = app.get('toggle')
//     console.log(start)
//     if (start){
//         let string = req.params.char
//         console.log(string)

//         if (string == "key_space") {
//             robot.keyTap("space")
//         }
//         else if (string == "key_delete") {
//             robot.keyTap("backspace")
//         }
//         else if (string == "up" || string == "down" || string == "right" || string == "left") {
//             robot.keyTap(string)
//         }
//         else if (string == "key_newline") {
//             robot.keyTap("enter")
//         }
//         else if (string == "key_quotation") {
//             robot.keyTap("\"")
//         }
//         else if (string == "key_question") {
//             robot.keyTap("?")
//         }
//         else if (string == "key_less") {
//             robot.keyTap("<")
//         }
//         else if (string == "key_more") {
//             robot.keyTap(">")
//         }
//         else if (string == "key_lbracket") {
//             robot.keyTap("{")
//         }
//         else if (string == "key_rbracket") {
//             robot.keyTap("}")
//         }
//         else if (string == "key_slash") {
//             robot.keyTap("/")
//         }
//         else{
//             robot.typeString(string)
//         }
//         res.send("keyboard type")

//     }
//     else {
//         res.send("the keyboard is off")
//     }
// })


app.get('/api/mouseToggle', (req, res) => {
    robot.setMouseDelay(0)
    res.setHeader('Content-Type', 'application/json')
    let start = app.get('toggle')
    if (start) {
        let whetherdown = app.get('mousedown')
        if (whetherdown) {
            robot.mouseToggle("down")
            app.set('mousedown', false)
        }
        else {
            robot.mouseToggle("up")
            app.set('mousedown', true)
        }
    }

    res_data = {
        "status": "mouse move"
    }
    res.json(res_data)
})


app.get('/api/mouseup', (req, res) => {
    robot.setMouseDelay(0)
    res.setHeader('Content-Type', 'application/json')
    let start = app.get('toggle')
    console.log("sss!")
    if (start) {
        robot.mouseToggle("up")
    }

    res_data = {
        "status": "mouse move"
    }
    res.json(res_data)
})



app.get('/api/mousedown', (req, res) => {
    robot.setMouseDelay(0)
    res.setHeader('Content-Type', 'application/json')
    let start = app.get('toggle')
    if (start) {
        robot.mouseToggle("down")
    }

    res_data = {
        "status": "mouse move"
    }
    res.json(res_data)
})


app.get('/api/moveMouse/:xx/:yy', (req, res) => {
    robot.setMouseDelay(0)
    res.setHeader('Content-Type', 'application/json')

    let start = app.get('toggle')
    if (start){
        let x = parseFloat(req.params.xx)
        let y = parseFloat(req.params.yy)
        robot.moveMouse(robot.getMousePos().x + x, robot.getMousePos().y + y)
    }
    // console.log(robot.getMousePos())
    res_data = {
        "status": "mouse move"
    }
    res.json(res_data)
})



app.get('/api/dragMouse/:xx/:yy', (req, res) => {
    robot.setMouseDelay(0)
    res.setHeader('Content-Type', 'application/json')

    let start = app.get('toggle')
    if (start){
        let x = parseFloat(req.params.xx)
        let y = parseFloat(req.params.yy)
        robot.mouseToggle("down");
        robot.dragMouse(robot.getMousePos().x + x, robot.getMousePos().y + y)
        // robot.mouseToggle("up");

    }
    // console.log(robot.getMousePos())
    res_data = {
        "status": "mouse move"
    }
    res.json(res_data)
})



app.get('/api/scrollMouse/:xx/:yy', (req, res) => {
    robot.setMouseDelay(0)
    res.setHeader('Content-Type', 'application/json')

    let start = app.get('toggle')
    if (start){
        let x = parseFloat(req.params.xx)
        let y = parseFloat(req.params.yy)

        robot.scrollMouse(x, y)
    }
    // console.log(robot.getMousePos())
    res_data = {
        "status": "mouse scoroll"
    }
    res.json(res_data)
})


app.get('/leftclick', (req, res) => {

    res.setHeader('Content-Type', 'application/json')

    let start = app.get('toggle')
    if (start) {
        robot.mouseClick()
    }
    
    res_data = {
        "status": "left click"
    }
    res.json(res_data)
})

app.get('/doubleClick', (req, res) => {

    res.setHeader('Content-Type', 'application/json')

    let start = app.get('toggle')
    if (start) {
        robot.mouseClick('left', true)
    }
    
    res_data = {
        "status": "left click"
    }
    res.json(res_data)
})

app.get('/connect', (req, res) => {

    res.setHeader('Content-Type', 'application/json')

    let myNotification = new Notification('Keyboard Found', {
        body: 'Connected from ipad keyboard'
      })
  
    res.json(res_data)
})

app.get('/lightup', (req, res) => {
    res.setHeader('Content-Type', 'application/json')

    let start = app.get('toggle')
    if (start) {
        robot.keyTap('lights_mon_up')
    }
   
    res_data = {
        "status": "right click"
    }
    res.json(res_data)
})


app.get('/lightdown', (req, res) => {
    res.setHeader('Content-Type', 'application/json')

    let start = app.get('toggle')
    if (start) {
        robot.keyTap('lights_mon_down')
    }
   
    res_data = {
        "status": "right click"
    }
    res.json(res_data)
})


app.get('/volumnup', (req, res) => {
    res.setHeader('Content-Type', 'application/json')

    let start = app.get('toggle')
    if (start) {
        robot.keyTap('audio_vol_up')
    }
   
    res_data = {
        "status": "right click"
    }
    res.json(res_data)
})


app.get('/volumndown', (req, res) => {
    res.setHeader('Content-Type', 'application/json')

    let start = app.get('toggle')
    if (start) {
        robot.keyTap('audio_vol_down')
    }
   
    res_data = {
        "status": "right click"
    }
    res.json(res_data)
})




app.get('/rightclick', (req, res) => {

    res.setHeader('Content-Type', 'application/json')

    let start = app.get('toggle')
    if (start) {
        robot.mouseClick('right')
    }
   
    res_data = {
        "status": "right click"
    }
    res.json(res_data)
})



app.get('/toggle', (req, res) => {
    let start = app.get('toggle')
    if (start) {
        app.set('toggle', false)
        res.send("manage")
    }
    else {
        app.set('toggle', true)
        res.send("manage")
    }

})


app.get('/show', (req, res) => {
    
    console.log(robot.getMousePos())
})




app.listen(3000, () => {
    // TO do: parse the ip address to server

    let ip = app.get('ip')
    let data_body = {
        'name': "brad",
        'ip': ip
    }
    console.log(ip)
    fetch("https://mboard-middle-server.herokuapp.com/api/sendip/", {
              method: 'POST',
              body: JSON.stringify(data_body),
              name: "brad",
              ip: ip,
              headers: new Headers({
                'Content-Type': 'application/json'
              })
            })
          .then((response) => {
            if (!response.ok) throw Error(response.statusText);
            return response.json()
          })
          .then((data) => {
            console.log("sended")
            console.log(data)
          })
          .catch(error => console.log(error)) // eslint-disable-line no-console

    console.log('The M-board has started!')
})



// console.log("fff")

