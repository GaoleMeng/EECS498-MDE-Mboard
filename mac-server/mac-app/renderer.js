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

    res.setHeader('Content-Type', 'application/json')
    // let ip = req.body.ip

    let x = parseFloat(req.params.xx)
    let y = parseFloat(req.params.yy)

    robot.moveMouse(robot.getMousePos().x + x, robot.getMousePos().y + y)
    // console.log(robot.getMousePos())
    res_data = {
        "status": "mouse move"
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

