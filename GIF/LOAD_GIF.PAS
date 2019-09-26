UNIT Load_Gif;
{Load un Gif de 320x200x256}
{----------------------------------------------------------------------------}
INTERFACE
{----------------------------------------------------------------------------}
VAR
  VSCREEN:POINTER;                   {Pointer d'un virtual screen}
  PALETTE:ARRAY[0..256*3-1] OF Byte; {Creation d'une palette}
  VRAM_POS,                          {Position courante dans la RAM VGA}
  REST:WORD;                         {Autres octets en m‚moire centrale
                                      et # d'erreur }
  GIFNAME:STRING;
{----------------------------------------------------------------------------}

PROCEDURE LOADGIF(GName:String);
{Load le Gif dans Vscreen, un pointer 64 000 et le met dans la memoire video}

PROCEDURE LOADGIF2(GName:String;VS:POINTER);
{Load le Gif dans Vs, un pointer 64 000}

PROCEDURE SETPAL;
{Load la palette courante}
{----------------------------------------------------------------------------}
 IMPLEMENTATION

PROCEDURE SETPAL;EXTERNAL;

PROCEDURE READGIF;EXTERNAL;
{$L LOAD_GIF.OBJ}


PROCEDURE LOADGIF2(GName:String;VS:POINTER);
  Begin
  GIFNAME:=GNAME+#0;                  {Fait une chaine Texte }
  VRAM_POS:=0;                        {OffSet 0 de $A000 }
  READGIF;                            {charge l'image }
  SETPAL;
  MOVE(VSCREEN^,VS^,64000); {Copie le Gif dans un pointeur quelconque}
  End;

PROCEDURE LOADGIF(GName:String);
  Begin
  GIFNAME:=GNAME+#0;                  {Fait une chaine Texte }
  VRAM_POS:=0;                        {OffSet 0 de $A000 }
  READGIF;                            {charge l'image }
  SETPAL;                             {Load la palette courante}
  MOVE(VSCREEN^,PTR($a000,0)^,64000); {Affiche le Gif}
  End;
{----------------------------------------------------------------------------}
Begin
 GetMem(VScreen,64000); {Donne 64000 octets dans le pointeur VSCREEN}
End.
{----------------------------------------------------------------------------}
{                            -= The enD !!! =-                               }
{----------------------------------------------------------------------------}
