# A script created for fun. A reusable prompt which will give input to the Widnows speech synthesizer to read aloud.

Add-Type -AssemblyName System.speech

while($true){
	#Gets input from user:
	$Input = Read-Host -Prompt "Enter a word or phrase you would like the PC to speak aloud"

	#Sets up Speech Synthesizer object
	$Speak = New-Object System.Speech.Synthesis.SpeechSynthesizer

	#Outputs audio based on input above
	$Speak.Speak($Input)
}
