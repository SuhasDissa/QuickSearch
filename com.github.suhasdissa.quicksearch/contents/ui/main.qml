import QtQuick 2.0
import QtWebEngine 1.5
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras

ColumnLayout {
    RowLayout{
        Layout.fillWidth: true
        PlasmaComponents3.Button {
            icon.name: "go-previous"
            onClicked: webview.goBack()
            enabled: webview.canGoBack
        }
        PlasmaComponents3.Button {
            icon.name: "go-next"
            onClicked: webview.goForward()
            enabled: webview.canGoForward
        }
        PlasmaComponents3.Button {
            icon.name: "go-home-symbolic"
            onClicked: webview.url = plasmoid.configuration.homeurl
        }
        PlasmaComponents3.TextField {
            Layout.fillWidth: true
            onAccepted: {
                var url = text;
                if (url.indexOf(":/") < 0) {
                    url = plasmoid.configuration.query + url;
                }
                webview.url = url;
            }
            onActiveFocusChanged: {
                if (activeFocus) {
                    selectAll();
                }
            }

            text: webview.url
        }

        PlasmaComponents3.Button {
            icon.name: webview.loading ? "process-stop" : "view-refresh"
            onClicked: webview.loading ? webview.stop() : webview.reload()
        }
    }

    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true

        Layout.minimumWidth: PlasmaCore.Units.gridUnit * 48
        Layout.preferredHeight: PlasmaCore.Units.gridUnit * 108

        WebEngineView {
            id: webview
            anchors.fill: parent
            Component.onCompleted: url = plasmoid.configuration.homeurl;
            Connections {
                target: plasmoid.configuration
            }

            onLinkHovered: {
                if (hoveredUrl.toString() !== "") {
                    mouseArea.cursorShape = Qt.PointingHandCursor;
                } else {
                    mouseArea.cursorShape = Qt.ArrowCursor;
                }
            }

            onNewViewRequested: {
                var url = request.requestedUrl;

                if (request.userInitiated) {
                    Qt.openUrlExternally(url);
                }
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            acceptedButtons: Qt.BackButton | Qt.ForwardButton
            onPressed: {
                if (mouse.button === Qt.BackButton) {
                    webview.goBack();
                } else if (mouse.button === Qt.ForwardButton) {
                    webview.goForward();
                }
            }
        }
    }
}
