package funkin.desktop;

import lime.app.Application;
import openfl.display.BitmapData;
import flixel.system.scaleModes.BaseScaleMode;
import flixel.system.scaleModes.FixedScaleAdjustSizeScaleMode;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class DesktopMain extends MusicBeatState {
    public var oldScaleMode:BaseScaleMode;
    public var wallpaper:FlxSprite;
    public var screenSize:FlxPoint;

    public var windows:WindowGroup;

    public static var instance:DesktopMain;

    public override function create() {
        super.create();
        instance = this;
        
        FlxG.mouse.useSystemCursor = FlxG.mouse.visible = true;
        oldScaleMode = FlxG.scaleMode;
        FlxG.scaleMode = new FixedScaleAdjustSizeScaleMode(false, false);

        wallpaper = new FlxSprite();
        #if windows
        try {
            wallpaper.loadGraphic(BitmapData.fromFile('${Sys.getEnv("AppData")}\\Microsoft\\Windows\\Themes\\TranscodedWallpaper'));
        } catch(e) #end wallpaper.loadGraphic(Paths.image("menuBG"));
        wallpaper.scrollFactor.set(0, 0); // anchor at top left
        add(wallpaper);

        screenSize = new FlxPoint(-1, -1);

        windows = new WindowGroup();
        add(windows);
        windows.add(new Window("Test Window", 640, 480, 200, 200));
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);

        if (screenSize.x != FlxG.width || screenSize.y != FlxG.height) {
            screenSize.set(FlxG.width, FlxG.height);
            updateScreenRes();
        }
    }

    public function updateScreenRes() {
        // update wallpaper
        wallpaper.setUnstretchedGraphicSize(FlxG.width, FlxG.height);
    }

    public override function destroy() {
        super.destroy();
        FlxG.scaleMode = oldScaleMode;
        FlxG.mouse.useSystemCursor = FlxG.mouse.visible = false;

        // TODO: switch back while using config
        FlxG.resizeGame(1280, 720);
    }
}