sending
sendTo: anObject

	"Checks if the object to send the message is the target of the proxy or not. If positive, the AvDelegationMethodProvider is asked to obtain a delegation method.
	This delegation method is executed on the proxy, and allows the proxy to handle all messages and even instance variable accesses as messages.
	
	Check AvDelegationMethodProvider for more information.

   Note also, that some methods such as primitives are executed on the target and not the proxy to get a correct behaviour."
	
	| method |
	anObject == target ifFalse: [
		^ anObject perform: message selector withArguments: message arguments.
	].

	method := target class lookupSelector: message selector.

	method ifNil: [ 
		MessageNotUnderstood new 
			message: ((Message selector: message selector arguments: message arguments) lookupClass: target class; yourself);
			receiver: target;
			signal ].

	(self shouldExecuteOnTarget: method) ifTrue: [ 
		^ MirrorPrimitives
			withReceiver: target
			andArguments: message arguments
			execute: method
	].

	method := self delegationMethodFor: method.

	^ MirrorPrimitives
		withReceiver: proxy
		andArguments: message arguments
		execute: method