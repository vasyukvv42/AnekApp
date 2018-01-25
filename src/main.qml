import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import QtQuick.Controls.Material 2.2
import AnekAPI 1.0
import AndroidUtils 1.0

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 800
    height: 600
    flags: Qt.Window | Qt.MaximizeUsingFullscreenGeometryHint

    function dp(size) {
        var ratio = Screen.pixelDensity * 2.54 / 16
        return (ratio > 1) ? ratio * size : size
    }

    AndroidUtils {
        id: util
        statusBarColor: Material.color(Material.Green, Material.Shade700)
    }

    AnekAPI {
        id: anekapi
        hostname: "theth.ddns.net"
        port: 8080

        Component.onCompleted: connectToServer()
        onConnected: requestAnek()

        onAnekReady: {
            anekLabel.text = text
            likesLabel.text = likes
            sourceButton.state = pub
            busyIndicator.visible = false
        }

        onErrorMessage: {
            util.showShortToastMessage(message)
            busyIndicator.visible = false
        }
    }

    header: ToolBar {
        id: appBar
        height: dp(56)

        RowLayout {
            id: appBarLayout
            anchors.leftMargin: dp(16)
            anchors.rightMargin: dp(16)
            anchors.fill: parent

            Label {
                id: appTitle
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
                Material.accent: "#ffffff"
            }

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            ToolButton {
                id: shareButton
                anchors.verticalCenter: parent.verticalCenter
                visible: util.available
                icon.source: "res/share.svg"
                icon.width: dp(24)
                icon.height: dp(24)
                icon.color: "#ffffff"

                onClicked: util.sharePlainText(anekapi.text, "Share Anek")
            }
        }
    }

    ScrollView {
        id: scrollview
        contentWidth: -1
        anchors.fill: parent

        Pane {
            id: anekCard
            width: parent.width
            anchors.centerIn: parent.Center
            Material.elevation: 8

            ColumnLayout {
                id: anekCardLayout
                anchors.fill: parent

                Label {
                    id: anekLabel
                    Layout.fillWidth: true
                    Layout.bottomMargin: dp(2)
                    font.pointSize: 16
                    renderType: Text.NativeRendering
                    wrapMode: Text.WordWrap
                }

                RowLayout {
                    id: infoLayout
                    spacing: 0

                    Label {
                        id: sourceLabel
                        Layout.fillHeight: true
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 14
                        Material.foreground: Material.Grey
                        text: "Source:"

                        MouseArea {
                            anchors.fill: parent
                            onClicked: sourceButton.clicked()
                        }
                    }

                    ToolButton {
                        id: sourceButton
                        Layout.fillHeight: true
                        icon.color: "transparent"
                        icon.height: dp(30)
                        icon.width: dp(30)

                        states: [
                            State {
                                name: "mlj"
                                PropertyChanges {
                                    target: sourceButton
                                    icon.source: "res/mlj.png"
                                    onClicked: Qt.openUrlExternally("https://vk.com/jumoreski")
                                }
                            },
                            State {
                                name: "akb"
                                PropertyChanges {
                                    target: sourceButton
                                    icon.source: "res/akb.png"
                                    onClicked: Qt.openUrlExternally("https://vk.com/baneks")
                                }
                            },
                            State {
                                name: "osa"
                                PropertyChanges {
                                    target: sourceButton
                                    icon.source: "res/osa.png"
                                    onClicked: Qt.openUrlExternally("https://vk.com/hilarious_stuff")
                                }
                            }

                        ]
                    }

                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }

                    Label {
                        id: likesLabel
                        Layout.fillHeight: true
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 14
                        Material.foreground: Material.Grey
                    }

                    ToolButton {
                        id: heartIcon
                        Layout.fillHeight: true
                        background: null
                        icon.source: "res/heart.svg"
                        icon.color: "#9e9e9e"
                        icon.height: dp(18)
                        icon.width: dp(18)
                    }
                }
            }
        }
    }

    footer: ToolBar {
        id: nextAnekBar
        height: dp(56)

        ToolButton {
            id: nextAnekButton
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
