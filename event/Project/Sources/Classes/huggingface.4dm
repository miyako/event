property folder : Object
property URL : Text
property domain : Text
property paths : Collection
property name : Text

Class constructor($model : Object; $URL : Text; $paths : Variant; $domain : Text; $name : Text)
	
	If ($model#Null:C1517)
		If (OB Instance of:C1731($model; 4D:C1709.Folder)) || (OB Instance of:C1731($model; 4D:C1709.File))
			This:C1470.folder:=$model
		End if 
	End if 
	
	This:C1470.URL:=$URL
	This:C1470.paths:=[]
	
	var $vt : Integer
	$vt:=Value type:C1509($paths)
	Case of 
		: ($vt=Is text:K8:3) && ($paths#"")
			This:C1470.paths.push($paths)
		: ($vt=Is collection:K8:32)
			var $path : Variant
			For each ($path; $paths)
				If (Value type:C1509($path)=Is text:K8:3) && ($path#"")
					This:C1470.paths.push($path)
				End if 
			End for each 
	End case 
	
	This:C1470.domain:=$domain
	This:C1470.name:=$name
	
Function get path() : Text
	
	If (This:C1470.paths.length=0)
		return ""
	End if 
	
	return This:C1470.paths.first()