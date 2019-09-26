UNIT PlayAnim;

INTERFACE

Procedure AnmInit(const filename : string);
Procedure AnmDone;
Procedure AnmReadFrame(const frameNumber : word);

type IntArray  = array[0..9999] of WORD;
var	pInt : ^IntArray;
	palette : array[1..256*3] of byte;
	header : record
	 id          : array[0..5] of byte;
     nLps        : word;
	 nRecords    : longint;
	 contentType : array[0..51] of byte;
     nFrames     : longint;
     pad         : array[0..29] of word;
    end;

IMPLEMENTATION

VAR	f : FILE;
	LP : array[0..9999] of RECORD
     base,
     nRecords,
     size:word;
    END;
var aa:word;
var curlp : record
	 base     : word;
	 nRecords : word;
	 size     : word;
    end;

buffer : POINTER;

Procedure AnmReadHeader;
Var i,j : word;
	fill : array[1..128] of byte;
Begin
 BlockRead(f, header, 128);
 BlockRead(f, fill, 128);
 j:=1;
for i:=1 to 256 do begin
 BlockRead(f, fill, 4);
 palette[j]:=fill[3] SHR 2;
 palette[j+1]:=fill[2] SHR 2;
 palette[j+2]:=fill[1] SHR 2;
 inc(j,3);
End;
 {read long-page array}
 BlockRead(f, LP, header.nFrames*6 );
End;

Procedure AnmInit(const filename : string);
Begin
 Assign(F, filename);
 Reset(F,1);
 AnmReadHeader;
 GetMem(buffer,65535);
End;

Procedure AnmDone;
Begin
 Close(f);
 FreeMem(buffer,65535);
End;

Procedure  AnmReadFrame(const frameNumber : word);
var i,size : integer;
	Tmp: word;
	Ofset, pos : word;
	destFrame : word;

Begin
 Asm
  Mov i,-1;
End;

Repeat
 Asm
  Inc i
 End;

 If (LP[i].base <= frameNumber) AND (LP[i].base + LP[i].nRecords > frameNumber) then aa:=i;
Until (i=header.nlps-1);

 seek(f, longint($B00) + (longint(aa)*$10000)); {find page}
 BlockRead( f, curlp, 6); {read LP}
 BlockRead( f, Tmp, 2);   {skip word with 0 value}
 
 Asm
  Mov Ax,curlp.nRecords
  Mov Bx,02
  Mul Bx
  Mov Bx,curlp.size
  Add Ax,Bx
  Mov Word Ptr size,Ax
 End;

 If size<$10000 Then
  BlockRead( f, buffer^, size );

 Asm
  Mov Ax, frameNumber
  Sub Ax,curlp.base
  Mov destFrame,Ax
  Xor Ax,Ax
  Mov Ofset,0
 End;

 pInt := @buffer^;
 
 Asm
  Mov Ofset,0
 End;

 If destFrame>0 then
  For i:=0 to destFrame-1 do Inc( Ofset, pInt^[i] );

 Asm
  Mov Ax,curlp.nRecords
  Mov Bx,02d
  Mul Bx
  Add Ax,Ofset
  Mov pos,Ax
  Xor Ax,Ax
  Xor BX,BX
  Add pos,04d
  Push Ds
  Push 0A000H
  Mov Di,offset Es
  Pop Es
  Lds Si,buffer
  Add Si,pos
  Cld
  Xor Ch,Ch
  Jmp @NEXTOP
@SKIP:
  Sub Cl,80H   { Strip off sign bit, leaving skip cnt.}
  Jz  @LONGOP  { cnt==0 indicates a long op.}
			   {--- shortSkip ---}
  Add Di,Cx    { skip # pixels.  (CH=0)}
			   {--- variation on NEXTOP inline to minimize jmp's ---}
@NEXTOP:	   { Get and decode next op.}
  Mov Cl,[Si]
  Inc Si
  Jcxz @RUN
  Or Cl,Cl	   { Test CL's sign bit.}
  Jl @SKIP
@DUMP:
  Rep Movsb	   { copy # pixels.  (CH=0)}
			   {--- variation on NEXTOP inline to minimize jmp's ---}
  Mov Cl,[Si]
  Inc Si
  Or Cl, Cl	   { Test CL's sign bit.}
  Jl @skip
  Jg @dump
@run:
  Mov	Cl,[Si]	{ 8-bit unsigned count.}
  Inc	Si
  Lodsb	        { pixel value.}
  Rep Stosb	    {  set # pixels to value.  (CH=0)}
		        {--- variation on NEXTOP inline to minimize jmp's ---}
  Mov Cl,[Si]
  Inc Si
  Jcxz @run
  Or Cl, Cl	    { Test CL's sign bit.}
  Jl @skip
  Jmp @dump

@longOp:	    { NOTE: if load into CX, must clear CH afterwards.}
  Lodsw		   	{ 16-bit unsigned count.}
  Or Ax,Ax		{ set flags.}
  Jle @notLongSkip
@longSkip:
  Add Di,Ax		{ skip # pixels.}
  jmp   @nextOp
				{ longSkip only used for > 2*127, so can't be very many,}
				{ so don't bother saving one jmp with inline NEXTOP.}
@notLongSkip:
  Jz @stop	    { long count of zero means "stop code".}
  Mov Cx,Ax		{ may SET CH non-zero.}
  Sub Ch,80h	{ Clear sign bit.}
  Cmp Ch,40h
  Jge @longRun
				{ --- For maximum speed on longDump, caller should insure src & dst are}
				{ aligned.  To do so, caller must calculate whether}
				{ src DATA will begin on same (odd or even) alignment as dst data.}
				{ If not, first put a 1-byte Dump, which occupies 2 src bytes, thereby}
				{ shifting relative alignment (src moves 2, dst moves 1).}
				{ longDump}
  Test Si,1
				{ Insure src word-aligned.}
				{ In case caller didn't sync src & dst, we chose}
				{ to align src because we know it is of benefit --}
				{ aligning dst on 8-bit video cards might not be of}
				{ any benefit.}
  Jz @dumpWordAligned
  Movsb			{ get to word boundary.}
  Dec Cx
@dumpWordAligned:
  Shr Cx,1			{ Convert byte count to word count.}
  Jc @dumpOddByte
  Rep Movsw			{ Word-aligned.}
@longOpDone:
  Xor Ch,Ch			{ SET CH = 0.}
  Jmp @nextOp

@dumpOddByte:
  Rep Movsw			{ Word-aligned.}
  Movsb
  Jmp @longOpDone

@longRun:
  Sub Ch,40h		{ Clear "longRun" bit.}
  Lodsb
  Mov Ah,Al		    { Replicate byte to word value.}
  Test Di,1  	    { Insure dst word-aligned.}
  Jz @runWordAligned
  Stosb
  Dec Cx
@runWordAligned:
  Shr Cx,1			{ Convert byte count to word count.}
  Jc @runOddByte
  Rep Stosw			{ Word-aligned.}
  Jmp @longOpDone
@runOddByte:
  Rep Stosw			{ Word-aligned.}
  Stosb
  Jmp @longOpDone
@stop:
  Pop Ds			{ Restore DS }
 End;
End;

End.
