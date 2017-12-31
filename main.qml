import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4

import gwol.components 1.0

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 300
    title: qsTr("Gwol")

    Material.theme: Material.Dark
    Material.accent: Material.color(Material.DeepOrange)

    Shortcut {
        sequence: "Q"
        onActivated: Qt.quit()
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: columnLayout.forceActiveFocus()
    }

    Gwol {
        id: gwol
        onWolFnished: {
            dialog_ta.text = output;
            dialog.title = success ? "success".toUpperCase() : "failure".toUpperCase();
            dialog.open();
        }
    }

    function wol() {
        if (ipaddr.length <= 0) {
            ipaddr.forceActiveFocus();
            return;
        }
        var ip_address = ipaddr.text

        if (!mac.acceptableInput) {
            mac.forceActiveFocus()
            return;
        }

        var mac_address = mac.text
        var port_no = checkbox.checked ? parseInt(port.text) : "40000";
        gwol.callWol(ip_address, mac_address, port_no);
    }

    ColumnLayout {
        id: columnLayout
        spacing: 0
        anchors.fill: parent

        Item {
            id: title
            width: 200
            height: 55
            Layout.preferredHeight: 55
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillWidth: true

            Label {
                id: label2
                text: qsTr("GWOL")
                font.letterSpacing: 5
                font.capitalization: Font.MixedCase
                font.pointSize: 28
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Item {
            id: general
            y: 0
            height: 0
            Layout.fillHeight: false
            Layout.preferredHeight: 100
            Layout.fillWidth: true

            GridLayout {
                x: 78
                y: 8
                columnSpacing: 20
                rowSpacing: -35
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.top: parent.top
                rows: 1
                columns: 2

                Label {
                    id: label
                    height: 30
                    text: qsTr("Ipaddr")
                    Layout.preferredHeight: 40
                    font.bold: true
                    font.pointSize: 17
                }


                Label {
                    id: label1
                    height: 30
                    text: qsTr("MAC ")
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 218
                    font.bold: true
                    font.pointSize: 17
                }


                TextField {
                    id: ipaddr
                    text: qsTr("")
                    padding: 0
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 232
                    placeholderText: "192.168.0.100"
                }

                TextField {
                    id: mac
                    text: qsTr("")
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 218
                    inputMask: "HH:HH:HH:HH:HH:HH;_"
                    font.pointSize: 14
                }
            }
        }

        Item {
            id: advancedCheckbox
            y: 0
            width: 200
            height: 200
            Layout.preferredHeight: 40
            Layout.fillHeight: false
            Layout.fillWidth: true

            CheckBox {
                id: checkbox
                x: 16
                y: 20
                width: 107
                height: 40
                text: qsTr("advanced")
                checked: false
                spacing: 6
                wheelEnabled: false
                font.pointSize: 10
                anchors.verticalCenterOffset: 0
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Item {
            id: advanced
            width: 200
            height: 0
            Layout.fillHeight: false
            clip: true
            Layout.preferredHeight: 0
            Layout.fillWidth: true

            Label {
                id: label3
                x: 94
                y: 8
                width: 200
                height: 0
                text: qsTr("Port")
                font.bold: true
                Layout.preferredHeight: 40
                font.pointSize: 14
            }

            TextField {
                id: port
                x: 94
                y: 40
                width: 200
                height: 30
                text: qsTr("")
                font.pointSize: 12
                placeholderText: "40000"
                validator: IntValidator{}
            }
            states: [
                State {
                    name: "openState"
                    when: checkbox.checked

                    PropertyChanges {
                        target: advanced
                        Layout.preferredHeight: 100
                    }
                    PropertyChanges {
                        target: root
                        height: columnLayout.implicitHeight
                    }
                }
            ]

            transitions: Transition {

                NumberAnimation {
                    property: "Layout.preferredHeight"
                    duration: 50
                    easing.type: Easing.InOutQuad
                }
            }
        }

        Item {
            id: buttons
            y: 0
            width: 0
            height: 0
            Layout.preferredHeight: 50
            Layout.fillHeight: false
            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            Layout.fillWidth: true

            Button {
                id: wakeButton
                x: 426
                y: 0
                text: qsTr("Wake")
                anchors.verticalCenterOffset: 0
                anchors.verticalCenter: parent.verticalCenter
            }

            Button {
                id: quitButton
                x: 532
                y: 1
                text: qsTr("Quit")
                anchors.verticalCenterOffset: 0
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Dialog {
        id: dialog
        x: 97
        y: 35
        width: 447
        height: 230
        clip: true

        dim: true
        modal: true

        standardButtons: Dialog.Ok

        contentItem: TextArea {
            id: dialog_ta
            readOnly: true
            selectByMouse: true
            wrapMode: TextEdit.WordWrap
            font.pointSize: 16
        }
    }

    Connections {
        target: quitButton
        onClicked: Qt.quit()
    }

    Connections {
        target: wakeButton
        onClicked: wol()
    }
}
