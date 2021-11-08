import QtQuick 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12 as QQC2

import org.kde.kirigami 2.8 as Kirigami
import org.kde.plasma.core 2.0 as PlasmaCore

Kirigami.FormLayout {
    anchors.right: parent.right
    anchors.left: parent.left

    property alias cfg_homeurl: homeurl.text
    property alias cfg_query: query.text

    RowLayout{
        Kirigami.FormData.label: i18nc("@title:group", "Homepage URL:")

    QQC2.TextArea {
        id: homeurl
        placeholderText : "https://search.brave.com/"
    }

    }
    RowLayout{
        Kirigami.FormData.label: i18nc("@title:group", "Search Engine Query:")

    QQC2.TextArea {
        id: query
        placeholderText : "https://search.brave.com/search?q="
    }

    }
}

