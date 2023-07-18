import QtQuick 2.15
import QtQuick.Controls 2.15
import QtMultimedia 5.15

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: "Video Player"

    MediaPlayer {
        id: player
        autoLoad: true

        onStatusChanged: {
            if (player.status === MediaPlayer.EndOfMedia) {
                playPauseButton.text = "Play"
            }
        }
    }

    VideoOutput {
        anchors.fill: parent
        source: player
    }

    Rectangle {
        width: parent.width
        height: 50
        color: "black"
        anchors.bottom: parent.bottom

        RowLayout {
            anchors.centerIn: parent

            Button {
                id: playPauseButton
                text: "Play"
                onClicked: {
                    if (player.playbackState === MediaPlayer.PlayingState) {
                        player.pause()
                        playPauseButton.text = "Play"
                    } else {
                        player.play()
                        playPauseButton.text = "Pause"
                    }
                }
            }

            Slider {
                id: progressSlider
                width: parent.width / 2
                value: player.position
                maximumValue: player.duration

                onValueChanged: {
                    if (progressSlider.pressed) {
                        player.position = value
                    }
                }
            }
        }
    }

    FileDialog {
        id: fileDialog
        title: "Open Video File"
        folder: shortcuts.home
        nameFilters: ["Video Files (*.mp4 *.avi)"]

        onAccepted: {
            player.source = fileDialog.fileUrl
            player.play()
            playPauseButton.text = "Pause"
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            fileDialog.open()
        }
    }

    Component.onCompleted: {
        // Load a default video for testing
        player.source = "C:/Users/HP/Desktop/QT/sample.mp4"
    }
}
