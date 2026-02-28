//%attributes = {}
If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $homeFolder : 4D:C1709.Folder
	$homeFolder:=Folder:C1567(fk home folder:K87:24).folder(".GGUF")
	
	$folder:=$homeFolder.folder("ms-marco-MiniLM-L6-v2")  //where to keep the repo
	$path:="ms-marco-MiniLM-L6-v2-Q8_0.gguf"  //path to the file
	$URL:="keisuke-miyako/ms-marco-MiniLM-L6-v2-gguf-q8_0"  //path to the repo
	
	$URL:=["https://huggingface.co"; "keisuke-miyako"; "ms-marco-MiniLM-L6-v2-gguf-q8_0"; "resolve"; "main"; $path].join("/")
	
	$file:=$folder.file($path)
	
	cs:C1710.download.new(\
		$folder; \
		$file; \
		$file.folder; \
		""; \
		$URL; \
		{}; \
		Formula:C1597(IDLE:C311); \
		{}; Formula:C1597(IDLE:C311)).head()
	
End if 