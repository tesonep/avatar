sending
sendTo: anObject

	| method |
	anObject == instance ifFalse: [
		^ anObject perform: message selector withArguments: message arguments.
	].

	method := target lookupSelector: message selector.

	method ifNil: [ 
		MessageNotUnderstood new 
			message: ((Message selector: message selector arguments: message arguments) lookupClass: target class; yourself);
			receiver: target;
			signal ].

	(self shouldExecuteOnTarget: method) ifTrue: [ 
		^ MirrorPrimitives
			withReceiver: instance
			andArguments: message arguments
			execute: method
	].

	method := AvDelegationMethodProvider uniqueInstance delegationMethodFor: method.

	^ MirrorPrimitives
			withReceiver: instance
			andArguments: message arguments
			execute: method.