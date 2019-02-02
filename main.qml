import QtQuick 2.10
import QtMultimedia 5.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.10

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Timer")

    property int sec: 0
    property int min: 0
    property int hour: 0
    background: Image {
        source: "qrc:/image/background.jpg"
    }

    property bool start: false

    Audio {
        id: sound
        autoPlay: false
        source: "qrc:/sound/ring.mp3"
        onPlaying: window.start = true
        onStopped: window.start = false
    }

    Timer {
        id: timer2
        interval: 100
        running: false
        repeat: false
        onTriggered: textAreaRead(false)
    }

    function startTimer() {
	
        hourEdit.text = addingNull(hourEdit.length, hourEdit.text)
        minutEdit.text = addingNull(minutEdit.length, minutEdit.text)
        secondsEdit.text = addingNull(secondsEdit.length, secondsEdit.text)
        if (secondsEdit.text == "00" && minutEdit.text == "00" && hourEdit.text == "00") {

        } else if (timer.running) {
            timer.stop()
            if (window.sec > 9)
                secondsEdit.text = window.sec
            else
                secondsEdit.text = "0" + window.sec
            if (window.min > 9)
                minutEdit.text = window.min
            else
                minutEdit.text = "0" + window.min
            if (window.hour > 9)
                hourEdit.text = window.hour
            else
                hourEdit.text = "0" + window.hour
            textAreaRead(false)
        } else {
            window.sec = secondsEdit.text
            window.min = minutEdit.text
            window.hour = hourEdit.text
            if (!window.start) {
               timer.start()
               textAreaRead(true)
            } else if (window.start) {
                sound.stop()
                textAreaRead(true)
                timer2.start()
            }
        }
    }

    function textAreaRead (i) {
        secondsEdit.readOnly = i
        minutEdit.readOnly = i
        hourEdit.readOnly = i
    }

    function addingNull(len, str) {
        if (len < 1)
            str = "00"
        else if (len < 2)
            str = "0" + str
        return str
    }

    function lowTime() {
        var hours = hourEdit.text
        var minut = minutEdit.text
        var seconds = secondsEdit.text
        if (seconds === "01" && minut === "00" && hours === "00") {
            timer.stop()
            textAreaRead(false)
            sound.play()
            seconds = sec
            if (min > 9)
                minutEdit.text = min
            else
                minutEdit.text = "0" + min
            if (hour > 9)
                hourEdit.text = hour
            else
                hourEdit.text = "0" + hour
        } else if (seconds === "00" && minut !== "00") {
            minut--
            if (minut > 9)
                minutEdit.text = minut
            else
                minutEdit.text = "0" + minut
            secondsEdit.text = "59"
            seconds = "59"
        } else if (seconds === "00" && minut === "00" && hours !== "00") {
            hours--
            if (hours > 9)
                hourEdit.text = hours
            else
                hourEdit.text = "0" + hours
            minutEdit.text = "59"
            secondsEdit.text = "59"
            seconds = "59"
        } else
            seconds--
        if (seconds > 9)
            secondsEdit.text = seconds
        else
            secondsEdit.text = "0" + seconds
    }

    Timer {
        id: timer
        interval: 1000
        running: false
        repeat: true
        onTriggered: lowTime()
    }

    Item {
        id: mainRect
        anchors.centerIn: parent
        width: parent.width / 1.8823
        height: parent.height / 3.2

        TextArea {
            id: hourEdit
            width: parent.width / 3.4
            text: qsTr("00")
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            font.family: "Times New Roman"
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: parent.height / 7.5
            font.pixelSize: parent.height / 1.875
            onLengthChanged: {
                var number = text
                if (length > 2)
                    remove(2,3)
                if (!check.isNumber (number))
                    text = "00"
            }
            Keys.onPressed: {
                if (event.key === 16777220) {
                  startTimer()
                }
                if (event.key === 32) {
                    startTimer()
                }
            }
        }

        Label {
            id: label
            width: hourEdit.width / 5
            text: qsTr(":")
            font.family: "Times New Roman"
            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: parent.height / 1.875
            font.bold: true
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: hourEdit.right
            anchors.leftMargin: 0
        }

        Label {
            id: label1
            width: hourEdit.width / 5
            text: qsTr(":")
            anchors.left: minutEdit.right
            anchors.leftMargin: 0
            font.family: "Times New Roman"
            font.pointSize: parent.height / 1.875
            anchors.bottomMargin: 0
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            font.bold: true
            anchors.top: parent.top
        }

        TextArea {
            id: minutEdit
            width: hourEdit.width
            text: qsTr("00")
            font.family: "Times New Roman"
            anchors.bottomMargin: 0
            font.pixelSize: parent.height / 1.875
            horizontalAlignment: Text.AlignHCenter
            anchors.bottom: parent.bottom
            font.bold: true
            anchors.topMargin: parent.height / 7.5
            anchors.left: label.right
            anchors.top: parent.top
            anchors.leftMargin: 0
            onLengthChanged: {
                var number = text
                if (length > 2)
                    remove(2, 3)
                if (number > 59)
                    text = "00"
                if (!check.isNumber (number))
                    text = "00"
            }
            Keys.onPressed: {
                if (event.key === 16777220) {
                  startTimer()
                }
                if (event.key === 32) {
                    startTimer()
                }
            }
        }

        TextArea {
            id: secondsEdit
            width: hourEdit.width
            text: qsTr("00")
            font.family: "Times New Roman"
            font.pixelSize: parent.height / 1.875
            anchors.bottomMargin: 0
            horizontalAlignment: Text.AlignHCenter
            anchors.bottom: parent.bottom
            anchors.topMargin: parent.height / 7.5
            font.bold: true
            anchors.left: label1.right
            anchors.top: parent.top
            anchors.leftMargin: 0
            onLengthChanged: {
                var number = text
                if (length > 2)
                    remove(2, 3)
                if (number > 59)
                    text = "00"
                if (!check.isNumber (number))
                    text = "00"
            }
            Keys.onPressed: {
                if (event.key === 16777220) {
                  startTimer()
                }
                if (event.key === 32) {
                    startTimer()
                }

            }
        }

        Label {
            id: labelHour
            text: qsTr("Hour")
            font.pointSize: parent.height / 8.333
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.family: "Times New Roman"
            anchors.right: label.left
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: hourEdit.top
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
        }

        Label {
            id: labelMinut
            text: qsTr("Minute")
            font.pointSize: parent.height / 8.333
            font.bold: true
            font.family: "Times New Roman"
            anchors.right: label1.left
            anchors.rightMargin: 0
            anchors.left: label.right
            anchors.leftMargin: 0
            anchors.bottom: minutEdit.top
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Label {
            id: labelSecond
            text: qsTr("Second")
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: label1.right
            anchors.leftMargin: 0
            anchors.bottom: secondsEdit.top
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            font.pointSize: parent.height / 8.333
            font.bold: true
            font.family: "Times New Roman"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Button {
        id: buttonPlay
	opacity: 0.55
        width: mainRect.width / 3.4
        height: mainRect.height / 3.75
        text: qsTr("Play")
        font.pointSize: height / 2.222
        font.bold: true
        font.family: "Times New Roman"
        anchors.top: mainRect.bottom
        anchors.topMargin: 0
        anchors.left: mainRect.left
        anchors.leftMargin: 0
        onClicked: {
            startTimer()
        }
    }

    Button {
        id: buttonStop
	opacity: 0.55
        width: buttonPlay.width
        height: buttonPlay.height
        text: qsTr("Stop")
        anchors.left: buttonPlay.right
        anchors.leftMargin: label.width
        anchors.top: mainRect.bottom
        anchors.topMargin: 0
        font.pointSize: height / 2.222
        font.bold: true
        onClicked: {
            timer.stop()
            sound.stop()
            textAreaRead(false)
        }
    }

    Button {
        id: buttonReset
	opacity: 0.55
        width: buttonPlay.width
        height: buttonPlay.height
        text: qsTr("Reset")
        anchors.right: mainRect.right
        anchors.rightMargin: 0
        anchors.top: mainRect.bottom
        anchors.topMargin: 0
        font.pointSize: height / 2.222
        font.bold: true
        font.family: "Times New Roman"
        onClicked: {
            timer.stop()
            hourEdit.text = "00"
            minutEdit.text = "00"
            secondsEdit.text = "00"

        }
    }
}
