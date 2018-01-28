import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import QtQuick.Controls.Material 2.2
import AnekAPI 1.0
import AndroidUtils 1.0

Pane {
    property alias text: anekLabel.text
    property alias likes: likesLabel.text

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

    ColumnLayout {
        id: anekCardLayout
        anchors.fill: parent
        anchors.margins: dp(2)
        spacing: dp(2)
        
        Label {
            id: anekLabel
            Layout.fillWidth: true
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
                text: "Source: "
                
                MouseArea {
                    anchors.fill: parent
                    onClicked: sourceButton.clicked()
                }
            }
            
            ToolButton {
                id: sourceButton
                icon.color: "transparent"
                icon.height: dp(30)
                icon.width: dp(30)
                anchors.verticalCenter: parent.verticalCenter
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
                background: null
                icon.source: "res/heart.svg"
                icon.color: "#9e9e9e"
                icon.height: dp(18)
                icon.width: dp(18)
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
