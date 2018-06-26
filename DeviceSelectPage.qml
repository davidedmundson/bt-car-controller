import QtQuick 2.2
import QtBluetooth 5.11
import org.kde.kirigami 2.5 as Kirigami

Kirigami.ScrollablePage  {
    id: root
    supportsRefreshing: true
    title: "Select Device"
    signal serviceSelected(BluetoothService service)

    ListView {
        id: view
        model: BluetoothDiscoveryModel {
            id: bluetoothModel
            onErrorChanged: {
                console.log("ERROR", error);
            }
            //DAVE need filter model on serviceName
        }
        delegate: Kirigami.BasicListItem {
            text: model.name
            onClicked: root.serviceSelected(model.service)
        }
    }
    refreshing: true;
    onRefreshingChanged: {
        if (refreshing)
            bluetoothModel.running = true;
        refreshing = Qt.binding(bluetoothModel.running == true)
    }
}
