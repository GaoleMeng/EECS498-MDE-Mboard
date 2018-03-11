// the server running on the mac

const express = require('express')
const app = express()
const robot = require("robotjs")
const ip = require("ip")
var keyEnable = false
var bodyParser = require("body-parser");
app.use(bodyParser.json());

app.set('toggle', false)
app.set('ip', ip.address())


app.get('/input/:char', (req, res) => {
    // let string = req.params.char
    // robot.typeString("abc")
    // console.log(keyboard)
    // if ()

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
        else{
            robot.typeString(string)
        }
        res.send("keyboard type")

    }
    else {
        res.send("the keyboard is off")
    }
})


app.post('/api/move', (req, res) => {
    // let string = req.params.char
    // robot.typeString("abc")
    // console.log(keyboard)
    // if ()

    let start = app.get('toggle')
    console.log(start)
    if (start){
        let string = req.params.char
        console.log(string)

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
            robot.keyTap("\"")
        }
        else if (string == "key_question") {
            robot.keyTap("?")
        }
        else if (string == "key_less") {
            robot.keyTap("<")
        }
        else if (string == "key_more") {
            robot.keyTap(">")
        }
        else if (string == "key_lbracket") {
            robot.keyTap("{")
        }
        else if (string == "key_rbracket") {
            robot.keyTap("}")
        }
        else if (string == "key_slash") {
            robot.keyTap("/")
        }
        else{
            robot.typeString(string)
        }
        res.send("keyboard type")

    }
    else {
        res.send("the keyboard is off")
    }
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

