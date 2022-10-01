import 'package:flutter/material.dart';

// 主题颜色配置
const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    // 主色
    primary: Colors.blue,
    onPrimary: Colors.white,
    primaryContainer: Colors.white,
    onPrimaryContainer: Colors.black,
    // 次要
    // 导航栏，侧边栏，文章块，底部tabbar
    secondary: Colors.white,
    onSecondary: Colors.black12,
    // 错误
    error: Colors.red,
    onError: Colors.white,
    // 背景
    background: Color(0xfff5f6f7),
    onBackground: Color(0xff4e5358),
    // 表面
    surface: Colors.white,
    onSurface: Colors.black,
    shadow: Color(0x74747414),
    // 侧边栏
    surfaceVariant: Color(0x00000008),
    // 次级字体，图标
    onSurfaceVariant: Color(0xff4e5358),

    // 边框
    outline: Color(0x3232320f));

const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    // 主色
    primary: Colors.blue,
    onPrimary: Colors.white,
    primaryContainer: Color(0xff323335),
    onPrimaryContainer: Color(0xffe5eef7),
    // 次要
    // 导航栏，侧边栏，文章块，底部tabbar
    secondary: Colors.white,
    onSecondary: Colors.black12,
    // 错误
    error: Colors.red,
    onError: Colors.white,
    // 背景
    background: Color(0xff292a2d),
    onBackground: Color(0xffe5eef7),
    // 表面
    surface: Colors.white,
    onSurface: Colors.black,
    shadow: Color(0x74747414),
    // 侧边栏
    surfaceVariant: Color(0x00000008),
    // 次级字体，图标
    onSurfaceVariant: Color(0xff4e5358),

    // 边框
    outline: Color(0x3232320f));
