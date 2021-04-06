# hangoongmal 🇰🇷
**hangoongmal** is a program that outputs sound and text of korean pronunciation.  
TTS uses AVfoundation framework (of Mac OS) to produce voice.

**한궁말**은 한국어 발음을 소리와 문자열로 출력하는 프로그램입니다.  
TTS는 (맥 운영체제의) AVfoundation을 사용해 목소리를 생성합니다.

## build
````bash
$ swiftc speaker.swift
````

## run
the program can read from arguments or stdin.

프로그램은 문장을 인자로 받거나 stdin으로 파일을 받아와 실행 가능합니다.

````bash
$ ./speaker "따갑기만 한 햇살 아래서 칼날 같은 소금을 핥았다."
따갑끼만 한 핻쌀 아래서 칼랄 가튼 소그믈 할탇따
````  
````bash
$ ./speaker < YOUR_FILE.txt
````
-m option mimics korean pronunciation in english  

-m 옵션은 한국어 발음을 영어로 흉내냅니다.
````bash
$ ./speaker -m "따갑기만 한 햇살 아래서 칼날 같은 소금을 핥았다."
tah ghahb kee mahn - hahn - haed sahl - ah rae suh - kahl rahl - ghah twoon - so ghwoo mwool - hahl tahd tah
````  
