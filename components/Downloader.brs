sub init()
    m.top.functionName = "getSampleContent"
end sub

' For this task node, we will be retrieving the necessary data from the url
' specified from the uri field of this task. This function will return
' the content as a tree of ContentNodes.
sub getSampleContent()
    url = CreateObject("roUrlTransfer")
    url.SetUrl(m.top.uri)

    rsp = url.GetToString()
		if Len(rsp) = 0
			error=url.GetFailureReason()
			if Len(error) <> 0
				m.top.error = error
			else
				m.top.error = "CONEXÃO RECUSADA!"
			end if
		else
			loadJson(rsp)
		end if
end sub


sub loadJson(jsonStr as String)
	json=ParseJson(jsonStr)	
	if json = Invalid
		m.top.error = "JSON INVALIDO!"
		return
	end if

	if json.url = Invalid
		m.top.error = "CAMPO URL NÃO ENCONTRADO!"
		return
	end if

	m.top.list=json.url.Split("|")
end sub





