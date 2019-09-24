# Pong

My Pong version (Asm / 1999).

![Screenshot0](/Pong/Screenshots/screenshot0.jpg)

![Screenshot1](/Pong/Screenshots/screenshot1.jpg)

![Screenshot2](/Pong/Screenshots/screenshot2.jpg)

## Play

https://www.jsr-productions.com/dos/Pong.html

or

Use DOSBox to run Pong.exe

## Info

### Keyboard/Control
- Player 1: W/X
- Player 2: Up/Down

### Arguments
```
Pong -[numbers of Balls (1-4)] /[Numbers of seconds (1..99999)
  Ex: Pong -3 /120  (3 balls and two minutes)
```

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
