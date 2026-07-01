import QtQuick
import Quickshell.Services.Mpris

Item {
    id: root

    property bool hasPlayers: Mpris.players.values.length > 0
    property var activePlayer: null
    readonly property string title: activePlayer ? (activePlayer.trackTitle || activePlayer.identity || "Media") : "Media"
    readonly property string artist: activePlayer ? (activePlayer.trackArtist || activePlayer.trackAlbumArtist || activePlayer.identity || "") : ""
    readonly property string album: activePlayer ? (activePlayer.trackAlbum || "") : ""
    readonly property string artUrl: activePlayer ? (activePlayer.trackArtUrl || "") : ""
    readonly property string fullText: artist && title ? artist + " - " + title : title

    function refreshActivePlayer() {
        let players = Mpris.players.values;
        let playingPlayer = null;
        let pausedPlayer = null;

        for (let i = 0; i < players.length; i++) {
            let player = players[i];
            if (player.isPlaying) {
                playingPlayer = player;
                break;
            }
            if (!pausedPlayer && player.playbackState !== MprisPlaybackState.Stopped)
                pausedPlayer = player;

        }

        root.activePlayer = playingPlayer || pausedPlayer || (players.length > 0 ? players[0] : null);
        root.hasPlayers = players.length > 0;
    }

    function togglePlaying() {
        if (activePlayer && activePlayer.canTogglePlaying)
            activePlayer.togglePlaying();

    }

    function next() {
        if (activePlayer && activePlayer.canGoNext)
            activePlayer.next();

    }

    function previous() {
        if (activePlayer && activePlayer.canGoPrevious)
            activePlayer.previous();

    }

    Connections {
        target: Mpris.players

        function onValuesChanged() {
            root.refreshActivePlayer();
        }

    }

    Timer {
        interval: 750
        running: true
        repeat: true
        onTriggered: root.refreshActivePlayer()
    }

    Component.onCompleted: refreshActivePlayer()
}
