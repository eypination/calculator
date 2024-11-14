import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: screen
    visible: true
    width: 300
    height: 500
    title: "Calculator"
    color: "#024873"
    minimumWidth: 300
    minimumHeight: 500
    maximumWidth: 300
    maximumHeight: 500

    FontLoader {
        id: opensans
        source: "qrc:/fonts/fonts/open-sans-semibold.ttf"
    }

    QtObject {
        id: appProperties

        property real fontSizeLarge: 50
        property real fontSizeMedium: 20
        property real fontSizeButton: 20
        property real fontSizeOperationButton: 30
        property real lineHeightLarge: 60
        property real lineHeightMedium: 30
        property real lineHeightButton: 30
        property real letterSpacingLarge: 0.5
        property real letterSpacingMedium: 0.5
        property real letterSpacingButton: 1

        property string currentInput: "0"
        property string previousInput: ""
        property string operation: ""
        property bool justPerformedOperation: false

        property bool showSecretCodeInput: false
        property string secretCode: ""
        property string targetSecretCode: "123"

        function resetSecretCode() {
            showSecretCodeInput = false
            secretCode = ""
            codeInputTimer.stop()
        }

        function checkSecretCode() {
            if (secretCode === targetSecretCode) {
                mainMenu.visible = false
                secretMenu.visible = true
                resetSecretCode()
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            id: mainMenu
            implicitWidth: screen.width
            implicitHeight: screen.height * 0.28
            color: "#04BFAD"
            radius: 25
            Layout.topMargin: 0
            Layout.alignment: Qt.AlignTop
            layer.enabled: true
            layer.smooth: true
            clip: true
            visible: true

            Rectangle {
                width: screen.width
                height: screen.height / 2
                color: parent.color
                radius: 25
                anchors.bottom: parent.bottom
            }

            ColumnLayout {
                anchors.fill: parent

                Text {
                    id: upperDisplay
                    text: appProperties.previousInput + " " + appProperties.operation
                    font.family: "Open Sans Semibold"
                    font.pixelSize: appProperties.fontSizeMedium
                    color: "#FFFFFF"
                    horizontalAlignment: Text.AlignRight
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter  // Замена anchors.right
                    Layout.rightMargin: 20
                }

                Text {
                    id: lowerDisplay
                    text: appProperties.currentInput
                    font.family: "Open Sans Semibold"
                    font.pixelSize: appProperties.fontSizeLarge
                    color: "#FFFFFF"
                    horizontalAlignment: Text.AlignRight
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter  // Замена anchors.right
                    Layout.rightMargin: 20
                }
            }
        }

        Rectangle {
            id: secretMenu
            visible: false
            color: "#FFFFFF"
            Layout.alignment: Qt.AlignCenter  // центрируем меню по центру экрана
            Layout.preferredWidth: parent.width  // указываем предпочтительную ширину
            Layout.preferredHeight: parent.height

            ColumnLayout {
                anchors.centerIn: parent

                Text {
                    text: "Секретное меню"
                    font.pixelSize: 24
                    color: "#024873"
                }

                Button {
                    text: "Назад"
                    onClicked: {
                        secretMenu.visible = false
                        mainMenu.visible = true
                        appProperties.resetSecretCode()
                    }
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }

        Timer {
            id: holdTimer
            interval: 4000
            repeat: false
            onTriggered: {
                appProperties.showSecretCodeInput = true
                codeInputTimer.start()
            }
        }

        Timer {
            id: codeInputTimer
            interval: 5000
            repeat: false
            onTriggered: {
                appProperties.resetSecretCode()
            }
        }

        GridLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.topMargin: 12
            rows: 5
            columns: 4
            rowSpacing: 18
            columnSpacing: 18
            implicitHeight: 60

            Rectangle {
                id: button1
                color: "#0889A6"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                x: parent.width * 0.2608
                y: parent.height * 0.0441
                Text {
                    text: "()"
                    anchors.centerIn: parent
                    color: "#FFFFFF"
                    font.family: "Open Sans Semibold"
                    font.pixelSize: appProperties.fontSizeButton
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button1.color = "#F7E425"
                    }
                    onReleased: {
                        button1.color = "#0889A6"
                    }
                }
            }
            Rectangle {
                id: button2
                color: "#0889A6"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                x: parent.width * 0.2308
                y: parent.height * 0.0441

                Item {
                    width: button2.width
                    height: button2.height
                    Rectangle {
                        radius: 2
                        width: button2.width * 0.35
                        height: 2
                        color: "#FFFFFF"
                        anchors.centerIn: parent
                        y: button2.height * 0.33
                        rotation: 115
                    }
                    //плюс
                    Rectangle {
                        radius: 2
                        width: 9.5
                        height: 2
                        color: "#FFFFFF"
                        x: button2.width * 0.27
                        y: button2.height * 0.38
                    }
                    Rectangle {
                        radius: 2
                        width: 2
                        height: 9.5
                        color: "#FFFFFF"
                        x: button2.width * 0.348
                        y: button2.height * 0.3
                    }


                    //минус
                    Rectangle {
                        radius: 2
                        width: 9.5
                        height: 2
                        color: "#FFFFFF"
                        x: button2.width * 0.55
                        y: button2.height * 0.557
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button2.color = "#F7E425"
                    }
                    onReleased: {
                        button2.color = "#0889A6"
                    }
                    onClicked: {
                        if (appProperties.currentInput !== "") {
                            appProperties.currentInput = String(-Number(appProperties.currentInput));
                            appProperties.justPerformedOperation = true;
                        }
                    }
                }
            }
            Rectangle {
                id: button3
                color: "#0889A6"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                x: parent.width * 0.2008
                y: parent.height * 0.0441
                Item {
                    width: button3.width
                    height: button3.height
                    Rectangle {
                        radius: 2
                        width: button3.width * 0.35
                        height: 2
                        color: "#FFFFFF"
                        anchors.centerIn: parent
                        y: button3.height * 0.33
                        rotation: 120
                    }

                    Rectangle {
                        width: 6.5
                        height: 8.5
                        color: "transparent"
                        border.color: "#FFFFFF"
                        border.width: 1.8
                        radius: 3
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.margins: 16
                    }

                    Rectangle {
                        width: 6.5
                        height: 8.5
                        color: "transparent"
                        border.color: "#FFFFFF"
                        border.width: 1.8
                        radius: 3
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.margins: 16
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button3.color = "#F7E425"
                    }
                    onReleased: {
                        button3.color = "#0889A6"
                    }
                    onClicked: {
                        if (appProperties.currentInput !== "") {
                            appProperties.currentInput = String(Number(appProperties.currentInput) / 100);
                            appProperties.justPerformedOperation = true;
                        }
                    }
                }
            }
            Rectangle {
                id: button4
                color: "#0889A6"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                x: parent.width * 0.1408
                y: parent.height * 0.0522
                Item {
                    width: button4.width
                    height: button4.height
                    Rectangle {
                        radius: 2
                        width: button4.width * 0.3333
                        height: 2
                        color: "#FFFFFF"
                        anchors.centerIn: parent
                        y: button4.height * 0.5
                    }
                    Rectangle {
                        width: 3.5
                        height: 3.5
                        radius: 3
                        color: "#FFFFFF"
                        anchors.horizontalCenter: parent.horizontalCenter
                        y: button4.height * 0.59
                    }
                    Rectangle {
                        width: 3.5
                        height: 3.5
                        radius: 3
                        color: "#FFFFFF"
                        anchors.horizontalCenter: parent.horizontalCenter
                        y: button4.height * 0.34
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button4.color = "#F7E425"
                    }
                    onReleased: {
                        button4.color = "#0889A6"
                    }
                    onClicked: {
                        if (appProperties.currentInput !== "") {
                            appProperties.previousInput = appProperties.currentInput;
                            appProperties.currentInput = "0";
                            appProperties.operation = "÷";
                            appProperties.justPerformedOperation = true;
                        }
                    }
                }
            }

            Rectangle {
                id: button5
                color: "#B0D1D8"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                Text {
                    id: textbutton5
                    text: "7"
                    anchors.centerIn: parent
                    color: "#024873"
                    font.family: "Open Sans Semibold"
                    font.pixelSize: appProperties.fontSizeButton
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button5.color = "#04BFAD"
                        textbutton5.color = "#FFFFFF"
                    }
                    onReleased: {
                        button5.color = "#B0D1D8"
                        textbutton5.color = "#024873"
                    }
                    onClicked: {
                        if (appProperties.currentInput === "0") {
                            appProperties.currentInput = "7"
                        } else {
                            appProperties.currentInput += "7"
                        }
                    }
                }
            }

            Rectangle {
                id: button6
                color: "#B0D1D8"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                Text {
                    id: textbutton6
                    text: "8"
                    anchors.centerIn: parent
                    color: "#024873"
                    font.family: "Open Sans Semibold"
                    font.pixelSize: appProperties.fontSizeButton
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button6.color = "#04BFAD"
                        textbutton6.color = "#FFFFFF"
                    }
                    onReleased: {
                        button6.color = "#B0D1D8"
                        textbutton6.color = "#024873"
                    }
                    onClicked: {
                        if (appProperties.currentInput === "0") {
                            appProperties.currentInput = "8"
                        } else {
                            appProperties.currentInput += "8"
                        }
                    }
                }
            }

            Rectangle {
                id: button7
                color: "#B0D1D8"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                Text {
                    id: textbutton7
                    text: "9"
                    anchors.centerIn: parent
                    color: "#024873"
                    font.family: "Open Sans Semibold"
                    font.pixelSize: appProperties.fontSizeButton
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button7.color = "#04BFAD"
                        textbutton7.color = "#FFFFFF"
                    }
                    onReleased: {
                        button7.color = "#B0D1D8"
                        textbutton7.color = "#024873"
                    }
                    onClicked: {
                        if (appProperties.currentInput === "0") {
                            appProperties.currentInput = "9"
                        } else {
                            appProperties.currentInput += "9"
                        }
                    }
                }
            }

            Rectangle {
                id: button8
                color: "#0889A6"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                x: parent.width * 0.1108
                y: parent.height * 0.0441
                Item {
                    width: button8.width
                    height: button8.height

                    Rectangle {
                        radius: 2
                        width: button8.width * 0.3333
                        height: 2
                        color: "#FFFFFF"
                        anchors.centerIn: parent
                        y: button8.height * 0.5
                        rotation: 45
                    }
                    Rectangle {
                        radius: 2
                        width: button8.width * 0.3333
                        height: 2
                        color: "#FFFFFF"
                        anchors.centerIn: parent
                        y: button8.height * 0.5
                        rotation: 135
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button8.color = "#F7E425"
                    }
                    onReleased: {
                        button8.color = "#0889A6"
                    }
                    onClicked: {
                        if (appProperties.currentInput !== "") {
                            appProperties.previousInput = appProperties.currentInput;
                            appProperties.currentInput = "0";
                            appProperties.operation = "×";
                            appProperties.justPerformedOperation = true;
                        }
                    }
                }
            }
            Rectangle {
                id: button9
                color: "#B0D1D8"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                Text {
                    id: textbutton9
                    text: "4"
                    anchors.centerIn: parent
                    color: "#024873"
                    font.family: "Open Sans Semibold"
                    font.pixelSize: appProperties.fontSizeButton
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button9.color = "#04BFAD"
                        textbutton9.color = "#FFFFFF"
                    }
                    onReleased: {
                        button9.color = "#B0D1D8"
                        textbutton9.color = "#024873"
                    }
                    onClicked: {
                        if (appProperties.currentInput === "0") {
                            appProperties.currentInput = "4"
                        } else {
                            appProperties.currentInput += "4"
                        }
                    }
                }
            }
            Rectangle {
                id: button10
                color: "#B0D1D8"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                Text {
                    id: textbutton10
                    text: "5"
                    anchors.centerIn: parent
                    color: "#024873"
                    font.family: "Open Sans Semibold"
                    font.pixelSize: appProperties.fontSizeButton
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button10.color = "#04BFAD"
                        textbutton10.color = "#FFFFFF"
                    }
                    onReleased: {
                        button10.color = "#B0D1D8"
                        textbutton10.color = "#024873"
                    }
                    onClicked: {
                        if (appProperties.currentInput === "0") {
                            appProperties.currentInput = "5"
                        } else {
                            appProperties.currentInput += "5"
                        }
                    }
                }
            }
            Rectangle {
                id: button11
                color: "#B0D1D8"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                Text {
                    id: textbutton11
                    text: "6"
                    anchors.centerIn: parent
                    color: "#024873"
                    font.family: "Open Sans Semibold"
                    font.pixelSize: appProperties.fontSizeButton
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button11.color = "#04BFAD"
                        textbutton11.color = "#FFFFFF"
                    }
                    onReleased: {
                        button11.color = "#B0D1D8"
                        textbutton11.color = "#024873"
                    }
                    onClicked: {
                        if (appProperties.currentInput === "0") {
                            appProperties.currentInput = "6"
                        } else {
                            appProperties.currentInput += "6"
                        }
                    }
                }
            }
            Rectangle {
                id: button12
                color: "#0889A6"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                x: parent.width * 0.0808
                y: parent.height * 0.0441
                Item {
                    width: button12.width
                    height: button12.height
                    Rectangle {
                        radius: 2
                        width: button12.width * 0.3333
                        height: 2
                        color: "#FFFFFF"
                        anchors.centerIn: parent
                        y: button12.height * 0.5
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button12.color = "#F7E425"
                    }
                    onReleased: {
                        button12.color = "#0889A6"
                    }
                    onClicked: {
                        if (appProperties.currentInput !== "") {
                            appProperties.previousInput = appProperties.currentInput;
                            appProperties.currentInput = "0";
                            appProperties.operation = "−";
                            appProperties.justPerformedOperation = true;
                        }
                    }
                }
            }
            Rectangle {
                id: button13
                color: "#B0D1D8"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                Text {
                    id: textbutton13
                    text: "1"
                    anchors.centerIn: parent
                    color: "#024873"
                    font.family: "Open Sans Semibold"
                    font.pixelSize: appProperties.fontSizeButton
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button13.color = "#04BFAD"
                        textbutton13.color = "#FFFFFF"
                    }
                    onReleased: {
                        button13.color = "#B0D1D8"
                        textbutton13.color = "#024873"
                    }
                    onClicked: {
                        if (appProperties.showSecretCodeInput) {
                            appProperties.secretCode += "1"
                            appProperties.currentInput = "1"
                            appProperties.checkSecretCode()
                        } else {
                            if (appProperties.currentInput === "0") {
                                appProperties.currentInput = "1"
                            }
                            else {
                                appProperties.currentInput += "1"
                            }
                        }
                    }
                }
            }
            Rectangle {
                id: button14
                color: "#B0D1D8"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                Text {
                    id: textbutton14
                    text: "2"
                    anchors.centerIn: parent
                    color: "#024873"
                    font.family: "Open Sans Semibold"
                    font.pixelSize: appProperties.fontSizeButton
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button14.color = "#04BFAD"
                        textbutton14.color = "#FFFFFF"
                    }
                    onReleased: {
                        button14.color = "#B0D1D8"
                        textbutton14.color = "#024873"
                    }
                    onClicked: {
                        if (appProperties.showSecretCodeInput) {
                            appProperties.secretCode += "2"
                            appProperties.currentInput = "2"
                            appProperties.checkSecretCode()
                        } else {
                            if (appProperties.currentInput === "0") {
                                appProperties.currentInput = "2"
                            }
                            else {
                                appProperties.currentInput += "2"
                            }
                        }
                    }
                }
            }
            Rectangle {
                id: button15
                color: "#B0D1D8"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                Text {
                    id: textbutton15
                    text: "3"
                    anchors.centerIn: parent
                    color: "#024873"
                    font.family: "Open Sans Semibold"
                    font.pixelSize: appProperties.fontSizeButton
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button15.color = "#04BFAD"
                        textbutton15.color = "#FFFFFF"
                    }
                    onReleased: {
                        button15.color = "#B0D1D8"
                        textbutton15.color = "#024873"
                    }
                    onClicked: {
                        if (appProperties.showSecretCodeInput) {
                            appProperties.secretCode += "3"
                            appProperties.currentInput = "3"
                            appProperties.checkSecretCode()
                        } else {
                            if (appProperties.currentInput === "0") {
                                appProperties.currentInput = "3"
                            }
                            else {
                                appProperties.currentInput += "3"
                            }
                        }
                    }
                }
            }
            Rectangle {
                id: button16
                color: "#0889A6"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                x: parent.width * 0.0508
                y: parent.height * 0.0441

                Item {
                    width: button16.width
                    height: button16.height

                    Rectangle {
                        radius: 2
                        width: button16.width * 0.3333
                        height: 2
                        color: "#FFFFFF"
                        anchors.centerIn: parent
                        y: button16.height * 0.1833
                    }
                    Rectangle {
                        radius: 2
                        width: 2
                        height: button16.height * 0.3333
                        color: "#FFFFFF"
                        anchors.centerIn: parent
                        x: button16.width * 0.1833
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button16.color = "#F7E425"
                    }
                    onReleased: {
                        button16.color = "#0889A6"
                    }
                    onClicked: {
                        if (appProperties.currentInput !== "") {
                            appProperties.previousInput = appProperties.currentInput;
                            appProperties.currentInput = "0";
                            appProperties.operation = "+";
                            appProperties.justPerformedOperation = true;
                        }
                    }
                }
            }
            Rectangle {
                id: button17
                color: "#F8AEAE"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                Text {
                    text: "C"
                    anchors.centerIn: parent
                    color: "#FFFFFF"
                    font.family: "Open Sans Semibold"
                    font.pixelSize: appProperties.fontSizeButton
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button17.color = "#F25E5E"
                    }
                    onReleased: {
                        button17.color = "#F8AEAE"
                    }
                    onClicked: {
                        appProperties.currentInput = "0";
                        appProperties.previousInput = "";
                        appProperties.operation = "";
                    }
                }
            }

            Rectangle {
                id: button18
                color: "#B0D1D8"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                Text {
                    id: textbutton18
                    text: "0"
                    anchors.centerIn: parent
                    color: "#024873"
                    font.family: "Open Sans Semibold"
                    font.pixelSize: appProperties.fontSizeButton
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button18.color = "#04BFAD"
                        textbutton18.color = "#FFFFFF"
                    }
                    onReleased: {
                        button18.color = "#B0D1D8"
                        textbutton18.color = "#024873"
                    }
                    onClicked: {
                        if (appProperties.currentInput === "0") {
                            appProperties.currentInput = "0"
                        } else {
                            appProperties.currentInput += "0"
                        }
                    }
                }
            }
            Rectangle {
                id: button20
                color: "#B0D1D8"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                Text {
                    id: textbutton20
                    text: "."
                    anchors.centerIn: parent
                    color: "#024873"
                    font.family: "Open Sans Semibold"
                    font.pixelSize: appProperties.fontSizeButton
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        button20.color = "#04BFAD"
                        textbutton20.color = "#FFFFFF"
                    }
                    onReleased: {
                        button20.color = "#B0D1D8"
                        textbutton20.color = '#024873'
                    }
                    onClicked: {
                        if (!appProperties.currentInput.includes(".")) {
                            appProperties.currentInput += ".";
                        }
                    }
                }
            }

            Rectangle {
                id: button21
                color: "#0889A6"
                radius: 25
                implicitWidth: 50
                implicitHeight: 50
                x: parent.width * 0.1708
                y: parent.height * 0.0441
                Item {
                    width: button21.width
                    height: button21.height

                    Rectangle {
                        radius: 2
                        width: button21.width * 0.3333
                        height: 2
                        color: "#FFFFFF"
                        anchors.horizontalCenter: parent.horizontalCenter
                        y: button21.height * 0.4267
                    }
                    Rectangle {
                        radius: 2
                        width: button21.width * 0.3333
                        height: 2
                        color: "#FFFFFF"
                        anchors.horizontalCenter: parent.horizontalCenter
                        y: button21.height * 0.5525
                    }
                }
                MouseArea {
                    id: longPressArea
                    anchors.fill: parent
                    onPressed: {
                        button21.color = "#F7E425"
                        holdTimer.start()
                    }
                    onReleased: {
                        button21.color = "#0889A6"
                        holdTimer.stop()
                        if (holdTimer.running) {
                            appProperties.showSecretCodeInput = true
                            codeInputTimer.start()
                        }
                    }
                    onClicked: {
                        var result
                        switch (appProperties.operation) {
                            case "+":
                                result = parseFloat(appProperties.previousInput) + parseFloat(appProperties.currentInput)
                                break
                            case "−":
                                result = parseFloat(appProperties.previousInput) - parseFloat(appProperties.currentInput)
                                break
                            case "×":
                                result = parseFloat(appProperties.previousInput) * parseFloat(appProperties.currentInput)
                                break
                            case "÷":
                                if (parseFloat(appProperties.currentInput) === 0) {
                                    appProperties.currentInput = "Error";
                                } else {
                                    result = parseFloat(appProperties.previousInput) / parseFloat(appProperties.currentInput);
                                }
                                break;
                            case "%":
                                result = parseFloat(appProperties.previousInput) / 100
                                break
                            default:
                                result = appProperties.currentInput;
                        }
                        appProperties.currentInput = result
                        appProperties.previousInput = ""
                        appProperties.operation = ""
                    }
                }
            }
        }
    }
}
