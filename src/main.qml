import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.0
import AnekAPI 0.1
import AndroidUtils 0.1

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 1280
    height: 720
    flags: Qt.Window | Qt.MaximizeUsingFullscreenGeometryHint

    property double dp: Screen.pixelDensity * 2.54 / 16

    AndroidUtils {
        id: util
        statusBarColor: Material.color(Material.Green, Material.Shade700)
    }

    AnekAPI {
        id: anekapi
        hostname: "theth.ddns.net"
        port: 8080

        Component.onCompleted: anekapi.connectToServer()
        onConnected: requestAnek()

        onAnekReady: {
            anekLabel.text = text
            busyIndicator.visible = false
        }

        onErrorMessage: {
            util.showShortToastMessage(message)
            busyIndicator.visible = false
        }
    }

    header: ToolBar {
        height: 56 * dp

        RowLayout {
            anchors.leftMargin: 16 * dp
            anchors.rightMargin: 16 * dp
            anchors.fill: parent

            Label {
                color: "#ffffff"
                renderType: Text.NativeRendering
                font.pointSize: 18
                text: "AnekApp"
                font.bold: true
                verticalAlignment: Text.AlignVCenter
                Layout.fillHeight: true
            }

            BusyIndicator {
                id: busyIndicator
                Layout.fillHeight: true
                width: 18 * dp
                height: 18 * dp
            }

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true

                ToolButton {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    visible: util.available
                    icon.source: "res/share.svg"
                    icon.width: 24 * dp
                    icon.height: 24 * dp
                    icon.color: "#ffffff"

                    onClicked: util.sharePlainText(anekapi.text, "Share Anek")
                }
            }
        }
    }

    ScrollView {
        id: scrollview
        contentWidth: -1
        anchors.fill: parent

        ColumnLayout {
            width: scrollview.width

            Pane {
                Layout.fillWidth: true
                Material.elevation: 8

                Label {
                    id: anekLabel
                    font.pointSize: 16
                    width: parent.width
                    renderType: Text.NativeRendering
                    wrapMode: Text.WordWrap
                }
            }
        }
    }

    footer: ToolBar {
        height: 56 * dp
        ToolButton {
            anchors.fill: parent
            text: "Next Anek"
            font.pointSize: 16
            Material.foreground: "#ffffff"

            onClicked:  {
                busyIndicator.visible = true
                anekapi.requestAnek()
            }
        }
    }
}
