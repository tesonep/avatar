reflective operations
instanceDoesNotUnderstand: aMessage
	| aClass otherClass |
	aClass := MirrorPrimitives classOf: self.
	^ [ aClass _instance: self doesNotUnderstand: aMessage ]
		on: MessageNotUnderstood
		do: [
			'********' logCr.
			otherClass := MirrorPrimitives classOf: aClass.
			(MirrorPrimitives fieldOf: otherClass at: 2) logCr.
			(otherClass name) logCr.
			('Error: ' , aClass name , ' ' , aMessage selector) asString logCr.
			^ nil ]