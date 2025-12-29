property folder : Object
property URL : Text
property domain : Text
property path : Text
property name : Text

Class constructor($model : Object; $URL : Text; $path : Text; $domain : Text; $name : Text)
	
	If ($model#Null:C1517)
		If (OB Instance of:C1731($model; 4D:C1709.Folder)) || (OB Instance of:C1731($model; 4D:C1709.File))
			This:C1470.folder:=$model
		End if 
	End if 
	
	This:C1470.URL:=$URL
	This:C1470.path:=$path
	This:C1470.domain:=$domain
	This:C1470.name:=$name