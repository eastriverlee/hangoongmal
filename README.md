# korean_pronunciation
this is a program that outputs sound and text of korean pronunciation.
TTS uses AVfoundation framework (of Mac OS) to produce sound.

이것은 한국어 발음을 소리와 문자열로 출력하는 프로그램입니다.
TTS는 (맥 운영체제의) AVfoundation을 사용합니다.

### build
`swiftc speaker.swift`

### run
the program can read from arguments or stdin.

프로그램은 문장을 인자로 받거나 stdin으로 파일을 받아와 실행 가능합니다.

`./speaker "많은 사람들이 걷는다."`
`./speaker < YOUR_FILE.txt`
