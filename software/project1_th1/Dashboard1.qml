import QtQuick 2.12
import CustomControls 1.0
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import "./"

Item {
    id: root
    width: 1920  // Có thể thay đổi thành bất kỳ kích thước nào
    height: 960

    // TỶ LỆ SCALE TỰ ĐỘNG - so với thiết kế gốc 1920x960
    readonly property real baseWidth: 1920
    readonly property real baseHeight: 960
    readonly property real scaleX: width / baseWidth
    readonly property real scaleY: height / baseHeight
    readonly property real scaleFactor: Math.min(scaleX, scaleY)

    // Hàm scale responsive
    function scaled(value) {
        return value * scaleFactor
    }

    property int nextSpeed: 60

    function generateRandom(maxLimit = 70){
        let rand = Math.random() * maxLimit;
        rand = Math.floor(rand);
        return rand;
    }

    function speedColor(value){
        if(value < 60 ){
            return "green"
        } else if(value > 60 && value < 150){
            return "yellow"
        }else{
            return "Red"
        }
    }

    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered:{
            currentTime.text = Qt.formatDateTime(new Date(), "hh:mm")
        }
    }

    Timer{
        repeat: true
        interval: 3000
        running: true
        onTriggered: {
            nextSpeed = generateRandom()
        }
    }

    Timer {
        id: leftTurnSignalTimer
        interval: 500
        repeat: true
        running: false
        onTriggered: {
            leftTurnSignal.opacity = leftTurnSignal.opacity === 1.0 ? 0.2 : 1.0
            leftTurnIndicator.opacity = leftTurnIndicator.opacity === 1.0 ? 0.2 : 1.0
        }
    }

    Timer {
        id: rightTurnSignalTimer
        interval: 500
        repeat: true
        running: false
        onTriggered: {
            rightTurnSignal.opacity = rightTurnSignal.opacity === 1.0 ? 0.2 : 1.0
            rightTurnIndicator.opacity = rightTurnIndicator.opacity === 1.0 ? 0.2 : 1.0
        }
    }

    Shortcut {
        sequence: "Ctrl+Q"
        context: Qt.ApplicationShortcut
        onActivated: Qt.quit()
    }

    Image {
        id: dashboard
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        source: "qrc:/assets/Dashboard.svg"

        // Top Bar
        Image {
            id: topBar
            width: scaled(1357)
            source: "qrc:/assets/Vector 70.svg"

            anchors{
                top: parent.top
                topMargin: scaled(26.50)
                horizontalCenter: parent.horizontalCenter
            }

            Image {
                id: leftTurnSignal
                width: scaled(42.5)
                height: scaled(38.25)
                visible: true
                opacity: 0.2
                anchors{
                    top: parent.top
                    topMargin: scaled(25)
                    leftMargin: scaled(50)
                    left: parent.left
                }
                source: "qrc:/assets/Dark_blue_left_arrow.svg"
                Behavior on opacity { NumberAnimation { duration: 200 } }
            }

            Image {
                id: headLight
                property bool indicator: false
                width: scaled(42.5)
                height: scaled(38.25)
                anchors{
                    top: parent.top
                    topMargin: scaled(25)
                    leftMargin: scaled(230)
                    left: parent.left
                }
                source: indicator ? "qrc:/assets/Low beam headlights.svg" : "qrc:/assets/Low_beam_headlights_white.svg"
                Behavior on indicator { NumberAnimation { duration: 300 }}
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        headLight.indicator = !headLight.indicator
                    }
                }
            }

            Label{
                id: currentTime
                text: Qt.formatDateTime(new Date(), "hh:mm")
                font.pixelSize: scaled(32)
                font.family: "Inter"
                font.bold: Font.DemiBold
                color: "#FFFFFF"
                anchors.top: parent.top
                anchors.topMargin: scaled(25)
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Label{
                id: currentDate
                text: Qt.formatDateTime(new Date(), "dd/MM/yyyy")
                font.pixelSize: scaled(32)
                font.family: "Inter"
                font.bold: Font.DemiBold
                color: "#FFFFFF"
                anchors.right: parent.right
                anchors.rightMargin: scaled(230)
                anchors.top: parent.top
                anchors.topMargin: scaled(25)
            }

            Image {
                id: rightTurnSignal
                width: scaled(42.5)
                height: scaled(38.25)
                visible: true
                opacity: 0.2
                anchors{
                    top: parent.top
                    topMargin: scaled(25)
                    rightMargin: scaled(50)
                    right: parent.right
                }
                source: "qrc:/assets/Dark_blue_right_arrow.svg"
                Behavior on opacity { NumberAnimation { duration: 200 } }
            }
        }

        // Speed Gauge (Center)
        Gauge {
            id: speedLabel
            width: scaled(450)
            height: scaled(450)
            property bool accelerating
            value: accelerating ? maximumValue : 0
            maximumValue: 250

            anchors.top: parent.top
            anchors.topMargin: Math.floor(parent.height * 0.25)
            anchors.horizontalCenter: parent.horizontalCenter

            Component.onCompleted: forceActiveFocus()

            Behavior on value { NumberAnimation { duration: 1000 }}

            Keys.onSpacePressed: accelerating = true
            Keys.onEnterPressed: radialBar.accelerating = true
            Keys.onReturnPressed: radialBar.accelerating = true
            Keys.onLeftPressed: leftGauge.accelerating  = true
            Keys.onRightPressed: rightGauge.accelerating = true

            Keys.onReleased: {
                if (event.key === Qt.Key_Space) {
                    accelerating = false;
                    event.accepted = true;
                }else if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
                    radialBar.accelerating = false;
                    event.accepted = true;
                }else if(event.key === Qt.Key_Left){
                    leftGauge.accelerating = false;
                    event.accepted = true;
                }else if(event.key === Qt.Key_Right){
                    rightGauge.accelerating = false;
                    event.accepted = true;
                }
            }

            Keys.onPressed: {
                if(event.key === Qt.Key_M){
                   forthRightIndicator.indicator = !forthRightIndicator.indicator
                   event.accepted = true;
                }else if(event.key === Qt.Key_L){
                    firstLeftIndicator.rareLightOn = !firstLeftIndicator.rareLightOn
                    event.accepted = true;
                }else if(event.key === Qt.Key_N){
                    secondLeftIndicator.headLightOn = !secondLeftIndicator.headLightOn
                    event.accepted = true;
                }else if(event.key === Qt.Key_B){
                    thirdLeftIndicator.lightOn = !thirdLeftIndicator.lightOn
                    event.accepted = true;
                }else if(event.key === Qt.Key_C){
                    forthLeftIndicator.parkingLightOn = !forthLeftIndicator.parkingLightOn
                    event.accepted = true;
                }else if(event.key === Qt.Key_V){
                    firstRightIndicator.sheetBelt = !firstRightIndicator.sheetBelt
                    event.accepted = true;
                }else if(event.key === Qt.Key_Z){
                    event.accepted = true;
                    secondRightIndicator.indicator = !secondRightIndicator.indicator
                }else if(event.key === Qt.Key_X){
                    event.accepted = true;
                    thirdRightIndicator.indicator = !thirdRightIndicator.indicator
                }else if(event.key === Qt.Key_Q){
                    if(leftTurnSignalTimer.running){
                        leftTurnSignalTimer.stop();
                        leftTurnSignal.opacity = 0.2;
                        leftTurnIndicator.opacity = 0.2;
                    } else {
                        rightTurnSignalTimer.stop();
                        rightTurnSignal.opacity = 0.2;
                        rightTurnIndicator.opacity = 0.2;
                        leftTurnSignalTimer.start();
                    }
                    event.accepted = true;
                }else if(event.key === Qt.Key_W){
                    if(rightTurnSignalTimer.running){
                        rightTurnSignalTimer.stop();
                        rightTurnSignal.opacity = 0.2;
                        rightTurnIndicator.opacity = 0.2;
                    } else {
                        leftTurnSignalTimer.stop();
                        leftTurnSignal.opacity = 0.2;
                        leftTurnIndicator.opacity = 0.2;
                        rightTurnSignalTimer.start();
                    }
                    event.accepted = true;
                }else if(event.key === Qt.Key_E){
                    leftTurnSignalTimer.stop();
                    rightTurnSignalTimer.stop();
                    leftTurnSignal.opacity = 0.2;
                    rightTurnSignal.opacity = 0.2;
                    leftTurnIndicator.opacity = 0.2;
                    rightTurnIndicator.opacity = 0.2;
                    event.accepted = true;
                }else if(event.key === Qt.Key_R){
                    car.carLightsOn = !car.carLightsOn;
                    event.accepted = true;
                }
            }
        }

        // Speed Limit
        Rectangle{
            id:speedLimit
            width: scaled(130)
            height: scaled(130)
            radius: height/2
            color: "#D9D9D9"
            border.color: speedColor(maxSpeedlabel.text)
            border.width: scaled(10)

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: scaled(50)

            Label{
                id:maxSpeedlabel
                text: getRandomInt(150, speedLabel.maximumValue).toFixed(0)
                font.pixelSize: scaled(45)
                font.family: "Inter"
                font.bold: Font.Bold
                color: "#01E6DE"
                anchors.centerIn: parent

                function getRandomInt(min, max) {
                    return Math.floor(Math.random() * (max - min + 1)) + min;
                }
            }
        }

        Image {
            width: scaled(150)
            height: scaled(40)
            fillMode: Image.PreserveAspectFit
            anchors{
                bottom: car.top
                bottomMargin: scaled(5)
                horizontalCenter:car.horizontalCenter
            }
            source: "qrc:/assets/Model 3.png"
        }

        Image {
            id:car
            property bool carLightsOn: false
            width: scaled(120)
            height: scaled(80)
            fillMode: Image.PreserveAspectFit
            anchors{
                bottom: speedLimit.top
                bottomMargin: scaled(15)
                horizontalCenter:speedLimit.horizontalCenter
            }
            source: carLightsOn ? "qrc:/assets/newcar.svg" : "qrc:/assets/Car.svg"
            Behavior on carLightsOn { NumberAnimation { duration: 300 }}
        }

        // Left Road
        Image {
            id: leftRoad
            width: scaled(127)
            height: scaled(397)
            anchors{
                left: speedLimit.left
                leftMargin: scaled(100)
                bottom: parent.bottom
                bottomMargin: scaled(26.50)
            }
            source: "qrc:/assets/Vector 2.svg"
        }

        Image {
            id: leftTurnIndicator
            width: scaled(60)
            height: scaled(60)
            visible: true
            opacity: 0.2
            anchors{
                left: leftRoad.left
                leftMargin: scaled(-200)
                verticalCenter: leftRoad.verticalCenter
            }
            source: "qrc:/assets/arrow_left.svg"
            Behavior on opacity { NumberAnimation { duration: 200 } }
        }

        // Left side info
        RowLayout{
            spacing: scaled(20)

            anchors{
                left: parent.left
                leftMargin: scaled(250)
                bottom: parent.bottom
                bottomMargin: scaled(26.50 + 65)
            }

            RowLayout{
                spacing: scaled(3)
                Label{
                    text: "100.6"
                    font.pixelSize: scaled(32)
                    font.family: "Inter"
                    font.bold: Font.Normal
                    color: "#FFFFFF"
                }

                Label{
                    text: "°F"
                    font.pixelSize: scaled(32)
                    font.family: "Inter"
                    font.bold: Font.Normal
                    opacity: 0.2
                    color: "#FFFFFF"
                }
            }

            RowLayout{
                spacing: scaled(1)
                Layout.topMargin: scaled(10)
                Rectangle{
                    width: scaled(20)
                    height: scaled(15)
                    color: speedLabel.value.toFixed(0) > 31.25 ? speedLabel.speedColor : "#01E6DC"
                }
                Rectangle{
                    width: scaled(20)
                    height: scaled(15)
                    color: speedLabel.value.toFixed(0) > 62.5 ? speedLabel.speedColor : "#01E6DC"
                }
                Rectangle{
                    width: scaled(20)
                    height: scaled(15)
                    color: speedLabel.value.toFixed(0) > 93.75 ? speedLabel.speedColor : "#01E6DC"
                }
                Rectangle{
                    width: scaled(20)
                    height: scaled(15)
                    color: speedLabel.value.toFixed(0) > 125.25 ? speedLabel.speedColor : "#01E6DC"
                }
                Rectangle{
                    width: scaled(20)
                    height: scaled(15)
                    color: speedLabel.value.toFixed(0) > 156.5 ? speedLabel.speedColor : "#01E6DC"
                }
                Rectangle{
                    width: scaled(20)
                    height: scaled(15)
                    color: speedLabel.value.toFixed(0) > 187.75 ? speedLabel.speedColor : "#01E6DC"
                }
                Rectangle{
                    width: scaled(20)
                    height: scaled(15)
                    color: speedLabel.value.toFixed(0) > 219 ? speedLabel.speedColor : "#01E6DC"
                }
            }

            Label{
                text: speedLabel.value.toFixed(0) + " MPH "
                font.pixelSize: scaled(32)
                font.family: "Inter"
                font.bold: Font.Normal
                color: "#FFFFFF"
            }
        }

        // Right Road
        Image {
            id: rightRoad
            width: scaled(127)
            height: scaled(397)
            anchors{
                right: speedLimit.right
                rightMargin: scaled(100)
                bottom: parent.bottom
                bottomMargin: scaled(26.50)
            }
            source: "qrc:/assets/Vector 1.svg"
        }

        Image {
            id: rightTurnIndicator
            width: scaled(60)
            height: scaled(60)
            visible: true
            opacity: 0.2
            anchors{
                right: rightRoad.right
                rightMargin: scaled(-200)
                verticalCenter: rightRoad.verticalCenter
            }
            source: "qrc:/assets/arrow_right.svg"
            Behavior on opacity { NumberAnimation { duration: 200 } }
        }

        // Right side gear
        RowLayout{
            spacing: scaled(20)
            anchors{
                right: parent.right
                rightMargin: scaled(350)
                bottom: parent.bottom
                bottomMargin: scaled(26.50 + 65)
            }

            Label{
                text: "Ready"
                font.pixelSize: scaled(32)
                font.family: "Inter"
                font.bold: Font.Normal
                color: "#32D74B"
            }

            Label{
                text: "P"
                font.pixelSize: scaled(32)
                font.family: "Inter"
                font.bold: Font.Normal
                color: "#FFFFFF"
            }

            Label{
                text: "R"
                font.pixelSize: scaled(32)
                font.family: "Inter"
                font.bold: Font.Normal
                opacity: 0.2
                color: "#FFFFFF"
            }
            Label{
                text: "N"
                font.pixelSize: scaled(32)
                font.family: "Inter"
                font.bold: Font.Normal
                opacity: 0.2
                color: "#FFFFFF"
            }
            Label{
                text: "D"
                font.pixelSize: scaled(32)
                font.family: "Inter"
                font.bold: Font.Normal
                opacity: 0.2
                color: "#FFFFFF"
            }
        }

        // Left Side Icons
        Image {
            id:forthLeftIndicator
            property bool parkingLightOn: true
            width: scaled(72)
            height: scaled(62)
            anchors{
                left: parent.left
                leftMargin: scaled(175)
                bottom: thirdLeftIndicator.top
                bottomMargin: scaled(25)
            }
            Behavior on parkingLightOn { NumberAnimation { duration: 300 }}
            source: parkingLightOn ? "qrc:/assets/Parking lights.svg" : "qrc:/assets/Parking_lights_white.svg"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    forthLeftIndicator.parkingLightOn = !forthLeftIndicator.parkingLightOn
                }
            }
        }

        Image {
            id:thirdLeftIndicator
            property bool lightOn: true
            width: scaled(52)
            height: scaled(70.2)
            anchors{
                left: parent.left
                leftMargin: scaled(145)
                bottom: secondLeftIndicator.top
                bottomMargin: scaled(25)
            }
            source: lightOn ? "qrc:/assets/Lights.svg" : "qrc:/assets/Light_White.svg"
            Behavior on lightOn { NumberAnimation { duration: 300 }}
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    thirdLeftIndicator.lightOn = !thirdLeftIndicator.lightOn
                }
            }
        }

        Image {
            id:secondLeftIndicator
            property bool headLightOn: true
            width: scaled(51)
            height: scaled(51)
            anchors{
                left: parent.left
                leftMargin: scaled(125)
                bottom: firstLeftIndicator.top
                bottomMargin: scaled(30)
            }
            Behavior on headLightOn { NumberAnimation { duration: 300 }}
            source:headLightOn ?  "qrc:/assets/Low beam headlights.svg" : "qrc:/assets/Low_beam_headlights_white.svg"

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    secondLeftIndicator.headLightOn = !secondLeftIndicator.headLightOn
                }
            }
        }

        Image {
            id:firstLeftIndicator
            property bool rareLightOn: false
            width: scaled(51)
            height: scaled(51)
            anchors{
                left: parent.left
                leftMargin: scaled(100)
                verticalCenter: speedLabel.verticalCenter
            }
            source: rareLightOn ? "qrc:/assets/Rare_fog_lights_red.svg" : "qrc:/assets/Rare fog lights.svg"
            Behavior on rareLightOn { NumberAnimation { duration: 300 }}
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    firstLeftIndicator.rareLightOn = !firstLeftIndicator.rareLightOn
                }
            }
        }

        // Right Side Icons
        Image {
            id:forthRightIndicator
            property bool indicator: true
            width: scaled(56.83)
            height: scaled(36.17)
            anchors{
                right: parent.right
                rightMargin: scaled(195)
                bottom: thirdRightIndicator.top
                bottomMargin: scaled(50)
            }
            source: indicator ? "qrc:/assets/FourthRightIcon.svg" : "qrc:/assets/FourthRightIcon_red.svg"
            Behavior on indicator { NumberAnimation { duration: 300 }}
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    forthRightIndicator.indicator = !forthRightIndicator.indicator
                }
            }
        }

        Image {
            id:thirdRightIndicator
            property bool indicator: true
            width: scaled(56.83)
            height: scaled(36.17)
            anchors{
                right: parent.right
                rightMargin: scaled(155)
                bottom: secondRightIndicator.top
                bottomMargin: scaled(50)
            }
            source: indicator ? "qrc:/assets/thirdRightIcon.svg" : "qrc:/assets/thirdRightIcon_red.svg"
            Behavior on indicator { NumberAnimation { duration: 300 }}
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    thirdRightIndicator.indicator = !thirdRightIndicator.indicator
                }
            }
        }

        Image {
            id:secondRightIndicator
            property bool indicator: true
            width: scaled(56.83)
            height: scaled(36.17)
            anchors{
                right: parent.right
                rightMargin: scaled(125)
                bottom: firstRightIndicator.top
                bottomMargin: scaled(50)
            }
            source: indicator ? "qrc:/assets/SecondRightIcon.svg" : "qrc:/assets/SecondRightIcon_red.svg"
            Behavior on indicator { NumberAnimation { duration: 300 }}
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    secondRightIndicator.indicator = !secondRightIndicator.indicator
                }
            }
        }

        Image {
            id:firstRightIndicator
            property bool sheetBelt: true
            width: scaled(36)
            height: scaled(45)
            anchors{
                right: parent.right
                rightMargin: scaled(100)
                verticalCenter: speedLabel.verticalCenter
            }
            source: sheetBelt ? "qrc:/assets/FirstRightIcon.svg" : "qrc:/assets/FirstRightIcon_grey.svg"
            Behavior on sheetBelt { NumberAnimation { duration: 300 }}
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    firstRightIndicator.sheetBelt = !firstRightIndicator.sheetBelt
                }
            }
        }

        // Left Gauge
        SideGauge {
            id:leftGauge
            anchors{
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: parent.width / 7
            }
            property bool accelerating
            width: scaled(400)
            height: scaled(400)
            value: accelerating ? maximumValue : 0
            maximumValue: 250
            Component.onCompleted: forceActiveFocus()
            Behavior on value { NumberAnimation { duration: 1000 }}

            Keys.onSpacePressed: accelerating = true
            Keys.onReleased: {
                if (event.key === Qt.Key_Space) {
                    accelerating = false;
                    event.accepted = true;
                }
            }
        }

        // Right Gauge
        SideGauge {
            id:rightGauge
            anchors{
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: parent.width / 7
            }
            property bool accelerating
            width: scaled(400)
            height: scaled(400)
            value: accelerating ? maximumValue : 0
            maximumValue: 250
            Component.onCompleted: forceActiveFocus()
            Behavior on value { NumberAnimation { duration: 1000 }}

            Keys.onSpacePressed: accelerating = true
            Keys.onReleased: {
                if (event.key === Qt.Key_Space) {
                    accelerating = false;
                    event.accepted = true;
                }
            }
        }

        // Progress Bar (hidden)
        RadialBar {
            id:radialBar
            visible: false
            anchors{
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: parent.width / 6
            }

            width: scaled(338)
            height: scaled(338)
            penStyle: Qt.RoundCap
            dialType: RadialBar.NoDial
            progressColor: "#01E4E0"
            backgroundColor: "transparent"
            dialWidth: scaled(17)
            startAngle: 270
            spanAngle: 3.6 * value
            minValue: 0
            maxValue: 100
            value: accelerating ? maxValue : 65
            textFont {
                family: "inter"
                italic: false
                bold: Font.Medium
                pixelSize: scaled(60)
            }
            showText: false
            suffixText: ""
            textColor: "#FFFFFF"

            property bool accelerating
            Behavior on value { NumberAnimation { duration: 1000 }}

            ColumnLayout{
                anchors.centerIn: parent
                Label{
                    text: radialBar.value.toFixed(0) + "%"
                    font.pixelSize: scaled(65)
                    font.family: "Inter"
                    font.bold: Font.Normal
                    color: "#FFFFFF"
                    Layout.alignment: Qt.AlignHCenter
                }

                Label{
                    text: "Battery charge"
                    font.pixelSize: scaled(28)
                    font.family: "Inter"
                    font.bold: Font.Normal
                    opacity: 0.8
                    color: "#FFFFFF"
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }
    }
}
