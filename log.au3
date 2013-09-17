;==========================================================================
;
; NAME: write to file example
; AUTHOR: John Sorensen
;
; COMMENT: login autoIT script/snippet to check for file and log if exists
; 
;==========================================================================

local $file
;check if file exists, if so then  log and exit
func openFile()
   
If FileExists(@ScriptDir & "\log.txt") Then
  
$file = Fileopen(@ScriptDir &"\log.txt", 1)

  
EndIf
EndFunc

func writeLog($write)
   openFile()
; Write month/day @ time
FileWrite($file, $write)
; go to next line
FileWrite($file, @CRLF)
FileClose($file)

EndFunc