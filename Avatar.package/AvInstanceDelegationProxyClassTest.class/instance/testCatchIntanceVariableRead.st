tests
testCatchIntanceVariableRead

	handler := AvTestLogAndResendHandler new.
	self newProxy superclass.
	
	self assert: handler messages size equals: 2.
	self assert: handler messages first selector equals: #superclass.
	
	self assert: handler messages second selector equals: #instVarAt:.
	self assert: handler messages second arguments asArray equals: #( 1 ).