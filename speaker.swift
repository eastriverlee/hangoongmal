import Foundation
import AVFoundation

let start: UInt16 = 0xAC00
let end: UInt16 = 0xD7AF

typealias 글자 = Character
typealias 음운 = Character
typealias 자음 = Character
typealias 모음 = Character
typealias 받침 = Character
typealias 한글 = String

let 없음: Character = " "

let ㄱ: 자음 = "ᄀ"
let ㄲ: 자음 = "ᄁ"
let ㄴ: 자음 = "ᄂ"
let ㄷ: 자음 = "ᄃ"
let ㄸ: 자음 = "ᄄ"
let ㄹ: 자음 = "ᄅ"
let ㅁ: 자음 = "ᄆ"
let ㅂ: 자음 = "ᄇ"
let ㅃ: 자음 = "ᄈ"
let ㅅ: 자음 = "ᄉ"
let ㅆ: 자음 = "ᄊ"
let ㅇ: 자음 = "ᄋ"
let ㅈ: 자음 = "ᄌ"
let ㅉ: 자음 = "ᄍ"
let ㅊ: 자음 = "ᄎ"
let ㅋ: 자음 = "ᄏ"
let ㅌ: 자음 = "ᄐ"
let ㅍ: 자음 = "ᄑ"
let ㅎ: 자음 = "ᄒ"

let _ㄱ: 받침 = "ᆨ"
let _ㄲ: 받침 = "ᆩ"
let _ㄱㅅ: 받침 = "ᆪ"
let _ㄴ: 받침 = "ᆫ"
let _ㄴㅈ: 받침 = "ᆬ"
let _ㄴㅎ: 받침 = "ᆭ"
let _ㄷ: 받침 = "ᆮ"
let _ㄹ: 받침 = "ᆯ"
let _ㄹㄱ: 받침 = "ᆰ"
let _ㄹㅁ: 받침 = "ᆱ"
let _ㄹㅂ: 받침 = "ᆲ"
let _ㄹㅅ: 받침 = "ᆳ"
let _ㄹㅌ: 받침 = "ᆴ"
let _ㄹㅍ: 받침 = "ᆵ"
let _ㄹㅎ: 받침 = "ᆶ"
let _ㅁ: 받침 = "ᆷ"
let _ㅂ: 받침 = "ᆸ"
let _ㅂㅅ: 받침 = "ᆹ"
let _ㅅ: 받침 = "ᆺ"
let _ㅆ: 받침 = "ᆻ"
let _ㅇ: 받침 = "ᆼ"
let _ㅈ: 받침 = "ᆽ"
let _ㅊ: 받침 = "ᆾ"
let _ㅋ: 받침 = "ᆿ"
let _ㅌ: 받침 = "ᇀ"
let _ㅍ: 받침 = "ᇁ"
let _ㅎ: 받침 = "ᇂ"

let ㅏ: 모음 = "ᅡ"
let ㅐ: 모음 = "ᅢ"
let ㅑ: 모음 = "ᅣ"
let ㅒ: 모음 = "ᅤ"
let ㅓ: 모음 = "ᅥ"
let ㅔ: 모음 = "ᅦ"
let ㅕ: 모음 = "ᅧ"
let ㅖ: 모음 = "ᅨ"
let ㅗ: 모음 = "ᅩ"
let ㅘ: 모음 = "ᅪ"
let ㅙ: 모음 = "ᅫ"
let ㅚ: 모음 = "ᅬ"
let ㅛ: 모음 = "ᅭ"
let ㅜ: 모음 = "ᅮ"
let ㅝ: 모음 = "ᅯ"
let ㅞ: 모음 = "ᅰ"
let ㅟ: 모음 = "ᅱ"
let ㅠ: 모음 = "ᅲ"
let ㅡ: 모음 = "ᅳ"
let ㅢ: 모음 = "ᅴ"
let ㅣ: 모음 = "ᅵ"

typealias Unicode = UInt16
extension Character {
    func unicode() -> Unicode {
        var result: Unicode = 0
        for c in String(self).utf16 {result = c}
        return result
    }
}

extension Unicode {
    func character() -> Character {
        return Character(UnicodeScalar(self)!)
    }
}

class 음절 {
    required init(_ 글자: 글자) {
        unicode = 글자.unicode()
        guard start <= unicode && unicode <= end else { 초성 = 글자; return }
        let nth = unicode - start
        초성 = ((nth / 28) / 21 + 0x1100).character()
        중성 = ((nth / 28) % 21 + 0x1161).character()
        종성 = ((nth % 28) + 0x11A7).character(); if 종성 == "ᆧ" { 종성 = 없음 }
        let 받침: (앞: 받침, 뒤: 받침) = 종성.받침분리()
        앞받침 = 받침.앞
        뒷받침 = 받침.뒤
    }
    let unicode: Unicode
    var 초성: 자음 = 없음
    var 중성: 모음 = 없음
    var 종성: 받침 = 없음
    var 앞받침: 받침 = 없음
    var 뒷받침: 받침 = 없음
    var 받침: 받침 { get { 뒷받침 } set { 뒷받침 = newValue } }
    var 홑받침: Bool { 앞받침 == 없음 && 뒷받침 != 없음 }
    var 끝소리: 받침 {
        switch 종성 {
        case _ㄲ, _ㄱㅅ, _ㅋ, _ㄹㄱ:            return _ㄱ
        case _ㄴㅈ, _ㄴㅎ:                      return _ㄴ
        case _ㅅ, _ㅆ, _ㅈ, _ㅊ, _ㅌ, _ㅎ:      return _ㄷ
        case _ㄹㅎ, _ㄹㅌ:                      return _ㄹ
        case _ㄹㅁ:                             return _ㅁ
        case _ㅍ, _ㅂㅅ, _ㄹㅂ, _ㄹㅍ:          return _ㅂ
        default :                               return 종성
        }
    }
}

extension 글자 {
    func 초성중성종성() -> 음절 {
        return 음절(self)
    }
}

extension 음운 {
    var 된소리: 자음 {
        switch self {
        case ㄱ:  return ㄲ
        case ㄷ:  return ㄸ
        case ㅂ:  return ㅃ
        case ㅅ:  return ㅆ
        case ㅈ:  return ㅉ
        default: return self
        }
    }
}

extension 받침 {
    var 자음: 자음 {
        switch self {
        case _ㄱ: return ㄱ
        case _ㄲ: return ㄲ
        case _ㄴ: return ㄴ
        case _ㄷ: return ㄷ
        case _ㄹ: return ㄹ
        case _ㅁ: return ㅁ
        case _ㅂ: return ㅂ
        case _ㅅ: return ㅅ
        case _ㅇ: return ㅇ
        case _ㅈ: return ㅈ
        case _ㅊ: return ㅊ
        case _ㅋ: return ㅋ
        case _ㅌ: return ㅌ
        case _ㅍ: return ㅍ
        case _ㅎ: return ㅎ
        default: return self
        }
    }
    var 받침: 받침 {
        switch self {
        case ㄱ: return _ㄱ
        case ㄲ: return _ㄲ
        case ㄴ: return _ㄴ
        case ㄷ: return _ㄷ
        case ㄹ: return _ㄹ
        case ㅁ: return _ㅁ
        case ㅂ: return _ㅂ
        case ㅅ: return _ㅅ
        case ㅇ: return _ㅇ
        case ㅈ: return _ㅈ
        case ㅊ: return _ㅊ
        case ㅋ: return _ㅋ
        case ㅌ: return _ㅌ
        case ㅍ: return _ㅍ
        case ㅎ: return _ㅎ
        default: return self
        }
    }
    func 받침분리() -> (받침, 받침) {
        switch self {
        case _ㄲ:  return (_ㄱ, _ㄱ)
        case _ㄱㅅ: return (_ㄱ, _ㅅ)
        case _ㄴㅈ: return (_ㄴ, _ㅈ)
        case _ㄴㅎ: return (_ㄴ, _ㅎ)
        case _ㄹㄱ: return (_ㄹ, _ㄱ)
        case _ㄹㅁ: return (_ㄹ, _ㅁ)
        case _ㄹㅂ: return (_ㄹ, _ㅂ)
        case _ㄹㅅ: return (_ㄹ, _ㅅ)
        case _ㄹㅌ: return (_ㄹ, _ㅌ)
        case _ㄹㅍ: return (_ㄹ, _ㅍ)
        case _ㄹㅎ: return (_ㄹ, _ㅎ)
        case _ㅂㅅ: return (_ㅂ, _ㅅ)
        case _ㅆ:  return (_ㅅ, _ㅅ)
        default:   return (없음, self)
        }
    }
}

let 사잇소리 = [
("볼일", "볼일"),
("식용유", "시굥뉴"),
("깻잎", "깬닢"),
("꽃잎", "꼰닢"),
("풀잎", "풀맆"),
("눈요기", "눈뇨기"),
("맨입", "맨닙"),
("담요", "담뇨"),
("막일", "망닐"),
("영업용", "영엄뇽"),
("한여름", "한녀름")
]

extension 한글 {
    func 초성중성종성() -> [음절] { self.map{ $0.초성중성종성() } }
    func 예외(_ 처리: [(표기: 한글, 발음: 한글)]) -> 한글 {
        var processed = self
        for 해당 in 처리 {
            processed = processed.replacingOccurrences(of: 해당.표기, with: 해당.발음)
        }
        return processed
    }
    func pronounced() -> [음절] {
        var 문장: [음절] = 예외(사잇소리).초성중성종성()
        for i in 문장.indices {
            var 이번: 음절 { get { 문장[i] } set { 문장[i] = newValue } }
            guard i < 문장.count - 1 else { 이번.종성 = 이번.끝소리; break }
            let j = i + (문장[i + 1].초성 == " " && 문장.count   > i + 2 ? 1 : 1)
            var 다음: 음절 { get { 문장[j] } set { 문장[j] = newValue } }
            var 앞받침: 받침 { get { 이번.앞받침 } set { 이번.앞받침 = newValue } }
            var 뒷받침: 받침 { get { 이번.뒷받침 } set { 이번.뒷받침 = newValue } }
            func 만남(_ 자음들: [자음], _ 자음: 자음) -> Bool {
                자음들.contains(이번.끝소리.자음) && 다음.초성 == 자음 || (이번.끝소리.자음  == 자음 || 뒷받침.자음 == 자음) && 자음들.contains(다음.초성)
            }
            
            //MARK: - 자음동화
            if 다음.초성 == ㄴ || 다음.초성 == ㅁ || 다음.초성 == ㄹ {
                switch 이번.끝소리 {
                case _ㄱ: 이번.종성 = _ㅇ
                case _ㄷ: 이번.종성 = _ㄴ
                case _ㅂ: 이번.종성 = _ㅁ
                default: break
                }
            }
            if 다음.초성 == ㄹ && (이번.끝소리 == _ㅁ || 이번.종성 == _ㅇ ) {
                다음.초성 = ㄴ
                continue
            } else if 만남([ㄴ], ㄹ) {
                if 다음.초성 == ㄴ {
                    다음.초성 = ㄹ; 이번.종성 = _ㄹ
                    continue 
                }
                else {
                    이번.종성 = _ㄹ
                    continue
                }
            }
            
            if 다음.초성 == ㅇ && 이번.종성 != 없음 {
                //MARK: - 구개음화
                if 다음.중성 == ㅣ {
                    if 이번.종성 == _ㄷ {
                        이번.종성 = 이번.앞받침
                        다음.초성 = ㅈ
                        continue
                    } else if 이번.뒷받침 == _ㅌ {
                        이번.종성 = 이번.앞받침
                        다음.초성 = ㅊ
                        continue
                    }
                }
                //MARK: - 연음
                switch 뒷받침 {
                    case _ㅇ: break
                    case _ㅎ: 
                        다음.초성 = 앞받침.자음
                        이번.종성 = 없음
                        continue
                    default: 
                        다음.초성 = 뒷받침.자음
                        이번.종성 = 앞받침
                        continue
                }
            }
            
            //MARK: - 격음화
            if 만남([ㅂ, ㄷ, ㅈ, ㄱ], ㅎ) {
                if 다음.초성 == ㅎ {
                    switch 이번.끝소리 {
                    case _ㅂ: 다음.초성 = ㅍ
                    case _ㄷ: 다음.초성 = ㅌ
                    case _ㅈ: 다음.초성 = ㅊ
                    case _ㄱ: 다음.초성 = ㅋ
                    default: break
                    }
                } else {
                    switch 다음.초성 {
                    case ㅂ: 다음.초성 = ㅍ
                    case ㄷ: 다음.초성 = ㅌ
                    case ㅈ: 다음.초성 = ㅊ
                    case ㄱ: 다음.초성 = ㅋ
                    default: break
                    }
                }
                이번.종성 = 앞받침
                continue
            } else {
            //MARK: - 경음화
                switch 다음.초성 {
                case ㄱ, ㄷ, ㅂ, ㅅ, ㅈ:
                    switch 이번.끝소리 {
                    case _ㄱ, _ㄷ, _ㅂ:
                        다음.초성 = 다음.초성.된소리
                    case _ㄹ:
                        guard 다음.초성 != ㅂ && !이번.홑받침 else { break }
                        다음.초성 = 다음.초성.된소리
                    default: break
                    }
                default: break
                }
                이번.종성 = 이번.끝소리
            }
        }
        return 문장
    }
}

enum Language: String {
   case korean = "ko-KR"
   case english = "en-US"
}

func speak(_ sentence: String, in language: Language) {
    let utterance = AVSpeechUtterance(string: sentence)
    utterance.voice = AVSpeechSynthesisVoice(language: language.rawValue)
    utterance.rate = 0.5
    let synthesizer = AVSpeechSynthesizer()
    synthesizer.speak(utterance)
    while (synthesizer.isSpeaking) {
        sleep(1)
    }
}

var isMimicking = false

func mimic(_ sound: [음절]) -> String {
    var pronunciation = ""
    for syllable in sound {
        let 초성 = syllable.초성
        let 중성 = syllable.중성
        let 종성 = syllable.종성
        switch 초성 { 
        case ㄱ: pronunciation += "gh"
        case ㄴ: pronunciation += "n"
        case ㄷ: pronunciation += "d"
        case ㄹ: pronunciation += "r"
        case ㅁ: pronunciation += "m"
        case ㅂ: pronunciation += "b"
        case ㅅ: pronunciation += "s"
        case ㅈ: pronunciation += "j"
        case ㅊ: pronunciation += "ch"
        case ㅋ, ㄲ: pronunciation += "k"
        case ㅌ, ㄸ: pronunciation += "t"
        case ㅍ, ㅃ: pronunciation += "p"
        case ㅎ: pronunciation += "h"
        case " ": pronunciation += "-"
        case ",": pronunciation += ","
        case ".": pronunciation += "."
        case "?": pronunciation += "?"
        case "!": pronunciation += "!"
        default: break
        }
        switch 중성 {
        case ㅏ: pronunciation += "ah"
        case ㅐ: pronunciation += "ae"
        case ㅑ: pronunciation += "ya"
        case ㅒ: pronunciation += "yae"
        case ㅓ: pronunciation += "uh"
        case ㅔ: pronunciation += "eh"
        case ㅕ: pronunciation += "yuh"
        case ㅖ: pronunciation += "ye"
        case ㅗ: pronunciation += "o"
        case ㅛ: pronunciation += "yo"
        case ㅜ: pronunciation += "woo"
        case ㅝ: pronunciation += "woe"
        case ㅞ: pronunciation += "wooeh"
        case ㅟ: pronunciation += "we"
        case ㅠ: pronunciation += "u"
        case ㅡ: pronunciation += "woo"
        case ㅢ: pronunciation += "euee"
        case ㅣ: pronunciation += "ee"
        default: break
        }
        switch 종성 {
        case _ㄱ: pronunciation += "k"
        case _ㄴ: pronunciation += "n"
        case _ㄷ: pronunciation += "t"
        case _ㄹ: pronunciation += "l"
        case _ㅁ: pronunciation += "m"
        case _ㅂ: pronunciation += "b"
        case _ㅇ: pronunciation += "ng"
        default: break
        }
        pronunciation += " "
    }
    return pronunciation
}

func pronounce(_ sentence: 한글, in language: Language = .korean) {
    let sound = sentence.pronounced()
    var pronunciation = ""
    for syllable in sound {
        let 초성 = syllable.초성.unicode()
        let 중성 = syllable.중성.unicode()
        let 종성 = syllable.종성.unicode()
        guard 초성 != 32 && (0x1100 <= 초성 && 초성 <= 0x1112) else {pronunciation += "\(syllable.초성)"; continue}
        if 종성 == 32 {
            guard 중성 != 32 else {pronunciation += "\(syllable.초성)"; continue}
            let c = (start + ((초성 - 0x1100) * 21 + (중성 - 0x1161)) * 28).character()
            pronunciation += "\(c)"
        } else {
            let c = (start + ((초성 - 0x1100) * 21 + (중성 - 0x1161)) * 28 + (종성 - 0x11A7)).character()
            pronunciation += "\(c)"
        }
    }
    print(pronunciation)
    if isMimicking {
        pronunciation = mimic(sound)
    }
    speak(pronunciation, in: language)
}

let arguments = CommandLine.arguments
if arguments.count > 1 {
    for i in arguments.indices {
        if i != 0 {
            if i == 1 && arguments[i] == "-m" {
                isMimicking = true
            } else {
                pronounce(arguments[i], in: isMimicking ? .english : .korean)
            }
        }
    }
} else {
    let filedata = FileHandle.standardInput.availableData
    if let content = String(bytes: filedata, encoding: .utf8) {
        pronounce(content)
    }
}
