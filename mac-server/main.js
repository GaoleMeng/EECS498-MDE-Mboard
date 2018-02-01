const express = require('express')
const app = express()
const robot = require("robotjs");

app.get('/', (req, res) => {
    // let string = req.params.char
    robot.typeString("abc")
    res.send("keyboard type")
})

app.listen(3000, () => console.log('Example app listening on port 3000!'))
