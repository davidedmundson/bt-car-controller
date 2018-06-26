import QtQuick.Controls 2.4
import QtQuick 2.2

Slider {
    id: control
    orientation: Qt.Vertical
    value: 0
    from: -1
    to: 1
    stepSize: 0.25
    snapMode: Slider.SnapAlways

    onPressedChanged: {
        if (!pressed) {
            value = 0;
        }
    }

    //my controller shuts down if there's no new data in 3 seconds, repeat every second even if the value doesn't change
    Timer {
        interval: 1000
        repeat: true
        running: pressed
        onTriggered: valueChanged(value)
    }

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 80
        implicitHeight: 200
//         width: 20
        height: control.availableHeight
        radius: 2
        color: "#bdbebf"
    }

    handle: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.visualPosition * (control.availableHeight - height)
        implicitWidth: 80
        implicitHeight: 80
        radius: 3
        color: control.pressed ? "#f0f0f0" : "#f6f6f6"
        border.color: "#bdbebf"
    }

    Rectangle {
        color: "black"
        width: 10
        height: 1
        anchors.right: control.left
        anchors.verticalCenter: control.verticalCenter
    }
        Rectangle {
        color: "black"
        width: 10
        height: 1
        anchors.left: control.right
        anchors.verticalCenter: control.verticalCenter
    }
}
