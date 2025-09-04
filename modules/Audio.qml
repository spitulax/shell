// TODO:
// - Click to open media menu and speaker/mic slider
// - Double-click to toggle mute
// - Right-click to open pwvucontrol
// - Media (icon changes when playing media)

import qs.components
import qs.sources

VerticalText {
    id: root
    text: [Audio.getIcon(), Audio.volume]
}
