
[中文介绍](http://suchang.net/blog/2019-12.html#p1)

the ObjectiveC version please refers to ObjC branch.

# Introduction

the library provide a simple interface to use theme/skin manager for iOS8+, including 

- backgroundColor
- borderColor
- gradientColor
- font family and size
- image or tint image
- attributed string foreground/background color

also provide a simple way to add the theme/skin ability for other UI element.

# ScreenShot

#### Light

![Light](https://github.com/lalawue/LWTheme/blob/Swift/Example/Screenshot/light.png)

#### Dark

![Dark](https://github.com/lalawue/LWTheme/blob/Swift/Example/Screenshot/dark.png)

# Demos

```
cd Example
pod install
open Example.xcworkspace
```

then click 'change theme'.

# ThemeMap and Interface

change theme with 

```
LWThemeManager.sharedInstance.useThemeMode(_ mode : LWThemeMode, themeMap : NSDictionary)
```

theme map is a dictionary, defined with color key, font family name and size (conjunction with ':'), image name for different mode.

you can defined yours theme map as below:

![LightMap](https://github.com/lalawue/LWTheme/blob/Swift/Example/Screenshot/lightmap.png)

![DarkMap](https://github.com/lalawue/LWTheme/blob/Swift/Example/Screenshot/darkmap.png)
