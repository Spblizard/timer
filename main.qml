import QtQuick 2.10
import QtMultimedia 5.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.10

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Timer")

    property string sec: ""
    property string min: ""
    property string hour: ""

    Audio {
        id: sound
        autoPlay: false
        source: "qrc:/sound/scream.mp3"
    }

    function startTimer() {
        hourEdit.text = addingNull(hourEdit.length, hourEdit.text)
        minutEdit.text = addingNull(minutEdit.length, minutEdit.text)
        secondsEdit.text = addingNull(secondsEdit.length, secondsEdit.text)
        if (secondsEdit.text == "00" && minutEdit.text == "00" && hourEdit.text == "00") {

        } else {
            window.sec = secondsEdit.text
            window.min = minutEdit.text
            window.hour = hourEdit.text
            timer.start()
            textAreaRead(true)
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
            minutEdit.text = min
            hourEdit.text = hour
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
            width: 100
            text: qsTr("00")
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            font.family: "Times New Roman"
            anchors.right: label.left
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 20
            font.pixelSize: 80
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
            }
        }

        Label {
            id: label
            width: 20
            text: qsTr(":")
            font.family: "Times New Roman"
            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 80
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
            width: 20
            text: qsTr(":")
            anchors.left: minutEdit.right
            anchors.leftMargin: 0
            font.family: "Times New Roman"
            font.pointSize: 80
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
            x: 6
            y: -4
            width: 100
            text: qsTr("00")
            font.family: "Times New Roman"
            anchors.bottomMargin: 0
            font.pixelSize: 80
            horizontalAlignment: Text.AlignHCenter
            anchors.bottom: parent.bottom
            font.bold: true
            anchors.topMargin: 20
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
            }
        }

        TextArea {
            id: secondsEdit
            x: 13
            y: -12
            width: 100
            text: qsTr("00")
            font.family: "Times New Roman"
            font.pixelSize: 80
            anchors.bottomMargin: 0
            horizontalAlignment: Text.AlignHCenter
            anchors.bottom: parent.bottom
            anchors.topMargin: 20
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
            }
        }

        Label {
            id: labelHour
            text: qsTr("Hour")
            font.pointSize: 18
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
            font.pointSize: 18
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
            font.pointSize: 18
            font.bold: true
            font.family: "Times New Roman"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Button {
        id: buttonPlay
        text: qsTr("Play")
        font.pointSize: 18
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
        text: qsTr("Stop")
        anchors.left: buttonPlay.right
        anchors.leftMargin: 20
        anchors.top: mainRect.bottom
        anchors.topMargin: 0
        font.pointSize: 18
        font.bold: true
        onClicked: {
            timer.stop()
            textAreaRead(false)
        }
    }

    Button {
        id: buttonReset
        text: qsTr("Reset")
        anchors.right: mainRect.right
        anchors.rightMargin: 0
        anchors.top: mainRect.bottom
        anchors.topMargin: 0
        font.pointSize: 18
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
