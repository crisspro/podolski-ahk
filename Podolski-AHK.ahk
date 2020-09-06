;nombre: Podolski-AHK
;Autor: crisspro
;Año: 2020
;Licencia: GPL-3.0

#include nvda.ahk

ScriptNombre:= "Podolski-AHK"
VSTNombre:= "Podolski"
VSTControl:= "Podolski.vst"

xg:= 0
yg:= 0
VSTControlDetectado:= False
VSTNombreDetectado:= False

;funciones

;mensajes
hablar(es,en)
{
if (InStr(A_language,"0a") = "3")
nvdaSpeak(es)
else
nvdaSpeak(en)
}

SetTitleMatchMode,2

;inicio
SoundPlay,sounds/start.wav
hablar(ScriptNombre " activado",ScriptNombre " ready")

;detecta el plugin
loop
{
WinGet, VentanaID,Id,A
winget, controles, ControlList, A
IfWinActive,%VSTNombre%
{
VSTNombreDetectado:= True
loop, parse, controles, `n
{
if A_LoopField contains %VSTControl%
{
VSTControlDetectado:= True
ControlGetPos, x,y,a,b,%A_loopField%, ahk_id %VentanaID% 
xg:= x
yg:= y
break
}
else
VSTControlDetectado:= False
}
}
else
VSTNombreDetectado:= False
}


;atajos
#If VSTControlDetectado= True and VSTNombreDetectado= True

;despliega el menú de presets.
p:: MouseClick,LEFT, xg+500, yg+272,1

;cambia al preset anterior.
a::
MouseClick,LEFT, xg+390, yg+272,1
hablar("anterior", "back")
return

;cambia al siguiente preset.
s::
MouseClick,LEFT, xg+680, yg+272,1
hablar("siguiente", "next")
return
 

;abre la ayuda.
f1::
if (InStr(A_language,"0a") = "3")
Run Documentation\es.html
else
Run Documentation\en.html
return

;sale del script.
^q:: 
hablar(ScriptNombre " cerrado",ScriptNombre " closed")
SoundPlay,sounds/exit.wav,1
ExitApp
return