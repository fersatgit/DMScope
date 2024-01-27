unit GDIPlus;

{$ALIGN ON}
{$W-}
{$MINENUMSIZE 4}

interface

uses
  Windows;

type
  tagSTATSTG     =record
                  pwcsName:          PWideChar;
                  dwType:            Longint;
                  cbSize:            int64;
                  mtime:             TFileTime;
                  ctime:             TFileTime;
                  atime:             TFileTime;
                  grfMode:           Longint;
                  grfLocksSupported: Longint;
                  clsid:             TGUID;
                  grfStateBits:      Longint;
                  reserved:          Longint;
                  end;
                  
  ISequentialStream = interface(IUnknown)
  ['{0c733a30-2a1c-11ce-ade5-00aa0044773d}']
  function Read(pv: Pointer; cb: Longint; pcbRead: PLongint): LongInt;stdcall;
  function Write(pv: Pointer; cb: Longint; pcbWritten: PLongint): LongInt;stdcall;
  end;

  IStream = interface(ISequentialStream)
  ['{0000000C-0000-0000-C000-000000000046}']
  function Seek(dlibMove: int64; dwOrigin: Longint; libNewPosition: pint64): LongInt; stdcall;
  function SetSize(libNewSize: int64): LongInt; stdcall;
  function CopyTo(stm: IStream; cb: int64; out cbRead: int64; cbWritten: pint64): LongInt; stdcall;
  function Commit(grfCommitFlags: Longint): LongInt; stdcall;
  function Revert: LongInt; stdcall;
  function LockRegion(libOffset: int64; cb: int64; dwLockType: Longint): LongInt; stdcall;
  function UnlockRegion(libOffset: int64; cb: int64; dwLockType: Longint): LongInt; stdcall;
  function Stat(out statstg: tagSTATSTG; grfStatFlag: Longint): LongInt;stdcall;
  function Clone(out stm: IStream): LongInt; stdcall;
  end;

  INT16   = type Smallint;
  UINT16  = type Word;
  PUINT16 = ^UINT16;
  UINT32  = type Cardinal;
  TSingleDynArray = array of Single;

  GraphicsState     = UINT;
  GraphicsContainer = UINT;
  FillMode = (
    FillModeAlternate,        // 0
    FillModeWinding           // 1
  );
  TFillMode = FillMode;

  QualityMode = (
    QualityModeInvalid   = -1,
    QualityModeDefault   =  0,
    QualityModeLow       =  1, // Best performance
    QualityModeHigh      =  2  // Best rendering quality
  );
  TQualityMode = QualityMode;

  CompositingMode = (
    CompositingModeSourceOver,    // 0
    CompositingModeSourceCopy     // 1
  );
  TCompositingMode = CompositingMode;

  CompositingQuality = (
    CompositingQualityInvalid          = ord(QualityModeInvalid),
    CompositingQualityDefault          = ord(QualityModeDefault),
    CompositingQualityHighSpeed        = ord(QualityModeLow),
    CompositingQualityHighQuality      = ord(QualityModeHigh),
    CompositingQualityGammaCorrected,
    CompositingQualityAssumeLinear
  );
  TCompositingQuality = CompositingQuality;

  Unit_ = (
    UnitWorld,      // 0 -- World coordinate (non-physical unit)
    UnitDisplay,    // 1 -- Variable -- for PageTransform only
    UnitPixel,      // 2 -- Each unit is one device pixel.
    UnitPoint,      // 3 -- Each unit is a printer's point, or 1/72 inch.
    UnitInch,       // 4 -- Each unit is 1 inch.
    UnitDocument,   // 5 -- Each unit is 1/300 inch.
    UnitMillimeter  // 6 -- Each unit is 1 millimeter.
  );
  TUnit = Unit_;

  MetafileFrameUnit = (
    MetafileFrameUnitPixel      = ord(UnitPixel),
    MetafileFrameUnitPoint      = ord(UnitPoint),
    MetafileFrameUnitInch       = ord(UnitInch),
    MetafileFrameUnitDocument   = ord(UnitDocument),
    MetafileFrameUnitMillimeter = ord(UnitMillimeter),
    MetafileFrameUnitGdi        // GDI compatible .01 MM units
  );
  TMetafileFrameUnit = MetafileFrameUnit;

  CoordinateSpace = (
    CoordinateSpaceWorld,     // 0
    CoordinateSpacePage,      // 1
    CoordinateSpaceDevice     // 2
  );
  TCoordinateSpace = CoordinateSpace;

  WrapMode = (
    WrapModeTile,        // 0
    WrapModeTileFlipX,   // 1
    WrapModeTileFlipY,   // 2
    WrapModeTileFlipXY,  // 3
    WrapModeClamp        // 4
  );
  TWrapMode = WrapMode;

  HatchStyle = (
    HatchStyleHorizontal                   = 0,
    HatchStyleVertical                     = 1,
    HatchStyleForwardDiagonal              = 2,
    HatchStyleBackwardDiagonal             = 3,
    HatchStyleCross                        = 4,
    HatchStyleDiagonalCross                = 5,
    HatchStyle05Percent                    = 6,
    HatchStyle10Percent                    = 7,
    HatchStyle20Percent                    = 8,
    HatchStyle25Percent                    = 9,
    HatchStyle30Percent                    = 10,
    HatchStyle40Percent                    = 11,
    HatchStyle50Percent                    = 12,
    HatchStyle60Percent                    = 13,
    HatchStyle70Percent                    = 14,
    HatchStyle75Percent                    = 15,
    HatchStyle80Percent                    = 16,
    HatchStyle90Percent                    = 17,
    HatchStyleLightDownwardDiagonal        = 18,
    HatchStyleLightUpwardDiagonal          = 19,
    HatchStyleDarkDownwardDiagonal         = 20,
    HatchStyleDarkUpwardDiagonal           = 21,
    HatchStyleWideDownwardDiagonal         = 22,
    HatchStyleWideUpwardDiagonal           = 23,
    HatchStyleLightVertical                = 24,
    HatchStyleLightHorizontal              = 25,
    HatchStyleNarrowVertical               = 26,
    HatchStyleNarrowHorizontal             = 27,
    HatchStyleDarkVertical                 = 28,
    HatchStyleDarkHorizontal               = 29,
    HatchStyleDashedDownwardDiagonal       = 30,
    HatchStyleDashedUpwardDiagonal         = 31,
    HatchStyleDashedHorizontal             = 32,
    HatchStyleDashedVertical               = 33,
    HatchStyleSmallConfetti                = 34,
    HatchStyleLargeConfetti                = 35,
    HatchStyleZigZag                       = 36,
    HatchStyleWave                         = 37,
    HatchStyleDiagonalBrick                = 38,
    HatchStyleHorizontalBrick              = 39,
    HatchStyleWeave                        = 40,
    HatchStylePlaid                        = 41,
    HatchStyleDivot                        = 42,
    HatchStyleDottedGrid                   = 43,
    HatchStyleDottedDiamond                = 44,
    HatchStyleShingle                      = 45,
    HatchStyleTrellis                      = 46,
    HatchStyleSphere                       = 47,
    HatchStyleSmallGrid                    = 48,
    HatchStyleSmallCheckerBoard            = 49,
    HatchStyleLargeCheckerBoard            = 50,
    HatchStyleOutlinedDiamond              = 51,
    HatchStyleSolidDiamond                 = 52,

    HatchStyleTotal                        = 53,
    HatchStyleLargeGrid = HatchStyleCross, // 4

    HatchStyleMin       = HatchStyleHorizontal,
    HatchStyleMax       = HatchStyleTotal - 1);
  THatchStyle = HatchStyle;

  DashStyle = (
    DashStyleSolid,          // 0
    DashStyleDash,           // 1
    DashStyleDot,            // 2
    DashStyleDashDot,        // 3
    DashStyleDashDotDot,     // 4
    DashStyleCustom          // 5
  );
  TDashStyle = DashStyle;

  DashCap = (
    DashCapFlat             = 0,
    DashCapRound            = 2,
    DashCapTriangle         = 3);
  TDashCap = DashCap;

  LineCap = (
    LineCapFlat             = 0,
    LineCapSquare           = 1,
    LineCapRound            = 2,
    LineCapTriangle         = 3,

    LineCapNoAnchor         = $10, // corresponds to flat cap
    LineCapSquareAnchor     = $11, // corresponds to square cap
    LineCapRoundAnchor      = $12, // corresponds to round cap
    LineCapDiamondAnchor    = $13, // corresponds to triangle cap
    LineCapArrowAnchor      = $14, // no correspondence

    LineCapCustom           = $ff, // custom cap

    LineCapAnchorMask       = $f0  // mask to check for anchor or not.
  );
  TLineCap = LineCap;

  CustomLineCapType = (
    CustomLineCapTypeDefault         = 0,
    CustomLineCapTypeAdjustableArrow = 1);
  TCustomLineCapType = CustomLineCapType;

  LineJoin = (
    LineJoinMiter        = 0,
    LineJoinBevel        = 1,
    LineJoinRound        = 2,
    LineJoinMiterClipped = 3);
  TLineJoin = LineJoin;

  {$Z1}
  PathPointType = (
    PathPointTypeStart           = $00, // move
    PathPointTypeLine            = $01, // line
    PathPointTypeBezier          = $03, // default Bezier (= cubic Bezier)
    PathPointTypePathTypeMask    = $07, // type mask (lowest 3 bits).
    PathPointTypeDashMode        = $10, // currently in dash mode.
    PathPointTypePathMarker      = $20, // a marker for the path.
    PathPointTypeCloseSubpath    = $80, // closed flag
    PathPointTypeBezier3         = $03  // cubic Bezier
  );
  TPathPointType = PathPointType;
  {$Z4}

  WarpMode = (
    WarpModePerspective,    // 0
    WarpModeBilinear        // 1
  );
  TWarpMode = WarpMode;

  LinearGradientMode = (
    LinearGradientModeHorizontal,         // 0
    LinearGradientModeVertical,           // 1
    LinearGradientModeForwardDiagonal,    // 2
    LinearGradientModeBackwardDiagonal    // 3
  );
  TLinearGradientMode = LinearGradientMode;

  CombineMode = (
    CombineModeReplace,     // 0
    CombineModeIntersect,   // 1
    CombineModeUnion,       // 2
    CombineModeXor,         // 3
    CombineModeExclude,     // 4
    CombineModeComplement   // 5 (Exclude From)
  );
  TCombineMode = CombineMode;

  ImageType = (
    ImageTypeUnknown,   // 0
    ImageTypeBitmap,    // 1
    ImageTypeMetafile   // 2
  );
  TImageType = ImageType;

  InterpolationMode = (
    InterpolationModeInvalid          = ord(QualityModeInvalid),
    InterpolationModeDefault          = ord(QualityModeDefault),
    InterpolationModeLowQuality       = ord(QualityModeLow),
    InterpolationModeHighQuality      = ord(QualityModeHigh),
    InterpolationModeBilinear,
    InterpolationModeBicubic,
    InterpolationModeNearestNeighbor,
    InterpolationModeHighQualityBilinear,
    InterpolationModeHighQualityBicubic);
  TInterpolationMode = InterpolationMode;

  PenAlignment = (
    PenAlignmentCenter       = 0,
    PenAlignmentInset        = 1);
  TPenAlignment = PenAlignment;

  BrushType = (
   BrushTypeSolidColor       = 0,
   BrushTypeHatchFill        = 1,
   BrushTypeTextureFill      = 2,
   BrushTypePathGradient     = 3,
   BrushTypeLinearGradient   = 4);
  TBrushType = BrushType;

  PenType = (
   PenTypeSolidColor       =  ord(BrushTypeSolidColor),
   PenTypeHatchFill        =  ord(BrushTypeHatchFill),
   PenTypeTextureFill      =  ord(BrushTypeTextureFill),
   PenTypePathGradient     =  ord(BrushTypePathGradient),
   PenTypeLinearGradient   =  ord(BrushTypeLinearGradient),
   PenTypeUnknown          = -1);
  TPenType = PenType;

  MatrixOrder = (
    MatrixOrderPrepend    = 0,
    MatrixOrderAppend     = 1);
  TMatrixOrder = MatrixOrder;

  GenericFontFamily = (
    GenericFontFamilySerif,
    GenericFontFamilySansSerif,
    GenericFontFamilyMonospace);
  TGenericFontFamily = GenericFontFamily;

  FontStyle = Integer;
  TFontStyle = FontStyle;

  SmoothingMode = (
    SmoothingModeInvalid     = ord(QualityModeInvalid),
    SmoothingModeDefault     = ord(QualityModeDefault),
    SmoothingModeHighSpeed   = ord(QualityModeLow),
    SmoothingModeHighQuality = ord(QualityModeHigh),
    SmoothingModeNone,
    SmoothingModeAntiAlias);
  TSmoothingMode = SmoothingMode;

  PixelOffsetMode = (
    PixelOffsetModeInvalid     = Ord(QualityModeInvalid),
    PixelOffsetModeDefault     = Ord(QualityModeDefault),
    PixelOffsetModeHighSpeed   = Ord(QualityModeLow),
    PixelOffsetModeHighQuality = Ord(QualityModeHigh),
    PixelOffsetModeNone,    // No pixel offset
    PixelOffsetModeHalf     // Offset by -0.5, -0.5 for fast anti-alias perf
  );
  TPixelOffsetMode = PixelOffsetMode;

  TextRenderingHint = (
    TextRenderingHintSystemDefault = 0,            // Glyph with system default rendering hint
    TextRenderingHintSingleBitPerPixelGridFit,     // Glyph bitmap with hinting
    TextRenderingHintSingleBitPerPixel,            // Glyph bitmap without hinting
    TextRenderingHintAntiAliasGridFit,             // Glyph anti-alias bitmap with hinting
    TextRenderingHintAntiAlias,                    // Glyph anti-alias bitmap without hinting
    TextRenderingHintClearTypeGridFit              // Glyph CT bitmap with hinting
  );
  TTextRenderingHint = TextRenderingHint;

  MetafileType = (
    MetafileTypeInvalid,            // Invalid metafile
    MetafileTypeWmf,                // Standard WMF
    MetafileTypeWmfPlaceable,       // Placeable WMF
    MetafileTypeEmf,                // EMF (not EMF+)
    MetafileTypeEmfPlusOnly,        // EMF+ without dual, down-level records
    MetafileTypeEmfPlusDual         // EMF+ with dual, down-level records
  );
  TMetafileType = MetafileType;

  EmfType = (
    EmfTypeEmfOnly     = Ord(MetafileTypeEmf),          // no EMF+, only EMF
    EmfTypeEmfPlusOnly = Ord(MetafileTypeEmfPlusOnly),  // no EMF, only EMF+
    EmfTypeEmfPlusDual = Ord(MetafileTypeEmfPlusDual)   // both EMF+ and EMF
  );
  TEmfType = EmfType;

  ObjectType = (
    ObjectTypeInvalid,
    ObjectTypeBrush,
    ObjectTypePen,
    ObjectTypePath,
    ObjectTypeRegion,
    ObjectTypeImage,
    ObjectTypeFont,
    ObjectTypeStringFormat,
    ObjectTypeImageAttributes,
    ObjectTypeCustomLineCap,
    ObjectTypeMax = ObjectTypeCustomLineCap,
    ObjectTypeMin = ObjectTypeBrush);
  TObjectType = ObjectType;

  StringFormatFlags = Integer;
  TStringFormatFlags = StringFormatFlags;

  StringTrimming = (
    StringTrimmingNone              = 0,
    StringTrimmingCharacter         = 1,
    StringTrimmingWord              = 2,
    StringTrimmingEllipsisCharacter = 3,
    StringTrimmingEllipsisWord      = 4,
    StringTrimmingEllipsisPath      = 5);
  TStringTrimming = StringTrimming;

  StringDigitSubstitute = (
    StringDigitSubstituteUser        = 0,  // As NLS setting
    StringDigitSubstituteNone        = 1,
    StringDigitSubstituteNational    = 2,
    StringDigitSubstituteTraditional = 3);
  TStringDigitSubstitute = StringDigitSubstitute;
  PStringDigitSubstitute = ^TStringDigitSubstitute;

  HotkeyPrefix = (
    HotkeyPrefixNone        = 0,
    HotkeyPrefixShow        = 1,
    HotkeyPrefixHide        = 2);
  THotkeyPrefix = HotkeyPrefix;

  StringAlignment = (
    StringAlignmentNear   = 0,
    StringAlignmentCenter = 1,
    StringAlignmentFar    = 2);
  TStringAlignment = StringAlignment;

  DriverStringOptions = Integer;
  TDriverStringOptions = DriverStringOptions;
  FlushIntention = (
    FlushIntentionFlush = 0,        // Flush all batched rendering operations
    FlushIntentionSync = 1          // Flush all batched rendering operations and wait for them to complete
  );
  TFlushIntention = FlushIntention;

  EncoderParameterValueType = Integer;
  TEncoderParameterValueType = EncoderParameterValueType;

  EncoderValue = (
    EncoderValueColorTypeCMYK,
    EncoderValueColorTypeYCCK,
    EncoderValueCompressionLZW,
    EncoderValueCompressionCCITT3,
    EncoderValueCompressionCCITT4,
    EncoderValueCompressionRle,
    EncoderValueCompressionNone,
    EncoderValueScanMethodInterlaced,
    EncoderValueScanMethodNonInterlaced,
    EncoderValueVersionGif87,
    EncoderValueVersionGif89,
    EncoderValueRenderProgressive,
    EncoderValueRenderNonProgressive,
    EncoderValueTransformRotate90,
    EncoderValueTransformRotate180,
    EncoderValueTransformRotate270,
    EncoderValueTransformFlipHorizontal,
    EncoderValueTransformFlipVertical,
    EncoderValueMultiFrame,
    EncoderValueLastFrame,
    EncoderValueFlush,
    EncoderValueFrameDimensionTime,
    EncoderValueFrameDimensionResolution,
    EncoderValueFrameDimensionPage);
  TEncoderValue = EncoderValue;

  EmfToWmfBitsFlags = (
    EmfToWmfBitsFlagsDefault          = $00000000,
    EmfToWmfBitsFlagsEmbedEmf         = $00000001,
    EmfToWmfBitsFlagsIncludePlaceable = $00000002,
    EmfToWmfBitsFlagsNoXORClip        = $00000004);
  TEmfToWmfBitsFlags = EmfToWmfBitsFlags;

  ImageAbort             = function: BOOL; stdcall;
  DrawImageAbort         = ImageAbort;
  GetThumbnailImageAbort = ImageAbort;

  Status = (
    Ok,
    GenericError,
    InvalidParameter,
    OutOfMemory,
    ObjectBusy,
    InsufficientBuffer,
    NotImplemented,
    Win32Error,
    WrongState,
    Aborted,
    FileNotFound,
    ValueOverflow,
    AccessDenied,
    UnknownImageFormat,
    FontFamilyNotFound,
    FontStyleNotFound,
    NotTrueTypeFont,
    UnsupportedGdiplusVersion,
    GdiplusNotInitialized,
    PropertyNotFound,
    PropertyNotSupported);
  TStatus = Status;

  PSizeF = ^TSizeF;
  TSizeF = packed record
    Width  : Single;
    Height : Single;
  end;

  PSize = ^TSize;
  TSize = packed record
    Width  : Cardinal;
    Height : Cardinal;
  end;

  PPointF = ^TPointF;
  TPointF = packed record
    X : Single;
    Y : Single;
  end;
  TPointFDynArray = array of TPointF;
  TPointDynArray = array of TPoint;

  PRectF = ^TRectF;
  TRectF = packed record
    X     : Single;
    Y     : Single;
    Width : Single;
    Height: Single;
  end;
  TRectFDynArray = array of TRectF;
  TRectDynArray = array of TRect;

  TPathData = packed record
    Count  : Integer;
    Points : PPointF;
    Types  : PBYTE;
  end;

  PCharacterRange = ^TCharacterRange;
  TCharacterRange = packed record
    First  : Integer;
    Length : Integer;
  end;

  DebugEventLevel = (
    DebugEventLevelFatal,
    DebugEventLevelWarning);
  TDebugEventLevel = DebugEventLevel;

  DebugEventProc         = procedure(level: DebugEventLevel; message: PChar); stdcall;
  NotificationHookProc   = function(out token: ULONG): Status; stdcall;
  NotificationUnhookProc = procedure(token: ULONG); stdcall;

  GdiplusStartupInput = packed record
    GdiplusVersion          : Cardinal;       // Must be 1
    DebugEventCallback      : DebugEventProc; // Ignored on free builds
    SuppressBackgroundThread: BOOL;           // FALSE unless you're prepared to call the hook/unhook functions properly
    SuppressExternalCodecs  : BOOL;           // FALSE unless you want GDI+ only to use
  end;                                        // its internal image codecs.
  TGdiplusStartupInput = GdiplusStartupInput;
  PGdiplusStartupInput = ^TGdiplusStartupInput;

  GdiplusStartupOutput = packed record
    NotificationHook  : NotificationHookProc;
    NotificationUnhook: NotificationUnhookProc;
  end;
  TGdiplusStartupOutput = GdiplusStartupOutput;
  PGdiplusStartupOutput = ^TGdiplusStartupOutput;

  PARGB  = ^ARGB;
  ARGB   = DWORD;
  ARGB64 = Int64;

  PixelFormat = Integer;
  TPixelFormat = PixelFormat;

  PaletteFlags = (
    PaletteFlagsHasAlpha    = $0001,
    PaletteFlagsGrayScale   = $0002,
    PaletteFlagsHalftone    = $0004);
  TPaletteFlags = PaletteFlags;

  ColorPalette = packed record
    Flags  : UINT ;                 // Palette flags
    Count  : UINT ;                 // Number of color entries
    Entries: array [0..0] of ARGB ; // Palette color entries
  end;

  TColorPalette = ColorPalette;
  PColorPalette = ^TColorPalette;

  ColorMode = (
    ColorModeARGB32 = 0,
    ColorModeARGB64 = 1);
  TColorMode = ColorMode;

  ColorChannelFlags = (
    ColorChannelFlagsC = 0,
    ColorChannelFlagsM,
    ColorChannelFlagsY,
    ColorChannelFlagsK,
    ColorChannelFlagsLast);
  TColorChannelFlags = ColorChannelFlags;

  PColor = ^TColor;
  TColor = ARGB;
  TColorDynArray = array of TColor;
  RECTL = Windows.Trect;
  SIZEL = Windows.TSize;

  ENHMETAHEADER3 = packed record
    iType          : DWORD;  // Record type EMR_HEADER
    nSize          : DWORD;  // Record size in bytes.  This may be greater
                             // than the sizeof(ENHMETAHEADER).
    rclBounds      : RECTL;  // Inclusive-inclusive bounds in device units
    rclFrame       : RECTL;  // Inclusive-inclusive Picture Frame .01mm unit
    dSignature     : DWORD;  // Signature.  Must be ENHMETA_SIGNATURE.
    nVersion       : DWORD;  // Version number
    nBytes         : DWORD;  // Size of the metafile in bytes
    nRecords       : DWORD;  // Number of records in the metafile
    nHandles       : WORD;   // Number of handles in the handle table
                             // Handle index zero is reserved.
    sReserved      : WORD;   // Reserved.  Must be zero.
    nDescription   : DWORD;  // Number of chars in the unicode desc string
                             // This is 0 if there is no description string
    offDescription : DWORD;  // Offset to the metafile description record.
                             // This is 0 if there is no description string
    nPalEntries    : DWORD;  // Number of entries in the metafile palette.
    szlDevice      : SIZEL;  // Size of the reference device in pels
    szlMillimeters : SIZEL;  // Size of the reference device in millimeters
  end;
  TENHMETAHEADER3 = ENHMETAHEADER3;
  PENHMETAHEADER3 = ^TENHMETAHEADER3;

  PWMFRect16 = packed record
    Left   : INT16;
    Top    : INT16;
    Right  : INT16;
    Bottom : INT16;
  end;
  TPWMFRect16 = PWMFRect16;
  PPWMFRect16 = ^TPWMFRect16;

  WmfPlaceableFileHeader = packed record
    Key         : UINT32;      // GDIP_WMF_PLACEABLEKEY
    Hmf         : INT16;       // Metafile HANDLE number (always 0)
    BoundingBox : PWMFRect16;  // Coordinates in metafile units
    Inch        : INT16;       // Number of metafile units per inch
    Reserved    : UINT32;      // Reserved (always 0)
    Checksum    : INT16;       // Checksum value for previous 10 WORDs
  end;
  TWmfPlaceableFileHeader = WmfPlaceableFileHeader;
  PWmfPlaceableFileHeader = ^TWmfPlaceableFileHeader;

  TMetafileHeader = packed class
  public
    Type_        : TMetafileType;
    Size         : UINT;           // Size of the metafile (in bytes)
    Version      : UINT;           // EMF+, EMF, or WMF version
    EmfPlusFlags : UINT;
    DpiX         : Single;
    DpiY         : Single;
    X            : Integer;        // Bounds in device units
    Y            : Integer;
    Width        : Integer;
    Height       : Integer;
    Header       : record
    case integer of
      0: (WmfHeader: TMETAHEADER;);
      1: (EmfHeader: TENHMETAHEADER3);
    end;
    EmfPlusHeaderSize : Integer; // size of the EMF+ header in file
    LogicalDpiX       : Integer; // Logical Dpi of reference Hdc
    LogicalDpiY       : Integer; // usually valid only for EMF+
  end;

  IImageBytes = Interface(IUnknown)
    ['{025D1823-6C7D-447B-BBDB-A3CBC3DFA2FC}']
    function CountBytes(out pcb: UINT): HRESULT; stdcall;
    function LockBytes(cb: UINT; ulOffset: ULONG; out ppvBytes: pointer): HRESULT; stdcall;
    function UnlockBytes(pvBytes: pointer; cb: UINT; ulOffset: ULONG): HRESULT; stdcall;
  end;

  ImageCodecInfo = packed record
    Clsid             : TGUID;
    FormatID          : TGUID;
    CodecName         : PWCHAR;
    DllName           : PWCHAR;
    FormatDescription : PWCHAR;
    FilenameExtension : PWCHAR;
    MimeType          : PWCHAR;
    Flags             : DWORD;
    Version           : DWORD;
    SigCount          : DWORD;
    SigSize           : DWORD;
    SigPattern        : PBYTE;
    SigMask           : PBYTE;
  end;
  TImageCodecInfo = ImageCodecInfo;
  PImageCodecInfo = ^TImageCodecInfo;

  ImageCodecFlags = (
    ImageCodecFlagsEncoder            = $00000001,
    ImageCodecFlagsDecoder            = $00000002,
    ImageCodecFlagsSupportBitmap      = $00000004,
    ImageCodecFlagsSupportVector      = $00000008,
    ImageCodecFlagsSeekableEncode     = $00000010,
    ImageCodecFlagsBlockingDecode     = $00000020,
    ImageCodecFlagsBuiltin            = $00010000,
    ImageCodecFlagsSystem             = $00020000,
    ImageCodecFlagsUser               = $00040000);
  TImageCodecFlags = ImageCodecFlags;

  ImageLockMode = Integer;
  TImageLockMode = ImageLockMode;

  BitmapData = packed record
    Width       : UINT;
    Height      : UINT;
    Stride      : Integer;
    PixelFormat : PixelFormat;
    Scan0       : Pointer;
    Reserved    : UINT;
  end;
  TBitmapData = BitmapData;
  PBitmapData = ^TBitmapData;

  ImageFlags = (
    ImageFlagsNone                = 0,
    ImageFlagsScalable            = $0001,
    ImageFlagsHasAlpha            = $0002,
    ImageFlagsHasTranslucent      = $0004,
    ImageFlagsPartiallyScalable   = $0008,
    ImageFlagsColorSpaceRGB       = $0010,
    ImageFlagsColorSpaceCMYK      = $0020,
    ImageFlagsColorSpaceGRAY      = $0040,
    ImageFlagsColorSpaceYCBCR     = $0080,
    ImageFlagsColorSpaceYCCK      = $0100,
    ImageFlagsHasRealDPI          = $1000,
    ImageFlagsHasRealPixelSize    = $2000,
    ImageFlagsReadOnly            = $00010000,
    ImageFlagsCaching             = $00020000);
  TImageFlags = ImageFlags;

  RotateFlipType = (
    RotateNoneFlipNone = 0,
    Rotate90FlipNone   = 1,
    Rotate180FlipNone  = 2,
    Rotate270FlipNone  = 3,
    RotateNoneFlipX    = 4,
    Rotate90FlipX      = 5,
    Rotate180FlipX     = 6,
    Rotate270FlipX     = 7,
    RotateNoneFlipY    = Rotate180FlipX,
    Rotate90FlipY      = Rotate270FlipX,
    Rotate180FlipY     = RotateNoneFlipX,
    Rotate270FlipY     = Rotate90FlipX,
    RotateNoneFlipXY   = Rotate180FlipNone,
    Rotate90FlipXY     = Rotate270FlipNone,
    Rotate180FlipXY    = RotateNoneFlipNone,
    Rotate270FlipXY    = Rotate90FlipNone);
  TRotateFlipType = RotateFlipType;

  EncoderParameter = packed record
    Guid           : TGUID;   // GUID of the parameter
    NumberOfValues : ULONG;   // Number of the parameter values
    Type_          : ULONG;   // Value type, like ValueTypeLONG  etc.
    Value          : Pointer; // A pointer to the parameter values
  end;
  TEncoderParameter = EncoderParameter;
  PEncoderParameter = ^TEncoderParameter;

  EncoderParameters = packed record
    Count     : UINT;               // Number of parameters in this structure
    Parameter : array[0..0] of TEncoderParameter;  // Parameter values
  end;
  TEncoderParameters = EncoderParameters;
  PEncoderParameters = ^TEncoderParameters;

  PropertyItem = record // NOT PACKED !!
    id       : ULONG;   // ID of this property
    length   : ULONG;   // Length of the property value, in bytes
    type_    : WORD;    // Type of the value, as one of TAG_TYPE_XXX
    value    : Pointer; // property value
  end;
  TPropertyItem = PropertyItem;
  PPropertyItem = ^TPropertyItem;

  ColorMatrix = packed array[0..4, 0..4] of Single;
  TColorMatrix = ColorMatrix;
  PColorMatrix = ^TColorMatrix;

  ColorMatrixFlags = (
    ColorMatrixFlagsDefault   = 0,
    ColorMatrixFlagsSkipGrays = 1,
    ColorMatrixFlagsAltGray   = 2);
  TColorMatrixFlags = ColorMatrixFlags;

  ColorAdjustType = (
    ColorAdjustTypeDefault,
    ColorAdjustTypeBitmap,
    ColorAdjustTypeBrush,
    ColorAdjustTypePen,
    ColorAdjustTypeText,
    ColorAdjustTypeCount,
    ColorAdjustTypeAny);
  TColorAdjustType = ColorAdjustType;

  ColorMap = packed record
    oldColor: TColor;
    newColor: TColor;
  end;
  TColorMap = ColorMap;
  PColorMap = ^TColorMap;

  GpTexture = Pointer;
  GpLineGradient = Pointer;
  GpHatch =  Pointer;
  GpPen = Pointer;
  GpCustomLineCap = Pointer;
  GpAdjustableArrowCap = Pointer;
  GpImage = Pointer;
  GpBitmap = Pointer;
  GpMetafile = Pointer;
  GpImageAttributes = Pointer;
  GpRegion = Pointer;
  GpCachedBitmap = Pointer;
  GpStatus          = TStatus;
  GpFillMode        = TFillMode;
  GpWrapMode        = TWrapMode;
  GpUnit            = TUnit;
  GpCoordinateSpace = TCoordinateSpace;
  GpPointF          = PPointF;
  GpPoint           = PPoint;
  GpRectF           = PRectF;
  GpRect            = PRect;
  GpSizeF           = PSizeF;
  GpHatchStyle      = THatchStyle;
  GpDashStyle       = TDashStyle;
  GpLineCap         = TLineCap;
  GpDashCap         = TDashCap;
  GpPenAlignment    = TPenAlignment;
  GpLineJoin        = TLineJoin;
  GpPenType         = TPenType;
  LongIntType       = TBrushType;
  GpMatrixOrder     = TMatrixOrder;
  GpFlushIntention  = TFlushIntention;

const
  WINGDIPDLL = 'gdiplus.dll';
  FlatnessDefault = 0.25;

  FontStyleRegular    = Integer(0);
  FontStyleBold       = Integer(1);
  FontStyleItalic     = Integer(2);
  FontStyleBoldItalic = Integer(3);
  FontStyleUnderline  = Integer(4);
  FontStyleStrikeout  = Integer(8);

  GDIP_EMFPLUS_RECORD_BASE      = $00004000;
  GDIP_WMF_RECORD_BASE          = $00010000;

  StringFormatFlagsDirectionRightToLeft        = $00000001;
  StringFormatFlagsDirectionVertical           = $00000002;
  StringFormatFlagsNoFitBlackBox               = $00000004;
  StringFormatFlagsDisplayFormatControl        = $00000020;
  StringFormatFlagsNoFontFallback              = $00000400;
  StringFormatFlagsMeasureTrailingSpaces       = $00000800;
  StringFormatFlagsNoWrap                      = $00001000;
  StringFormatFlagsLineLimit                   = $00002000;
  StringFormatFlagsNoClip                      = $00004000;

  DriverStringOptionsCmapLookup             = 1;
  DriverStringOptionsVertical               = 2;
  DriverStringOptionsRealizedAdvance        = 4;
  DriverStringOptionsLimitSubpixel          = 8;

  EncoderParameterValueTypeByte          : Integer = 1;    // 8-bit unsigned int
  EncoderParameterValueTypeASCII         : Integer = 2;    // 8-bit byte containing one 7-bit ASCII code. NULL terminated.
  EncoderParameterValueTypeShort         : Integer = 3;    // 16-bit unsigned int
  EncoderParameterValueTypeLong          : Integer = 4;    // 32-bit unsigned int
  EncoderParameterValueTypeRational      : Integer = 5;    // Two Longs. The first Long is the numerator, the second Long expresses the denomintor.
  EncoderParameterValueTypeLongRange     : Integer = 6;    // Two longs which specify a range of integer values. The first Long specifies the lower end and the second one specifies the higher end. All values are inclusive at both ends
  EncoderParameterValueTypeUndefined     : Integer = 7;    // 8-bit byte that can take any value depending on field definition
  EncoderParameterValueTypeRationalRange : Integer = 8;    // Two Rationals. The first Rational specifies the lower end and the second specifies the higher end. All values are inclusive at both ends

  FLT_MAX       =  3.402823466e+38; // max value
  FLT_MIN       =  1.175494351e-38; // min positive value
  REAL_MAX      = FLT_MAX;
  REAL_MIN      = FLT_MIN;
  REAL_TOLERANCE= (FLT_MIN * 100);
  REAL_EPSILON  = 1.192092896e-07;  // FLT_EPSILON

  ALPHA_SHIFT = 24;
  RED_SHIFT   = 16;
  GREEN_SHIFT = 8;
  BLUE_SHIFT  = 0;
  ALPHA_MASK  = (ARGB($ff) shl ALPHA_SHIFT);

  PixelFormatIndexed     = $00010000; // Indexes into a palette
  PixelFormatGDI         = $00020000; // Is a GDI-supported format
  PixelFormatAlpha       = $00040000; // Has an alpha component
  PixelFormatPAlpha      = $00080000; // Pre-multiplied alpha
  PixelFormatExtended    = $00100000; // Extended color 16 bits/channel
  PixelFormatCanonical   = $00200000;
  PixelFormatUndefined      = 0;
  PixelFormatDontCare       = 0;
  PixelFormat1bppIndexed    = (1  or ( 1 shl 8) or PixelFormatIndexed or PixelFormatGDI);
  PixelFormat4bppIndexed    = (2  or ( 4 shl 8) or PixelFormatIndexed or PixelFormatGDI);
  PixelFormat8bppIndexed    = (3  or ( 8 shl 8) or PixelFormatIndexed or PixelFormatGDI);
  PixelFormat16bppGrayScale = (4  or (16 shl 8) or PixelFormatExtended);
  PixelFormat16bppRGB555    = (5  or (16 shl 8) or PixelFormatGDI);
  PixelFormat16bppRGB565    = (6  or (16 shl 8) or PixelFormatGDI);
  PixelFormat16bppARGB1555  = (7  or (16 shl 8) or PixelFormatAlpha or PixelFormatGDI);
  PixelFormat24bppRGB       = (8  or (24 shl 8) or PixelFormatGDI);
  PixelFormat32bppRGB       = (9  or (32 shl 8) or PixelFormatGDI);
  PixelFormat32bppARGB      = (10 or (32 shl 8) or PixelFormatAlpha or PixelFormatGDI or PixelFormatCanonical);
  PixelFormat32bppPARGB     = (11 or (32 shl 8) or PixelFormatAlpha or PixelFormatPAlpha or PixelFormatGDI);
  PixelFormat48bppRGB       = (12 or (48 shl 8) or PixelFormatExtended);
  PixelFormat64bppARGB      = (13 or (64 shl 8) or PixelFormatAlpha  or PixelFormatCanonical or PixelFormatExtended);
  PixelFormat64bppPARGB     = (14 or (64 shl 8) or PixelFormatAlpha  or PixelFormatPAlpha or PixelFormatExtended);
  PixelFormatMax            = 15;

  aclAliceBlue            = $FFF0F8FF;
  aclAntiqueWhite         = $FFFAEBD7;
  aclAqua                 = $FF00FFFF;
  aclAquamarine           = $FF7FFFD4;
  aclAzure                = $FFF0FFFF;
  aclBeige                = $FFF5F5DC;
  aclBisque               = $FFFFE4C4;
  aclBlack                = $FF000000;
  aclBlanchedAlmond       = $FFFFEBCD;
  aclBlue                 = $FF0000FF;
  aclBlueViolet           = $FF8A2BE2;
  aclBrown                = $FFA52A2A;
  aclBurlyWood            = $FFDEB887;
  aclCadetBlue            = $FF5F9EA0;
  aclChartreuse           = $FF7FFF00;
  aclChocolate            = $FFD2691E;
  aclCoral                = $FFFF7F50;
  aclCornflowerBlue       = $FF6495ED;
  aclCornsilk             = $FFFFF8DC;
  aclCrimson              = $FFDC143C;
  aclCyan                 = $FF00FFFF;
  aclDarkBlue             = $FF00008B;
  aclDarkCyan             = $FF008B8B;
  aclDarkGoldenrod        = $FFB8860B;
  aclDarkGray             = $FFA9A9A9;
  aclDarkGreen            = $FF006400;
  aclDarkKhaki            = $FFBDB76B;
  aclDarkMagenta          = $FF8B008B;
  aclDarkOliveGreen       = $FF556B2F;
  aclDarkOrange           = $FFFF8C00;
  aclDarkOrchid           = $FF9932CC;
  aclDarkRed              = $FF8B0000;
  aclDarkSalmon           = $FFE9967A;
  aclDarkSeaGreen         = $FF8FBC8B;
  aclDarkSlateBlue        = $FF483D8B;
  aclDarkSlateGray        = $FF2F4F4F;
  aclDarkTurquoise        = $FF00CED1;
  aclDarkViolet           = $FF9400D3;
  aclDeepPink             = $FFFF1493;
  aclDeepSkyBlue          = $FF00BFFF;
  aclDimGray              = $FF696969;
  aclDodgerBlue           = $FF1E90FF;
  aclFirebrick            = $FFB22222;
  aclFloralWhite          = $FFFFFAF0;
  aclForestGreen          = $FF228B22;
  aclFuchsia              = $FFFF00FF;
  aclGainsboro            = $FFDCDCDC;
  aclGhostWhite           = $FFF8F8FF;
  aclGold                 = $FFFFD700;
  aclGoldenrod            = $FFDAA520;
  aclGray                 = $FF808080;
  aclGreen                = $FF008000;
  aclGreenYellow          = $FFADFF2F;
  aclHoneydew             = $FFF0FFF0;
  aclHotPink              = $FFFF69B4;
  aclIndianRed            = $FFCD5C5C;
  aclIndigo               = $FF4B0082;
  aclIvory                = $FFFFFFF0;
  aclKhaki                = $FFF0E68C;
  aclLavender             = $FFE6E6FA;
  aclLavenderBlush        = $FFFFF0F5;
  aclLawnGreen            = $FF7CFC00;
  aclLemonChiffon         = $FFFFFACD;
  aclLightBlue            = $FFADD8E6;
  aclLightCoral           = $FFF08080;
  aclLightCyan            = $FFE0FFFF;
  aclLightGoldenrodYellow = $FFFAFAD2;
  aclLightGray            = $FFD3D3D3;
  aclLightGreen           = $FF90EE90;
  aclLightPink            = $FFFFB6C1;
  aclLightSalmon          = $FFFFA07A;
  aclLightSeaGreen        = $FF20B2AA;
  aclLightSkyBlue         = $FF87CEFA;
  aclLightSlateGray       = $FF778899;
  aclLightSteelBlue       = $FFB0C4DE;
  aclLightYellow          = $FFFFFFE0;
  aclLime                 = $FF00FF00;
  aclLimeGreen            = $FF32CD32;
  aclLinen                = $FFFAF0E6;
  aclMagenta              = $FFFF00FF;
  aclMaroon               = $FF800000;
  aclMediumAquamarine     = $FF66CDAA;
  aclMediumBlue           = $FF0000CD;
  aclMediumOrchid         = $FFBA55D3;
  aclMediumPurple         = $FF9370DB;
  aclMediumSeaGreen       = $FF3CB371;
  aclMediumSlateBlue      = $FF7B68EE;
  aclMediumSpringGreen    = $FF00FA9A;
  aclMediumTurquoise      = $FF48D1CC;
  aclMediumVioletRed      = $FFC71585;
  aclMidnightBlue         = $FF191970;
  aclMintCream            = $FFF5FFFA;
  aclMistyRose            = $FFFFE4E1;
  aclMoccasin             = $FFFFE4B5;
  aclNavajoWhite          = $FFFFDEAD;
  aclNavy                 = $FF000080;
  aclOldLace              = $FFFDF5E6;
  aclOlive                = $FF808000;
  aclOliveDrab            = $FF6B8E23;
  aclOrange               = $FFFFA500;
  aclOrangeRed            = $FFFF4500;
  aclOrchid               = $FFDA70D6;
  aclPaleGoldenrod        = $FFEEE8AA;
  aclPaleGreen            = $FF98FB98;
  aclPaleTurquoise        = $FFAFEEEE;
  aclPaleVioletRed        = $FFDB7093;
  aclPapayaWhip           = $FFFFEFD5;
  aclPeachPuff            = $FFFFDAB9;
  aclPeru                 = $FFCD853F;
  aclPink                 = $FFFFC0CB;
  aclPlum                 = $FFDDA0DD;
  aclPowderBlue           = $FFB0E0E6;
  aclPurple               = $FF800080;
  aclRed                  = $FFFF0000;
  aclRosyBrown            = $FFBC8F8F;
  aclRoyalBlue            = $FF4169E1;
  aclSaddleBrown          = $FF8B4513;
  aclSalmon               = $FFFA8072;
  aclSandyBrown           = $FFF4A460;
  aclSeaGreen             = $FF2E8B57;
  aclSeaShell             = $FFFFF5EE;
  aclSienna               = $FFA0522D;
  aclSilver               = $FFC0C0C0;
  aclSkyBlue              = $FF87CEEB;
  aclSlateBlue            = $FF6A5ACD;
  aclSlateGray            = $FF708090;
  aclSnow                 = $FFFFFAFA;
  aclSpringGreen          = $FF00FF7F;
  aclSteelBlue            = $FF4682B4;
  aclTan                  = $FFD2B48C;
  aclTeal                 = $FF008080;
  aclThistle              = $FFD8BFD8;
  aclTomato               = $FFFF6347;
  aclTransparent          = $00FFFFFF;
  aclTurquoise            = $FF40E0D0;
  aclViolet               = $FFEE82EE;
  aclWheat                = $FFF5DEB3;
  aclWhite                = $FFFFFFFF;
  aclWhiteSmoke           = $FFF5F5F5;
  aclYellow               = $FFFFFF00;
  aclYellowGreen          = $FF9ACD32;

  // Shift count and bit mask for A, R, G, B components
  AlphaShift  = 24;
  RedShift    = 16;
  GreenShift  = 8;
  BlueShift   = 0;
  AlphaMask   = $ff000000;
  RedMask     = $00ff0000;
  GreenMask   = $0000ff00;
  BlueMask    = $000000ff;

  GDIP_EMFPLUSFLAGS_DISPLAY      = $00000001;

  ImageFormatUndefined : TGUID = '{b96b3ca9-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatMemoryBMP : TGUID = '{b96b3caa-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatBMP       : TGUID = '{b96b3cab-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatEMF       : TGUID = '{b96b3cac-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatWMF       : TGUID = '{b96b3cad-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatJPEG      : TGUID = '{b96b3cae-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatPNG       : TGUID = '{b96b3caf-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatGIF       : TGUID = '{b96b3cb0-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatTIFF      : TGUID = '{b96b3cb1-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatEXIF      : TGUID = '{b96b3cb2-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatIcon      : TGUID = '{b96b3cb5-0728-11d3-9d7b-0000f81ef32e}';
  FrameDimensionTime       : TGUID = '{6aedbd6d-3fb5-418a-83a6-7f45229dc872}';
  FrameDimensionResolution : TGUID = '{84236f7b-3bd3-428f-8dab-4ea1439ca315}';
  FrameDimensionPage       : TGUID = '{7462dc86-6180-4c7e-8e3f-ee7333a7a483}';
  FormatIDImageInformation : TGUID = '{e5836cbe-5eef-4f1d-acde-ae4c43b608ce}';
  FormatIDJpegAppHeaders   : TGUID = '{1c4afdcd-6177-43cf-abc7-5f51af39ee85}';
  EncoderCompression      : TGUID = '{e09d739d-ccd4-44ee-8eba-3fbf8be4fc58}';
  EncoderColorDepth       : TGUID = '{66087055-ad66-4c7c-9a18-38a2310b8337}';
  EncoderScanMethod       : TGUID = '{3a4e2661-3109-4e56-8536-42c156e7dcfa}';
  EncoderVersion          : TGUID = '{24d18c76-814a-41a4-bf53-1c219cccf797}';
  EncoderRenderMethod     : TGUID = '{6d42c53a-229a-4825-8bb7-5c99e2b9a8b8}';
  EncoderQuality          : TGUID = '{1d5be4b5-fa4a-452d-9cdd-5db35105e7eb}';
  EncoderTransformation   : TGUID = '{8d0eb2d1-a58e-4ea8-aa14-108074b7b6f9}';
  EncoderLuminanceTable   : TGUID = '{edb33bce-0266-4a77-b904-27216099e717}';
  EncoderChrominanceTable : TGUID = '{f2e455dc-09b3-4316-8260-676ada32481c}';
  EncoderSaveFlag         : TGUID = '{292266fc-ac40-47bf-8cfc-a85b89a655de}';
  CodecIImageBytes : TGUID = '{025d1823-6c7d-447b-bbdb-a3cbc3dfa2fc}';

  ImageLockModeRead         = $0001;
  ImageLockModeWrite        = $0002;
  ImageLockModeUserInputBuf = $0004;
  
  PropertyTagTypeByte      : Integer =  1;
  PropertyTagTypeASCII     : Integer =  2;
  PropertyTagTypeShort     : Integer =  3;
  PropertyTagTypeLong      : Integer =  4;
  PropertyTagTypeRational  : Integer =  5;
  PropertyTagTypeUndefined : Integer =  7;
  PropertyTagTypeSLONG     : Integer =  9;
  PropertyTagTypeSRational : Integer = 10;

  PropertyTagExifIFD            = $8769;
  PropertyTagGpsIFD             = $8825;
  PropertyTagNewSubfileType     = $00FE;
  PropertyTagSubfileType        = $00FF;
  PropertyTagImageWidth         = $0100;
  PropertyTagImageHeight        = $0101;
  PropertyTagBitsPerSample      = $0102;
  PropertyTagCompression        = $0103;
  PropertyTagPhotometricInterp  = $0106;
  PropertyTagThreshHolding      = $0107;
  PropertyTagCellWidth          = $0108;
  PropertyTagCellHeight         = $0109;
  PropertyTagFillOrder          = $010A;
  PropertyTagDocumentName       = $010D;
  PropertyTagImageDescription   = $010E;
  PropertyTagEquipMake          = $010F;
  PropertyTagEquipModel         = $0110;
  PropertyTagStripOffsets       = $0111;
  PropertyTagOrientation        = $0112;
  PropertyTagSamplesPerPixel    = $0115;
  PropertyTagRowsPerStrip       = $0116;
  PropertyTagStripBytesCount    = $0117;
  PropertyTagMinSampleValue     = $0118;
  PropertyTagMaxSampleValue     = $0119;
  PropertyTagXResolution        = $011A;   // Image resolution in width direction
  PropertyTagYResolution        = $011B;   // Image resolution in height direction
  PropertyTagPlanarConfig       = $011C;   // Image data arrangement
  PropertyTagPageName           = $011D;
  PropertyTagXPosition          = $011E;
  PropertyTagYPosition          = $011F;
  PropertyTagFreeOffset         = $0120;
  PropertyTagFreeByteCounts     = $0121;
  PropertyTagGrayResponseUnit   = $0122;
  PropertyTagGrayResponseCurve  = $0123;
  PropertyTagT4Option           = $0124;
  PropertyTagT6Option           = $0125;
  PropertyTagResolutionUnit     = $0128;   // Unit of X and Y resolution
  PropertyTagPageNumber         = $0129;
  PropertyTagTransferFuncition  = $012D;
  PropertyTagSoftwareUsed       = $0131;
  PropertyTagDateTime           = $0132;
  PropertyTagArtist             = $013B;
  PropertyTagHostComputer       = $013C;
  PropertyTagPredictor          = $013D;
  PropertyTagWhitePoint         = $013E;
  PropertyTagPrimaryChromaticities = $013F;
  PropertyTagColorMap           = $0140;
  PropertyTagHalftoneHints      = $0141;
  PropertyTagTileWidth          = $0142;
  PropertyTagTileLength         = $0143;
  PropertyTagTileOffset         = $0144;
  PropertyTagTileByteCounts     = $0145;
  PropertyTagInkSet             = $014C;
  PropertyTagInkNames           = $014D;
  PropertyTagNumberOfInks       = $014E;
  PropertyTagDotRange           = $0150;
  PropertyTagTargetPrinter      = $0151;
  PropertyTagExtraSamples       = $0152;
  PropertyTagSampleFormat       = $0153;
  PropertyTagSMinSampleValue    = $0154;
  PropertyTagSMaxSampleValue    = $0155;
  PropertyTagTransferRange      = $0156;
  PropertyTagJPEGProc               = $0200;
  PropertyTagJPEGInterFormat        = $0201;
  PropertyTagJPEGInterLength        = $0202;
  PropertyTagJPEGRestartInterval    = $0203;
  PropertyTagJPEGLosslessPredictors = $0205;
  PropertyTagJPEGPointTransforms    = $0206;
  PropertyTagJPEGQTables            = $0207;
  PropertyTagJPEGDCTables           = $0208;
  PropertyTagJPEGACTables           = $0209;
  PropertyTagYCbCrCoefficients  = $0211;
  PropertyTagYCbCrSubsampling   = $0212;
  PropertyTagYCbCrPositioning   = $0213;
  PropertyTagREFBlackWhite      = $0214;
  PropertyTagICCProfile         = $8773;   // This TAG is defined by ICC
  PropertyTagGamma                = $0301;
  PropertyTagICCProfileDescriptor = $0302;
  PropertyTagSRGBRenderingIntent  = $0303;
  PropertyTagImageTitle         = $0320;
  PropertyTagCopyright          = $8298;
  PropertyTagResolutionXUnit           = $5001;
  PropertyTagResolutionYUnit           = $5002;
  PropertyTagResolutionXLengthUnit     = $5003;
  PropertyTagResolutionYLengthUnit     = $5004;
  PropertyTagPrintFlags                = $5005;
  PropertyTagPrintFlagsVersion         = $5006;
  PropertyTagPrintFlagsCrop            = $5007;
  PropertyTagPrintFlagsBleedWidth      = $5008;
  PropertyTagPrintFlagsBleedWidthScale = $5009;
  PropertyTagHalftoneLPI               = $500A;
  PropertyTagHalftoneLPIUnit           = $500B;
  PropertyTagHalftoneDegree            = $500C;
  PropertyTagHalftoneShape             = $500D;
  PropertyTagHalftoneMisc              = $500E;
  PropertyTagHalftoneScreen            = $500F;
  PropertyTagJPEGQuality               = $5010;
  PropertyTagGridSize                  = $5011;
  PropertyTagThumbnailFormat           = $5012;  // 1 = JPEG, 0 = RAW RGB
  PropertyTagThumbnailWidth            = $5013;
  PropertyTagThumbnailHeight           = $5014;
  PropertyTagThumbnailColorDepth       = $5015;
  PropertyTagThumbnailPlanes           = $5016;
  PropertyTagThumbnailRawBytes         = $5017;
  PropertyTagThumbnailSize             = $5018;
  PropertyTagThumbnailCompressedSize   = $5019;
  PropertyTagColorTransferFunction     = $501A;
  PropertyTagThumbnailData             = $501B;    // RAW thumbnail bits in
  PropertyTagThumbnailImageWidth        = $5020;   // Thumbnail width
  PropertyTagThumbnailImageHeight       = $5021;   // Thumbnail height
  PropertyTagThumbnailBitsPerSample     = $5022;   // Number of bits per
  PropertyTagThumbnailCompression       = $5023;   // Compression Scheme
  PropertyTagThumbnailPhotometricInterp = $5024;   // Pixel composition
  PropertyTagThumbnailImageDescription  = $5025;   // Image Tile
  PropertyTagThumbnailEquipMake         = $5026;   // Manufacturer of Image Input equipment
  PropertyTagThumbnailEquipModel        = $5027;   // Model of Image input equipment
  PropertyTagThumbnailStripOffsets    = $5028;  // Image data location
  PropertyTagThumbnailOrientation     = $5029;  // Orientation of image
  PropertyTagThumbnailSamplesPerPixel = $502A;  // Number of components
  PropertyTagThumbnailRowsPerStrip    = $502B;  // Number of rows per strip
  PropertyTagThumbnailStripBytesCount = $502C;  // Bytes per compressed strip
  PropertyTagThumbnailResolutionX     = $502D;  // Resolution in width direction
  PropertyTagThumbnailResolutionY     = $502E;  // Resolution in height direction
  PropertyTagThumbnailPlanarConfig    = $502F;  // Image data arrangement
  PropertyTagThumbnailResolutionUnit  = $5030;  // Unit of X and Y Resolution
  PropertyTagThumbnailTransferFunction = $5031;  // Transfer function
  PropertyTagThumbnailSoftwareUsed     = $5032;  // Software used
  PropertyTagThumbnailDateTime         = $5033;  // File change date and time
  PropertyTagThumbnailArtist          = $5034;  // Person who created the image
  PropertyTagThumbnailWhitePoint      = $5035;  // White point chromaticity
  PropertyTagThumbnailPrimaryChromaticities = $5036; // Chromaticities of primaries
  PropertyTagThumbnailYCbCrCoefficients = $5037; // Color space transformation coefficients
  PropertyTagThumbnailYCbCrSubsampling = $5038;  // Subsampling ratio of Y to C
  PropertyTagThumbnailYCbCrPositioning = $5039;  // Y and C position
  PropertyTagThumbnailRefBlackWhite    = $503A;  // Pair of black and white reference values
  PropertyTagThumbnailCopyRight       = $503B;   // CopyRight holder
  PropertyTagLuminanceTable           = $5090;
  PropertyTagChrominanceTable         = $5091;
  PropertyTagFrameDelay               = $5100;
  PropertyTagLoopCount                = $5101;
  PropertyTagPixelUnit         = $5110;  // Unit specifier for pixel/unit
  PropertyTagPixelPerUnitX     = $5111;  // Pixels per unit in X
  PropertyTagPixelPerUnitY     = $5112;  // Pixels per unit in Y
  PropertyTagPaletteHistogram  = $5113;  // Palette histogram
  PropertyTagExifExposureTime  = $829A;
  PropertyTagExifFNumber       = $829D;
  PropertyTagExifExposureProg  = $8822;
  PropertyTagExifSpectralSense = $8824;
  PropertyTagExifISOSpeed      = $8827;
  PropertyTagExifOECF          = $8828;
  PropertyTagExifVer           = $9000;
  PropertyTagExifDTOrig        = $9003; // Date & time of original
  PropertyTagExifDTDigitized   = $9004; // Date & time of digital data generation
  PropertyTagExifCompConfig    = $9101;
  PropertyTagExifCompBPP       = $9102;
  PropertyTagExifShutterSpeed  = $9201;
  PropertyTagExifAperture      = $9202;
  PropertyTagExifBrightness    = $9203;
  PropertyTagExifExposureBias  = $9204;
  PropertyTagExifMaxAperture   = $9205;
  PropertyTagExifSubjectDist   = $9206;
  PropertyTagExifMeteringMode  = $9207;
  PropertyTagExifLightSource   = $9208;
  PropertyTagExifFlash         = $9209;
  PropertyTagExifFocalLength   = $920A;
  PropertyTagExifMakerNote     = $927C;
  PropertyTagExifUserComment   = $9286;
  PropertyTagExifDTSubsec      = $9290;  // Date & Time subseconds
  PropertyTagExifDTOrigSS      = $9291;  // Date & Time original subseconds
  PropertyTagExifDTDigSS       = $9292;  // Date & TIme digitized subseconds
  PropertyTagExifFPXVer        = $A000;
  PropertyTagExifColorSpace    = $A001;
  PropertyTagExifPixXDim       = $A002;
  PropertyTagExifPixYDim       = $A003;
  PropertyTagExifRelatedWav    = $A004;  // related sound file
  PropertyTagExifInterop       = $A005;
  PropertyTagExifFlashEnergy   = $A20B;
  PropertyTagExifSpatialFR     = $A20C;  // Spatial Frequency Response
  PropertyTagExifFocalXRes     = $A20E;  // Focal Plane X Resolution
  PropertyTagExifFocalYRes     = $A20F;  // Focal Plane Y Resolution
  PropertyTagExifFocalResUnit  = $A210;  // Focal Plane Resolution Unit
  PropertyTagExifSubjectLoc    = $A214;
  PropertyTagExifExposureIndex = $A215;
  PropertyTagExifSensingMethod = $A217;
  PropertyTagExifFileSource    = $A300;
  PropertyTagExifSceneType     = $A301;
  PropertyTagExifCfaPattern    = $A302;
  PropertyTagGpsVer            = $0000;
  PropertyTagGpsLatitudeRef    = $0001;
  PropertyTagGpsLatitude       = $0002;
  PropertyTagGpsLongitudeRef   = $0003;
  PropertyTagGpsLongitude      = $0004;
  PropertyTagGpsAltitudeRef    = $0005;
  PropertyTagGpsAltitude       = $0006;
  PropertyTagGpsGpsTime        = $0007;
  PropertyTagGpsGpsSatellites  = $0008;
  PropertyTagGpsGpsStatus      = $0009;
  PropertyTagGpsGpsMeasureMode = $00A;
  PropertyTagGpsGpsDop         = $000B;  // Measurement precision
  PropertyTagGpsSpeedRef       = $000C;
  PropertyTagGpsSpeed          = $000D;
  PropertyTagGpsTrackRef       = $000E;
  PropertyTagGpsTrack          = $000F;
  PropertyTagGpsImgDirRef      = $0010;
  PropertyTagGpsImgDir         = $0011;
  PropertyTagGpsMapDatum       = $0012;
  PropertyTagGpsDestLatRef     = $0013;
  PropertyTagGpsDestLat        = $0014;
  PropertyTagGpsDestLongRef    = $0015;
  PropertyTagGpsDestLong       = $0016;
  PropertyTagGpsDestBearRef    = $0017;
  PropertyTagGpsDestBear       = $0018;
  PropertyTagGpsDestDistRef    = $0019;
  PropertyTagGpsDestDist       = $001A;

type
  EmfPlusRecordType = (
    WmfRecordTypeSetBkColor              = (META_SETBKCOLOR or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetBkMode               = (META_SETBKMODE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetMapMode              = (META_SETMAPMODE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetROP2                 = (META_SETROP2 or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetRelAbs               = (META_SETRELABS or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetPolyFillMode         = (META_SETPOLYFILLMODE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetStretchBltMode       = (META_SETSTRETCHBLTMODE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetTextCharExtra        = (META_SETTEXTCHAREXTRA or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetTextColor            = (META_SETTEXTCOLOR or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetTextJustification    = (META_SETTEXTJUSTIFICATION or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetWindowOrg            = (META_SETWINDOWORG or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetWindowExt            = (META_SETWINDOWEXT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetViewportOrg          = (META_SETVIEWPORTORG or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetViewportExt          = (META_SETVIEWPORTEXT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeOffsetWindowOrg         = (META_OFFSETWINDOWORG or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeScaleWindowExt          = (META_SCALEWINDOWEXT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeOffsetViewportOrg       = (META_OFFSETVIEWPORTORG or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeScaleViewportExt        = (META_SCALEVIEWPORTEXT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeLineTo                  = (META_LINETO or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeMoveTo                  = (META_MOVETO or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeExcludeClipRect         = (META_EXCLUDECLIPRECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeIntersectClipRect       = (META_INTERSECTCLIPRECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeArc                     = (META_ARC or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeEllipse                 = (META_ELLIPSE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeFloodFill               = (META_FLOODFILL or GDIP_WMF_RECORD_BASE),
    WmfRecordTypePie                     = (META_PIE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeRectangle               = (META_RECTANGLE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeRoundRect               = (META_ROUNDRECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypePatBlt                  = (META_PATBLT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSaveDC                  = (META_SAVEDC or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetPixel                = (META_SETPIXEL or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeOffsetClipRgn           = (META_OFFSETCLIPRGN or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeTextOut                 = (META_TEXTOUT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeBitBlt                  = (META_BITBLT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeStretchBlt              = (META_STRETCHBLT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypePolygon                 = (META_POLYGON or GDIP_WMF_RECORD_BASE),
    WmfRecordTypePolyline                = (META_POLYLINE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeEscape                  = (META_ESCAPE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeRestoreDC               = (META_RESTOREDC or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeFillRegion              = (META_FILLREGION or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeFrameRegion             = (META_FRAMEREGION or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeInvertRegion            = (META_INVERTREGION or GDIP_WMF_RECORD_BASE),
    WmfRecordTypePaintRegion             = (META_PAINTREGION or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSelectClipRegion        = (META_SELECTCLIPREGION or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSelectObject            = (META_SELECTOBJECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetTextAlign            = (META_SETTEXTALIGN or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeDrawText                = ($062F or GDIP_WMF_RECORD_BASE),  // META_DRAWTEXT
    WmfRecordTypeChord                   = (META_CHORD or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetMapperFlags          = (META_SETMAPPERFLAGS or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeExtTextOut              = (META_EXTTEXTOUT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetDIBToDev             = (META_SETDIBTODEV or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSelectPalette           = (META_SELECTPALETTE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeRealizePalette          = (META_REALIZEPALETTE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeAnimatePalette          = (META_ANIMATEPALETTE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetPalEntries           = (META_SETPALENTRIES or GDIP_WMF_RECORD_BASE),
    WmfRecordTypePolyPolygon             = (META_POLYPOLYGON or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeResizePalette           = (META_RESIZEPALETTE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeDIBBitBlt               = (META_DIBBITBLT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeDIBStretchBlt           = (META_DIBSTRETCHBLT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeDIBCreatePatternBrush   = (META_DIBCREATEPATTERNBRUSH or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeStretchDIB              = (META_STRETCHDIB or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeExtFloodFill            = (META_EXTFLOODFILL or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeSetLayout               = ($0149 or GDIP_WMF_RECORD_BASE),  // META_SETLAYOUT
    WmfRecordTypeResetDC                 = ($014C or GDIP_WMF_RECORD_BASE),  // META_RESETDC
    WmfRecordTypeStartDoc                = ($014D or GDIP_WMF_RECORD_BASE),  // META_STARTDOC
    WmfRecordTypeStartPage               = ($004F or GDIP_WMF_RECORD_BASE),  // META_STARTPAGE
    WmfRecordTypeEndPage                 = ($0050 or GDIP_WMF_RECORD_BASE),  // META_ENDPAGE
    WmfRecordTypeAbortDoc                = ($0052 or GDIP_WMF_RECORD_BASE),  // META_ABORTDOC
    WmfRecordTypeEndDoc                  = ($005E or GDIP_WMF_RECORD_BASE),  // META_ENDDOC
    WmfRecordTypeDeleteObject            = (META_DELETEOBJECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeCreatePalette           = (META_CREATEPALETTE or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeCreateBrush             = ($00F8 or GDIP_WMF_RECORD_BASE),  // META_CREATEBRUSH
    WmfRecordTypeCreatePatternBrush      = (META_CREATEPATTERNBRUSH or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeCreatePenIndirect       = (META_CREATEPENINDIRECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeCreateFontIndirect      = (META_CREATEFONTINDIRECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeCreateBrushIndirect     = (META_CREATEBRUSHINDIRECT or GDIP_WMF_RECORD_BASE),
    WmfRecordTypeCreateBitmapIndirect    = ($02FD or GDIP_WMF_RECORD_BASE),  // META_CREATEBITMAPINDIRECT
    WmfRecordTypeCreateBitmap            = ($06FE or GDIP_WMF_RECORD_BASE),  // META_CREATEBITMAP
    WmfRecordTypeCreateRegion            = (META_CREATEREGION or GDIP_WMF_RECORD_BASE),
    EmfRecordTypeHeader                  = EMR_HEADER,
    EmfRecordTypePolyBezier              = EMR_POLYBEZIER,
    EmfRecordTypePolygon                 = EMR_POLYGON,
    EmfRecordTypePolyline                = EMR_POLYLINE,
    EmfRecordTypePolyBezierTo            = EMR_POLYBEZIERTO,
    EmfRecordTypePolyLineTo              = EMR_POLYLINETO,
    EmfRecordTypePolyPolyline            = EMR_POLYPOLYLINE,
    EmfRecordTypePolyPolygon             = EMR_POLYPOLYGON,
    EmfRecordTypeSetWindowExtEx          = EMR_SETWINDOWEXTEX,
    EmfRecordTypeSetWindowOrgEx          = EMR_SETWINDOWORGEX,
    EmfRecordTypeSetViewportExtEx        = EMR_SETVIEWPORTEXTEX,
    EmfRecordTypeSetViewportOrgEx        = EMR_SETVIEWPORTORGEX,
    EmfRecordTypeSetBrushOrgEx           = EMR_SETBRUSHORGEX,
    EmfRecordTypeEOF                     = EMR_EOF,
    EmfRecordTypeSetPixelV               = EMR_SETPIXELV,
    EmfRecordTypeSetMapperFlags          = EMR_SETMAPPERFLAGS,
    EmfRecordTypeSetMapMode              = EMR_SETMAPMODE,
    EmfRecordTypeSetBkMode               = EMR_SETBKMODE,
    EmfRecordTypeSetPolyFillMode         = EMR_SETPOLYFILLMODE,
    EmfRecordTypeSetROP2                 = EMR_SETROP2,
    EmfRecordTypeSetStretchBltMode       = EMR_SETSTRETCHBLTMODE,
    EmfRecordTypeSetTextAlign            = EMR_SETTEXTALIGN,
    EmfRecordTypeSetColorAdjustment      = EMR_SETCOLORADJUSTMENT,
    EmfRecordTypeSetTextColor            = EMR_SETTEXTCOLOR,
    EmfRecordTypeSetBkColor              = EMR_SETBKCOLOR,
    EmfRecordTypeOffsetClipRgn           = EMR_OFFSETCLIPRGN,
    EmfRecordTypeMoveToEx                = EMR_MOVETOEX,
    EmfRecordTypeSetMetaRgn              = EMR_SETMETARGN,
    EmfRecordTypeExcludeClipRect         = EMR_EXCLUDECLIPRECT,
    EmfRecordTypeIntersectClipRect       = EMR_INTERSECTCLIPRECT,
    EmfRecordTypeScaleViewportExtEx      = EMR_SCALEVIEWPORTEXTEX,
    EmfRecordTypeScaleWindowExtEx        = EMR_SCALEWINDOWEXTEX,
    EmfRecordTypeSaveDC                  = EMR_SAVEDC,
    EmfRecordTypeRestoreDC               = EMR_RESTOREDC,
    EmfRecordTypeSetWorldTransform       = EMR_SETWORLDTRANSFORM,
    EmfRecordTypeModifyWorldTransform    = EMR_MODIFYWORLDTRANSFORM,
    EmfRecordTypeSelectObject            = EMR_SELECTOBJECT,
    EmfRecordTypeCreatePen               = EMR_CREATEPEN,
    EmfRecordTypeCreateBrushIndirect     = EMR_CREATEBRUSHINDIRECT,
    EmfRecordTypeDeleteObject            = EMR_DELETEOBJECT,
    EmfRecordTypeAngleArc                = EMR_ANGLEARC,
    EmfRecordTypeEllipse                 = EMR_ELLIPSE,
    EmfRecordTypeRectangle               = EMR_RECTANGLE,
    EmfRecordTypeRoundRect               = EMR_ROUNDRECT,
    EmfRecordTypeArc                     = EMR_ARC,
    EmfRecordTypeChord                   = EMR_CHORD,
    EmfRecordTypePie                     = EMR_PIE,
    EmfRecordTypeSelectPalette           = EMR_SELECTPALETTE,
    EmfRecordTypeCreatePalette           = EMR_CREATEPALETTE,
    EmfRecordTypeSetPaletteEntries       = EMR_SETPALETTEENTRIES,
    EmfRecordTypeResizePalette           = EMR_RESIZEPALETTE,
    EmfRecordTypeRealizePalette          = EMR_REALIZEPALETTE,
    EmfRecordTypeExtFloodFill            = EMR_EXTFLOODFILL,
    EmfRecordTypeLineTo                  = EMR_LINETO,
    EmfRecordTypeArcTo                   = EMR_ARCTO,
    EmfRecordTypePolyDraw                = EMR_POLYDRAW,
    EmfRecordTypeSetArcDirection         = EMR_SETARCDIRECTION,
    EmfRecordTypeSetMiterLimit           = EMR_SETMITERLIMIT,
    EmfRecordTypeBeginPath               = EMR_BEGINPATH,
    EmfRecordTypeEndPath                 = EMR_ENDPATH,
    EmfRecordTypeCloseFigure             = EMR_CLOSEFIGURE,
    EmfRecordTypeFillPath                = EMR_FILLPATH,
    EmfRecordTypeStrokeAndFillPath       = EMR_STROKEANDFILLPATH,
    EmfRecordTypeStrokePath              = EMR_STROKEPATH,
    EmfRecordTypeFlattenPath             = EMR_FLATTENPATH,
    EmfRecordTypeWidenPath               = EMR_WIDENPATH,
    EmfRecordTypeSelectClipPath          = EMR_SELECTCLIPPATH,
    EmfRecordTypeAbortPath               = EMR_ABORTPATH,
    EmfRecordTypeReserved_069            = 69,  // Not Used
    EmfRecordTypeGdiComment              = EMR_GDICOMMENT,
    EmfRecordTypeFillRgn                 = EMR_FILLRGN,
    EmfRecordTypeFrameRgn                = EMR_FRAMERGN,
    EmfRecordTypeInvertRgn               = EMR_INVERTRGN,
    EmfRecordTypePaintRgn                = EMR_PAINTRGN,
    EmfRecordTypeExtSelectClipRgn        = EMR_EXTSELECTCLIPRGN,
    EmfRecordTypeBitBlt                  = EMR_BITBLT,
    EmfRecordTypeStretchBlt              = EMR_STRETCHBLT,
    EmfRecordTypeMaskBlt                 = EMR_MASKBLT,
    EmfRecordTypePlgBlt                  = EMR_PLGBLT,
    EmfRecordTypeSetDIBitsToDevice       = EMR_SETDIBITSTODEVICE,
    EmfRecordTypeStretchDIBits           = EMR_STRETCHDIBITS,
    EmfRecordTypeExtCreateFontIndirect   = EMR_EXTCREATEFONTINDIRECTW,
    EmfRecordTypeExtTextOutA             = EMR_EXTTEXTOUTA,
    EmfRecordTypeExtTextOutW             = EMR_EXTTEXTOUTW,
    EmfRecordTypePolyBezier16            = EMR_POLYBEZIER16,
    EmfRecordTypePolygon16               = EMR_POLYGON16,
    EmfRecordTypePolyline16              = EMR_POLYLINE16,
    EmfRecordTypePolyBezierTo16          = EMR_POLYBEZIERTO16,
    EmfRecordTypePolylineTo16            = EMR_POLYLINETO16,
    EmfRecordTypePolyPolyline16          = EMR_POLYPOLYLINE16,
    EmfRecordTypePolyPolygon16           = EMR_POLYPOLYGON16,
    EmfRecordTypePolyDraw16              = EMR_POLYDRAW16,
    EmfRecordTypeCreateMonoBrush         = EMR_CREATEMONOBRUSH,
    EmfRecordTypeCreateDIBPatternBrushPt = EMR_CREATEDIBPATTERNBRUSHPT,
    EmfRecordTypeExtCreatePen            = EMR_EXTCREATEPEN,
    EmfRecordTypePolyTextOutA            = EMR_POLYTEXTOUTA,
    EmfRecordTypePolyTextOutW            = EMR_POLYTEXTOUTW,
    EmfRecordTypeSetICMMode              = 98,  // EMR_SETICMMODE,
    EmfRecordTypeCreateColorSpace        = 99,  // EMR_CREATECOLORSPACE,
    EmfRecordTypeSetColorSpace           = 100, // EMR_SETCOLORSPACE,
    EmfRecordTypeDeleteColorSpace        = 101, // EMR_DELETECOLORSPACE,
    EmfRecordTypeGLSRecord               = 102, // EMR_GLSRECORD,
    EmfRecordTypeGLSBoundedRecord        = 103, // EMR_GLSBOUNDEDRECORD,
    EmfRecordTypePixelFormat             = 104, // EMR_PIXELFORMAT,
    EmfRecordTypeDrawEscape              = 105, // EMR_RESERVED_105,
    EmfRecordTypeExtEscape               = 106, // EMR_RESERVED_106,
    EmfRecordTypeStartDoc                = 107, // EMR_RESERVED_107,
    EmfRecordTypeSmallTextOut            = 108, // EMR_RESERVED_108,
    EmfRecordTypeForceUFIMapping         = 109, // EMR_RESERVED_109,
    EmfRecordTypeNamedEscape             = 110, // EMR_RESERVED_110,
    EmfRecordTypeColorCorrectPalette     = 111, // EMR_COLORCORRECTPALETTE,
    EmfRecordTypeSetICMProfileA          = 112, // EMR_SETICMPROFILEA,
    EmfRecordTypeSetICMProfileW          = 113, // EMR_SETICMPROFILEW,
    EmfRecordTypeAlphaBlend              = 114, // EMR_ALPHABLEND,
    EmfRecordTypeSetLayout               = 115, // EMR_SETLAYOUT,
    EmfRecordTypeTransparentBlt          = 116, // EMR_TRANSPARENTBLT,
    EmfRecordTypeReserved_117            = 117, // Not Used
    EmfRecordTypeGradientFill            = 118, // EMR_GRADIENTFILL,
    EmfRecordTypeSetLinkedUFIs           = 119, // EMR_RESERVED_119,
    EmfRecordTypeSetTextJustification    = 120, // EMR_RESERVED_120,
    EmfRecordTypeColorMatchToTargetW     = 121, // EMR_COLORMATCHTOTARGETW,
    EmfRecordTypeCreateColorSpaceW       = 122, // EMR_CREATECOLORSPACEW,
    EmfRecordTypeMax                     = 122,
    EmfRecordTypeMin                     = 1,
    EmfPlusRecordTypeInvalid = GDIP_EMFPLUS_RECORD_BASE,
    EmfPlusRecordTypeHeader,
    EmfPlusRecordTypeEndOfFile,
    EmfPlusRecordTypeComment,
    EmfPlusRecordTypeGetDC,
    EmfPlusRecordTypeMultiFormatStart,
    EmfPlusRecordTypeMultiFormatSection,
    EmfPlusRecordTypeMultiFormatEnd,
    EmfPlusRecordTypeObject,
    EmfPlusRecordTypeClear,
    EmfPlusRecordTypeFillRects,
    EmfPlusRecordTypeDrawRects,
    EmfPlusRecordTypeFillPolygon,
    EmfPlusRecordTypeDrawLines,
    EmfPlusRecordTypeFillEllipse,
    EmfPlusRecordTypeDrawEllipse,
    EmfPlusRecordTypeFillPie,
    EmfPlusRecordTypeDrawPie,
    EmfPlusRecordTypeDrawArc,
    EmfPlusRecordTypeFillRegion,
    EmfPlusRecordTypeFillPath,
    EmfPlusRecordTypeDrawPath,
    EmfPlusRecordTypeFillClosedCurve,
    EmfPlusRecordTypeDrawClosedCurve,
    EmfPlusRecordTypeDrawCurve,
    EmfPlusRecordTypeDrawBeziers,
    EmfPlusRecordTypeDrawImage,
    EmfPlusRecordTypeDrawImagePoints,
    EmfPlusRecordTypeDrawString,
    EmfPlusRecordTypeSetRenderingOrigin,
    EmfPlusRecordTypeSetAntiAliasMode,
    EmfPlusRecordTypeSetTextRenderingHint,
    EmfPlusRecordTypeSetTextContrast,
    EmfPlusRecordTypeSetInterpolationMode,
    EmfPlusRecordTypeSetPixelOffsetMode,
    EmfPlusRecordTypeSetCompositingMode,
    EmfPlusRecordTypeSetCompositingQuality,
    EmfPlusRecordTypeSave,
    EmfPlusRecordTypeRestore,
    EmfPlusRecordTypeBeginContainer,
    EmfPlusRecordTypeBeginContainerNoParams,
    EmfPlusRecordTypeEndContainer,
    EmfPlusRecordTypeSetWorldTransform,
    EmfPlusRecordTypeResetWorldTransform,
    EmfPlusRecordTypeMultiplyWorldTransform,
    EmfPlusRecordTypeTranslateWorldTransform,
    EmfPlusRecordTypeScaleWorldTransform,
    EmfPlusRecordTypeRotateWorldTransform,
    EmfPlusRecordTypeSetPageTransform,
    EmfPlusRecordTypeResetClip,
    EmfPlusRecordTypeSetClipRect,
    EmfPlusRecordTypeSetClipPath,
    EmfPlusRecordTypeSetClipRegion,
    EmfPlusRecordTypeOffsetClip,
    EmfPlusRecordTypeDrawDriverString,
    EmfPlusRecordTotal,
    EmfPlusRecordTypeMax = EmfPlusRecordTotal-1,
    EmfPlusRecordTypeMin = EmfPlusRecordTypeHeader);
  TEmfPlusRecordType = EmfPlusRecordType;
  EnumerateMetafileProc  = function(recordType: EmfPlusRecordType; flags: UINT; dataSize: UINT; data: PBYTE; callbackData: pointer): BOOL; stdcall;

  function GdipAlloc(size: ULONG): pointer; stdcall;external WINGDIPDLL;
  procedure GdipFree(ptr: pointer); stdcall;external WINGDIPDLL;
  function GdiplusStartup(out token: THandle;const input: GdiplusStartupInput; output: PGdiplusStartupOutput): Status; stdcall;external WINGDIPDLL;
  procedure GdiplusShutdown(token: ULONG); stdcall;external WINGDIPDLL;
  function GdipCreatePath(brushMode: GPFILLMODE; out path: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreatePath2(const v1,v2; v3: Integer; v4: GPFILLMODE; out path: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreatePath2I(const v1,v2; v3: Integer; v4: GPFILLMODE; out path: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipClonePath(path: THandle; out clonePath: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDeletePath(path: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipResetPath(path: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPointCount(path: THandle; out count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathTypes(path: THandle; types: PBYTE; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathPoints(v1: THandle; points: GPPOINTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathPointsI(v1: THandle; points: GPPOINT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathFillMode(path: THandle; var fillmode: GPFILLMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPathFillMode(path: THandle; fillmode: GPFILLMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathData(path: THandle; pathData: Pointer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipStartPathFigure(path: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipClosePathFigure(path: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipClosePathFigures(path: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPathMarker(path: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipClearPathMarkers(path: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipReversePath(path: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathLastPoint(path: THandle; lastPoint: GPPOINTF): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathLine(path: THandle; x1, y1, x2, y2: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathLine2(path: THandle; points: GPPOINTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathArc(path: THandle; x, y, width, height, startAngle, sweepAngle: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathBezier(path: THandle; x1, y1, x2, y2, x3, y3, x4, y4: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathBeziers(path: THandle; points: GPPOINTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathCurve(path: THandle; points: GPPOINTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathCurve2(path: THandle; points: GPPOINTF; count: Integer; tension: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathCurve3(path: THandle; points: GPPOINTF; count: Integer; offset: Integer; numberOfSegments: Integer; tension: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathClosedCurve(path: THandle; points: GPPOINTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathClosedCurve2(path: THandle; points: GPPOINTF; count: Integer; tension: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathRectangle(path: THandle; x: Single; y: Single; width: Single; height: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathRectangles(path: THandle; rects: GPRECTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathEllipse(path: THandle;  x: Single; y: Single; width: Single; height: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathPie(path: THandle; x: Single; y: Single; width: Single; height: Single; startAngle: Single; sweepAngle: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathPolygon(path: THandle; points: GPPOINTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathPath(path: THandle; addingPath: THandle; connect: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathString(path: THandle; string_: PWCHAR; length: Integer; family: THandle; style: Integer; emSize: Single; layoutRect: PRECTF; format: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathStringI(path: THandle; string_: PWCHAR; length: Integer; family: THandle; style: Integer; emSize: Single; layoutRect: PRECT; format: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathLineI(path: THandle; x1: Integer; y1: Integer; x2: Integer; y2: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathLine2I(path: THandle; points: GPPOINT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathArcI(path: THandle; x: Integer; y: Integer; width: Integer; height: Integer; startAngle: Single; sweepAngle: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathBezierI(path: THandle; x1: Integer; y1: Integer; x2: Integer; y2: Integer; x3: Integer; y3: Integer; x4: Integer; y4: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathBeziersI(path: THandle; points: GPPOINT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathCurveI(path: THandle; points: GPPOINT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathCurve2I(path: THandle; points: GPPOINT; count: Integer; tension: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathCurve3I(path: THandle; points: GPPOINT; count: Integer; offset: Integer; numberOfSegments: Integer; tension: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathClosedCurveI(path: THandle; points: GPPOINT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathClosedCurve2I(path: THandle; points: GPPOINT; count: Integer; tension: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathRectangleI(path: THandle; x: Integer; y: Integer; width: Integer; height: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathRectanglesI(path: THandle; rects: GPRECT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathEllipseI(path: THandle; x: Integer; y: Integer; width: Integer; height: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathPieI(path: THandle; x: Integer; y: Integer; width: Integer; height: Integer; startAngle: Single; sweepAngle: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipAddPathPolygonI(path: THandle; points: GPPOINT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFlattenPath(path: THandle; matrix: THandle; flatness: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipWindingModeOutline(path: THandle; matrix: THandle; flatness: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipWidenPath(nativePath: THandle; pen: GPPEN; matrix: THandle; flatness: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipWarpPath(path: THandle; matrix: THandle; points: GPPOINTF; count: Integer; srcx: Single; srcy: Single; srcwidth: Single; srcheight: Single; warpMode: WARPMODE; flatness: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipTransformPath(path: THandle; matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathWorldBounds(path: THandle; bounds: GPRECTF; matrix: THandle; pen: GPPEN): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathWorldBoundsI(path: THandle; bounds: GPRECT; matrix: THandle; pen: GPPEN): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsVisiblePathPoint(path: THandle; x: Single; y: Single; graphics: THandle; out result: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsVisiblePathPointI(path: THandle; x: Integer; y: Integer; graphics: THandle; out result: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsOutlineVisiblePathPoint(path: THandle; x: Single; y: Single; pen: GPPEN; graphics: THandle; out result: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsOutlineVisiblePathPointI(path: THandle; x: Integer; y: Integer; pen: GPPEN; graphics: THandle; out result: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreatePathIter(out iterator: THandle; path: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDeletePathIter(iterator: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipPathIterNextSubpath(iterator: THandle; var resultCount: Integer; var startIndex: Integer; var endIndex: Integer; out isClosed: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipPathIterNextSubpathPath(iterator: THandle; var resultCount: Integer; path: THandle; out isClosed: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipPathIterNextPathType(iterator: THandle; var resultCount: Integer; pathType: PBYTE; var startIndex: Integer; var endIndex: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipPathIterNextMarker(iterator: THandle; var resultCount: Integer; var startIndex: Integer; var endIndex: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipPathIterNextMarkerPath(iterator: THandle; var resultCount: Integer; path: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipPathIterGetCount(iterator: THandle; out count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipPathIterGetSubpathCount(iterator: THandle; out count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipPathIterIsValid(iterator: THandle; out valid: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipPathIterHasCurve(iterator: THandle; out hasCurve: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipPathIterRewind(iterator: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipPathIterEnumerate(iterator: THandle; var resultCount: Integer; points: GPPOINTF; types: PBYTE; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipPathIterCopyData(iterator: THandle; var resultCount: Integer; points: GPPOINTF; types: PBYTE; startIndex: Integer; endIndex: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateMatrix(out matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateMatrix2(m11: Single; m12: Single; m21: Single; m22: Single; dx: Single; dy: Single; out matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateMatrix3(rect: GPRECTF; dstplg: GPPOINTF; out matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateMatrix3I(rect: GPRECT; dstplg: GPPOINT; out matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCloneMatrix(matrix: THandle; out cloneMatrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDeleteMatrix(matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetMatrixElements(matrix: THandle; m11: Single; m12: Single; m21: Single; m22: Single; dx: Single; dy: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipMultiplyMatrix(matrix: THandle; matrix2: THandle; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipTranslateMatrix(matrix: THandle; offsetX: Single; offsetY: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipScaleMatrix(matrix: THandle; scaleX: Single; scaleY: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipRotateMatrix(matrix: THandle; angle: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipShearMatrix(matrix: THandle; shearX: Single; shearY: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipInvertMatrix(matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipTransformMatrixPoints(matrix: THandle; pts: GPPOINTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipTransformMatrixPointsI(matrix: THandle; pts: GPPOINT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipVectorTransformMatrixPoints(matrix: THandle; pts: GPPOINTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipVectorTransformMatrixPointsI(matrix: THandle; pts: GPPOINT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetMatrixElements(matrix: THandle; matrixOut: PSingle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsMatrixInvertible(matrix: THandle; out result: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsMatrixIdentity(matrix: THandle; out result: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsMatrixEqual(matrix: THandle; matrix2: THandle; out result: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateRegion(out region: GPREGION): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateRegionRect(rect: GPRECTF; out region: GPREGION): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateRegionRectI(rect: GPRECT; out region: GPREGION): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateRegionPath(path: THandle; out region: GPREGION): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateRegionRgnData(regionData: PBYTE; size: Integer; out region: GPREGION): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateRegionHrgn(hRgn: HRGN; out region: GPREGION): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCloneRegion(region: GPREGION; out cloneRegion: GPREGION): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDeleteRegion(region: GPREGION): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetInfinite(region: GPREGION): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetEmpty(region: GPREGION): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCombineRegionRect(region: GPREGION; rect: GPRECTF; combineMode: COMBINEMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCombineRegionRectI(region: GPREGION; rect: GPRECT; combineMode: COMBINEMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCombineRegionPath(region: GPREGION; path: THandle; combineMode: COMBINEMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCombineRegionRegion(region: GPREGION; region2: GPREGION; combineMode: COMBINEMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipTranslateRegion(region: GPREGION; dx: Single; dy: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipTranslateRegionI(region: GPREGION; dx: Integer; dy: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipTransformRegion(region: GPREGION; matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetRegionBounds(region: GPREGION; graphics: THandle; rect: GPRECTF): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetRegionBoundsI(region: GPREGION; graphics: THandle; rect: GPRECT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetRegionHRgn(region: GPREGION; graphics: THandle; out hRgn: HRGN): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsEmptyRegion(region: GPREGION; graphics: THandle; out result: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsInfiniteRegion(region: GPREGION; graphics: THandle; out result: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsEqualRegion(region: GPREGION; region2: GPREGION; graphics: THandle; out result: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetRegionDataSize(region: GPREGION; out bufferSize: UINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetRegionData(region: GPREGION; buffer: PBYTE; bufferSize: UINT; sizeFilled: PUINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsVisibleRegionPoint(region: GPREGION; x: Single; y: Single; graphics: THandle; out result: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsVisibleRegionPointI(region: GPREGION; x: Integer; y: Integer; graphics: THandle; out result: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsVisibleRegionRect(region: GPREGION; x: Single; y: Single; width: Single; height: Single; graphics: THandle; out result: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsVisibleRegionRectI(region: GPREGION; x: Integer; y: Integer; width: Integer; height: Integer; graphics: THandle; out result: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetRegionScansCount(region: GPREGION; out count: UINT; matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetRegionScans(region: GPREGION; rects: GPRECTF; out count: Integer; matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetRegionScansI(region: GPREGION; rects: GPRECT; out count: Integer; matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCloneBrush(brush: THandle; out cloneBrush: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDeleteBrush(brush: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetBrushType(brush: THandle; out type_: LONGINTTYPE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateHatchBrush(hatchstyle: Integer; forecol: ARGB; backcol: ARGB; out brush: GPHATCH): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetHatchStyle(brush: GPHATCH; out hatchstyle: GPHATCHSTYLE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetHatchForegroundColor(brush: GPHATCH; out forecol: ARGB): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetHatchBackgroundColor(brush: GPHATCH; out backcol: ARGB): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateTexture(image: GPIMAGE; wrapmode: GPWRAPMODE; var texture: GPTEXTURE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateTexture2(image: GPIMAGE; wrapmode: GPWRAPMODE; x: Single; y: Single; width: Single; height: Single; out texture: GPTEXTURE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateTextureIA(image: GPIMAGE; imageAttributes: GPIMAGEATTRIBUTES; x: Single; y: Single; width: Single; height: Single; out texture: GPTEXTURE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateTexture2I(image: GPIMAGE; wrapmode: GPWRAPMODE; x: Integer; y: Integer; width: Integer; height: Integer; out texture: GPTEXTURE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateTextureIAI(image: GPIMAGE; imageAttributes: GPIMAGEATTRIBUTES; x: Integer; y: Integer; width: Integer; height: Integer; out texture: GPTEXTURE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetTextureTransform(brush: GPTEXTURE; matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetTextureTransform(brush: GPTEXTURE; matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipResetTextureTransform(brush: GPTEXTURE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipMultiplyTextureTransform(brush: GPTEXTURE; matrix: THandle; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipTranslateTextureTransform(brush: GPTEXTURE; dx: Single; dy: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipScaleTextureTransform(brush: GPTEXTURE; sx: Single; sy: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipRotateTextureTransform(brush: GPTEXTURE; angle: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetTextureWrapMode(brush: GPTEXTURE; wrapmode: GPWRAPMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetTextureWrapMode(brush: GPTEXTURE; var wrapmode: GPWRAPMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetTextureImage(brush: GPTEXTURE; out image: GPIMAGE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateSolidFill(color: ARGB; out brush: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetSolidFillColor(brush: THandle; color: ARGB): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetSolidFillColor(brush: THandle; out color: ARGB): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateLineBrush(point1: GPPOINTF; point2: GPPOINTF; color1: ARGB; color2: ARGB; wrapMode: GPWRAPMODE; out lineGradient: GPLINEGRADIENT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateLineBrushI(point1: GPPOINT; point2: GPPOINT; color1: ARGB; color2: ARGB; wrapMode: GPWRAPMODE; out lineGradient: GPLINEGRADIENT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateLineBrushFromRect(rect: GPRECTF; color1: ARGB; color2: ARGB; mode: LINEARGRADIENTMODE; wrapMode: GPWRAPMODE; out lineGradient: GPLINEGRADIENT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateLineBrushFromRectI(rect: GPRECT; color1: ARGB; color2: ARGB; mode: LINEARGRADIENTMODE; wrapMode: GPWRAPMODE; out lineGradient: GPLINEGRADIENT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateLineBrushFromRectWithAngle(rect: GPRECTF; color1: ARGB; color2: ARGB; angle: Single; isAngleScalable: Bool; wrapMode: GPWRAPMODE; out lineGradient: GPLINEGRADIENT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateLineBrushFromRectWithAngleI(rect: GPRECT; color1: ARGB; color2: ARGB; angle: Single; isAngleScalable: Bool; wrapMode: GPWRAPMODE; out lineGradient: GPLINEGRADIENT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetLineColors(brush: GPLINEGRADIENT; color1: ARGB; color2: ARGB): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetLineColors(brush: GPLINEGRADIENT; colors: PARGB): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetLineRect(brush: GPLINEGRADIENT; rect: GPRECTF): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetLineRectI(brush: GPLINEGRADIENT; rect: GPRECT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetLineGammaCorrection(brush: GPLINEGRADIENT; useGammaCorrection: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetLineGammaCorrection(brush: GPLINEGRADIENT; out useGammaCorrection: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetLineBlendCount(brush: GPLINEGRADIENT; out count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetLineBlend(brush: GPLINEGRADIENT; blend: PSingle; positions: PSingle; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetLineBlend(brush: GPLINEGRADIENT; blend: PSingle; positions: PSingle; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetLinePresetBlendCount(brush: GPLINEGRADIENT; out count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetLinePresetBlend(brush: GPLINEGRADIENT; blend: PARGB; positions: PSingle; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetLinePresetBlend(brush: GPLINEGRADIENT; blend: PARGB; positions: PSingle; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetLineSigmaBlend(brush: GPLINEGRADIENT; focus: Single; scale: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetLineLinearBlend(brush: GPLINEGRADIENT; focus: Single; scale: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetLineWrapMode(brush: GPLINEGRADIENT; wrapmode: GPWRAPMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetLineWrapMode(brush: GPLINEGRADIENT; out wrapmode: GPWRAPMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetLineTransform(brush: GPLINEGRADIENT; matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetLineTransform(brush: GPLINEGRADIENT; matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipResetLineTransform(brush: GPLINEGRADIENT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipMultiplyLineTransform(brush: GPLINEGRADIENT; matrix: THandle; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipTranslateLineTransform(brush: GPLINEGRADIENT; dx: Single; dy: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipScaleLineTransform(brush: GPLINEGRADIENT; sx: Single; sy: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipRotateLineTransform(brush: GPLINEGRADIENT; angle: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreatePathGradient(points: GPPOINTF; count: Integer; wrapMode: GPWRAPMODE; out polyGradient: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreatePathGradientI(points: GPPOINT; count: Integer; wrapMode: GPWRAPMODE; out polyGradient: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreatePathGradientFromPath(path: THandle; out polyGradient: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathGradientCenterColor(brush: THandle; out colors: ARGB): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPathGradientCenterColor(brush: THandle; colors: ARGB): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathGradientSurroundColorsWithCount(brush: THandle; color: PARGB; var count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPathGradientSurroundColorsWithCount(brush: THandle; color: PARGB; var count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathGradientPath(brush: THandle; path: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPathGradientPath(brush: THandle; path: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathGradientCenterPoint(brush: THandle; points: GPPOINTF): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathGradientCenterPointI(brush: THandle; points: GPPOINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPathGradientCenterPoint(brush: THandle; points: GPPOINTF): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPathGradientCenterPointI(brush: THandle; points: GPPOINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathGradientRect(brush: THandle; rect: GPRECTF): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathGradientRectI(brush: THandle; rect: GPRECT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathGradientPointCount(brush: THandle; var count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathGradientSurroundColorCount(brush: THandle; var count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPathGradientGammaCorrection(brush: THandle; useGammaCorrection: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathGradientGammaCorrection(brush: THandle; var useGammaCorrection: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathGradientBlendCount(brush: THandle; var count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathGradientBlend(brush: THandle; blend: PSingle; positions: PSingle; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPathGradientBlend(brush: THandle; blend: PSingle; positions: PSingle; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathGradientPresetBlendCount(brush: THandle; var count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathGradientPresetBlend(brush: THandle; blend: PARGB; positions: PSingle; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPathGradientPresetBlend(brush: THandle; blend: PARGB; positions: PSingle; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPathGradientSigmaBlend(brush: THandle; focus: Single; scale: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPathGradientLinearBlend(brush: THandle; focus: Single; scale: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathGradientWrapMode(brush: THandle; var wrapmode: GPWRAPMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPathGradientWrapMode(brush: THandle; wrapmode: GPWRAPMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathGradientTransform(brush: THandle; matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPathGradientTransform(brush: THandle; matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipResetPathGradientTransform(brush: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipMultiplyPathGradientTransform(brush: THandle; matrix: THandle; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipTranslatePathGradientTransform(brush: THandle; dx: Single; dy: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipScalePathGradientTransform(brush: THandle; sx: Single; sy: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipRotatePathGradientTransform(brush: THandle; angle: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPathGradientFocusScales(brush: THandle; var xScale: Single; var yScale: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPathGradientFocusScales(brush: THandle; xScale: Single; yScale: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreatePen1(color: ARGB; width: Single; unit_: GPUNIT; out pen: GPPEN): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreatePen2(brush: THandle; width: Single; unit_: GPUNIT; out pen: GPPEN): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipClonePen(pen: GPPEN; out clonepen: GPPEN): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDeletePen(pen: GPPEN): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPenWidth(pen: GPPEN; width: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenWidth(pen: GPPEN; out width: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPenUnit(pen: GPPEN; unit_: GPUNIT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenUnit(pen: GPPEN; var unit_: GPUNIT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPenLineCap197819(pen: GPPEN; startCap: GPLINECAP; endCap: GPLINECAP; dashCap: GPDASHCAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPenStartCap(pen: GPPEN; startCap: GPLINECAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPenEndCap(pen: GPPEN; endCap: GPLINECAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPenDashCap197819(pen: GPPEN; dashCap: GPDASHCAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenStartCap(pen: GPPEN; out startCap: GPLINECAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenEndCap(pen: GPPEN; out endCap: GPLINECAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenDashCap197819(pen: GPPEN; out dashCap: GPDASHCAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPenLineJoin(pen: GPPEN; lineJoin: GPLINEJOIN): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenLineJoin(pen: GPPEN; var lineJoin: GPLINEJOIN): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPenCustomStartCap(pen: GPPEN; customCap: GPCUSTOMLINECAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenCustomStartCap(pen: GPPEN; out customCap: GPCUSTOMLINECAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPenCustomEndCap(pen: GPPEN; customCap: GPCUSTOMLINECAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenCustomEndCap(pen: GPPEN; out customCap: GPCUSTOMLINECAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPenMiterLimit(pen: GPPEN; miterLimit: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenMiterLimit(pen: GPPEN; out miterLimit: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPenMode(pen: GPPEN; penMode: GPPENALIGNMENT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenMode(pen: GPPEN;var penMode: GPPENALIGNMENT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPenTransform(pen: GPPEN; matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenTransform(pen: GPPEN; matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipResetPenTransform(pen: GPPEN): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipMultiplyPenTransform(pen: GPPEN; matrix: THandle; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipTranslatePenTransform(pen: GPPEN; dx: Single; dy: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipScalePenTransform(pen: GPPEN; sx: Single; sy: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipRotatePenTransform(pen: GPPEN; angle: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPenColor(pen: GPPEN; argb: ARGB): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenColor(pen: GPPEN; out argb: ARGB): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPenBrushFill(pen: GPPEN; brush: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenBrushFill(pen: GPPEN; out brush: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenFillType(pen: GPPEN; out type_: GPPENTYPE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenDashStyle(pen: GPPEN; out dashstyle: GPDASHSTYLE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPenDashStyle(pen: GPPEN; dashstyle: GPDASHSTYLE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenDashOffset(pen: GPPEN; out offset: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPenDashOffset(pen: GPPEN; offset: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenDashCount(pen: GPPEN; var count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPenDashArray(pen: GPPEN; dash: PSingle; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenDashArray(pen: GPPEN; dash: PSingle; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenCompoundCount(pen: GPPEN; out count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPenCompoundArray(pen: GPPEN; dash: PSingle; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPenCompoundArray(pen: GPPEN; dash: PSingle; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateCustomLineCap(fillPath: THandle; strokePath: THandle; baseCap: GPLINECAP; baseInset: Single; out customCap: GPCUSTOMLINECAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDeleteCustomLineCap(customCap: GPCUSTOMLINECAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCloneCustomLineCap(customCap: GPCUSTOMLINECAP; out clonedCap: GPCUSTOMLINECAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetCustomLineCapType(customCap: GPCUSTOMLINECAP; var capType: CUSTOMLINECAPTYPE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetCustomLineCapStrokeCaps(customCap: GPCUSTOMLINECAP; startCap: GPLINECAP; endCap: GPLINECAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetCustomLineCapStrokeCaps(customCap: GPCUSTOMLINECAP; var startCap: GPLINECAP; var endCap: GPLINECAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetCustomLineCapStrokeJoin(customCap: GPCUSTOMLINECAP; lineJoin: GPLINEJOIN): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetCustomLineCapStrokeJoin(customCap: GPCUSTOMLINECAP; var lineJoin: GPLINEJOIN): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetCustomLineCapBaseCap(customCap: GPCUSTOMLINECAP; baseCap: GPLINECAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetCustomLineCapBaseCap(customCap: GPCUSTOMLINECAP; var baseCap: GPLINECAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetCustomLineCapBaseInset(customCap: GPCUSTOMLINECAP; inset: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetCustomLineCapBaseInset(customCap: GPCUSTOMLINECAP; var inset: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetCustomLineCapWidthScale(customCap: GPCUSTOMLINECAP; widthScale: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetCustomLineCapWidthScale(customCap: GPCUSTOMLINECAP; var widthScale: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateAdjustableArrowCap(height: Single; width: Single; isFilled: Bool; out cap: GPADJUSTABLEARROWCAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetAdjustableArrowCapHeight(cap: GPADJUSTABLEARROWCAP; height: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetAdjustableArrowCapHeight(cap: GPADJUSTABLEARROWCAP; var height: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetAdjustableArrowCapWidth(cap: GPADJUSTABLEARROWCAP; width: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetAdjustableArrowCapWidth(cap: GPADJUSTABLEARROWCAP; var width: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetAdjustableArrowCapMiddleInset(cap: GPADJUSTABLEARROWCAP; middleInset: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetAdjustableArrowCapMiddleInset(cap: GPADJUSTABLEARROWCAP; var middleInset: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetAdjustableArrowCapFillState(cap: GPADJUSTABLEARROWCAP; fillState: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetAdjustableArrowCapFillState(cap: GPADJUSTABLEARROWCAP; var fillState: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipLoadImageFromStream(stream: ISTREAM; out image: GPIMAGE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipLoadImageFromFile(filename: PWCHAR; out image: GPIMAGE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipLoadImageFromStreamICM(stream: ISTREAM; out image: GPIMAGE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipLoadImageFromFileICM(filename: PWCHAR; out image: GPIMAGE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCloneImage(image: GPIMAGE; out cloneImage: GPIMAGE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDisposeImage(image: GPIMAGE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSaveImageToFile(image: GPIMAGE; filename: PWCHAR; clsidEncoder: PGUID; encoderParams: PENCODERPARAMETERS): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSaveImageToStream(image: GPIMAGE; stream: ISTREAM; clsidEncoder: PGUID; encoderParams: PENCODERPARAMETERS): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSaveAdd(image: GPIMAGE; encoderParams: PENCODERPARAMETERS): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSaveAddImage(image: GPIMAGE; newImage: GPIMAGE; encoderParams: PENCODERPARAMETERS): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetImageGraphicsContext(image: GPIMAGE; out graphics: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetImageBounds(image: GPIMAGE; srcRect: GPRECTF; var srcUnit: GPUNIT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetImageDimension(image: GPIMAGE; var width: Single; var height: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetImageType(image: GPIMAGE; var type_: IMAGETYPE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetImageWidth(image: GPIMAGE; var width: UINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetImageHeight(image: GPIMAGE; var height: UINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetImageHorizontalResolution(image: GPIMAGE; var resolution: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetImageVerticalResolution(image: GPIMAGE; var resolution: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetImageFlags(image: GPIMAGE; var flags: UINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetImageRawFormat(image: GPIMAGE; format: PGUID): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetImagePixelFormat(image: GPIMAGE; out format: TPIXELFORMAT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetImageThumbnail(image: GPIMAGE; thumbWidth: UINT; thumbHeight: UINT; out thumbImage: GPIMAGE; callback: GETTHUMBNAILIMAGEABORT; callbackData: Pointer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetEncoderParameterListSize(image: GPIMAGE; clsidEncoder: PGUID; out size: UINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetEncoderParameterList(image: GPIMAGE; clsidEncoder: PGUID; size: UINT; buffer: PENCODERPARAMETERS): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipImageGetFrameDimensionsCount(image: GPIMAGE; var count: UINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipImageGetFrameDimensionsList(image: GPIMAGE; dimensionIDs: PGUID; count: UINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipImageGetFrameCount(image: GPIMAGE; dimensionID: PGUID; var count: UINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipImageSelectActiveFrame(image: GPIMAGE; dimensionID: PGUID; frameIndex: UINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipImageRotateFlip(image: GPIMAGE; rfType: ROTATEFLIPTYPE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetImagePalette(image: GPIMAGE; palette: PCOLORPALETTE; size: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetImagePalette(image: GPIMAGE; palette: PCOLORPALETTE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetImagePaletteSize(image: GPIMAGE; var size: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPropertyCount(image: GPIMAGE; var numOfProperty: UINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPropertyIdList(image: GPIMAGE; numOfProperty: UINT; list: ULONG): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPropertyItemSize(image: GPIMAGE; propId: ULONG; var size: UINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPropertyItem(image: GPIMAGE; propId: ULONG; propSize: UINT; buffer: PPROPERTYITEM): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPropertySize(image: GPIMAGE; var totalBufferSize: UINT; var numProperties: UINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetAllPropertyItems(image: GPIMAGE; totalBufferSize: UINT; numProperties: UINT; allItems: PPROPERTYITEM): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipRemovePropertyItem(image: GPIMAGE; propId: ULONG): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPropertyItem(image: GPIMAGE; item: PPROPERTYITEM): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipImageForceValidation(image: GPIMAGE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateBitmapFromStream(stream: ISTREAM; out bitmap: GPBITMAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateBitmapFromFile(filename: PWCHAR; out bitmap: GPBITMAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateBitmapFromStreamICM(stream: ISTREAM; out bitmap: GPBITMAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateBitmapFromFileICM(filename: PWCHAR; var bitmap: GPBITMAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateBitmapFromScan0(width: Integer; height: Integer; stride: Integer; format: PIXELFORMAT; scan0: PBYTE; out bitmap: GPBITMAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateBitmapFromGraphics(width: Integer; height: Integer; target: THandle; out bitmap: GPBITMAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateBitmapFromGdiDib(gdiBitmapInfo: PBitmapInfo; gdiBitmapData: Pointer; out bitmap: GPBITMAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateBitmapFromHBITMAP(hbm: HBITMAP; hpal: HPALETTE; out bitmap: GPBITMAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateHBITMAPFromBitmap(bitmap: GPBITMAP; out hbmReturn: HBITMAP; background: ARGB): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateBitmapFromHICON(hicon: HICON; out bitmap: GPBITMAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateHICONFromBitmap(bitmap: GPBITMAP; out hbmReturn: HICON): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateBitmapFromResource(hInstance: HMODULE; lpBitmapName: PWCHAR; out bitmap: GPBITMAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCloneBitmapArea(x: Single; y: Single; width: Single; height: Single; format: PIXELFORMAT; srcBitmap: GPBITMAP; out dstBitmap: GPBITMAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCloneBitmapAreaI(x: Integer; y: Integer; width: Integer; height: Integer; format: PIXELFORMAT; srcBitmap: GPBITMAP; out dstBitmap: GPBITMAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipBitmapLockBits(bitmap: GPBITMAP; rect: GPRECT; flags: UINT; format: PIXELFORMAT; lockedBitmapData: PBITMAPDATA): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipBitmapUnlockBits(bitmap: GPBITMAP; lockedBitmapData: PBITMAPDATA): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipBitmapGetPixel(bitmap: GPBITMAP; x: Integer; y: Integer; var color: ARGB): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipBitmapSetPixel(bitmap: GPBITMAP; x: Integer; y: Integer; color: ARGB): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipBitmapSetResolution(bitmap: GPBITMAP; xdpi: Single; ydpi: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateImageAttributes(out imageattr: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCloneImageAttributes(imageattr: GPIMAGEATTRIBUTES; out cloneImageattr: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDisposeImageAttributes(imageattr: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetImageAttributesToIdentity(imageattr: GPIMAGEATTRIBUTES; type_: COLORADJUSTTYPE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipResetImageAttributes(imageattr: GPIMAGEATTRIBUTES; type_: COLORADJUSTTYPE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetImageAttributesColorMatrix(imageattr: GPIMAGEATTRIBUTES; type_: COLORADJUSTTYPE; enableFlag: Bool; colorMatrix: PCOLORMATRIX; grayMatrix: PCOLORMATRIX; flags: COLORMATRIXFLAGS): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetImageAttributesThreshold(imageattr: GPIMAGEATTRIBUTES; type_: COLORADJUSTTYPE; enableFlag: Bool; threshold: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetImageAttributesGamma(imageattr: GPIMAGEATTRIBUTES; type_: COLORADJUSTTYPE; enableFlag: Bool; gamma: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetImageAttributesNoOp(imageattr: GPIMAGEATTRIBUTES; type_: COLORADJUSTTYPE; enableFlag: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetImageAttributesColorKeys(imageattr: GPIMAGEATTRIBUTES; type_: COLORADJUSTTYPE; enableFlag: Bool; colorLow: ARGB; colorHigh: ARGB): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetImageAttributesOutputChannel(imageattr: GPIMAGEATTRIBUTES; type_: COLORADJUSTTYPE; enableFlag: Bool; channelFlags: COLORCHANNELFLAGS): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetImageAttributesOutputChannelColorProfile(imageattr: GPIMAGEATTRIBUTES; type_: COLORADJUSTTYPE; enableFlag: Bool; colorProfileFilename: PWCHAR): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetImageAttributesRemapTable(imageattr: GPIMAGEATTRIBUTES; type_: COLORADJUSTTYPE; enableFlag: Bool; mapSize: UINT; map: PCOLORMAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetImageAttributesWrapMode(imageAttr: GPIMAGEATTRIBUTES; wrap: WRAPMODE; argb: ARGB; clamp: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetImageAttributesICMMode(imageAttr: GPIMAGEATTRIBUTES; on_: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetImageAttributesAdjustedPalette(imageAttr: GPIMAGEATTRIBUTES; colorPalette: PCOLORPALETTE; colorAdjustType: COLORADJUSTTYPE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFlush(graphics: THandle; intention: GPFLUSHINTENTION): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateFromHDC(hdc: HDC; out graphics: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateFromHDC2(hdc: HDC; hDevice: THandle; out graphics: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateFromHWND(hwnd: HWND; out graphics: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateFromHWNDICM(hwnd: HWND; out graphics: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDeleteGraphics(graphics: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetDC(graphics: THandle; var hdc: HDC): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipReleaseDC(graphics: THandle; hdc: HDC): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetCompositingMode(graphics: THandle; compositingMode: COMPOSITINGMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetCompositingMode(graphics: THandle; var compositingMode: COMPOSITINGMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetRenderingOrigin(graphics: THandle; x: Integer; y: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetRenderingOrigin(graphics: THandle; var x: Integer; var y: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetCompositingQuality(graphics: THandle; compositingQuality: COMPOSITINGQUALITY): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetCompositingQuality(graphics: THandle; var compositingQuality: COMPOSITINGQUALITY): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetSmoothingMode(graphics: THandle; smoothingMode: SMOOTHINGMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetSmoothingMode(graphics: THandle; var smoothingMode: SMOOTHINGMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPixelOffsetMode(graphics: THandle; pixelOffsetMode: PIXELOFFSETMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPixelOffsetMode(graphics: THandle; var pixelOffsetMode: PIXELOFFSETMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetTextRenderingHint(graphics: THandle; mode: TEXTRENDERINGHINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetTextRenderingHint(graphics: THandle; var mode: TEXTRENDERINGHINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetTextContrast(graphics: THandle; contrast: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetTextContrast(graphics: THandle; var contrast: UINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetInterpolationMode(graphics: THandle; interpolationMode: INTERPOLATIONMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetInterpolationMode(graphics: THandle; var interpolationMode: INTERPOLATIONMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetWorldTransform(graphics: THandle; matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipResetWorldTransform(graphics: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipMultiplyWorldTransform(graphics: THandle; matrix: THandle; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipTranslateWorldTransform(graphics: THandle; dx: Single; dy: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipScaleWorldTransform(graphics: THandle; sx: Single; sy: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipRotateWorldTransform(graphics: THandle; angle: Single; order: GPMATRIXORDER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetWorldTransform(graphics: THandle; out matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipResetPageTransform(graphics: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPageUnit(graphics: THandle; var unit_: GPUNIT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetPageScale(graphics: THandle; var scale: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPageUnit(graphics: THandle; unit_: GPUNIT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetPageScale(graphics: THandle; scale: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetDpiX(graphics: THandle; var dpi: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetDpiY(graphics: THandle; var dpi: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipTransformPoints(graphics: THandle; destSpace: GPCOORDINATESPACE; srcSpace: GPCOORDINATESPACE; points: GPPOINTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipTransformPointsI(graphics: THandle; destSpace: GPCOORDINATESPACE; srcSpace: GPCOORDINATESPACE; points: GPPOINT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetNearestColor(graphics: THandle; argb: PARGB): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateHalftonePalette: HPALETTE; stdcall;external WINGDIPDLL;
  function GdipDrawLine(graphics: THandle; pen: GPPEN; x1: Single; y1: Single; x2: Single; y2: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawLineI(graphics: THandle; pen: GPPEN; x1: Integer; y1: Integer; x2: Integer; y2: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawLines(graphics: THandle; pen: GPPEN; points: GPPOINTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawLinesI(graphics: THandle; pen: GPPEN; points: GPPOINT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawArc(graphics: THandle; pen: GPPEN; x: Single; y: Single; width: Single; height: Single; startAngle: Single; sweepAngle: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawArcI(graphics: THandle; pen: GPPEN; x: Integer; y: Integer; width: Integer; height: Integer; startAngle: Single; sweepAngle: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawBezier(graphics: THandle; pen: GPPEN; x1: Single; y1: Single; x2: Single; y2: Single; x3: Single; y3: Single; x4: Single; y4: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawBezierI(graphics: THandle; pen: GPPEN; x1: Integer; y1: Integer; x2: Integer; y2: Integer; x3: Integer; y3: Integer; x4: Integer; y4: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawBeziers(graphics: THandle; pen: GPPEN; points: GPPOINTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawBeziersI(graphics: THandle; pen: GPPEN; points: GPPOINT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawRectangle(graphics: THandle; pen: GPPEN; x: Single; y: Single; width: Single; height: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawRectangleI(graphics: THandle; pen: GPPEN; x: Integer; y: Integer; width: Integer; height: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawRectangles(graphics: THandle; pen: GPPEN; rects: GPRECTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawRectanglesI(graphics: THandle; pen: GPPEN; rects: GPRECT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawEllipse(graphics: THandle; pen: GPPEN; x: Single; y: Single; width: Single; height: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawEllipseI(graphics: THandle; pen: GPPEN; x: Integer; y: Integer; width: Integer; height: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawPie(graphics: THandle; pen: GPPEN; x: Single; y: Single; width: Single;  height: Single; startAngle: Single; sweepAngle: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawPieI(graphics: THandle; pen: GPPEN; x: Integer; y: Integer; width: Integer; height: Integer; startAngle: Single; sweepAngle: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawPolygon(graphics: THandle; pen: GPPEN; points: GPPOINTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawPolygonI(graphics: THandle; pen: GPPEN; points: GPPOINT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawPath(graphics: THandle; pen: GPPEN; path: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawCurve(graphics: THandle; pen: GPPEN; points: GPPOINTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawCurveI(graphics: THandle; pen: GPPEN; points: GPPOINT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawCurve2(graphics: THandle; pen: GPPEN; points: GPPOINTF; count: Integer; tension: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawCurve2I(graphics: THandle; pen: GPPEN; points: GPPOINT; count: Integer; tension: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawCurve3(graphics: THandle; pen: GPPEN; points: GPPOINTF; count: Integer; offset: Integer; numberOfSegments: Integer; tension: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawCurve3I(graphics: THandle; pen: GPPEN; points: GPPOINT; count: Integer; offset: Integer; numberOfSegments: Integer; tension: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawClosedCurve(graphics: THandle; pen: GPPEN; points: GPPOINTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawClosedCurveI(graphics: THandle; pen: GPPEN; points: GPPOINT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawClosedCurve2(graphics: THandle; pen: GPPEN; points: GPPOINTF; count: Integer; tension: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawClosedCurve2I(graphics: THandle; pen: GPPEN; points: GPPOINT; count: Integer; tension: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGraphicsClear(graphics: THandle; color: ARGB): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFillRectangle(graphics: THandle; brush: THandle; x: Single; y: Single; width: Single; height: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFillRectangleI(graphics: THandle; brush: THandle; x: Integer; y: Integer; width: Integer; height: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFillRectangles(graphics: THandle; brush: THandle; rects: GPRECTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFillRectanglesI(graphics: THandle; brush: THandle; rects: GPRECT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFillPolygon(graphics: THandle; brush: THandle; points: GPPOINTF; count: Integer; fillMode: GPFILLMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFillPolygonI(graphics: THandle; brush: THandle; points: GPPOINT; count: Integer; fillMode: GPFILLMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFillPolygon2(graphics: THandle; brush: THandle; points: GPPOINTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFillPolygon2I(graphics: THandle; brush: THandle; points: GPPOINT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFillEllipse(graphics: THandle; brush: THandle; x: Single; y: Single; width: Single; height: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFillEllipseI(graphics: THandle; brush: THandle; x: Integer; y: Integer; width: Integer; height: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFillPie(graphics: THandle; brush: THandle; x: Single; y: Single; width: Single; height: Single; startAngle: Single; sweepAngle: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFillPieI(graphics: THandle; brush: THandle; x: Integer; y: Integer; width: Integer; height: Integer; startAngle: Single; sweepAngle: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFillPath(graphics: THandle; brush: THandle; path: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFillClosedCurve(graphics: THandle; brush: THandle; points: GPPOINTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFillClosedCurveI(graphics: THandle; brush: THandle; points: GPPOINT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFillClosedCurve2(graphics: THandle; brush: THandle; points: GPPOINTF; count: Integer; tension: Single; fillMode: GPFILLMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFillClosedCurve2I(graphics: THandle; brush: THandle; points: GPPOINT; count: Integer; tension: Single; fillMode: GPFILLMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFillRegion(graphics: THandle; brush: THandle; region: GPREGION): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawImage(graphics: THandle; image: GPIMAGE; x: Single; y: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawImageI(graphics: THandle; image: GPIMAGE; x: Integer; y: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawImageRect(graphics: THandle; image: GPIMAGE; x: Single; y: Single; width: Single; height: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawImageRectI(graphics: THandle; image: GPIMAGE; x: Integer; y: Integer; width: Integer; height: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawImagePoints(graphics: THandle; image: GPIMAGE; dstpoints: GPPOINTF; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawImagePointsI(graphics: THandle; image: GPIMAGE; dstpoints: GPPOINT; count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawImagePointRect(graphics: THandle; image: GPIMAGE; x: Single; y: Single; srcx: Single; srcy: Single; srcwidth: Single; srcheight: Single; srcUnit: GPUNIT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawImagePointRectI(graphics: THandle; image: GPIMAGE; x: Integer; y: Integer; srcx: Integer; srcy: Integer; srcwidth: Integer; srcheight: Integer; srcUnit: GPUNIT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawImageRectRect(graphics: THandle; image: GPIMAGE; dstx: Single; dsty: Single; dstwidth: Single; dstheight: Single; srcx: Single; srcy: Single; srcwidth: Single; srcheight: Single; srcUnit: GPUNIT; imageAttributes: GPIMAGEATTRIBUTES; callback: DRAWIMAGEABORT; callbackData: Pointer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawImageRectRectI(graphics: THandle; image: GPIMAGE; dstx: Integer; dsty: Integer; dstwidth: Integer; dstheight: Integer; srcx: Integer; srcy: Integer; srcwidth: Integer; srcheight: Integer; srcUnit: GPUNIT; imageAttributes: GPIMAGEATTRIBUTES; callback: DRAWIMAGEABORT; callbackData: Pointer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawImagePointsRect(graphics: THandle; image: GPIMAGE; points: GPPOINTF; count: Integer; srcx: Single; srcy: Single; srcwidth: Single; srcheight: Single; srcUnit: GPUNIT; imageAttributes: GPIMAGEATTRIBUTES; callback: DRAWIMAGEABORT; callbackData: Pointer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawImagePointsRectI(graphics: THandle; image: GPIMAGE; points: GPPOINT; count: Integer; srcx: Integer; srcy: Integer; srcwidth: Integer; srcheight: Integer; srcUnit: GPUNIT; imageAttributes: GPIMAGEATTRIBUTES; callback: DRAWIMAGEABORT; callbackData: Pointer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipEnumerateMetafileDestPoint(graphics: THandle; metafile: GPMETAFILE; destPoint: PPOINTF; callback: ENUMERATEMETAFILEPROC; callbackData: Pointer; imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipEnumerateMetafileDestPointI(graphics: THandle; metafile: GPMETAFILE; destPoint: PPOINT; callback: ENUMERATEMETAFILEPROC; callbackData: Pointer; imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipEnumerateMetafileDestRect(graphics: THandle; metafile: GPMETAFILE; destRect: PRECTF; callback: ENUMERATEMETAFILEPROC; callbackData: Pointer; imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipEnumerateMetafileDestRectI(graphics: THandle; metafile: GPMETAFILE; destRect: PRECT; callback: ENUMERATEMETAFILEPROC; callbackData: Pointer; imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipEnumerateMetafileDestPoints(graphics: THandle; metafile: GPMETAFILE; destPoints: PPOINTF; count: Integer; callback: ENUMERATEMETAFILEPROC; callbackData: Pointer; imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipEnumerateMetafileDestPointsI(graphics: THandle; metafile: GPMETAFILE; destPoints: PPOINT; count: Integer; callback: ENUMERATEMETAFILEPROC; callbackData: Pointer; imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipEnumerateMetafileSrcRectDestPoint(graphics: THandle; metafile: GPMETAFILE; destPoint: PPOINTF; srcRect: PRECTF; srcUnit: TUNIT; callback: ENUMERATEMETAFILEPROC; callbackData: Pointer; imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipEnumerateMetafileSrcRectDestPointI(graphics: THandle; metafile: GPMETAFILE; destPoint: PPOINT; srcRect: PRECT; srcUnit: TUNIT; callback: ENUMERATEMETAFILEPROC; callbackData: Pointer; imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipEnumerateMetafileSrcRectDestRect(graphics: THandle; metafile: GPMETAFILE; destRect: PRECTF; srcRect: PRECTF; srcUnit: TUNIT; callback: ENUMERATEMETAFILEPROC; callbackData: Pointer; imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipEnumerateMetafileSrcRectDestRectI(graphics: THandle; metafile: GPMETAFILE; destRect: PRECT; srcRect: PRECT; srcUnit: TUNIT; callback: ENUMERATEMETAFILEPROC; callbackData: Pointer; imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipEnumerateMetafileSrcRectDestPoints(graphics: THandle; metafile: GPMETAFILE; destPoints: PPOINTF; count: Integer; srcRect: PRECTF; srcUnit: TUNIT; callback: ENUMERATEMETAFILEPROC; callbackData: Pointer;  imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipEnumerateMetafileSrcRectDestPointsI(graphics: THandle; metafile: GPMETAFILE; destPoints: PPOINT; count: Integer; srcRect: PRECT; srcUnit: TUNIT; callback: ENUMERATEMETAFILEPROC; callbackData: Pointer; imageAttributes: GPIMAGEATTRIBUTES): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipPlayMetafileRecord(metafile: GPMETAFILE; recordType: EMFPLUSRECORDTYPE; flags: UINT; dataSize: UINT; data: PBYTE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetClipGraphics(graphics: THandle; srcgraphics: THandle; combineMode: COMBINEMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetClipRect(graphics: THandle; x: Single; y: Single; width: Single; height: Single; combineMode: COMBINEMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetClipRectI(graphics: THandle; x: Integer; y: Integer; width: Integer; height: Integer; combineMode: COMBINEMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetClipPath(graphics: THandle; path: THandle; combineMode: COMBINEMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetClipRegion(graphics: THandle; region: GPREGION; combineMode: COMBINEMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetClipHrgn(graphics: THandle; hRgn: HRGN; combineMode: COMBINEMODE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipResetClip(graphics: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipTranslateClip(graphics: THandle; dx: Single; dy: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipTranslateClipI(graphics: THandle; dx: Integer; dy: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetClip(graphics: THandle; region: GPREGION): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetClipBounds(graphics: THandle; rect: GPRECTF): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetClipBoundsI(graphics: THandle; rect: GPRECT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsClipEmpty(graphics: THandle; result: PBool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetVisibleClipBounds(graphics: THandle; rect: GPRECTF): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetVisibleClipBoundsI(graphics: THandle; rect: GPRECT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsVisibleClipEmpty(graphics: THandle; var result: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsVisiblePoint(graphics: THandle; x: Single; y: Single; var result: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsVisiblePointI(graphics: THandle; x: Integer; y: Integer; var result: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsVisibleRect(graphics: THandle; x: Single; y: Single; width: Single; height: Single; var result: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsVisibleRectI(graphics: THandle; x: Integer; y: Integer; width: Integer; height: Integer; var result: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSaveGraphics(graphics: THandle; var state: GRAPHICSSTATE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipRestoreGraphics(graphics: THandle; state: GRAPHICSSTATE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipBeginContainer(graphics: THandle; dstrect: GPRECTF; srcrect: GPRECTF; unit_: GPUNIT; var state: GRAPHICSCONTAINER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipBeginContainerI(graphics: THandle; dstrect: GPRECT; srcrect: GPRECT; unit_: GPUNIT; var state: GRAPHICSCONTAINER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipBeginContainer2(graphics: THandle; var state: GRAPHICSCONTAINER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipEndContainer(graphics: THandle; state: GRAPHICSCONTAINER): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetMetafileHeaderFromWmf(hWmf: HMETAFILE; wmfPlaceableFileHeader: PWMFPLACEABLEFILEHEADER; header: Pointer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetMetafileHeaderFromEmf(hEmf: HENHMETAFILE; header: Pointer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetMetafileHeaderFromFile(filename: PWCHAR; header: Pointer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetMetafileHeaderFromStream(stream: ISTREAM; header: Pointer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetMetafileHeaderFromMetafile(metafile: GPMETAFILE; header: Pointer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetHemfFromMetafile(metafile: GPMETAFILE; var hEmf: HENHMETAFILE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateStreamOnFile(filename: PWCHAR; access: UINT; out stream: ISTREAM): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateMetafileFromWmf(hWmf: HMETAFILE; deleteWmf: Bool; wmfPlaceableFileHeader: PWMFPLACEABLEFILEHEADER; out metafile: GPMETAFILE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateMetafileFromEmf(hEmf: HENHMETAFILE; deleteEmf: Bool; out metafile: GPMETAFILE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateMetafileFromFile(file_: PWCHAR; out metafile: GPMETAFILE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateMetafileFromWmfFile(file_: PWCHAR; wmfPlaceableFileHeader: PWMFPLACEABLEFILEHEADER; out metafile: GPMETAFILE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateMetafileFromStream(stream: ISTREAM; out metafile: GPMETAFILE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipRecordMetafile(referenceHdc: HDC; type_: EMFTYPE; frameRect: GPRECTF; frameUnit: METAFILEFRAMEUNIT; description: PWCHAR; out metafile: GPMETAFILE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipRecordMetafileI(referenceHdc: HDC; type_: EMFTYPE; frameRect: GPRECT; frameUnit: METAFILEFRAMEUNIT; description: PWCHAR; out metafile: GPMETAFILE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipRecordMetafileFileName(fileName: PWCHAR; referenceHdc: HDC; type_: EMFTYPE; frameRect: GPRECTF; frameUnit: METAFILEFRAMEUNIT; description: PWCHAR; out metafile: GPMETAFILE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipRecordMetafileFileNameI(fileName: PWCHAR; referenceHdc: HDC; type_: EMFTYPE; frameRect: GPRECT; frameUnit: METAFILEFRAMEUNIT; description: PWCHAR; out metafile: GPMETAFILE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipRecordMetafileStream(stream: ISTREAM; referenceHdc: HDC; type_: EMFTYPE; frameRect: GPRECTF; frameUnit: METAFILEFRAMEUNIT; description: PWCHAR; out metafile: GPMETAFILE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipRecordMetafileStreamI(stream: ISTREAM; referenceHdc: HDC; type_: EMFTYPE; frameRect: GPRECT; frameUnit: METAFILEFRAMEUNIT; description: PWCHAR; out metafile: GPMETAFILE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetMetafileDownLevelRasterizationLimit(metafile: GPMETAFILE; metafileRasterizationLimitDpi: UINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetMetafileDownLevelRasterizationLimit(metafile: GPMETAFILE; var metafileRasterizationLimitDpi: UINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetImageDecodersSize(out numDecoders: UINT; out size: UINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetImageDecoders(numDecoders: UINT; size: UINT; decoders: PIMAGECODECINFO): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetImageEncodersSize(out numEncoders: UINT; out size: UINT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetImageEncoders(numEncoders: UINT; size: UINT; encoders: PIMAGECODECINFO): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipComment(graphics: THandle; sizeData: UINT; data: PBYTE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateFontFamilyFromName(name: PWCHAR; fontCollection: THandle; out FontFamily: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDeleteFontFamily(FontFamily: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCloneFontFamily(FontFamily: THandle; out clonedFontFamily: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetGenericFontFamilySansSerif(out nativeFamily: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetGenericFontFamilySerif(out nativeFamily: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetGenericFontFamilyMonospace(out nativeFamily: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetFamilyName(family: THandle; name: PWideChar; language: LANGID): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipIsStyleAvailable(family: THandle; style: Integer; var IsStyleAvailable: Bool): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFontCollectionEnumerable(fontCollection: THandle; graphics: THandle; var numFound: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipFontCollectionEnumerate(fontCollection: THandle; numSought: Integer; gpfamilies: array of THandle; var numFound: Integer; graphics: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetEmHeight(family: THandle; style: Integer; out EmHeight: UINT16): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetCellAscent(family: THandle; style: Integer; var CellAscent: UINT16): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetCellDescent(family: THandle; style: Integer; var CellDescent: UINT16): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetLineSpacing(family: THandle; style: Integer; var LineSpacing: UINT16): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateFontFromDC(hdc: HDC; out font: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateFontFromLogfontA(hdc: HDC; logfont: PLOGFONTA; out font: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateFontFromLogfontW(hdc: HDC; logfont: PLOGFONTW; out font: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateFont(fontFamily: THandle; emSize: Single; style: Integer; _unit: Unit_; out font: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCloneFont(font: THandle; out cloneFont: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDeleteFont(font: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetFamily(font: THandle; out family: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetFontStyle(font: THandle; var style: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetFontSize(font: THandle; var size: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetFontUnit(font: THandle; var unit_: TUNIT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetFontHeight(font: THandle; graphics: THandle; var height: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetFontHeightGivenDPI(font: THandle; dpi: Single; var height: Single): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetLogFontA(font: THandle; graphics: THandle; var logfontA: LOGFONTA): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetLogFontW(font: THandle; graphics: THandle; var logfontW: LOGFONTW): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipNewInstalledFontCollection(out fontCollection: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipNewPrivateFontCollection(out fontCollection: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDeletePrivateFontCollection(out fontCollection: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetFontCollectionFamilyCount(fontCollection: THandle; var numFound: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetFontCollectionFamilyList(fontCollection: THandle; numSought: Integer; gpfamilies: THandle; var numFound: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipPrivateAddFontFile(fontCollection: THandle; filename: PWCHAR): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipPrivateAddMemoryFont(fontCollection: THandle; memory: Pointer; length: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawString(graphics: THandle; string_: PWCHAR; length: Integer; font: THandle;var layoutRect: TRECTF; stringFormat: THandle; brush: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipMeasureString(graphics: THandle; string_: PWCHAR; length: Integer; font: THandle; layoutRect: PRECTF; stringFormat: THandle; boundingBox: PRECTF; codepointsFitted: PInteger; linesFilled: PInteger): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipMeasureCharacterRanges(graphics: THandle; string_: PWCHAR; length: Integer; font: THandle; layoutRect: PRECTF; stringFormat: THandle; regionCount: Integer; const regions: GPREGION): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawDriverString(graphics: THandle; const text: PUINT16; length: Integer; const font: THandle; const brush: THandle; const positions: PPOINTF; flags: Integer; const matrix: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipMeasureDriverString(graphics: THandle; text: PUINT16; length: Integer; font: THandle; positions: PPOINTF; flags: Integer; matrix: THandle; boundingBox: PRECTF): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateStringFormat(formatAttributes: Integer; language: LANGID; out format: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipStringFormatGetGenericDefault(out format: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipStringFormatGetGenericTypographic(out format: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDeleteStringFormat(format: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCloneStringFormat(format: THandle; out newFormat: THandle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetStringFormatFlags(format: THandle; flags: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetStringFormatFlags(format: THandle; out flags: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetStringFormatAlign(format: THandle; align: STRINGALIGNMENT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetStringFormatAlign(format: THandle; out align: STRINGALIGNMENT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetStringFormatLineAlign(format: THandle; align: STRINGALIGNMENT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetStringFormatLineAlign(format: THandle; out align: STRINGALIGNMENT): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetStringFormatTrimming(format: THandle; trimming: STRINGTRIMMING): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetStringFormatTrimming(format: THandle; out trimming: STRINGTRIMMING): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetStringFormatHotkeyPrefix(format: THandle; hotkeyPrefix: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetStringFormatHotkeyPrefix(format: THandle; out hotkeyPrefix: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetStringFormatTabStops(format: THandle; firstTabOffset: Single; count: Integer; tabStops: PSingle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetStringFormatTabStops(format: THandle; count: Integer; firstTabOffset: PSingle; tabStops: PSingle): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetStringFormatTabStopCount(format: THandle; out count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetStringFormatDigitSubstitution(format: THandle; language: LANGID; substitute: STRINGDIGITSUBSTITUTE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetStringFormatDigitSubstitution(format: THandle; language: PUINT; substitute: PSTRINGDIGITSUBSTITUTE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipGetStringFormatMeasurableCharacterRangeCount(format: THandle; out count: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipSetStringFormatMeasurableCharacterRanges(format: THandle; rangeCount: Integer; ranges: PCHARACTERRANGE): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipCreateCachedBitmap(bitmap: GPBITMAP; graphics: THandle; out cachedBitmap: GPCACHEDBITMAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDeleteCachedBitmap(cachedBitmap: GPCACHEDBITMAP): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipDrawCachedBitmap(graphics: THandle; cachedBitmap: GPCACHEDBITMAP; x: Integer; y: Integer): GPSTATUS; stdcall;external WINGDIPDLL;
  function GdipEmfToWmfBits(hemf: HENHMETAFILE; cbData16: UINT; pData16: PBYTE; iMapMode: Integer; eFlags: Integer): UINT; stdcall;external WINGDIPDLL;

implementation

end.



