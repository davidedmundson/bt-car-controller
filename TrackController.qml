import QtQuick 2.2
import QtQuick.Layouts 1.3
// import QtQuick.Controls 2.2
import QtBluetooth 5.11
import org.kde.kirigami 2.5 as Kirigami

Kirigami.Page
{
    title: "..."
    property alias service: socket.service
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
            Layout.fillHeight: true

            onValueChanged: {
                console.log("1:" + Math.round(value * 100) + "\n")
                socket.stringData = "1:" + Math.round(value * 100) + "\n"

            }
        }
        ColumnLayout {
            Layout.fillWidth: true
            Item {
                width: 20
            }
            Text {
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                text: socket.socketState == BluetoothSocket.Connecting ? "Connecting" :
                        socket.socketState == BluetoothSocket.Connected  ? "Connected" : socket.socketState
            }
        }
        Control {
            Layout.fillHeight: true
            onValueChanged: socket.stringData = "2:" + Math.round(value * 100) + "\n"
        }
    }
}
