import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

Window {
    id: root
    width: 640
    height: 480
    visible: true

    Image {
        anchors.fill: parent
        source: "qrc:/night.jpg"
    }
    Timer {
        id: snowflake_generator
        triggeredOnStart: true
        onTriggered: {
            var snowflake_obj = snowflake.createObject(root)
            snowflake_obj.x = Math.random() * (root.width - snowflake_obj.width)
            snowflake_obj.y = Math.random() * 100
            snowflake_generator.interval = Math.random() * 900 + 100
        }
        running: true
        repeat: true
    }
    Component {
        id: snowflake
        Button {
            id: snowflake_button
            width: 20
            height: 20
            onClicked: snowflake_button.destroy()
            background: Image {
                anchors.fill: parent
                source: "qrc:/snowflake.png"
            }

            property int snowflake_movement: snowflake_button.hovered ? 2 : 1

            Timer {
                interval: Math.random() * 70 + 30
                repeat: true
                running: true
                onTriggered: {
                    snowflake_button.y += snowflake_movement
                    if (snowflake_button.y >= root.height - snowflake_button.height) {
                        snowflake_button.destroy()
                        lose_text.visible = true
                    }
                }
            }
        }
    }
    Text {
        id: lose_text
        text: "YOU LOSE"
        anchors.centerIn: parent
        color: "red"
        font.pixelSize: root.height / 5
        font.bold: true
        visible: false
    }
}
