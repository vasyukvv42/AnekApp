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
    title: "AnekApp"
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
            anekCard.text = text
            anekCard.likes = likes
            anekCard.state = pub
            appBar.showLoading = false
        }

        onErrorMessage: {
            util.showShortToastMessage(message)
            appBar.showLoading = false
        }
    }

    header: AppBar {
        id: appBar
        title: "AnekApp"
        height: dp(56)
        shareButtonVisible: util.available

        onShareClicked: util.sharePlainText(anekapi.text, "Share Anek")

        onCopyClicked: {
            clipboard.setText(anekapi.text)
            util.showShortToastMessage("Anek copied to clipboard")
        }

    }

    ScrollView {
        id: scrollview
        contentWidth: -1
        anchors.fill: parent

        AnekCard {
            id: anekCard
            width: parent.width
            anchors.centerIn: parent.Center
            Material.elevation: 8
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
                appBar.showLoading = true
                anekapi.requestAnek()
            }
        }
    }
}
