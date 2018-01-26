import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import QtQuick.Controls.Material 2.2
import AnekAPI 1.0
import AndroidUtils 1.0

ToolBar {
    signal shareClicked
    signal copyClicked
    property alias title: appTitle.text
    property alias showLoading: busyIndicator.visible
    property alias shareButtonVisible: shareButton.visible
    
    RowLayout {
        id: appBarLayout
        anchors.leftMargin: dp(16)
        anchors.rightMargin: dp(16)
        anchors.fill: parent

        spacing: dp(16)
        
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
            id: copyButton
            Layout.fillHeight: true
            icon.source: "res/copy.svg"
            icon.width: dp(24)
            icon.height: dp(24)
            icon.color: "#ffffff"

            onClicked: copyClicked()
        }
        
        ToolButton {
            id: shareButton
            Layout.fillHeight: true
            icon.source: "res/share.svg"
            icon.width: dp(24)
            icon.height: dp(24)
            icon.color: "#ffffff"

            onClicked: shareClicked()
        }
    }
}
