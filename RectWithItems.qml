import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle{
    id: main_rect

    signal button_clicked()
    property bool auth_is_OK
    property bool show_busy_indicator
    property bool show_edit_box
    property bool auth_mode
    property bool auth_btn_enable
    property string auth_btn_caption
    property string searching_word
    property real pass_txt_fld_opacity
    property real user_txt_fld_y

    function is_auth_OK(){
        if(user_txt_fld.text === "user1" &&
                pass_txt_fld.text === "pass")
            return true

        return false
    }

    
    Column {
        id: clmn
        anchors.centerIn: parent
        spacing: 10

        Keys.onEnterPressed: auth_btn.clicked()
        Keys.onReturnPressed: auth_btn.clicked()
        BusyIndicator{
            id: busy_indicator
            running: main_rect.show_busy_indicator
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 10
        }

        TextField {
            id: user_txt_fld
            placeholderText: qsTr(auth_mode?"Login":"Word to search")
            y: main_rect.user_txt_fld_y
            visible: main_rect.show_edit_box
            focus: true
        }
        TextField {
            id: pass_txt_fld
            echoMode: "Password"
            placeholderText: qsTr("Password")
            opacity: main_rect.pass_txt_fld_opacity
        }
        Button {
            id: auth_btn
            text: main_rect.auth_btn_caption
            enabled: user_txt_fld.text !== "" || main_rect.show_busy_indicator
            onClicked: {

                if(main_rect.auth_mode)
                    main_rect.auth_is_OK = is_auth_OK()
                else
                {
                    main_rect.searching_word = user_txt_fld.text
                }

                user_txt_fld.text = ""
                pass_txt_fld.text = ""
                user_txt_fld.focus = true

                main_rect.button_clicked()
            }
        }

    }
}
