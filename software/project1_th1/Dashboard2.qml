import QtQuick 2.12
import CustomControls 1.0
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import "./"
Item {
    width: 1024
    height: 768
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

        /*
          Top Bar Of Screen
        */

        Image {
            id: topBar
            width: 1357
            source: "qrc:/assets/Vector 70.svg"

            anchors{
                top: parent.top
                topMargin: 26.50
                horizontalCenter: parent.horizontalCenter
            }

            Image {
                id: headLight
                property bool indicator: false
                width: 42.5
                height: 38.25
                anchors{
                    top: parent.top
                    topMargin: 25
                    leftMargin: 230
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
                font.pixelSize: 32
                font.family: "Inter"
                font.bold: Font.DemiBold
                color: "#FFFFFF"
                anchors.top: parent.top
                anchors.topMargin: 25
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Label{
                id: currentDate
                text: Qt.formatDateTime(new Date(), "dd/MM/yyyy")
                font.pixelSize: 32
                font.family: "Inter"
                font.bold: Font.DemiBold
                color: "#FFFFFF"
                anchors.right: parent.right
                anchors.rightMargin: 230
                anchors.top: parent.top
                anchors.topMargin: 25
            }
        }



        /*
          Speed Label
        */

        //        Label{
        //            id:speedLabel
        //            text: "68"
        //            font.pixelSize: 134
        //            font.family: "Inter"
        //            color: "#01E6DE"
        //            font.bold: Font.DemiBold
        //            anchors.top: parent.top
        //            anchors.topMargin:Math.floor(parent.height * 0.35)
        //            anchors.horizontalCenter: parent.horizontalCenter
        //        }
        MapGauge {
            id: speedLabel
            width: 450
            height: 450
            property bool accelerating
            value: accelerating ? maximumValue : 0
            maximumValue: 250

            anchors.top: parent.top
            anchors.topMargin:Math.floor(parent.height * 0.25)
            anchors.horizontalCenter: parent.horizontalCenter

            Component.onCompleted: forceActiveFocus()

            Behavior on value { NumberAnimation { duration: 1000 }}

            Keys.onSpacePressed: accelerating = true
            Keys.onReleased: {
                if (event.key === Qt.Key_Space) {
                    accelerating = false;
                    event.accepted = true;
                }else if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
                    speedLabel.accelerating = false; // <-- Sửa thành speedLabel
                    event.accepted = true
                }
            }

            Keys.onEnterPressed: speedLabel.accelerating = true // <-- Sửa thành speedLabel
            Keys.onReturnPressed: speedLabel.accelerating = true // <-- Sửa thành speedLabel
        }

        //        Label{
        //            text: "MPH"
        //            font.pixelSize: 46
        //            font.family: "Inter"
        //            color: "#01E6DE"
        //            font.bold: Font.Normal
        //            anchors.top:speedLabel.bottom
        //            anchors.horizontalCenter: parent.horizontalCenter
        //        }


        /*
          Speed Limit Label
        */

        Rectangle{
            id:speedLimit
            width: 130
            height: 130
            radius: height/2
            color: "#D9D9D9"
            border.color: speedColor(maxSpeedlabel.text)
            border.width: 10

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50

            Label{
                id:maxSpeedlabel
                text: getRandomInt(150, speedLabel.maximumValue).toFixed(0)
                font.pixelSize: 45
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
            anchors{
                bottom: car.top
                bottomMargin: 30
                horizontalCenter:car.horizontalCenter
            }
            source: "qrc:/assets/Model 3.png"
        }


        Image {
            id:car
            anchors{
                bottom: speedLimit.top
                bottomMargin: 30
                horizontalCenter:speedLimit.horizontalCenter
            }
            source: "qrc:/assets/Car.svg"

            // Thêm rotation nhẹ để xe trông như đang lắc trên đường
            RotationAnimation on rotation {
                running: speedLabel.value > 20
                loops: Animation.Infinite
                from: -1
                to: 1
                duration: 800
                easing.type: Easing.InOutQuad
            }
        }

        // IMGonline.com.ua  ==> Compress Image With


        /*
          Left Road
        */

        Image {
            id: leftRoad
            width: 127
            height: 397
            anchors{
                left: speedLimit.left
                leftMargin: 100
                bottom: parent.bottom
                bottomMargin: 26.50
            }

            source: "qrc:/assets/Vector 2.svg"
        }

        RowLayout{
            spacing: 20

            anchors{
                left: parent.left
                leftMargin: 250
                bottom: parent.bottom
                bottomMargin: 26.50 + 65
            }

            RowLayout{
                spacing: 3
                Label{
                    text: "100.6"
                    font.pixelSize: 32
                    font.family: "Inter"
                    font.bold: Font.Normal
                    font.capitalization: Font.AllUppercase
                    color: "#FFFFFF"
                }

                Label{
                    text: "°F"
                    font.pixelSize: 32
                    font.family: "Inter"
                    font.bold: Font.Normal
                    font.capitalization: Font.AllUppercase
                    opacity: 0.2
                    color: "#FFFFFF"
                }
            }

            RowLayout{
                spacing: 1
                Layout.topMargin: 10
                Rectangle{
                    width: 20
                    height: 15
                    color: speedLabel.value.toFixed(0) > 31.25 ? speedLabel.speedColor : "#01E6DC"
                }
                Rectangle{
                    width: 20
                    height: 15
                    color: speedLabel.value.toFixed(0) > 62.5 ? speedLabel.speedColor : "#01E6DC"
                }
                Rectangle{
                    width: 20
                    height: 15
                    color: speedLabel.value.toFixed(0) > 93.75 ? speedLabel.speedColor : "#01E6DC"
                }
                Rectangle{
                    width: 20
                    height: 15
                    color: speedLabel.value.toFixed(0) > 125.25 ? speedLabel.speedColor : "#01E6DC"
                }
                Rectangle{
                    width: 20
                    height: 15
                    color: speedLabel.value.toFixed(0) > 156.5 ? speedLabel.speedColor : "#01E6DC"
                }
                Rectangle{
                    width: 20
                    height: 15
                    color: speedLabel.value.toFixed(0) > 187.75 ? speedLabel.speedColor : "#01E6DC"
                }
                Rectangle{
                    width: 20
                    height: 15
                    color: speedLabel.value.toFixed(0) > 219 ? speedLabel.speedColor : "#01E6DC"
                }
            }

            Label{
                text: speedLabel.value.toFixed(0) + " MPH "
                font.pixelSize: 32
                font.family: "Inter"
                font.bold: Font.Normal
                font.capitalization: Font.AllUppercase
                color: "#FFFFFF"
            }
        }

        /*
          Right Road
        */

        Image {
            id: rightRoad
            width: 127
            height: 397
            anchors{
                right: speedLimit.right
                rightMargin: 100
                bottom: parent.bottom
                bottomMargin: 26.50
            }

            source: "qrc:/assets/Vector 1.svg"
        }

        /*
          Right Side gear
        */

        RowLayout{
            spacing: 20
            anchors{
                right: parent.right
                rightMargin: 350
                bottom: parent.bottom
                bottomMargin: 26.50 + 65
            }

            Label{
                text: "Ready"
                font.pixelSize: 32
                font.family: "Inter"
                font.bold: Font.Normal
                font.capitalization: Font.AllUppercase
                color: "#32D74B"
            }

            Label{
                text: "P"
                font.pixelSize: 32
                font.family: "Inter"
                font.bold: Font.Normal
                font.capitalization: Font.AllUppercase
                color: "#FFFFFF"
            }

            Label{
                text: "R"
                font.pixelSize: 32
                font.family: "Inter"
                font.bold: Font.Normal
                font.capitalization: Font.AllUppercase
                opacity: 0.2
                color: "#FFFFFF"
            }
            Label{
                text: "N"
                font.pixelSize: 32
                font.family: "Inter"
                font.bold: Font.Normal
                font.capitalization: Font.AllUppercase
                opacity: 0.2
                color: "#FFFFFF"
            }
            Label{
                text: "D"
                font.pixelSize: 32
                font.family: "Inter"
                font.bold: Font.Normal
                font.capitalization: Font.AllUppercase
                opacity: 0.2
                color: "#FFFFFF"
            }
        }

        /*Left Side Icons*/
        Image {
            id:forthLeftIndicator
            property bool parkingLightOn: true
            width: 72
            height: 62
            anchors{
                left: parent.left
                leftMargin: 175
                bottom: thirdLeftIndicator.top
                bottomMargin: 25
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
            width: 52
            height: 70.2
            anchors{
                left: parent.left
                leftMargin: 145
                bottom: secondLeftIndicator.top
                bottomMargin: 25
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
            width: 51
            height: 51
            anchors{
                left: parent.left
                leftMargin: 125
                bottom: firstLeftIndicator.top
                bottomMargin: 30
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
            width: 51
            height: 51
            anchors{
                left: parent.left
                leftMargin: 100
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

        /*Right Side Icons*/

        Image {
            id:forthRightIndicator
            property bool indicator: true
            width: 56.83
            height: 36.17
            anchors{
                right: parent.right
                rightMargin: 195
                bottom: thirdRightIndicator.top
                bottomMargin: 50
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
            width: 56.83
            height: 36.17
            anchors{
                right: parent.right
                rightMargin: 155
                bottom: secondRightIndicator.top
                bottomMargin: 50
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
            width: 56.83
            height: 36.17
            anchors{
                right: parent.right
                rightMargin: 125
                bottom: firstRightIndicator.top
                bottomMargin: 50
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
            width: 36
            height: 45
            anchors{
                right: parent.right
                rightMargin: 100
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

        // 3D Battery - Thay thế RadialBar bằng battery 3D đẹp
        Item {
            id: battery3D
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: parent.width / 6
            }
            width: 338
            height: 338

            property int batteryLevel: speedLabel.accelerating ? 100 : 65
            Behavior on batteryLevel { NumberAnimation { duration: 1000 }}

            // Background battery
            Image {
                id: batteryBackground
                anchors.centerIn: parent
                width: 200
                height: 280
                source: "qrc:/assets/battery2.png"
                opacity: 0.3

                // Hiệu ứng 3D với transform
                scale: 1.1

                // Animation xoay nhẹ
                RotationAnimation {
                    target: batteryBackground
                    property: "rotation"
                    from: -2
                    to: 2
                    duration: 3000
                    loops: Animation.Infinite
                    easing.type: Easing.InOutSine
                }

                // Hiệu ứng glow (fallback nếu không có DropShadow)
                Rectangle {
                    anchors.centerIn: parent
                    width: parent.width + 40
                    height: parent.height + 40
                    radius: 20
                    color: "#2001E4E0"
                    z: -1
                }
            }

            // Main battery với fill effect
            Rectangle {
                id: batteryFill
                anchors.centerIn: parent
                width: 180
                height: 260
                radius: 20
                color: "#00000000" // Trong suốt

                // Clip để tạo hiệu ứng fill
                clip: true

                Rectangle {
                    id: fillLevel
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: parent.height * (battery3D.batteryLevel / 100)
                    radius: parent.radius

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#00FF41" }
                        GradientStop { position: 0.3; color: "#01E4E0" }
                        GradientStop { position: 0.7; color: "#0099FF" }
                        GradientStop { position: 1.0; color: "#6C5CE7" }
                    }

                    // Animation cho fill level
                    Behavior on height { NumberAnimation { duration: 1000; easing.type: Easing.OutQuart }}

                    // Shimmer effect
                    Rectangle {
                        id: shimmer
                        anchors.fill: parent
                        radius: parent.radius
                        opacity: 0.3
                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0.0; color: "#00FFFFFF" }
                            GradientStop { position: 0.5; color: "#80FFFFFF" }
                            GradientStop { position: 1.0; color: "#00FFFFFF" }
                        }

                        // Moving shimmer với animation đơn giản
                        NumberAnimation on x {
                            from: -200
                            to: 200
                            duration: 2000
                            running: true
                            loops: Animation.Infinite
                        }
                    }
                }

                // Battery outline
                Image {
                    id: batteryOutline
                    anchors.centerIn: parent
                    width: 200
                    height: 280
                    source: "qrc:/assets/battery2.png"

                    // Hiệu ứng glow đơn giản
                    Rectangle {
                        anchors.centerIn: parent
                        width: parent.width + 30
                        height: parent.height + 30
                        radius: 14
                        color: battery3D.batteryLevel > 80 ? "#4000FF41" :
                               battery3D.batteryLevel > 50 ? "#4001E4E0" : "#40FF4757"
                        z: -1
                    }
                }
            }

            // Lightning bolt với animation
            Image {
                id: lightningBolt
                anchors.centerIn: batteryFill
                width: 80
                height: 120
                source: "qrc:/assets/lightning.png"
                opacity: battery3D.batteryLevel > 90 ? 1.0 : 0.6

                // Pulsing effect cho lightning
                PropertyAnimation on scale {
                    from: 0.9
                    to: 1.2
                    duration: 1000
                    loops: Animation.Infinite
                    easing.type: Easing.InOutSine
                }

                // Glow effect đơn giản
                Rectangle {
                    anchors.centerIn: parent
                    width: parent.width + 50
                    height: parent.height + 50
                    radius: width / 2
                    color: "#40FFFF00"
                    z: -1
                }
            }

            // Text overlay
            ColumnLayout {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 120

                Label {
                    text: battery3D.batteryLevel.toFixed(0) + "%"
                    font.pixelSize: 65
                    font.family: "Inter"
                    font.bold: Font.Bold
                    color: "#FFFFFF"
                    Layout.alignment: Qt.AlignHCenter

                    // Text glow đơn giản
                    Rectangle {
                        anchors.centerIn: parent
                        width: parent.width + 20
                        height: parent.height + 10
                        radius: 10
                        color: "#4001E4E0"
                        z: -1
                    }
                }

                Label {
                    text: "Battery charge"
                    font.pixelSize: 28
                    font.family: "Inter"
                    font.bold: Font.Normal
                    opacity: 0.8
                    color: "#FFFFFF"
                    Layout.alignment: Qt.AlignHCenter
                }
            }

            // Floating particles effect - Đơn giản hóa
            Repeater {
                model: 6
                delegate: Rectangle {
                    width: 3
                    height: 3
                    radius: 1.5
                    color: "#6001E4E0"
                    x: 50 + (index * 40)
                    y: battery3D.height
                    opacity: 0.7

                    // Simple floating animation
                    PropertyAnimation on y {
                        from: battery3D.height + 20
                        to: -20
                        duration: 3000 + (index * 500)
                        loops: Animation.Infinite
                    }

                    PropertyAnimation on opacity {
                        from: 0.2
                        to: 0.8
                        duration: 1500 + (index * 300)
                        loops: Animation.Infinite
                    }
                }
            }
        }

        ColumnLayout{
            spacing: 40

            anchors{
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: parent.width / 6
            }

            RowLayout{
                spacing: 30
                Image {
                    width: 72
                    height: 50
                    source: "qrc:/assets/road.svg"
                }

                ColumnLayout{
                    Label{
                        text: "188 KM"
                        font.pixelSize: 30
                        font.family: "Inter"
                        font.bold: Font.Normal
                        opacity: 0.8
                        color: "#FFFFFF"
                    }
                    Label{
                        text: "Distance"
                        font.pixelSize: 20
                        font.family: "Inter"
                        font.bold: Font.Normal
                        opacity: 0.8
                        color: "#FFFFFF"
                    }
                }
            }
            RowLayout{
                spacing: 30
                Image {
                    width: 72
                    height: 78
                    source: "qrc:/assets/fuel.svg"
                }

                ColumnLayout{
                    Label{
                        text: "34 mpg"
                        font.pixelSize: 30
                        font.family: "Inter"
                        font.bold: Font.Normal
                        opacity: 0.8
                        color: "#FFFFFF"
                    }
                    Label{
                        text: "Avg. Fuel Usage"
                        font.pixelSize: 20
                        font.family: "Inter"
                        font.bold: Font.Normal
                        opacity: 0.8
                        color: "#FFFFFF"
                    }
                }
            }
            RowLayout{
                spacing: 30
                Image {
                    width: 72
                    height: 72
                    source: "qrc:/assets/speedometer.svg"
                }

                ColumnLayout{
                    Label{
                        text: "78 mph"
                        font.pixelSize: 30
                        font.family: "Inter"
                        font.bold: Font.Normal
                        opacity: 0.8
                        color: "#FFFFFF"
                    }
                    Label{
                        text: "Avg. Speed"
                        font.pixelSize: 20
                        font.family: "Inter"
                        font.bold: Font.Normal
                        opacity: 0.8
                        color: "#FFFFFF"
                    }
                }
            }
        }
    }
}
