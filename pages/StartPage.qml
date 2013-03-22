import QtQuick 1.1
import Sailfish.Silica 1.0
import Sailfish.Office 1.0
import QtMobility.gallery 1.1

Page {

    allowedOrientations: window.allowedOrientations

    Component {
        id: delegate
        BackgroundItem {
            id: delegateItem
            width: view.width
            height: thumbnail.height
            //enabled: count > 0
            opacity: enabled ? 1.0 : 0.5

            Label {
                id: countLabel
                objectName: "countLabel"
                anchors {
                    right: thumbnail.left
                    rightMargin: theme.paddingLarge
                    verticalCenter: parent.verticalCenter
                }
                text: count
                color: delegateItem.down ? theme.highlightColor : theme.primaryColor
                font.pixelSize: theme.fontSizeLarge
            }

            // Load icon from a plugin
            Loader {
                id: thumbnail
                x: width - theme.paddingLarge
                width: theme.itemSizeExtraLarge
                height: width
                source: icon != "" ? icon : "PhotoIcon.qml"
                opacity: delegateItem.down ? 0.5 : 1
            }

            Label {
                id: titleLabel
                objectName: "titleLabel"
                elide: Text.ElideRight
                font.pixelSize: theme.fontSizeLarge
                text: title
                color: delegateItem.down ? theme.highlightColor : theme.primaryColor
                anchors {
                    left: thumbnail.right
                    right: parent.right
                    leftMargin: theme.paddingLarge
                    verticalCenter: parent.verticalCenter
                }
            }

            onClicked: {
                    console.debug("Model name: " + providerModel.objectName);
                    window.pageStack.push(page != "" ? Qt.resolvedUrl(page) : Qt.resolvedUrl("FileListPage.qml") , {
                    title: title,
                    model: providerModel,
                    //thumbnailDelegate: thumbnail != "" ? thumbnail : Qt.resolvedUrl("GridImageThumbnail.qml")
            } ) }
        }
    }

    SilicaListView {
        id: view
        objectName: "docListView"

        anchors.fill: parent
        delegate: delegate
        header: PageHeader { title: "Documents" }
        model: DocumentProviderListModel {
            id: documentSources
            TrackerDocumentProvider {
            }
        }
    }
}
