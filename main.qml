import QtQuick 2.2
import QtBluetooth 5.11
import org.kde.kirigami 2.5 as Kirigami

Kirigami.ApplicationWindow {
    id:  app
    wideScreen: false
    controlsVisible: true

    header: Kirigami.ApplicationHeader {
            minimumHeight: Kirigami.Units.gridUnit * 1.6
    }

    pageStack.initialPage: DeviceSelectPage{
        onServiceSelected: {
            pageStack.push(Qt.resolvedUrl("TrackController.qml"), {"service": service});
        }
    }

}
