// FontAwesome.swift
//
// Copyright (c) 2014 Doan Truong Thi
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import CoreText

private class FontLoader {
  class func loadFont(name: String) {
    let bundle = NSBundle.mainBundle()
    let fontURL = bundle.URLForResource(name, withExtension: "otf")
    
    let data = NSData(contentsOfURL: fontURL!)!
    
    let provider = CGDataProviderCreateWithCFData(data)
    let font = CGFontCreateWithDataProvider(provider)!
    
    var error: Unmanaged<CFError>?
    if !CTFontManagerRegisterGraphicsFont(font, &error) {
      let errorDescription: CFStringRef = CFErrorCopyDescription(error!.takeUnretainedValue())
      let nsError = error!.takeUnretainedValue() as AnyObject as! NSError
      NSException(name: NSInternalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
    }
  }
}

public extension UIFont {
  public class func fontAwesomeOfSize(fontSize: CGFloat) -> UIFont {
    struct Static {
      static var onceToken : dispatch_once_t = 0
    }
    
    let name = "FontAwesome"
    if (UIFont.fontNamesForFamilyName(name).count == 0) {
      dispatch_once(&Static.onceToken) {
        FontLoader.loadFont(name)
      }
    }

    return UIFont(name: name, size: fontSize)!
  }
}

public enum FontAwesome: String {
  case Adjust = "\u{f042}"
  case ADN = "\u{f170}"
  case AlignCenter = "\u{f037}"
  case AlignJustify = "\u{f039}"
  case AlignLeft = "\u{f036}"
  case AlignRight = "\u{f038}"
  case Ambulance = "\u{f0f9}"
  case Anchor = "\u{f13d}"
  case Android = "\u{f17b}"
  case Angellist = "\u{f209}"
  case AngleDoubleDown = "\u{f103}"
  case AngleDoubleLeft = "\u{f100}"
  case AngleDoubleRight = "\u{f101}"
  case AngleDoubleUp = "\u{f102}"
  case AngleDown = "\u{f107}"
  case AngleLeft = "\u{f104}"
  case AngleRight = "\u{f105}"
  case AngleUp = "\u{f106}"
  case Apple = "\u{f179}"
  case Archive = "\u{f187}"
  case AreaChart = "\u{f1fe}"
  case ArrowCircleDown = "\u{f0ab}"
  case ArrowCircleLeft = "\u{f0a8}"
  case ArrowCircleODown = "\u{f01a}"
  case ArrowCircleOLeft = "\u{f190}"
  case ArrowCircleORight = "\u{f18e}"
  case ArrowCircleOUp = "\u{f01b}"
  case ArrowCircleRight = "\u{f0a9}"
  case ArrowCircleUp = "\u{f0aa}"
  case ArrowDown = "\u{f063}"
  case ArrowLeft = "\u{f060}"
  case ArrowRight = "\u{f061}"
  case ArrowUp = "\u{f062}"
  case Arrows = "\u{f047}"
  case ArrowsAlt = "\u{f0b2}"
  case ArrowsH = "\u{f07e}"
  case ArrowsV = "\u{f07d}"
  case Asterisk = "\u{f069}"
  case At = "\u{f1fa}"
  case Automobile = "\u{f1b9}"
  case Backward = "\u{f04a}"
  case Ban = "\u{f05e}"
  case Bank = "\u{f19c}"
  case BarChart = "\u{f080}"
  case BarChartO = "\u{f080}A"
  case Barcode = "\u{f02a}"
  case Bars = "\u{f0c9}"
  case Bed = "\u{f236}"
  case Beer = "\u{f0fc}"
  case Behance = "\u{f1b4}"
  case BehanceSquare = "\u{f1b5}"
  case Bell = "\u{f0f3}"
  case BellO = "\u{f0a2}"
  case BellSlash = "\u{f1f6}"
  case BellSlashO = "\u{f1f7}"
  case Bicycle = "\u{f206}"
  case Binoculars = "\u{f1e5}"
  case BirthdayCake = "\u{f1fd}"
  case Bitbucket = "\u{f171}"
  case BitbucketSquare = "\u{f172}"
  case Bitcoin = "\u{f15a}"
  case Bold = "\u{f032}"
  case Bolt = "\u{f0e7}"
  case Bomb = "\u{f1e2}"
  case Book = "\u{f02d}"
  case Bookmark = "\u{f02e}"
  case BookmarkO = "\u{f097}"
  case Briefcase = "\u{f0b1}"
  case Btc = "\u{f15a}A"
  case Bug = "\u{f188}"
  case Building = "\u{f1ad}"
  case BuildingO = "\u{f0f7}"
  case Bullhorn = "\u{f0a1}"
  case Bullseye = "\u{f140}"
  case Bus = "\u{f207}"
  case Buysellads = "\u{f20d}"
  case Cab = "\u{f1ba}"
  case Calculator = "\u{f1ec}"
  case Calendar = "\u{f073}"
  case CalendarO = "\u{f133}"
  case Camera = "\u{f030}"
  case CameraRetro = "\u{f083}"
  case Car = "\u{f1b9}A"
  case CaretDown = "\u{f0d7}"
  case CaretLeft = "\u{f0d9}"
  case CaretRight = "\u{f0da}"
  case CaretSquareODown = "\u{f150}"
  case CaretSquareOLeft = "\u{f191}"
  case CaretSquareORight = "\u{f152}"
  case CaretSquareOUp = "\u{f151}"
  case CaretUp = "\u{f0d8}"
  case CartArrowDown = "\u{f218}"
  case CartPlus = "\u{f217}"
  case Cc = "\u{f20a}"
  case CCAmex = "\u{f1f3}"
  case CCDiscover = "\u{f1f2}"
  case CCMastercard = "\u{f1f1}"
  case CCPaypal = "\u{f1f4}"
  case CCStripe = "\u{f1f5}"
  case CCVisa = "\u{f1f0}"
  case Certificate = "\u{f0a3}"
  case Chain = "\u{f0c1}"
  case ChainBroken = "\u{f127}"
  case Check = "\u{f00c}"
  case CheckCircle = "\u{f058}"
  case CheckCircleO = "\u{f05d}"
  case CheckSquare = "\u{f14a}"
  case CheckSquareO = "\u{f046}"
  case ChevronCircleDown = "\u{f13a}"
  case ChevronCircleLeft = "\u{f137}"
  case ChevronCircleRight = "\u{f138}"
  case ChevronCircleUp = "\u{f139}"
  case ChevronDown = "\u{f078}"
  case ChevronLeft = "\u{f053}"
  case ChevronRight = "\u{f054}"
  case ChevronUp = "\u{f077}"
  case Child = "\u{f1ae}"
  case Circle = "\u{f111}"
  case CircleO = "\u{f10c}"
  case CircleONotch = "\u{f1ce}"
  case CircleThin = "\u{f1db}"
  case Clipboard = "\u{f0ea}"
  case ClockO = "\u{f017}"
  case Close = "\u{f00d}"
  case Cloud = "\u{f0c2}"
  case CloudDownload = "\u{f0ed}"
  case CloudUpload = "\u{f0ee}"
  case CNY = "\u{f157}"
  case Code = "\u{f121}"
  case CodeFork = "\u{f126}"
  case Codepen = "\u{f1cb}"
  case Coffee = "\u{f0f4}"
  case Cog = "\u{f013}"
  case Cogs = "\u{f085}"
  case Columns = "\u{f0db}"
  case Comment = "\u{f075}"
  case CommentO = "\u{f0e5}"
  case Comments = "\u{f086}"
  case CommentsO = "\u{f0e6}"
  case Compass = "\u{f14e}"
  case Compress = "\u{f066}"
  case Connectdevelop = "\u{f20e}"
  case Copy = "\u{f0c5}"
  case Copyright = "\u{f1f9}"
  case CreditCard = "\u{f09d}"
  case Crop = "\u{f125}"
  case Crosshairs = "\u{f05b}"
  case Css3 = "\u{f13c}"
  case Cube = "\u{f1b2}"
  case Cubes = "\u{f1b3}"
  case Cut = "\u{f0c4}"
  case Cutlery = "\u{f0f5}"
  case Dashboard = "\u{f0e4}"
  case Dashcube = "\u{f210}"
  case Database = "\u{f1c0}"
  case Dedent = "\u{f03b}"
  case Delicious = "\u{f1a5}"
  case Desktop = "\u{f108}"
  case Deviantart = "\u{f1bd}"
  case Diamond = "\u{f219}"
  case Digg = "\u{f1a6}"
  case Dollar = "\u{f155}"
  case DotCircleO = "\u{f192}"
  case Download = "\u{f019}"
  case Dribbble = "\u{f17d}"
  case Dropbox = "\u{f16b}"
  case Drupal = "\u{f1a9}"
  case Edit = "\u{f044}"
  case Eject = "\u{f052}"
  case EllipsisH = "\u{f141}"
  case EllipsisV = "\u{f142}"
  case Empire = "\u{f1d1}"
  case Envelope = "\u{f0e0}"
  case EnvelopeO = "\u{f003}"
  case EnvelopeSquare = "\u{f199}"
  case Eraser = "\u{f12d}"
  case EUR = "\u{f153}"
  case Euro = "\u{f153}A"
  case Exchange = "\u{f0ec}"
  case Exclamation = "\u{f12a}"
  case ExclamationCircle = "\u{f06a}"
  case ExclamationTriangle = "\u{f071}"
  case Expand = "\u{f065}"
  case ExternalLink = "\u{f08e}"
  case ExternalLinkSquare = "\u{f14c}"
  case Eye = "\u{f06e}"
  case EyeSlash = "\u{f070}"
  case Eyedropper = "\u{f1fb}"
  case Facebook = "\u{f09a}"
  case FacebookF = "\u{f09a}A"
  case FacebookOfficial = "\u{f230}"
  case FacebookSquare = "\u{f082}"
  case FastBackward = "\u{f049}"
  case FastForward = "\u{f050}"
  case Fax = "\u{f1ac}"
  case Female = "\u{f182}"
  case FighterJet = "\u{f0fb}"
  case File = "\u{f15b}"
  case FileArchiveO = "\u{f1c6}"
  case FileAudioO = "\u{f1c7}"
  case FileCodeO = "\u{f1c9}"
  case FileExcelO = "\u{f1c3}"
  case FileImageO = "\u{f1c5}"
  case FileMoviO = "\u{f1c8}"
  case FileO = "\u{f016}"
  case FilePdfO = "\u{f1c1}"
  case FilePhotoO = "\u{f1c5}A"
  case FilePictureO = "\u{f1c5}B"
  case FilePowerpointO = "\u{f1c4}"
  case FileSoundO = "\u{f1c7}A"
  case FileText = "\u{f15c}"
  case FileTextO = "\u{f0f6}"
  case FileVideoO = "\u{f1c8}A"
  case FileWordO = "\u{f1c2}"
  case FileZipO = "\u{f1c6}A"
  case FilesO = "\u{f0c5}A"
  case Film = "\u{f008}"
  case Filter = "\u{f0b0}"
  case Fire = "\u{f06d}"
  case FireExtinguisher = "\u{f134}"
  case Flag = "\u{f024}"
  case FlagCheckered = "\u{f11e}"
  case FlagO = "\u{f11d}"
  case Flash = "\u{f0e7}A"
  case Flask = "\u{f0c3}"
  case Flickr = "\u{f16e}"
  case FloppyO = "\u{f0c7}"
  case Folder = "\u{f07b}"
  case FolderO = "\u{f114}"
  case FolderOpen = "\u{f07c}"
  case FolderOpenO = "\u{f115}"
  case Font = "\u{f031}"
  case Forumbee = "\u{f211}"
  case Forward = "\u{f04e}"
  case Foursquare = "\u{f180}"
  case FrownO = "\u{f119}"
  case FutbolO = "\u{f1e3}"
  case Gamepad = "\u{f11b}"
  case Gavel = "\u{f0e3}"
  case Gbp = "\u{f154}"
  case Ge = "\u{f1d1}A"
  case Gear = "\u{f013}A"
  case Gears = "\u{f085}A"
  case Genderless = "\u{f1db}A"
  case Gift = "\u{f06b}"
  case Git = "\u{f1d3}"
  case GitSquare = "\u{f1d2}"
  case Github = "\u{f09b}"
  case GithubAlt = "\u{f113}"
  case GithubSquare = "\u{f092}"
  case Gittip = "\u{f184}"
  case Glass = "\u{f000}"
  case Globe = "\u{f0ac}"
  case Google = "\u{f1a0}"
  case GooglePlus = "\u{f0d5}"
  case GooglePlusSquare = "\u{f0d4}"
  case GoogleWallet = "\u{f1ee}"
  case GraduationCap = "\u{f19d}"
  case Gratipay = "\u{f184}A"
  case Group = "\u{f0c0}"
  case HSquare = "\u{f0fd}"
  case HackerNews = "\u{f1d4}"
  case HandODown = "\u{f0a7}"
  case HandOLeft = "\u{f0a5}"
  case HandORight = "\u{f0a4}"
  case HandOUp = "\u{f0a6}"
  case HddO = "\u{f0a0}"
  case Header = "\u{f1dc}"
  case Headphones = "\u{f025}"
  case Heart = "\u{f004}"
  case HeartO = "\u{f08a}"
  case Heartbeat = "\u{f21e}"
  case History = "\u{f1da}"
  case Home = "\u{f015}"
  case HospitalO = "\u{f0f8}"
  case Hotel = "\u{f236}A"
  case Html5 = "\u{f13b}"
  case Ils = "\u{f20b}"
  case Image = "\u{f03e}"
  case Inbox = "\u{f01c}"
  case Indent = "\u{f03c}"
  case Info = "\u{f129}"
  case InfoCircle = "\u{f05a}"
  case Inr = "\u{f156}"
  case Instagram = "\u{f16d}"
  case Institution = "\u{f19c}A"
  case Ioxhost = "\u{f208}"
  case Italic = "\u{f033}"
  case Joomla = "\u{f1aa}"
  case JPY = "\u{f157}A"
  case Jsfiddle = "\u{f1cc}"
  case Key = "\u{f084}"
  case KeyboardO = "\u{f11c}"
  case Krw = "\u{f159}"
  case Language = "\u{f1ab}"
  case Laptop = "\u{f109}"
  case LastFM = "\u{f202}"
  case LastFMSquare = "\u{f203}"
  case Leaf = "\u{f06c}"
  case Leanpub = "\u{f212}"
  case Legal = "\u{f0e3}A"
  case LemonO = "\u{f094}"
  case LevelDown = "\u{f149}"
  case LevelUp = "\u{f148}"
  case LifeBouy = "\u{f1cd}"
  case LifeBuoy = "\u{f1cd}A"
  case LifeRing = "\u{f1cd}B"
  case LifeSaver = "\u{f1cd}C"
  case LightbulbO = "\u{f0eb}"
  case LineChart = "\u{f201}"
  case Link = "\u{f0c1}A"
  case LinkedIn = "\u{f0e1}"
  case LinkedInSquare = "\u{f08c}"
  case Linux = "\u{f17c}"
  case List = "\u{f03a}"
  case ListAlt = "\u{f022}"
  case ListOL = "\u{f0cb}"
  case ListUL = "\u{f0ca}"
  case LocationArrow = "\u{f124}"
  case Lock = "\u{f023}"
  case LongArrowDown = "\u{f175}"
  case LongArrowLeft = "\u{f177}"
  case LongArrowRight = "\u{f178}"
  case LongArrowUp = "\u{f176}"
  case Magic = "\u{f0d0}"
  case Magnet = "\u{f076}"
  case MailForward = "\u{f064}"
  case MailReply = "\u{f112}"
  case MailReplyAll  = "\u{f122}"
  case Male = "\u{f183}"
  case MapMarker = "\u{f041}"
  case Mars = "\u{f222}"
  case MarsDouble = "\u{f227}"
  case MarsStroke = "\u{f229}"
  case MarsStrokeH = "\u{f22b}"
  case MarsStrokeV = "\u{f22a}"
  case Maxcdn = "\u{f136}"
  case Meanpath = "\u{f20c}"
  case Medium = "\u{f23a}"
  case Medkit = "\u{f0fa}"
  case MehO = "\u{f11a}"
  case Mercury = "\u{f223}"
  case Microphone = "\u{f130}"
  case MicrophoneSlash = "\u{f131}"
  case Minus = "\u{f068}"
  case MinusCircle = "\u{f056}"
  case MinusSquare = "\u{f146}"
  case MinusSquareO = "\u{f147}"
  case Mobile = "\u{f10b}"
  case MobilePhone = "\u{f10b}A"
  case Money = "\u{f0d6}"
  case MoonO = "\u{f186}"
  case MortarBoard = "\u{f19d}A"
  case Motorcycle = "\u{f21c}"
  case Music = "\u{f001}"
  case Navicon = "\u{f0c9}A"
  case Neuter = "\u{f22c}"
  case NewspaperO = "\u{f1ea}"
  case Openid = "\u{f19b}"
  case Outdent = "\u{f03b}A"
  case Pagelines = "\u{f18c}"
  case PaintBrush = "\u{f1fc}"
  case PaperPlane = "\u{f1d8}"
  case PaperPlaneO = "\u{f1d9}"
  case Paperclip = "\u{f0c6}"
  case Paragraph = "\u{f1dd}"
  case Paste = "\u{f0ea}A"
  case Pause = "\u{f04c}"
  case Paw = "\u{f1b0}"
  case Paypal = "\u{f1ed}"
  case Pencil = "\u{f040}"
  case PencilSquare = "\u{f14b}"
  case PencilSquareO = "\u{f044}A"
  case Phone = "\u{f095}"
  case PhoneSquare = "\u{f098}"
  case Photo = "\u{f03e}A"
  case PictureO = "\u{f03e}B"
  case PieChart = "\u{f200}"
  case PiedPiper = "\u{f1a7}"
  case PiedPiperAlt = "\u{f1a8}"
  case Pinterest = "\u{f0d2}"
  case PinterestP = "\u{f231}"
  case PinterestSquare = "\u{f0d3}"
  case Plane = "\u{f072}"
  case Play = "\u{f04b}"
  case PlayCircle = "\u{f144}"
  case PlayCircleO = "\u{f01d}"
  case Plug = "\u{f1e6}"
  case Plus = "\u{f067}"
  case PlusCircle = "\u{f055}"
  case PlusSquare = "\u{f0fe}"
  case PlusSquareO = "\u{f196}"
  case PowerOff = "\u{f011}"
  case Print = "\u{f02f}"
  case PuzzlePiece = "\u{f12e}"
  case Qq = "\u{f1d6}"
  case Qrcode = "\u{f029}"
  case Question = "\u{f128}"
  case QuestionCircle = "\u{f059}"
  case QuoteLeft = "\u{f10d}"
  case QuoteRight = "\u{f10e}"
  case Ra = "\u{f1d0}"
  case Random = "\u{f074}"
  case Rebel = "\u{f1d0}A"
  case Recycle = "\u{f1b8}"
  case Reddit = "\u{f1a1}"
  case RedditSquare = "\u{f1a2}"
  case Refresh = "\u{f021}"
  case Remove = "\u{f00d}A"
  case Renren = "\u{f18b}"
  case Reorder = "\u{f0c9}B"
  case Repeat = "\u{f01e}"
  case Reply = "\u{f112}A"
  case ReplyAll = "\u{f122}A"
  case Retweet = "\u{f079}"
  case RMB = "\u{f157}B"
  case Road = "\u{f018}"
  case Rocket = "\u{f135}"
  case RotateLeft = "\u{f0e2}"
  case RotateRight = "\u{f01e}A"
  case Rouble = "\u{f158}"
  case Rss = "\u{f09e}"
  case RssSquare = "\u{f143}"
  case RUB = "\u{f158}A"
  case Ruble = "\u{f158}B"
  case Rupee = "\u{f156}A"
  case Save = "\u{f0c7}A"
  case Scissors = "\u{f0c4}A"
  case Search = "\u{f002}"
  case SearchMinus = "\u{f010}"
  case SearchPlus = "\u{f00e}"
  case Sellsy = "\u{f213}"
  case Send = "\u{f1d8}A"
  case SendO = "\u{f1d9}A"
  case Server = "\u{f233}"
  case Share = "\u{f064}A"
  case ShareAlt = "\u{f1e0}"
  case ShareAltSquare = "\u{f1e1}"
  case ShareSquare = "\u{f14d}"
  case ShareSquareO = "\u{f045}"
  case Shekel = "\u{f20b}A"
  case Sheqel = "\u{f20b}B"
  case Shield = "\u{f132}"
  case Ship = "\u{f21a}"
  case Shirtsinbulk = "\u{f214}"
  case ShoppingCart = "\u{f07a}"
  case SignIn = "\u{f090}"
  case SignOut = "\u{f08b}"
  case Signal = "\u{f012}"
  case Simplybuilt = "\u{f215}"
  case Sitemap = "\u{f0e8}"
  case Skyatlas = "\u{f216}"
  case Skype = "\u{f17e}"
  case Slack = "\u{f198}"
  case Sliders = "\u{f1de}"
  case Slideshare = "\u{f1e7}"
  case SmileO = "\u{f118}"
  case SoccerBallO  = "\u{f1e3}A"
  case Sort = "\u{f0dc}"
  case SortAlphaAsc = "\u{f15d}"
  case SortAlphaDesc = "\u{f15e}"
  case SortAmountAsc = "\u{f160}"
  case SortAmountDesc = "\u{f161}"
  case SortAsc = "\u{f0de}"
  case SortDesc = "\u{f0dd}"
  case SortDown  = "\u{f0dd}A"
  case SortNumericAsc = "\u{f162}"
  case SortNumericDesc = "\u{f163}"
  case SortUp = "\u{f0de}A"
  case SoundCloud = "\u{f1be}"
  case SpaceShuttle = "\u{f197}"
  case Spinner = "\u{f110}"
  case Spoon = "\u{f1b1}"
  case Spotify = "\u{f1bc}"
  case Square = "\u{f0c8}"
  case SquareO = "\u{f096}"
  case StackExchange = "\u{f18d}"
  case StackOverflow = "\u{f16c}"
  case Star = "\u{f005}"
  case StarHalf = "\u{f089}"
  case StarHalfEmpty = "\u{f123}"
  case StarHalfFull = "\u{f123}A"
  case StarHalfO = "\u{f123}B"
  case StarO = "\u{f006}"
  case Steam = "\u{f1b6}"
  case SteamSquare = "\u{f1b7}"
  case StepBackward = "\u{f048}"
  case StepForward = "\u{f051}"
  case Stethoscope = "\u{f0f1}"
  case Stop = "\u{f04d}"
  case StreetView = "\u{f21d}"
  case Strikethrough = "\u{f0cc}"
  case StumbleUpon = "\u{f1a4}"
  case StumbleUponCircle = "\u{f1a3}"
  case Subscript = "\u{f12c}"
  case Subway = "\u{f239}"
  case Suitcase = "\u{f0f2}"
  case SunO = "\u{f185}"
  case Superscript = "\u{f12b}"
  case Support = "\u{f1cd}D"
  case Table = "\u{f0ce}"
  case Tablet = "\u{f10a}"
  case Tachometer = "\u{f0e4}A"
  case Tag = "\u{f02b}"
  case Tags = "\u{f02c}"
  case Tasks = "\u{f0ae}"
  case Taxi = "\u{f1ba}A"
  case TencentWeibo = "\u{f1d5}"
  case Terminal = "\u{f120}"
  case TextHeight = "\u{f034}"
  case TextWidth = "\u{f035}"
  case Th = "\u{f00a}"
  case ThLarge = "\u{f009}"
  case ThList = "\u{f00b}"
  case ThumbTack = "\u{f08d}"
  case ThumbsDown = "\u{f165}"
  case ThumbsODown = "\u{f088}"
  case ThumbsOUp = "\u{f087}"
  case ThumbsUp = "\u{f164}"
  case Ticket = "\u{f145}"
  case Times = "\u{f00d}B"
  case TimesCircle = "\u{f057}"
  case TimesCircleO = "\u{f05c}"
  case Tint = "\u{f043}"
  case ToggleDown = "\u{f150}A"
  case ToggleLeft = "\u{f191}A"
  case ToggleOff = "\u{f204}"
  case ToggleOn = "\u{f205}"
  case ToggleRight = "\u{f152}A"
  case ToggleUp = "\u{f151}A"
  case Train = "\u{f238}"
  case TransGender = "\u{f224}"
  case TransGenderAlt = "\u{f225}"
  case Trash = "\u{f1f8}"
  case TrashO = "\u{f014}"
  case Tree = "\u{f1bb}"
  case Trello = "\u{f181}"
  case Trophy = "\u{f091}"
  case Truck = "\u{f0d1}"
  case Try = "\u{f195}"
  case Tty = "\u{f1e4}"
  case Tumblr = "\u{f173}"
  case TumblrSquare = "\u{f174}"
  case TurkishLira  = "\u{f195}A"
  case Twitch = "\u{f1e8}"
  case Twitter = "\u{f099}"
  case TwitterSquare = "\u{f081}"
  case Umbrella = "\u{f0e9}"
  case Underline = "\u{f0cd}"
  case Undo = "\u{f0e2}A"
  case University = "\u{f19c}B"
  case Unlink = "\u{f127}A"
  case Unlock = "\u{f09c}"
  case UnlockAlt = "\u{f13e}"
  case Unsorted = "\u{f0dc}A"
  case Upload = "\u{f093}"
  case USD = "\u{f155}A"
  case User = "\u{f007}"
  case UserMd = "\u{f0f0}"
  case UserPlus = "\u{f234}"
  case UserSecret = "\u{f21b}"
  case UserTimes = "\u{f235}"
  case Users = "\u{f0c0}A"
  case Venus = "\u{f221}"
  case VenusDouble = "\u{f226}"
  case VenusMars = "\u{f228}"
  case Viacoin = "\u{f237}"
  case VideoCamera = "\u{f03d}"
  case VimeoSquare = "\u{f194}"
  case Vine = "\u{f1ca}"
  case Vk = "\u{f189}"
  case VolumeDown = "\u{f027}"
  case VolumeOff = "\u{f026}"
  case VolumeUp = "\u{f028}"
  case Warning = "\u{f071}A"
  case Wechat = "\u{f1d7}"
  case Weibo = "\u{f18a}"
  case Weixin = "\u{f1d7}A"
  case Whatsapp = "\u{f232}"
  case Wheelchair = "\u{f193}"
  case Wifi = "\u{f1eb}"
  case Windows = "\u{f17a}"
  case WON = "\u{f159}A"
  case Wordpress = "\u{f19a}"
  case Wrench = "\u{f0ad}"
  case Xing = "\u{f168}"
  case XingSquare = "\u{f169}"
  case Yahoo = "\u{f19e}"
  case Yelp = "\u{f1e9}"
  case Yen = "\u{f157}C"
  case Youtube = "\u{f167}"
  case YoutubePlay = "\u{f16a}"
}

public extension String {
  public static func fontAwesomeIconWithName(name: FontAwesome) -> String {
    return name.rawValue.substringToIndex(advance(name.rawValue.startIndex, 1))
  }
}

private func fa_constrainLabelToSize(label: UILabel, size: CGSize,
    maxFontSize: CGFloat, minFontSize: CGFloat) -> CGSize {
    // Set the frame of the label to the targeted rectangle
    var rect = CGRectMake(0, 0, size.width, size.height)
    label.frame = rect
    
    // Try all font sizes from largest to smallest font size
    var fontSize = maxFontSize
    
    // Fit label width wize
    var constraintSize = CGSizeMake(label.frame.size.width, CGFloat.max)
    var attributes = [ NSFontAttributeName: label.font ]
        
    var textRect = CGRectMake(0, 0, size.width, size.height)
    var done = false
    while !done {
        // Set current font size
        label.font = UIFont(name: label.font.fontName, size: fontSize)
        
        // Find label size for current font size
        textRect = label.text!.boundingRectWithSize(
            constraintSize,
            options: NSStringDrawingOptions.UsesFontLeading,
            attributes: attributes,
            context: nil)
        
        // Done, if created label is within target size
        // Else decrease the font size and try again
        if textRect.size.height <= label.frame.size.height {
            done = true
        } else if fontSize < minFontSize + 0.5 {
            done = true
        } else if fontSize < minFontSize + 2.0 {
            fontSize -= 2.0
        } else {
            fontSize = minFontSize
        }
    }
    return textRect.size
}

// Calculate aspect fit rectangle
func fa_getAspectFitRect(viewSize: CGSize, iconSize: CGSize) -> CGRect {
    
    // Calculate shrinkage factors for width and height
    let widthFactor = iconSize.width / viewSize.width
    let heightFactor = iconSize.height / viewSize.height
    let factor = fmax(widthFactor, heightFactor)
    
    // Multiply the view size by the greater of the vertical or horizontal shrinkage factor
    let newWidth = viewSize.width * factor
    let newHeight = viewSize.height * factor
    
    // Center horizontally or vertically
    let x = (viewSize.width - iconSize.width) / 2
    let y = (viewSize.height - iconSize.height) / 2
    
    return CGRectMake(x, y, newWidth, newHeight)
}

public extension UIImage {
    public static func fontAwesomeIconWithName(name: FontAwesome, backgroundColor bgColor: UIColor,
        iconColor fgColor: UIColor, imageSize viewSize: CGSize, margin m: CGFloat) -> UIImage! {
 
        // View size less margins
        var iconSize = CGSizeMake(viewSize.width - m - m, viewSize.height - m - m)
            
        var label = UILabel()
        var font = UIFont.fontAwesomeOfSize(iconSize.height)
        var textContent = String.fontAwesomeIconWithName(name)
        label.font = font
        label.text = textContent
            
        // Get correctly sized bounding box
        iconSize = fa_constrainLabelToSize(label, iconSize, 500.0, 5.0)
        
        // Start image drawing
        UIGraphicsBeginImageContextWithOptions(viewSize, false, 0.0)
        
        // Rectangle drawing
        let viewRect = CGRectMake(0, 0, viewSize.width, viewSize.height)
        let path:UIBezierPath = UIBezierPath(rect: viewRect)
        bgColor.setFill()
        path.fill()
        
        // Calculate aspect fit rectangle
        let textRect = fa_getAspectFitRect(viewSize, iconSize)
        
        // Text drawing
        var attributes = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: fgColor,
            NSBackgroundColorAttributeName: bgColor
        ]
        fgColor.setFill()
        (textContent as NSString).drawInRect(textRect, withAttributes: attributes)
            
        // End image drawing
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}


