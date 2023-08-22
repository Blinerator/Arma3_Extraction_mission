class CustomMessageDialog {
    idd = -1;
    movingEnable = true;
    controlsBackground[] = {Background};
    objects[] = {};
    controls[] = {MessageInput, OKButton, CancelButton};

    class Background: RscBackground {
        x = 0.288594 * safezoneW + safezoneX;
        y = 0.357 * safezoneH + safezoneY;
        w = 0.422812 * safezoneW;
        h = 0.286 * safezoneH;
        colorBackground[] = {0,0,0,0.8};
    };

    class MessageInput: RscEdit {
        idc = 101;
        x = 0.298906 * safezoneW + safezoneX;
        y = 0.3902 * safezoneH + safezoneY;
        w = 0.402187 * safezoneW;
        h = 0.2096 * safezoneH;
    };

    class OKButton: RscButton {
        text = "OK";
        x = 0.581094 * safezoneW + safezoneX;
        y = 0.609 * safezoneH + safezoneY;
        w = 0.103125 * safezoneW;
        h = 0.022 * safezoneH;
        action = "closeDialog 0";
    };

    class CancelButton: RscButton {
        text = "Cancel";
        x = 0.470937 * safezoneW + safezoneX;
        y = 0.609 * safezoneH + safezoneY;
        w = 0.103125 * safezoneW;
        h = 0.022 * safezoneH;
        action = "closeDialog 0";
    };
};
