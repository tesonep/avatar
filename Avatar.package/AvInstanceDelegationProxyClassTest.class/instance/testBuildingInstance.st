tests
testBuildingInstance

	| proxy x |
	handler := AvTestLogAndResendHandler new.
	target := InstanceVariableSlot.
	
	proxy := self newProxy.
	x := proxy named: #aName.
		
	self assert: handler messages size equals: 8.
	self assert: handler messages first selector equals: #named:.
	self assert: handler messages second selector equals: #checkValidName:.

	self assert: (MirrorPrimitives classOf: x) equals: proxy.
	self assert: x printString equals: '#aName => InstanceVariableSlot'
