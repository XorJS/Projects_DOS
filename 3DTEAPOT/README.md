# 3DTEAPOT

3DTEAPOT (Asm / 1999).

![Screenshot0](/3DTEAPOT/Screenshots/screenshot0.jpg)


## Play

https://www.jsr-productions.com/dos/3DTEAPOT.html

or

Use DOSBox to run 3DTEAPOT.exe or 3DTEAP~2.exe for more detail

## Info

### Keyboard/Control
- [Insert] And [Delete] For xXx Rotation (Start/Stop)
- [F1] - [F4] For Speed xXx Rotation
- [Home] And [End] For yYy Rotation (Start/Stop)
- [F5] - [F8] For Speed yYy Rotation
- [Page Up] And [Page Down] For zZz Rotation (Start/Stop)
- [F9] - [F12] For Speed zZz Rotation
- Uses Arrows For Moves Objects
- [+] and [-] For Z Positions

### DOSBox configuration (optional)
```
cycles=max ### auto
```

### Code

**Code in asm (x86). Sorry for the French comments ;)**

To compile with Turbo Assembler:
```
tasm Pong.asm
tlink Pong.obj /3
```
