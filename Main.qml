import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Effects



Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Animated Progress Bar")

    Rectangle
        {

            anchors.centerIn: parent
            width: 320
            height: 200
            color: "lime"

            Rectangle
            {
                id: progressBackground
                width: 300
                height: 30
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#e0e0e0"
                radius: 15
                z: 0


                Rectangle
                {
                    id: progressBar
                    width:0
                    height: parent.height
                    color: "crimson"
                    radius: 15
                    smooth: true
                    z: 1

                }
                Text
                {
                    anchors.centerIn: parent
                    text: Math.round((progressBar.width / progressBackground.width)*100) + "%"
                    font.pointSize: 15
                    font.bold: true
                    color: "black"
                    z: 3
                }

                MultiEffect
                {
                    id:glowEffect
                    anchors.fill: progressBar
                    source: progressBar
                    maskThresholdMin: 0.5
                    maskSpreadAtMin: 1.0
                    maskEnabled: true
                    maskSource: mask
                }

                Item
                {
                    layer.enabled: true
                    layer.smooth: true
                    visible: true
                    width: parent.width
                    height: parent.height
                    Rectangle
                    {
                        id:mask
                        width: parent.width
                        height: parent.height
                        radius: 15
                        color: "black"
                    }
                }
            }

            Button
            {

                text: "Start"
                width: 100
                height: 30
                background :
                    Rectangle
                {
                    implicitWidth : 100
                    implicitHeight : 30
                    radius: 8
                    color:"yellow"
                }
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: progressBackground.bottom
                anchors.topMargin: 20

                onClicked:
                {
                    progressBar.width = 0
                    progressAnim.start()
                }
            }


            NumberAnimation
            {
             id:progressAnim
             target: progressBar
             property: "width"
             to: 300
             duration: 2000
             easing.type: Easing.OutBounce

            }
        }
}
