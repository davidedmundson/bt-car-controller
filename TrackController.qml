import QtQuick 2.2
import QtQuick.Layouts 1.3
// import QtQuick.Controls 2.2
import QtBluetooth 5.11
import org.kde.kirigami 2.5 as Kirigami
import QtGamepad 1.0

Kirigami.Page
{
    title: "Drive!"
    property alias service: socket.service
    property alias hasGamepad: gamepad.connected

     Gamepad {
        id: gamepad
        deviceId: GamepadManager.connectedGamepads.length > 0 ? GamepadManager.connectedGamepads[0] : -1
    }

    BluetoothSocket {
        id: socket
        connected: true
        onSocketStateChanged: {
            console.log("AA", socket.socketState);
        }
        onErrorChanged: {
            console.log("BB", socket.error);
        }
        onConnectedChanged: {
            console.log("CC", socket.connect);
        }
    }

    RowLayout {
        anchors.fill: parent
        Control {
            id: leftSpeed
            Layout.fillHeight: true
            onValueChanged: {
                console.log("sending ", Math.round(value * 100));
                socket.stringData = "1:" + Math.round(value * 100) + "\n"
            }
            Binding {
                when: hasGamepad
                target: leftSpeed
                property: "value"
                value: Math.round(-gamepad.axisLeftY*4) / 4 //negated for reasons I don't understand.
            }
        }
        ColumnLayout {
            Layout.fillWidth: true
            Text {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                text: socket.socketState == BluetoothSocket.Connecting ? "Connecting..." :
                        socket.socketState == BluetoothSocket.Connected  ? "Connected" : "Error:" +socket.socketState
            }
            Text {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                text: "Gamepad connected"
                visible: hasGamepad
            }
        }
        Control {
            id: rightSpeed
            Layout.fillHeight: true
            onValueChanged: socket.stringData = "2:" + Math.round(value * 100) + "\n"
            Binding {
                when: hasGamepad
                target: rightSpeed
                property: "value"
                value: Math.round(-gamepad.axisRightY*4) / 4 //negated for reasons I don't understand.
            }
        }
    }
}
