property huggingfaces : Collection

Class constructor($huggingfaces : Collection)
	
	This:C1470.huggingfaces:=[]
	var $huggingface : Object
	For each ($huggingface; $huggingfaces)
		If (OB Instance of:C1731($huggingface; cs:C1710.huggingface))
			This:C1470.huggingfaces.push($huggingface)
		End if 
	End for each 