unit OpenGL;

interface
// generell options
{$H+,O+,X+}
{$DEFINE DGL_WIN}

uses
  Windows;

const
  OpenGL32='OpenGL32.dll';

type
  GLenum = Cardinal;
  GLboolean = BYTEBOOL;
  GLbitfield = Cardinal;
  GLbyte = Shortint;
  GLshort = SmallInt;
  GLint = Integer;
  GLsizei = Integer;
  GLubyte = Byte;
  GLushort = Word;
  GLuint = Cardinal;
  GLfloat = Single;
  GLclampf = Single;
  GLdouble = Double;
  GLclampd = Double;
  GLvoid = Pointer;
  GLint64 = Int64;
  GLuint64 = UInt64;

  TGLenum = GLenum;
  TGLboolean = GLboolean;
  TGLbitfield = GLbitfield;
  TGLbyte = GLbyte;
  TGLshort = GLshort;
  TGLint = GLint;
  TGLsizei = GLsizei;
  TGLubyte = GLubyte;
  TGLushort = GLushort;
  TGLuint = GLuint;
  TGLfloat = GLfloat;
  TGLclampf = GLclampf;
  TGLdouble = GLdouble;
  TGLclampd = GLclampd;
  TGLvoid = GLvoid;
  TGLint64 = GLint64;
  TGLuint64 = GLuint64;

  PGLboolean = ^GLboolean;
  PGLbyte = ^GLbyte;
  PGLshort = ^GLshort;
  PGLint = ^GLint;
  PGLsizei = ^GLsizei;
  PGLubyte = ^GLubyte;
  PGLushort = ^GLushort;
  PGLuint = ^GLuint;
  PGLclampf = ^GLclampf;
  PGLfloat = ^GLfloat;
  PGLdouble = ^GLdouble;
  PGLclampd = ^GLclampd;
  PGLenum = ^GLenum;
  PGLvoid = Pointer;
  PPGLvoid = ^PGLvoid;
  PGLint64 = ^GLint64;
  PGLuint64 = ^GLuint64;

  // GL_NV_half_float
  GLhalfNV = WORD;
  TGLhalfNV = GLhalfNV;
  PGLhalfNV = ^GLhalfNV;

  // GL_ARB_shader_objects
  PGLHandleARB = ^GLHandleARB;
  GLHandleARB = Integer;
  GLcharARB = AnsiChar;
  PGLcharARB = PAnsiChar;
  PPGLcharARB = ^PGLcharARB;

  // GL_VERSION_1_5
  GLintptr = GLint;
  PGLintptr = ^GLintptr;
  GLsizeiptr = GLsizei;

  // GL_ARB_vertex_buffer_object
  GLintptrARB = GLint;
  GLsizeiptrARB = GLsizei;

  // GL_VERSION_2_0
  GLHandle = Integer;
  PGLchar = PAnsiChar;
  PPGLchar = ^PGLChar;

  // GL_EXT_timer_query
  GLint64EXT = Int64;
  TGLint64EXT = GLint64EXT;
  PGLint64EXT = ^GLint64EXT;

  GLuint64EXT = GLuint64;
  TGLuint64EXT = GLuint64EXT;
  PGLuint64EXT = ^GLuint64EXT;

  // WGL_ARB_pbuffer
  HPBUFFERARB = THandle;

  // WGL_EXT_pbuffer
  HPBUFFEREXT = THandle;

  // WGL_NV_present_video
  PHVIDEOOUTPUTDEVICENV = ^HVIDEOOUTPUTDEVICENV;
  HVIDEOOUTPUTDEVICENV = THandle;

  // WGL_NV_video_output
  PHPVIDEODEV = ^HPVIDEODEV;
  HPVIDEODEV = THandle;

  // WGL_NV_gpu_affinity
  PHPGPUNV = ^HPGPUNV;
  PHGPUNV = ^HGPUNV;

  // WGL_NV_video_capture
  HVIDEOINPUTDEVICENV = THandle;
  PHVIDEOINPUTDEVICENV = ^HVIDEOINPUTDEVICENV;

  HPGPUNV = THandle;
  HGPUNV = THandle;

  // GL_ARB_sync
  GLsync = Pointer;

  // GL_ARB_cl_event
  { These incomplete types let us declare types compatible with OpenCL's cl_context and cl_event }
  _cl_context = record end;
  _cl_event = record end;
  p_cl_context = ^_cl_context;
  p_cl_event = ^_cl_event;

  // GL_ARB_compute_variable_group_size
  TglDispatchComputeGroupSizeARB = procedure (num_groups_x : GLuint; num_groups_y : GLuint; num_groups_z : GLuint; group_size_x : GLuint; group_size_y : GLuint; group_size_z : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_debug_output
  TglDebugProcARB = procedure (source: GLenum; type_: GLenum; id: GLuint; severity: GLenum; length: GLsizei; const message_: PGLchar; userParam: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_AMD_debug_output
  TglDebugProcAMD = procedure (id: GLuint; category: GLenum; severity: GLenum; length: GLsizei; const message_: PGLchar; userParam: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_KHR_debug (4.3)
  TglDebugProc = procedure(source : GLEnum; type_ : GLEnum; id : GLUInt; severity : GLUInt; length : GLsizei; const message_ : PGLCHar; userParam : PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_NV_vdpau_interop
  GLvdpauSurfaceNV = GLintptr;
  PGLvdpauSurfaceNV = ^GLvdpauSurfaceNV;

  // Datatypes corresponding to GL's types TGL(name)(type)(count)
  TGLVectorub2 = array[0..1] of GLubyte;
  TGLVectori2  = array[0..1] of GLint;
  TGLVectorf2  = array[0..1] of GLfloat;
  TGLVectord2  = array[0..1] of GLdouble;
  TGLVectorp2  = array[0..1] of Pointer;

  TGLVectorub3 = array[0..2] of GLubyte;
  TGLVectori3  = array[0..2] of GLint;
  TGLVectorf3  = array[0..2] of GLfloat;
  TGLVectord3  = array[0..2] of GLdouble;
  TGLVectorp3  = array[0..2] of Pointer;

  TGLVectorub4 = array[0..3] of GLubyte;
  TGLVectori4  = array[0..3] of GLint;
  TGLVectorf4  = array[0..3] of GLfloat;
  TGLVectord4  = array[0..3] of GLdouble;
  TGLVectorp4  = array[0..3] of Pointer;

  TGLArrayf4 = TGLVectorf4;
  TGLArrayf3 = TGLVectorf3;
  TGLArrayd3 = TGLVectord3;
  TGLArrayi4 = TGLVectori4;
  TGLArrayp4 = TGLVectorp4;

  TGlMatrixub3 = array[0..2, 0..2] of GLubyte;
  TGlMatrixi3  = array[0..2, 0..2] of GLint;
  TGLMatrixf3  = array[0..2, 0..2] of GLfloat;
  TGLMatrixd3  = array[0..2, 0..2] of GLdouble;

  TGlMatrixub4 = array[0..3, 0..3] of GLubyte;
  TGlMatrixi4  = array[0..3, 0..3] of GLint;
  TGLMatrixf4  = array[0..3, 0..3] of GLfloat;
  TGLMatrixd4  = array[0..3, 0..3] of GLdouble;

  TGLVector3f = TGLVectorf3;

  // Datatypes corresponding to OpenGL12.pas for easy porting
  TVector3f = TGLVectorf3;
  TVector3d = TGLVectord3;

  TVector4i = TGLVectori4;
  TVector4f = TGLVectorf4;
  TVector4p = TGLVectorp4;

  TMatrix4f = TGLMatrixf4;
  TMatrix4d = TGLMatrixd4;

  PGLMatrixd4 = ^TGLMatrixd4;
  PVector4i = ^TVector4i;



{$IFDEF FPC}
  TRect = packed record
    Left, Top, Right, Bottom: Longint;
  end;
{$ENDIF}


  PGPU_DEVICE = ^GPU_DEVICE;
  GPU_DEVICE = record
    cb: DWORD;
    DeviceName: array [0..31] of AnsiChar;
    DeviceString: array [0..127] of AnsiChar;
    Flags: DWORD;
    rcVirtualScreen: TRect;
  end;


type
{$IFDEF FPC}
  {$IFDEF DGL_WIN}
    PWGLSwap = ^TWGLSwap;
    {$EXTERNALSYM _WGLSWAP}
      _WGLSWAP = packed record
        hdc: HDC;
        uiFlags: UINT;
      end;

    TWGLSwap = _WGLSWAP;
  {$EXTERNALSYM WGLSWAP}
    WGLSWAP = _WGLSWAP;

  {$ENDIF}
{$ENDIF}

  // GLU types
  TGLUNurbs = record
  end;
  TGLUQuadric = record
  end;
  TGLUTesselator = record
  end;
  PGLUNurbs = ^TGLUNurbs;
  PGLUQuadric = ^TGLUQuadric;
  PGLUTesselator = ^TGLUTesselator;
  // backwards compatibility
  TGLUNurbsObj = TGLUNurbs;
  TGLUQuadricObj = TGLUQuadric;
  TGLUTesselatorObj = TGLUTesselator;
  TGLUTriangulatorObj = TGLUTesselator;
  PGLUNurbsObj = PGLUNurbs;
  PGLUQuadricObj = PGLUQuadric;
  PGLUTesselatorObj = PGLUTesselator;
  PGLUTriangulatorObj = PGLUTesselator;

  // GLUQuadricCallback
  TGLUQuadricErrorProc = procedure(errorCode: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  // GLUTessCallback
  TGLUTessBeginProc = procedure(AType: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TGLUTessEdgeFlagProc = procedure(Flag: GLboolean); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TGLUTessVertexProc = procedure(VertexData: Pointer); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TGLUTessEndProc = procedure; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TGLUTessErrorProc = procedure(ErrNo: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TGLUTessCombineProc = procedure(Coords: TGLArrayd3; VertexData: TGLArrayp4; Weight: TGLArrayf4; OutData: PPointer); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TGLUTessBeginDataProc = procedure(AType: GLenum; UserData: Pointer); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TGLUTessEdgeFlagDataProc = procedure(Flag: GLboolean; UserData: Pointer); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TGLUTessVertexDataProc = procedure(VertexData: Pointer; UserData: Pointer); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TGLUTessEndDataProc = procedure(UserData: Pointer); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TGLUTessErrorDataProc = procedure(ErrNo: GLenum; UserData: Pointer); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TGLUTessCombineDataProc = procedure(Coords: TGLArrayd3; VertexData: TGLArrayp4; Weight: TGLArrayf4; OutData: PPointer; UserData: Pointer); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  // GLUNurbsCallback
  TGLUNurbsErrorProc = procedure(ErrorCode: GLEnum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  //WIGGLE
  function wglGetProcAddress(ProcName: PAnsiChar): Pointer; stdcall;external OPenGL32;
  function wglCopyContext(p1: HGLRC; p2: HGLRC; p3: Cardinal): BOOL; stdcall;external OPenGL32;
  function wglCreateContext(DC: HDC): HGLRC; stdcall;external OPenGL32;
  function wglCreateLayerContext(p1: HDC; p2: Integer): HGLRC; stdcall;external OPenGL32;
  function wglDeleteContext(p1: HGLRC): BOOL; stdcall;external OPenGL32;
  function wglDescribeLayerPlane(p1: HDC; p2, p3: Integer; p4: Cardinal; p5: PLayerPlaneDescriptor): BOOL; stdcall;external OPenGL32;
  function wglGetCurrentContext: HGLRC; stdcall;external OPenGL32;
  function wglGetCurrentDC: HDC; stdcall;external OPenGL32;
  function wglGetLayerPaletteEntries(p1: HDC; p2, p3, p4: Integer; var pcr): Integer; stdcall;external OPenGL32;
  function wglMakeCurrent(DC: HDC; p2: HGLRC): BOOL; stdcall;external OPenGL32;
  function wglRealizeLayerPalette(p1: HDC; p2: Integer; p3: BOOL): BOOL; stdcall;external OPenGL32;
  function wglSetLayerPaletteEntries(p1: HDC; p2, p3, p4: Integer; var pcr): Integer; stdcall;external OPenGL32;
  function wglShareLists(p1, p2: HGLRC): BOOL; stdcall;external OPenGL32;
  function wglSwapLayerBuffers(p1: HDC; p2: Cardinal): BOOL; stdcall;external OPenGL32;
  function wglSwapMultipleBuffers(p1: UINT; const p2: PWGLSWAP): DWORD; stdcall;external OPenGL32;
  function wglUseFontBitmapsA(DC: HDC; p2, p3, p4: DWORD): BOOL; stdcall;external OPenGL32;
  function wglUseFontBitmapsW(DC: HDC; p2, p3, p4: DWORD): BOOL; stdcall;external OPenGL32;
  function wglUseFontBitmaps(DC: HDC; p2, p3, p4: DWORD): BOOL; stdcall;external OPenGL32;
  function wglUseFontOutlinesA(p1: HDC; p2, p3, p4: DWORD; p5, p6: Single; p7: Integer; p8: PGlyphMetricsFloat): BOOL; stdcall;external OPenGL32;
  function wglUseFontOutlinesW(p1: HDC; p2, p3, p4: DWORD; p5, p6: Single; p7: Integer; p8: PGlyphMetricsFloat): BOOL; stdcall;external OPenGL32;
  function wglUseFontOutlines(p1: HDC; p2, p3, p4: DWORD; p5, p6: Single; p7: Integer; p8: PGlyphMetricsFloat): BOOL; stdcall;external OPenGL32;

  //DEPRECATED
  procedure glAccum(op: GLenum; value: GLfloat);stdcall;external OPenGL32;
  procedure glAlphaFunc(func: GLenum; ref: GLclampf);stdcall; external OPenGL32;
  function  glAreTexturesResident(n: GLsizei; const textures: PGLuint; residences: PGLboolean): GLboolean;stdcall; external OPenGL32;
  procedure glArrayElement(i: GLint);stdcall; external OPenGL32;
  procedure glBegin(mode: GLenum);stdcall; external OPenGL32;
  procedure glBitmap(width: GLsizei; height: GLsizei; xorig: GLfloat; yorig: GLfloat; xmove: GLfloat; ymove: GLfloat; const bitmap: PGLubyte);stdcall; external OPenGL32;
  procedure glCallList(list: GLuint);stdcall; external OPenGL32;
  procedure glCallLists(n: GLsizei; _type: GLenum; const lists: PGLvoid);stdcall; external OPenGL32;
  procedure glClearAccum(red: GLfloat; green: GLfloat; blue: GLfloat; alpha: GLfloat);stdcall; external OPenGL32;
  procedure glClearIndex(c: GLfloat);stdcall; external OPenGL32;
  procedure glClipPlane(plane: GLenum; const equation: PGLdouble);stdcall; external OPenGL32; 
  procedure glColor3b(red: GLbyte; green: GLbyte; blue: GLbyte);stdcall; external OPenGL32; 
  procedure glColor3bv(const v: PGLbyte);stdcall; external OPenGL32; 
  procedure glColor3d(red: GLdouble; green: GLdouble; blue: GLdouble);stdcall; external OPenGL32; 
  procedure glColor3dv(const v: PGLdouble);stdcall; external OPenGL32; 
  procedure glColor3f(red: GLfloat; green: GLfloat; blue: GLfloat);stdcall; external OPenGL32; 
  procedure glColor3fv(const v: PGLfloat);stdcall; external OPenGL32; 
  procedure glColor3i(red: GLint; green: GLint; blue: GLint);stdcall; external OPenGL32; 
  procedure glColor3iv(const v: PGLint);stdcall; external OPenGL32; 
  procedure glColor3s(red: GLshort; green: GLshort; blue: GLshort);stdcall; external OPenGL32; 
  procedure glColor3sv(const v: PGLshort);stdcall; external OPenGL32; 
  procedure glColor3ub(red: GLubyte; green: GLubyte; blue: GLubyte);stdcall; external OPenGL32; 
  procedure glColor3ubv(const v: PGLubyte);stdcall; external OPenGL32; 
  procedure glColor3ui(red: GLuint; green: GLuint; blue: GLuint);stdcall; external OPenGL32; 
  procedure glColor3uiv(const v: PGLuint);stdcall; external OPenGL32; 
  procedure glColor3us(red: GLushort; green: GLushort; blue: GLushort);stdcall; external OPenGL32; 
  procedure glColor3usv(const v: PGLushort);stdcall; external OPenGL32; 
  procedure glColor4b(red: GLbyte; green: GLbyte; blue: GLbyte; alpha: GLbyte);stdcall; external OPenGL32; 
  procedure glColor4bv(const v: PGLbyte);stdcall; external OPenGL32; 
  procedure glColor4d(red: GLdouble; green: GLdouble; blue: GLdouble; alpha: GLdouble);stdcall; external OPenGL32; 
  procedure glColor4dv(const v: PGLdouble);stdcall; external OPenGL32; 
  procedure glColor4f(red: GLfloat; green: GLfloat; blue: GLfloat; alpha: GLfloat);stdcall; external OPenGL32; 
  procedure glColor4fv(const v: PGLfloat);stdcall; external OPenGL32; 
  procedure glColor4i(red: GLint; green: GLint; blue: GLint; alpha: GLint);stdcall; external OPenGL32; 
  procedure glColor4iv(const v: PGLint);stdcall; external OPenGL32; 
  procedure glColor4s(red: GLshort; green: GLshort; blue: GLshort; alpha: GLshort);stdcall; external OPenGL32; 
  procedure glColor4sv(const v: PGLshort);stdcall; external OPenGL32; 
  procedure glColor4ub(red: GLubyte; green: GLubyte; blue: GLubyte; alpha: GLubyte);stdcall; external OPenGL32; 
  procedure glColor4ubv(const v: PGLubyte);stdcall; external OPenGL32; 
  procedure glColor4ui(red: GLuint; green: GLuint; blue: GLuint; alpha: GLuint);stdcall; external OPenGL32; 
  procedure glColor4uiv(const v: PGLuint);stdcall; external OPenGL32; 
  procedure glColor4us(red: GLushort; green: GLushort; blue: GLushort; alpha: GLushort);stdcall; external OPenGL32; 
  procedure glColor4usv(const v: PGLushort);stdcall; external OPenGL32; 
  procedure glColorMaterial(face: GLenum; mode: GLenum);stdcall; external OPenGL32; 
  procedure glColorPointer(size: GLint; _type: GLenum; stride: GLsizei; const _pointer: PGLvoid);stdcall; external OPenGL32; 
  procedure glCopyPixels(x: GLint; y: GLint; width: GLsizei; height: GLsizei; _type: GLenum);stdcall; external OPenGL32;
  procedure glDeleteLists(list: GLuint; range: GLsizei);stdcall; external OPenGL32; 
  procedure glDisableClientState(_array: GLenum);stdcall; external OPenGL32; 
  procedure glDrawPixels(width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; const pixels: PGLvoid);stdcall; external OPenGL32; 
  procedure glEdgeFlag(flag: GLboolean);stdcall; external OPenGL32; 
  procedure glEdgeFlagPointer(stride: GLsizei; const _pointer: PGLvoid);stdcall; external OPenGL32; 
  procedure glEdgeFlagv(const flag: PGLboolean);stdcall; external OPenGL32; 
  procedure glEnableClientState(_array: GLenum);stdcall; external OPenGL32; 
  procedure glEnd();stdcall; external OPenGL32; 
  procedure glEndList();stdcall; external OPenGL32;
  procedure glEvalCoord1d(u: GLdouble);stdcall; external OPenGL32; 
  procedure glEvalCoord1dv(const u: PGLdouble);stdcall; external OPenGL32; 
  procedure glEvalCoord1f(u: GLfloat);stdcall; external OPenGL32; 
  procedure glEvalCoord1fv(const u: PGLfloat);stdcall; external OPenGL32; 
  procedure glEvalCoord2d(u: GLdouble; v: GLdouble);stdcall; external OPenGL32; 
  procedure glEvalCoord2dv(const u: PGLdouble);stdcall; external OPenGL32; 
  procedure glEvalCoord2f(u: GLfloat; v: GLfloat);stdcall; external OPenGL32; 
  procedure glEvalCoord2fv(const u: PGLfloat);stdcall; external OPenGL32; 
  procedure glEvalMesh1(mode: GLenum; i1: GLint; i2: GLint);stdcall; external OPenGL32; 
  procedure glEvalMesh2(mode: GLenum; i1: GLint; i2: GLint; j1: GLint; j2: GLint);stdcall; external OPenGL32; 
  procedure glEvalPoint1(i: GLint);stdcall; external OPenGL32; 
  procedure glEvalPoint2(i: GLint; j: GLint);stdcall; external OPenGL32; 
  procedure glFeedbackBuffer(size: GLsizei; _type: GLenum; buffer: PGLfloat);stdcall; external OPenGL32; 
  procedure glFogf(pname: GLenum; param: GLfloat);stdcall; external OPenGL32; 
  procedure glFogfv(pname: GLenum; const params: PGLfloat);stdcall; external OPenGL32; 
  procedure glFogi(pname: GLenum; param: GLint);stdcall; external OPenGL32; 
  procedure glFogiv(pname: GLenum; const params: PGLint);stdcall; external OPenGL32;
  procedure glFrustum(left: GLdouble; right: GLdouble; bottom: GLdouble; top: GLdouble; zNear: GLdouble; zFar: GLdouble);stdcall; external OPenGL32;
  procedure glFrontFace(mode: GLenum);stdcall; external OPenGL32;
  function  glGenLists(range: GLsizei): GLuint;stdcall; external OPenGL32; 
  procedure glGetClipPlane(plane: GLenum; equation: PGLdouble);stdcall; external OPenGL32; 
  procedure glGetLightfv(light: GLenum; pname: GLenum; params: PGLfloat);stdcall; external OPenGL32; 
  procedure glGetLightiv(light: GLenum; pname: GLenum; params: PGLint);stdcall; external OPenGL32; 
  procedure glGetMapdv(target: GLenum; query: GLenum; v: PGLdouble);stdcall; external OPenGL32; 
  procedure glGetMapfv(target: GLenum; query: GLenum; v: PGLfloat);stdcall; external OPenGL32; 
  procedure glGetMapiv(target: GLenum; query: GLenum; v: PGLint);stdcall; external OPenGL32; 
  procedure glGetMaterialfv(face: GLenum; pname: GLenum; params: PGLfloat);stdcall; external OPenGL32; 
  procedure glGetMaterialiv(face: GLenum; pname: GLenum; params: PGLint);stdcall; external OPenGL32; 
  procedure glGetPixelMapfv(map: GLenum; values: PGLfloat);stdcall; external OPenGL32; 
  procedure glGetPixelMapuiv(map: GLenum; values: PGLuint);stdcall; external OPenGL32; 
  procedure glGetPixelMapusv(map: GLenum; values: PGLushort);stdcall; external OPenGL32; 
  procedure glGetPolygonStipple(mask: PGLubyte);stdcall; external OPenGL32; 
  procedure glGetTexEnvfv(target: GLenum; pname: GLenum; params: PGLfloat);stdcall; external OPenGL32; 
  procedure glGetTexEnviv(target: GLenum; pname: GLenum; params: PGLint);stdcall; external OPenGL32; 
  procedure glGetTexGendv(coord: GLenum; pname: GLenum; params: PGLdouble);stdcall; external OPenGL32; 
  procedure glGetTexGenfv(coord: GLenum; pname: GLenum; params: PGLfloat);stdcall; external OPenGL32; 
  procedure glGetTexGeniv(coord: GLenum; pname: GLenum; params: PGLint);stdcall; external OPenGL32;
  procedure glIndexMask(mask: GLuint);stdcall; external OPenGL32; 
  procedure glIndexPointer(_type: GLenum; stride: GLsizei; const _pointer: PGLvoid);stdcall; external OPenGL32; 
  procedure glIndexd(c: GLdouble);stdcall; external OPenGL32; 
  procedure glIndexdv(const c: PGLdouble);stdcall; external OPenGL32; 
  procedure glIndexf(c: GLfloat);stdcall; external OPenGL32; 
  procedure glIndexfv(const c: PGLfloat);stdcall; external OPenGL32; 
  procedure glIndexi(c: GLint);stdcall; external OPenGL32; 
  procedure glIndexiv(const c: PGLint);stdcall; external OPenGL32; 
  procedure glIndexs(c: GLshort);stdcall; external OPenGL32;
  procedure glIndexsv(const c: PGLshort);stdcall; external OPenGL32; 
  procedure glIndexub(c: GLubyte);stdcall; external OPenGL32; 
  procedure glIndexubv(const c: PGLubyte);stdcall; external OPenGL32; 
  procedure glInitNames;stdcall; external OPenGL32; 
  procedure glInterleavedArrays(format: GLenum; stride: GLsizei; const _pointer: PGLvoid);stdcall; external OPenGL32; 
  function  glIsList(list: GLuint): GLboolean;stdcall; external OPenGL32; 
  function  glIsTexture(texture: GLuint): GLboolean;stdcall; external OPenGL32;
  procedure glLightModelf(pname: GLenum; param: GLfloat);stdcall; external OPenGL32; 
  procedure glLightModelfv(pname: GLenum; const params: PGLfloat);stdcall; external OPenGL32; 
  procedure glLightModeli(pname: GLenum; param: GLint);stdcall; external OPenGL32; 
  procedure glLightModeliv(pname: GLenum; const params: PGLint);stdcall; external OPenGL32; 
  procedure glLightf(light: GLenum; pname: GLenum; param: GLfloat);stdcall; external OPenGL32; 
  procedure glLightfv(light: GLenum; pname: GLenum; const params: PGLfloat);stdcall; external OPenGL32; 
  procedure glLighti(light: GLenum; pname: GLenum; param: GLint);stdcall; external OPenGL32; 
  procedure glLightiv(light: GLenum; pname: GLenum; const params: PGLint);stdcall; external OPenGL32; 
  procedure glLineStipple(factor: GLint; pattern: GLushort);stdcall; external OPenGL32; 
  procedure glListBase(base: GLuint);stdcall; external OPenGL32; 
  procedure glLoadIdentity;stdcall; external OPenGL32;
  procedure glLoadMatrixd(const m: PGLdouble);stdcall; external OPenGL32; 
  procedure glLoadMatrixf(const m: PGLfloat);stdcall; external OPenGL32; 
  procedure glLoadName(name: GLuint);stdcall; external OPenGL32; 
  procedure glMap1d(target: GLenum; u1: GLdouble; u2: GLdouble; stride: GLint; order: GLint; const points: PGLdouble);stdcall; external OPenGL32; 
  procedure glMap1f(target: GLenum; u1: GLfloat; u2: GLfloat; stride: GLint; order: GLint; const points: PGLfloat);stdcall; external OPenGL32; 
  procedure glMap2d(target: GLenum; u1: GLdouble; u2: GLdouble; ustride: GLint; uorder: GLint; v1: GLdouble; v2: GLdouble; vstride: GLint; vorder: GLint; const points: PGLdouble);stdcall; external OPenGL32; 
  procedure glMap2f(target: GLenum; u1: GLfloat; u2: GLfloat; ustride: GLint; uorder: GLint; v1: GLfloat; v2: GLfloat; vstride: GLint; vorder: GLint; const points: PGLfloat);stdcall; external OPenGL32; 
  procedure glMapGrid1d(un: GLint; u1: GLdouble; u2: GLdouble);stdcall; external OPenGL32; 
  procedure glMapGrid1f(un: GLint; u1: GLfloat; u2: GLfloat);stdcall; external OPenGL32; 
  procedure glMapGrid2d(un: GLint; u1: GLdouble; u2: GLdouble; vn: GLint; v1: GLdouble; v2: GLdouble);stdcall; external OPenGL32; 
  procedure glMapGrid2f(un: GLint; u1: GLfloat; u2: GLfloat; vn: GLint; v1: GLfloat; v2: GLfloat);stdcall; external OPenGL32; 
  procedure glMaterialf(face: GLenum; pname: GLenum; param: GLfloat);stdcall; external OPenGL32; 
  procedure glMaterialfv(face: GLenum; pname: GLenum; const params: PGLfloat);stdcall; external OPenGL32; 
  procedure glMateriali(face: GLenum; pname: GLenum; param: GLint);stdcall; external OPenGL32; 
  procedure glMaterialiv(face: GLenum; pname: GLenum; const params: PGLint);stdcall; external OPenGL32; 
  procedure glMatrixMode(mode: GLenum);stdcall; external OPenGL32; 
  procedure glMultMatrixd(const m: PGLdouble);stdcall; external OPenGL32; 
  procedure glMultMatrixf(const m: PGLfloat);stdcall; external OPenGL32;
  procedure glNewList(list: GLuint; mode: GLenum);stdcall; external OPenGL32; 
  procedure glNormal3b(nx: GLbyte; ny: GLbyte; nz: GLbyte);stdcall; external OPenGL32; 
  procedure glNormal3bv(const v: PGLbyte);stdcall; external OPenGL32; 
  procedure glNormal3d(nx: GLdouble; ny: GLdouble; nz: GLdouble);stdcall; external OPenGL32; 
  procedure glNormal3dv(const v: PGLdouble);stdcall; external OPenGL32; 
  procedure glNormal3f(nx: GLfloat; ny: GLfloat; nz: GLfloat);stdcall; external OPenGL32; 
  procedure glNormal3fv(const v: PGLfloat);stdcall; external OPenGL32; 
  procedure glNormal3i(nx: GLint; ny: GLint; nz: GLint);stdcall; external OPenGL32; 
  procedure glNormal3iv(const v: PGLint);stdcall; external OPenGL32;
  procedure glNormal3s(nx: GLshort; ny: GLshort; nz: GLshort);stdcall; external OPenGL32; 
  procedure glNormal3sv(const v: PGLshort);stdcall; external OPenGL32; 
  procedure glNormalPointer(_type: GLenum; stride: GLsizei; const _pointer: PGLvoid);stdcall; external OPenGL32; 
  procedure glOrtho(left: GLdouble; right: GLdouble; bottom: GLdouble; top: GLdouble; zNear: GLdouble; zFar: GLdouble);stdcall; external OPenGL32; 
  procedure glPassThrough(token: GLfloat);stdcall; external OPenGL32; 
  procedure glPixelMapfv(map: GLenum; mapsize: GLsizei; const values: PGLfloat);stdcall; external OPenGL32; 
  procedure glPixelMapuiv(map: GLenum; mapsize: GLsizei; const values: PGLuint);stdcall; external OPenGL32; 
  procedure glPixelMapusv(map: GLenum; mapsize: GLsizei; const values: PGLushort);stdcall; external OPenGL32; 
  procedure glPixelTransferf(pname: GLenum; param: GLfloat);stdcall; external OPenGL32; 
  procedure glPixelTransferi(pname: GLenum; param: GLint);stdcall; external OPenGL32; 
  procedure glPixelZoom(xfactor: GLfloat; yfactor: GLfloat);stdcall; external OPenGL32; 
  procedure glPolygonStipple(const mask: PGLubyte);stdcall; external OPenGL32; 
  procedure glPopAttrib();stdcall; external OPenGL32; 
  procedure glPopClientAttrib();stdcall; external OPenGL32; 
  procedure glPopMatrix();stdcall; external OPenGL32; 
  procedure glPopName();stdcall; external OPenGL32; 
  procedure glPrioritizeTextures(n: GLsizei; const textures: PGLuint; const priorities: PGLclampf);stdcall; external OPenGL32; 
  procedure glPushAttrib(mask: GLbitfield);stdcall; external OPenGL32; 
  procedure glPushClientAttrib(mask: GLbitfield);stdcall; external OPenGL32; 
  procedure glPushMatrix();stdcall; external OPenGL32; 
  procedure glPushName(name: GLuint);stdcall; external OPenGL32; 
  procedure glRasterPos2d(x: GLdouble; y: GLdouble);stdcall; external OPenGL32; 
  procedure glRasterPos2dv(const v: PGLdouble);stdcall; external OPenGL32; 
  procedure glRasterPos2f(x: GLfloat; y: GLfloat);stdcall; external OPenGL32; 
  procedure glRasterPos2fv(const v: PGLfloat);stdcall; external OPenGL32; 
  procedure glRasterPos2i(x: GLint; y: GLint);stdcall; external OPenGL32; 
  procedure glRasterPos2iv(const v: PGLint);stdcall; external OPenGL32; 
  procedure glRasterPos2s(x: GLshort; y: GLshort);stdcall; external OPenGL32; 
  procedure glRasterPos2sv(const v: PGLshort);stdcall; external OPenGL32; 
  procedure glRasterPos3d(x: GLdouble; y: GLdouble; z: GLdouble);stdcall; external OPenGL32; 
  procedure glRasterPos3dv(const v: PGLdouble);stdcall; external OPenGL32; 
  procedure glRasterPos3f(x: GLfloat; y: GLfloat; z: GLfloat);stdcall; external OPenGL32; 
  procedure glRasterPos3fv(const v: PGLfloat);stdcall; external OPenGL32; 
  procedure glRasterPos3i(x: GLint; y: GLint; z: GLint);stdcall; external OPenGL32; 
  procedure glRasterPos3iv(const v: PGLint);stdcall; external OPenGL32; 
  procedure glRasterPos3s(x: GLshort; y: GLshort; z: GLshort);stdcall; external OPenGL32;
  procedure glRasterPos3sv(const v: PGLshort);stdcall; external OPenGL32; 
  procedure glRasterPos4d(x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);stdcall; external OPenGL32; 
  procedure glRasterPos4dv(const v: PGLdouble);stdcall; external OPenGL32; 
  procedure glRasterPos4f(x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);stdcall; external OPenGL32; 
  procedure glRasterPos4fv(const v: PGLfloat);stdcall; external OPenGL32; 
  procedure glRasterPos4i(x: GLint; y: GLint; z: GLint; w: GLint);stdcall; external OPenGL32; 
  procedure glRasterPos4iv(const v: PGLint);stdcall; external OPenGL32; 
  procedure glRasterPos4s(x: GLshort; y: GLshort; z: GLshort; w: GLshort);stdcall; external OPenGL32; 
  procedure glRasterPos4sv(const v: PGLshort);stdcall; external OPenGL32;
  procedure glRectd(x1: GLdouble; y1: GLdouble; x2: GLdouble; y2: GLdouble);stdcall; external OPenGL32; 
  procedure glRectdv(const v1: PGLdouble; const v2: PGLdouble);stdcall; external OPenGL32; 
  procedure glRectf(x1: GLfloat; y1: GLfloat; x2: GLfloat; y2: GLfloat);stdcall; external OPenGL32; 
  procedure glRectfv(const v1: PGLfloat; const v2: PGLfloat);stdcall; external OPenGL32; 
  procedure glRecti(x1: GLint; y1: GLint; x2: GLint; y2: GLint);stdcall; external OPenGL32; 
  procedure glRectiv(const v1: PGLint; const v2: PGLint);stdcall; external OPenGL32; 
  procedure glRects(x1: GLshort; y1: GLshort; x2: GLshort; y2: GLshort);stdcall; external OPenGL32; 
  procedure glRectsv(const v1: PGLshort; const v2: PGLshort);stdcall; external OPenGL32; 
  function  glRenderMode(mode: GLenum): GLint;stdcall; external OPenGL32; 
  procedure glRotated(angle: GLdouble; x: GLdouble; y: GLdouble; z: GLdouble);stdcall; external OPenGL32; 
  procedure glRotatef(angle: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);stdcall; external OPenGL32; 
  procedure glScaled(x: GLdouble; y: GLdouble; z: GLdouble);stdcall; external OPenGL32; 
  procedure glScalef(x: GLfloat; y: GLfloat; z: GLfloat);stdcall; external OPenGL32; 
  procedure glSelectBuffer(size: GLsizei; buffer: PGLuint);stdcall; external OPenGL32; 
  procedure glShadeModel(mode: GLenum);stdcall; external OPenGL32; 
  procedure glTexCoord1d(s: GLdouble);stdcall; external OPenGL32; 
  procedure glTexCoord1dv(const v: PGLdouble);stdcall; external OPenGL32; 
  procedure glTexCoord1f(s: GLfloat);stdcall; external OPenGL32; 
  procedure glTexCoord1fv(const v: PGLfloat);stdcall; external OPenGL32; 
  procedure glTexCoord1i(s: GLint);stdcall; external OPenGL32; 
  procedure glTexCoord1iv(const v: PGLint);stdcall; external OPenGL32; 
  procedure glTexCoord1s(s: GLshort);stdcall; external OPenGL32; 
  procedure glTexCoord1sv(const v: PGLshort);stdcall; external OPenGL32; 
  procedure glTexCoord2d(s: GLdouble; t: GLdouble);stdcall; external OPenGL32; 
  procedure glTexCoord2dv(const v: PGLdouble);stdcall; external OPenGL32; 
  procedure glTexCoord2f(s: GLfloat; t: GLfloat);stdcall; external OPenGL32; 
  procedure glTexCoord2fv(const v: PGLfloat);stdcall; external OPenGL32; 
  procedure glTexCoord2i(s: GLint; t: GLint);stdcall; external OPenGL32; 
  procedure glTexCoord2iv(const v: PGLint);stdcall; external OPenGL32; 
  procedure glTexCoord2s(s: GLshort; t: GLshort);stdcall; external OPenGL32; 
  procedure glTexCoord2sv(const v: PGLshort);stdcall; external OPenGL32; 
  procedure glTexCoord3d(s: GLdouble; t: GLdouble; r: GLdouble);stdcall; external OPenGL32; 
  procedure glTexCoord3dv(const v: PGLdouble);stdcall; external OPenGL32; 
  procedure glTexCoord3f(s: GLfloat; t: GLfloat; r: GLfloat);stdcall; external OPenGL32;
  const
  GL_BUFFER_SIZE = $8764;
  GL_BUFFER_USAGE = $8765;
  GL_QUERY_COUNTER_BITS = $8864;
  GL_CURRENT_QUERY = $8865;
  GL_QUERY_RESULT = $8866;
  GL_QUERY_RESULT_AVAILABLE = $8867;
  GL_ARRAY_BUFFER = $8892;
  GL_ELEMENT_ARRAY_BUFFER = $8893;
  GL_ARRAY_BUFFER_BINDING = $8894;
  GL_ELEMENT_ARRAY_BUFFER_BINDING = $8895;
  GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = $889F;
  GL_READ_ONLY = $88B8;
  GL_WRITE_ONLY = $88B9;
  GL_READ_WRITE = $88BA;
  GL_BUFFER_ACCESS = $88BB;
  GL_BUFFER_MAPPED = $88BC;
  GL_BUFFER_MAP_POINTER = $88BD;
  GL_STREAM_DRAW = $88E0;
  GL_STREAM_READ = $88E1;
  GL_STREAM_COPY = $88E2;
  GL_STATIC_DRAW = $88E4;
  GL_STATIC_READ = $88E5;
  GL_STATIC_COPY = $88E6;
  GL_DYNAMIC_DRAW = $88E8;
  GL_DYNAMIC_READ = $88E9;
  GL_DYNAMIC_COPY = $88EA;
  GL_SAMPLES_PASSED = $8914;
  GL_VERTEX_ARRAY_BUFFER_BINDING = $8896;
  GL_NORMAL_ARRAY_BUFFER_BINDING = $8897;
  GL_COLOR_ARRAY_BUFFER_BINDING = $8898;
  GL_INDEX_ARRAY_BUFFER_BINDING = $8899;
  GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING = $889A;
  GL_EDGE_FLAG_ARRAY_BUFFER_BINDING = $889B;
  GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING = $889C;
  GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING = $889D;
  GL_WEIGHT_ARRAY_BUFFER_BINDING = $889E;
  GL_FOG_COORD_SRC = $8450;
  GL_FOG_COORD = $8451;
  GL_CURRENT_FOG_COORD = $8453;
  GL_FOG_COORD_ARRAY_TYPE = $8454;
  GL_FOG_COORD_ARRAY_STRIDE = $8455;
  GL_FOG_COORD_ARRAY_POINTER = $8456;
  GL_FOG_COORD_ARRAY = $8457;
  GL_FOG_COORD_ARRAY_BUFFER_BINDING = $889D;
  GL_SRC0_RGB = $8580;
  GL_SRC1_RGB = $8581;
  GL_SRC2_RGB = $8582;
  GL_SRC0_ALPHA = $8588;
  GL_SRC1_ALPHA = $8589;
  GL_SRC2_ALPHA = $858A;

  procedure glTexCoord3i(s: GLint; t: GLint; r: GLint);stdcall; external OPenGL32;
  procedure glTexCoord3iv(const v: PGLint);stdcall; external OPenGL32;
  procedure glTexCoord3s(s: GLshort; t: GLshort; r: GLshort);stdcall; external OPenGL32;
  procedure glTexCoord3sv(const v: PGLshort);stdcall; external OPenGL32;
  procedure glTexCoord4d(s: GLdouble; t: GLdouble; r: GLdouble; q: GLdouble);stdcall; external OPenGL32;
  procedure glTexCoord4dv(const v: PGLdouble);stdcall; external OPenGL32;
  procedure glTexCoord4f(s: GLfloat; t: GLfloat; r: GLfloat; q: GLfloat);stdcall; external OPenGL32;
  procedure glTexCoord4fv(const v: PGLfloat);stdcall; external OPenGL32;
  procedure glTexCoord4i(s: GLint; t: GLint; r: GLint; q: GLint);stdcall; external OPenGL32;
  procedure glTexCoord4iv(const v: PGLint);stdcall; external OPenGL32;
  procedure glTexCoord4s(s: GLshort; t: GLshort; r: GLshort; q: GLshort);stdcall; external OPenGL32; 
  procedure glTexCoord4sv(const v: PGLshort);stdcall; external OPenGL32; 
  procedure glTexCoordPointer(size: GLint; _type: GLenum; stride: GLsizei; const _pointer: PGLvoid);stdcall; external OPenGL32; 
  procedure glTexEnvf(target: GLenum; pname: GLenum; param: GLfloat);stdcall; external OPenGL32; 
  procedure glTexEnvfv(target: GLenum; pname: GLenum; const params: PGLfloat);stdcall; external OPenGL32; 
  procedure glTexEnvi(target: GLenum; pname: GLenum; param: GLint);stdcall; external OPenGL32; 
  procedure glTexEnviv(target: GLenum; pname: GLenum; const params: PGLint);stdcall; external OPenGL32; 
  procedure glTexGend(coord: GLenum; pname: GLenum; param: GLdouble);stdcall; external OPenGL32; 
  procedure glTexGendv(coord: GLenum; pname: GLenum; const params: PGLdouble);stdcall; external OPenGL32; 
  procedure glTexGenf(coord: GLenum; pname: GLenum; param: GLfloat);stdcall; external OPenGL32; 
  procedure glTexGenfv(coord: GLenum; pname: GLenum; const params: PGLfloat);stdcall; external OPenGL32; 
  procedure glTexGeni(coord: GLenum; pname: GLenum; param: GLint);stdcall; external OPenGL32; 
  procedure glTexGeniv(coord: GLenum; pname: GLenum; const params: PGLint);stdcall; external OPenGL32; 
  procedure glTranslated(x: GLdouble; y: GLdouble; z: GLdouble);stdcall; external OPenGL32; 
  procedure glTranslatef(x: GLfloat; y: GLfloat; z: GLfloat);stdcall; external OPenGL32; 
  procedure glVertex2d(x: GLdouble; y: GLdouble);stdcall; external OPenGL32; 
  procedure glVertex2dv(const v: PGLdouble);stdcall; external OPenGL32; 
  procedure glVertex2f(x: GLfloat; y: GLfloat);stdcall; external OPenGL32; 
  procedure glVertex2fv(const v: PGLfloat);stdcall; external OPenGL32; 
  procedure glVertex2i(x: GLint; y: GLint);stdcall; external OPenGL32; 
  procedure glVertex2iv(const v: PGLint);stdcall; external OPenGL32; 
  procedure glVertex2s(x: GLshort; y: GLshort);stdcall; external OPenGL32; 
  procedure glVertex2sv(const v: PGLshort);stdcall; external OPenGL32; 
  procedure glVertex3d(x: GLdouble; y: GLdouble; z: GLdouble);stdcall; external OPenGL32; 
  procedure glVertex3dv(const v: PGLdouble);stdcall; external OPenGL32; 
  procedure glVertex3f(x: GLfloat; y: GLfloat; z: GLfloat);stdcall; external OPenGL32; 
  procedure glVertex3fv(const v: PGLfloat);stdcall; external OPenGL32; 
  procedure glVertex3i(x: GLint; y: GLint; z: GLint);stdcall; external OPenGL32; 
  procedure glVertex3iv(const v: PGLint);stdcall; external OPenGL32; 
  procedure glVertex3s(x: GLshort; y: GLshort; z: GLshort);stdcall; external OPenGL32; 
  procedure glVertex3sv(const v: PGLshort);stdcall; external OPenGL32; 
  procedure glVertex4d(x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);stdcall; external OPenGL32; 
  procedure glVertex4dv(const v: PGLdouble);stdcall; external OPenGL32; 
  procedure glVertex4f(x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);stdcall; external OPenGL32; 
  procedure glVertex4fv(const v: PGLfloat);stdcall; external OPenGL32; 
  procedure glVertex4i(x: GLint; y: GLint; z: GLint; w: GLint);stdcall; external OPenGL32;
  procedure glVertex4iv(const v: PGLint);stdcall; external OPenGL32; 
  procedure glVertex4s(x: GLshort; y: GLshort; z: GLshort; w: GLshort);stdcall; external OPenGL32; 
  procedure glVertex4sv(const v: PGLshort);stdcall; external OPenGL32; 
  procedure glVertexPointer(size: GLint; _type: GLenum; stride: GLsizei; const _pointer: PGLvoid);stdcall; external OPenGL32; 

  // GL_VERSION_1_0
  procedure glCullFace(mode: GLenum); stdcall;external OpenGL32;
  procedure glHint(target: GLenum; mode: GLenum); stdcall;external OpenGL32;
  procedure glLineWidth(width: GLfloat); stdcall;external OpenGL32;
  procedure glPointSize(size: GLfloat); stdcall;external OpenGL32;
  procedure glPolygonMode(face: GLenum; mode: GLenum); stdcall;external OpenGL32;
  procedure glScissor(x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall;external OpenGL32;
  procedure glTexParameterf(target: GLenum; pname: GLenum; param: GLfloat); stdcall;external OpenGL32;
  procedure glTexParameterfv(target: GLenum; pname: GLenum; const params: PGLfloat); stdcall;external OpenGL32;
  procedure glTexParameteri(target: GLenum; pname: GLenum; param: GLint); stdcall;external OpenGL32;
  procedure glTexParameteriv(target: GLenum; pname: GLenum; const params: PGLint); stdcall;external OpenGL32;
  procedure glTexImage1D(target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; border: GLint; format: GLenum; _type: GLenum; const pixels: PGLvoid); stdcall;external OpenGL32;
  procedure glTexImage2D(target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; height: GLsizei; border: GLint; format: GLenum; _type: GLenum;var pixels); stdcall;external OpenGL32;
  procedure glDrawBuffer(mode: GLenum); stdcall;external OpenGL32;
  procedure glClear(mask: GLbitfield); stdcall;external OpenGL32;
  procedure glClearColor(red: GLclampf; green: GLclampf; blue: GLclampf; alpha: GLclampf); stdcall;external OpenGL32;
  procedure glClearStencil(s: GLint); stdcall;external OpenGL32;
  procedure glClearDepth(depth: GLclampd); stdcall;external OpenGL32;
  procedure glStencilMask(mask: GLuint); stdcall;external OpenGL32;
  procedure glColorMask(red: GLboolean; green: GLboolean; blue: GLboolean; alpha: GLboolean); stdcall;external OpenGL32;
  procedure glDepthMask(flag: GLboolean); stdcall;external OpenGL32;
  procedure glDisable(cap: GLenum); stdcall;external OpenGL32;
  procedure glEnable(cap: GLenum); stdcall;external OpenGL32;
  procedure glFinish; stdcall;external OpenGL32;
  procedure glFlush; stdcall;external OpenGL32;
  procedure glBlendFunc(sfactor: GLenum; dfactor: GLenum); stdcall;external OpenGL32;
  procedure glLogicOp(opcode: GLenum); stdcall;external OpenGL32;
  procedure glStencilFunc(func: GLenum; ref: GLint; mask: GLuint); stdcall;external OpenGL32;
  procedure glStencilOp(fail: GLenum; zfail: GLenum; zpass: GLenum); stdcall;external OpenGL32;
  procedure glDepthFunc(func: GLenum); stdcall;external OpenGL32;
  procedure glPixelStoref(pname: GLenum; param: GLfloat); stdcall;external OpenGL32;
  procedure glPixelStorei(pname: GLenum; param: GLint); stdcall;external OpenGL32;
  procedure glReadBuffer(mode: GLenum); stdcall;external OpenGL32;
  procedure glReadPixels(x: GLint; y: GLint; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; pixels: PGLvoid); stdcall;external OpenGL32;
  procedure glGetBooleanv(pname: GLenum; params: PGLboolean); stdcall;external OpenGL32;
  procedure glGetDoublev(pname: GLenum; params: PGLdouble); stdcall;external OpenGL32;
  function  glGetError: GLenum; stdcall;external OpenGL32;
  procedure glGetFloatv(pname: GLenum; params: PGLfloat); stdcall;external OpenGL32;
  procedure glGetIntegerv(pname: GLenum; params: PGLint); stdcall;external OpenGL32;
  function  glGetString(name: GLenum): PAnsiChar; stdcall;external OpenGL32;
  procedure glGetTexImage(target: GLenum; level: GLint; format: GLenum; _type: GLenum; pixels: PGLvoid); stdcall;external OpenGL32;
  procedure glGetTexParameteriv(target: GLenum; pname: GLenum; params: PGLint); stdcall;external OpenGL32;
  procedure glGetTexParameterfv(target: GLenum; pname: GLenum; params: PGLfloat); stdcall;external OpenGL32;
  procedure glGetTexLevelParameterfv(target: GLenum; level: GLint; pname: GLenum; params: PGLfloat); stdcall;external OpenGL32;
  procedure glGetTexLevelParameteriv(target: GLenum; level: GLint; pname: GLenum; params: PGLint); stdcall;external OpenGL32;
  function  glIsEnabled(cap: GLenum): GLboolean; stdcall;external OpenGL32;
  procedure glDepthRange(zNear: GLclampd; zFar: GLclampd); stdcall;external OpenGL32;
  procedure glViewport(x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall;external OpenGL32;

  // GL_VERSION_1_1
  procedure glDrawArrays(mode: GLenum; first: GLint; count: GLsizei); stdcall;external OpenGL32;
  procedure glDrawElements(mode: GLenum; count: GLsizei; _type: GLenum; const indices: PGLvoid); stdcall;external OpenGL32;
  procedure glGetPointerv(pname: GLenum; params: PGLvoid); stdcall;external OpenGL32;
  procedure glPolygonOffset(factor: GLfloat; units: GLfloat); stdcall;external OpenGL32;
  procedure glCopyTexImage1D(target: GLenum; level: GLint; internalFormat: GLenum; x: GLint; y: GLint; width: GLsizei; border: GLint); stdcall;external OpenGL32;
  procedure glCopyTexImage2D(target: GLenum; level: GLint; internalFormat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei; border: GLint); stdcall;external OpenGL32;
  procedure glCopyTexSubImage1D(target: GLenum; level: GLint; xoffset: GLint; x: GLint; y: GLint; width: GLsizei); stdcall;external OpenGL32;
  procedure glCopyTexSubImage2D(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall;external OpenGL32;
  procedure glTexSubImage1D(target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; _type: GLenum; const pixels: PGLvoid); stdcall;external OpenGL32;
  procedure glTexSubImage2D(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; const pixels: PGLvoid); stdcall;external OpenGL32;
  procedure glBindTexture(target: GLenum; texture: GLuint); stdcall;external OpenGL32;
  procedure glDeleteTextures(n: GLsizei; const textures: PGLuint); stdcall;external OpenGL32;
  procedure glGenTextures(n: GLsizei;out textures); stdcall;external OpenGL32;

var
  GL_VERSION_1_0,
  GL_VERSION_1_1,
  GL_VERSION_1_2,
  GL_VERSION_1_3,
  GL_VERSION_1_4,
  GL_VERSION_1_5,
  GL_VERSION_2_0,
  GL_VERSION_2_1,
  GL_VERSION_3_0,
  GL_VERSION_3_1,
  GL_VERSION_3_2,
  GL_VERSION_3_3,
  GL_VERSION_4_0,
  GL_VERSION_4_1,
  GL_VERSION_4_2,
  GL_VERSION_4_3,
  GL_VERSION_4_4,
  GL_VERSION_4_5,
  GLU_VERSION_1_1,
  GLU_VERSION_1_2,
  GLU_VERSION_1_3,
  GL_3DFX_multisample,
  GL_3DFX_tbuffer,
  GL_3DFX_texture_compression_FXT1,
  GL_APPLE_client_storage,
  GL_APPLE_element_array,
  GL_APPLE_fence,
  GL_APPLE_specular_vector,
  GL_APPLE_transform_hint,
  GL_APPLE_vertex_array_object,
  GL_APPLE_vertex_array_range,
  GL_APPLE_ycbcr_422,
  GL_APPLE_texture_range,
  GL_APPLE_float_pixels,
  GL_APPLE_vertex_program_evaluators,
  GL_APPLE_aux_depth_stencil,
  GL_APPLE_object_purgeable,
  GL_APPLE_row_bytes,
  GL_APPLE_rgb_422,
  GL_ARB_depth_texture,
  GL_ARB_fragment_program,
  GL_ARB_imaging,
  GL_ARB_matrix_palette,
  GL_ARB_multisample,
  GL_ARB_multitexture,
  GL_ARB_point_parameters,
  GL_ARB_shadow,
  GL_ARB_shadow_ambient,
  GL_ARB_texture_border_clamp,
  GL_ARB_texture_compression,
  GL_ARB_texture_cube_map,
  GL_ARB_texture_env_add,
  GL_ARB_texture_env_combine,
  GL_ARB_texture_env_crossbar,
  GL_ARB_texture_env_dot3,
  GL_ARB_texture_mirrored_repeat,
  GL_ARB_transpose_matrix,
  GL_ARB_vertex_blend,
  GL_ARB_vertex_buffer_object,
  GL_ARB_vertex_program,
  GL_ARB_window_pos,
  GL_ARB_shader_objects,
  GL_ARB_vertex_shader,
  GL_ARB_fragment_shader,
  GL_ARB_shading_language_100,
  GL_ARB_occlusion_query,
  GL_ARB_texture_non_power_of_two,
  GL_ARB_point_sprite,
  GL_ARB_fragment_program_shadow,
  GL_ARB_draw_buffers,
  GL_ARB_texture_rectangle,
  GL_ARB_color_buffer_float,
  GL_ARB_half_float_pixel,
  GL_ARB_texture_float,
  GL_ARB_pixel_buffer_object,
  GL_ARB_depth_buffer_float,
  GL_ARB_draw_instanced,
  GL_ARB_framebuffer_object,
  GL_ARB_framebuffer_sRGB,
  GL_ARB_geometry_shader4,
  GL_ARB_half_float_vertex,
  GL_ARB_instanced_arrays,
  GL_ARB_map_buffer_range,
  GL_ARB_texture_buffer_object,
  GL_ARB_texture_compression_rgtc,
  GL_ARB_texture_rg,
  GL_ARB_vertex_array_object,
  GL_ARB_uniform_buffer_object,
  GL_ARB_compatibility,
  GL_ARB_copy_buffer,
  GL_ARB_shader_texture_lod,
  GL_ARB_depth_clamp,
  GL_ARB_draw_elements_base_vertex,
  GL_ARB_fragment_coord_conventions,
  GL_ARB_provoking_vertex,
  GL_ARB_seamless_cube_map,
  GL_ARB_sync,
  GL_ARB_texture_multisample,
  GL_ARB_vertex_array_bgra,
  GL_ARB_draw_buffers_blend,
  GL_ARB_sample_shading,
  GL_ARB_texture_cube_map_array,
  GL_ARB_texture_gather,
  GL_ARB_texture_query_lod,
  GL_ARB_shading_language_include,
  GL_ARB_texture_compression_bptc,
  GL_ARB_blend_func_extended,
  GL_ARB_explicit_attrib_location,
  GL_ARB_occlusion_query2,
  GL_ARB_sampler_objects,
  GL_ARB_shader_bit_encoding,
  GL_ARB_texture_rgb10_a2ui,
  GL_ARB_texture_swizzle,
  GL_ARB_timer_query,
  GL_ARB_vertex_type_2_10_10_10_rev,
  GL_ARB_draw_indirect,
  GL_ARB_gpu_shader5,
  GL_ARB_gpu_shader_fp64,
  GL_ARB_shader_subroutine,
  GL_ARB_tessellation_shader,
  GL_ARB_texture_buffer_object_rgb32,
  GL_ARB_transform_feedback2,
  GL_ARB_transform_feedback3,
  GL_ARB_ES2_compatibility,
  GL_ARB_get_program_binary,
  GL_ARB_separate_shader_objects,
  GL_ARB_shader_precision,
  GL_ARB_vertex_attrib_64bit,
  GL_ARB_viewport_array,

  // GL 4.2
  GL_ARB_base_instance,
  GL_ARB_shading_language_420pack,
  GL_ARB_transform_feedback_instanced,
  GL_ARB_compressed_texture_pixel_storage,
  GL_ARB_conservative_depth,
  GL_ARB_internalformat_query,
  GL_ARB_map_buffer_alignment,
  GL_ARB_shader_atomic_counters,
  GL_ARB_shader_image_load_store,
  GL_ARB_shading_language_packing,
  GL_ARB_texture_storage,


  // GL 4.3
  GL_ARB_arrays_of_arrays,
  GL_ARB_fragment_layer_viewport,
  GL_ARB_shader_image_size,
  GL_ARB_ES3_compatibility,
  GL_ARB_clear_buffer_object,
  GL_ARB_compute_shader,
  GL_ARB_copy_image,
  GL_KHR_debug,
  GL_ARB_explicit_uniform_location,
  GL_ARB_framebuffer_no_attachments,
  GL_ARB_internalformat_query2,
  GL_ARB_invalidate_subdata,
  GL_ARB_multi_draw_indirect,
  GL_ARB_program_interface_query,
  GL_ARB_robust_buffer_access_behavior,
  GL_ARB_shader_storage_buffer_object,
  GL_ARB_stencil_texturing,
  GL_ARB_texture_buffer_range,
  GL_ARB_texture_query_levels,
  GL_ARB_texture_storage_multisample,
  GL_ARB_texture_view,
  GL_ARB_vertex_attrib_binding,
  GL_NV_path_rendering,
  GL_AMD_pinned_memory,
  GL_AMD_stencil_operation_extended,
  GL_AMD_vertex_shader_viewport_index,
  GL_AMD_vertex_shader_layer,
  GL_NV_bindless_texture,
  GL_NV_shader_atomic_float,
  GL_AMD_query_buffer_object,


  // GL 4.4
  GL_ARB_buffer_storage,
  GL_ARB_clear_texture,
  GL_ARB_enhanced_layouts,
  GL_ARB_multi_bind,
  GL_ARB_query_buffer_object,
  GL_ARB_texture_mirror_clamp_to_edge,
  GL_ARB_texture_stencil8,
  GL_ARB_vertex_type_10f_11f_11f_rev,
  GL_ARB_bindless_texture,
  GL_ARB_sparse_texture,

  // GL 4.5
  GL_ARB_clip_control,
  GL_ARB_cull_distance,
  GL_ARB_ES3_1_compatibility,
  GL_ARB_conditional_render_inverted,
  GL_KHR_context_flush_control,
  GL_ARB_derivative_control,
  GL_ARB_direct_state_access,
  GL_ARB_get_texture_sub_image,
  GL_KHR_robustness,
  GL_KHR_blend_equation_advanced,
  GL_KHR_blend_equation_advanced_coherent,
  GL_KHR_robust_buffer_access_behavior,
  GL_ARB_shader_texture_image_samples,
  GL_ARB_texture_barrier,

  GL_ARB_cl_event,
  GL_ARB_compute_variable_group_size,
  GL_ARB_debug_output,
  GL_ARB_robustness,
  GL_ARB_shader_stencil_export,
  GL_ATI_draw_buffers,
  GL_ATI_element_array,
  GL_ATI_envmap_bumpmap,
  GL_ATI_fragment_shader,
  GL_ATI_map_object_buffer,
  GL_ATI_pn_triangles,
  GL_ATI_separate_stencil,
  GL_ATI_text_fragment_shader,
  GL_ATI_texture_env_combine3,
  GL_ATI_texture_float,
  GL_ATI_texture_mirror_once,
  GL_ATI_vertex_array_object,
  GL_ATI_vertex_attrib_array_object,
  GL_ATI_vertex_streams,
  GL_ATI_meminfo,
  GL_AMD_performance_monitor,
  GL_AMD_texture_texture4,
  GL_AMD_vertex_shader_tesselator,
  GL_AMD_draw_buffers_blend,
  GL_AMD_shader_stencil_export,
  GL_AMD_seamless_cubemap_per_texture,
  GL_AMD_conservative_depth,
  GL_AMD_name_gen_delete,
  GL_AMD_debug_output,
  GL_AMD_transform_feedback3_lines_triangles,
  GL_AMD_depth_clamp_separate,
  GL_EXT_422_pixels,
  GL_EXT_abgr,
  GL_EXT_bgra,
  GL_EXT_blend_color,
  GL_EXT_blend_func_separate,
  GL_EXT_blend_logic_op,
  GL_EXT_blend_minmax,
  GL_EXT_blend_subtract,
  GL_EXT_clip_volume_hint,
  GL_EXT_cmyka,
  GL_EXT_color_matrix,
  GL_EXT_color_subtable,
  GL_EXT_compiled_vertex_array,
  GL_EXT_convolution,
  GL_EXT_coordinate_frame,
  GL_EXT_copy_texture,
  GL_EXT_cull_vertex,
  GL_EXT_draw_range_elements,
  GL_EXT_fog_coord,
  GL_EXT_framebuffer_object,
  GL_EXT_histogram,
  GL_EXT_index_array_formats,
  GL_EXT_index_func,
  GL_EXT_index_material,
  GL_EXT_index_texture,
  GL_EXT_light_texture,
  GL_EXT_misc_attribute,
  GL_EXT_multi_draw_arrays,
  GL_EXT_multisample,
  GL_EXT_packed_pixels,
  GL_EXT_paletted_texture,
  GL_EXT_pixel_transform,
  GL_EXT_pixel_transform_color_table,
  GL_EXT_point_parameters,
  GL_EXT_polygon_offset,
  GL_EXT_rescale_normal,
  GL_EXT_secondary_color,
  GL_EXT_separate_specular_color,
  GL_EXT_shadow_funcs,
  GL_EXT_shared_texture_palette,
  GL_EXT_stencil_two_side,
  GL_EXT_stencil_wrap,
  GL_EXT_subtexture,
  GL_EXT_texture,
  GL_EXT_texture3D,
  GL_EXT_texture_compression_s3tc,
  GL_EXT_texture_cube_map,
  GL_EXT_texture_edge_clamp,
  GL_EXT_texture_env_add,
  GL_EXT_texture_env_combine,
  GL_EXT_texture_env_dot3,
  GL_EXT_texture_filter_anisotropic,
  GL_EXT_texture_lod_bias,
  GL_EXT_texture_object,
  GL_EXT_texture_perturb_normal,
  GL_EXT_texture_rectangle,
  GL_EXT_vertex_array,
  GL_EXT_vertex_shader,
  GL_EXT_vertex_weighting,
  GL_EXT_depth_bounds_test,
  GL_EXT_texture_mirror_clamp,
  GL_EXT_blend_equation_separate,
  GL_EXT_pixel_buffer_object,
  GL_EXT_texture_compression_dxt1,
  GL_EXT_stencil_clear_tag,
  GL_EXT_packed_depth_stencil,
  GL_EXT_texture_sRGB,
  GL_EXT_framebuffer_blit,
  GL_EXT_framebuffer_multisample,
  GL_EXT_timer_query,
  GL_EXT_gpu_program_parameters,
  GL_EXT_bindable_uniform,
  GL_EXT_draw_buffers2,
  GL_EXT_draw_instanced,
  GL_EXT_framebuffer_sRGB,
  GL_EXT_geometry_shader4,
  GL_EXT_gpu_shader4,
  GL_EXT_packed_float,
  GL_EXT_texture_array,
  GL_EXT_texture_buffer_object,
  GL_EXT_texture_compression_latc,
  GL_EXT_texture_compression_rgtc,
  GL_EXT_texture_integer,
  GL_EXT_texture_shared_exponent,
  GL_EXT_transform_feedback,
  GL_EXT_direct_state_access,
  GL_EXT_vertex_array_bgra,
  GL_EXT_texture_swizzle,
  GL_EXT_provoking_vertex,
  GL_EXT_texture_snorm,
  GL_EXT_separate_shader_objects,
  GL_EXT_shader_image_load_store,
  GL_EXT_vertex_attrib_64bit,
  GL_EXT_texture_sRGB_decode,
  GL_FfdMaskSGIX,
  GL_HP_convolution_border_modes,
  GL_HP_image_transform,
  GL_HP_occlusion_test,
  GL_HP_texture_lighting,
  GL_IBM_cull_vertex,
  GL_IBM_multimode_draw_arrays,
  GL_IBM_rasterpos_clip,
  GL_IBM_texture_mirrored_repeat,
  GL_IBM_vertex_array_lists,
  GL_INGR_blend_func_separate,
  GL_INGR_color_clamp,
  GL_INGR_interlace_read,
  GL_INGR_palette_buffer,
  GL_INTEL_parallel_arrays,
  GL_INTEL_texture_scissor,
  GL_MESA_resize_buffers,
  GL_MESA_window_pos,
  GL_NV_blend_square,
  GL_NV_copy_depth_to_color,
  GL_NV_depth_clamp,
  GL_NV_evaluators,
  GL_NV_fence,
  GL_NV_float_buffer,
  GL_NV_fog_distance,
  GL_NV_fragment_program,
  GL_NV_half_float,
  GL_NV_light_max_exponent,
  GL_NV_multisample_filter_hint,
  GL_NV_occlusion_query,
  GL_NV_packed_depth_stencil,
  GL_NV_pixel_data_range,
  GL_NV_point_sprite,
  GL_NV_primitive_restart,
  GL_NV_register_combiners,
  GL_NV_register_combiners2,
  GL_NV_texgen_emboss,
  GL_NV_texgen_reflection,
  GL_NV_texture_compression_vtc,
  GL_NV_texture_env_combine4,
  GL_NV_texture_expand_normal,
  GL_NV_texture_rectangle,
  GL_NV_texture_shader,
  GL_NV_texture_shader2,
  GL_NV_texture_shader3,
  GL_NV_vertex_array_range,
  GL_NV_vertex_array_range2,
  GL_NV_vertex_program,
  GL_NV_vertex_program1_1,
  GL_NV_vertex_program2,
  GL_NV_fragment_program_option,
  GL_NV_fragment_program2,
  GL_NV_vertex_program2_option,
  GL_NV_vertex_program3,
  GL_NV_depth_buffer_float,
  GL_NV_fragment_program4,
  GL_NV_framebuffer_multisample_coverage,
  GL_NV_geometry_program4,
  GL_NV_gpu_program4,
  GL_NV_parameter_buffer_object,
  GL_NV_transform_feedback,
  GL_NV_vertex_program4,
  GL_NV_conditional_render,
  GL_NV_present_video,
  GL_NV_explicit_multisample,
  GL_NV_transform_feedback2,
  GL_NV_video_capture,
  GL_NV_copy_image,
  GL_NV_parameter_buffer_object2,
  GL_NV_shader_buffer_load,
  GL_NV_vertex_buffer_unified_memory,
  GL_NV_gpu_program5,
  GL_NV_gpu_shader5,
  GL_NV_shader_buffer_store,
  GL_NV_tessellation_program5,
  GL_NV_vertex_attrib_integer_64bit,
  GL_NV_multisample_coverage,
  GL_NV_vdpau_interop,
  GL_NV_texture_barrier,
  GL_OML_interlace,
  GL_OML_resample,
  GL_OML_subsample,
  GL_PGI_misc_hints,
  GL_PGI_vertex_hints,
  GL_REND_screen_coordinates,
  GL_S3_s3tc,
  GL_SGIS_detail_texture,
  GL_SGIS_fog_function,
  GL_SGIS_generate_mipmap,
  GL_SGIS_multisample,
  GL_SGIS_pixel_texture,
  GL_SGIS_point_line_texgen,
  GL_SGIS_point_parameters,
  GL_SGIS_sharpen_texture,
  GL_SGIS_texture4D,
  GL_SGIS_texture_border_clamp,
  GL_SGIS_texture_color_mask,
  GL_SGIS_texture_edge_clamp,
  GL_SGIS_texture_filter4,
  GL_SGIS_texture_lod,
  GL_SGIS_texture_select,
  GL_SGIX_async,
  GL_SGIX_async_histogram,
  GL_SGIX_async_pixel,
  GL_SGIX_blend_alpha_minmax,
  GL_SGIX_calligraphic_fragment,
  GL_SGIX_clipmap,
  GL_SGIX_convolution_accuracy,
  GL_SGIX_depth_pass_instrument,
  GL_SGIX_depth_texture,
  GL_SGIX_flush_raster,
  GL_SGIX_fog_offset,
  GL_SGIX_fog_scale,
  GL_SGIX_fragment_lighting,
  GL_SGIX_framezoom,
  GL_SGIX_igloo_interface,
  GL_SGIX_impact_pixel_texture,
  GL_SGIX_instruments,
  GL_SGIX_interlace,
  GL_SGIX_ir_instrument1,
  GL_SGIX_list_priority,
  GL_SGIX_pixel_texture,
  GL_SGIX_pixel_tiles,
  GL_SGIX_polynomial_ffd,
  GL_SGIX_reference_plane,
  GL_SGIX_resample,
  GL_SGIX_scalebias_hint,
  GL_SGIX_shadow,
  GL_SGIX_shadow_ambient,
  GL_SGIX_sprite,
  GL_SGIX_subsample,
  GL_SGIX_tag_sample_buffer,
  GL_SGIX_texture_add_env,
  GL_SGIX_texture_coordinate_clamp,
  GL_SGIX_texture_lod_bias,
  GL_SGIX_texture_multi_buffer,
  GL_SGIX_texture_scale_bias,
  GL_SGIX_texture_select,
  GL_SGIX_vertex_preclip,
  GL_SGIX_ycrcb,
  GL_SGIX_ycrcb_subsample,
  GL_SGIX_ycrcba,
  GL_SGI_color_matrix,
  GL_SGI_color_table,
  GL_SGI_depth_pass_instrument,
  GL_SGI_texture_color_table,
  GL_SUNX_constant_data,
  GL_SUN_convolution_border_modes,
  GL_SUN_global_alpha,
  GL_SUN_mesh_array,
  GL_SUN_slice_accum,
  GL_SUN_triangle_list,
  GL_SUN_vertex,

  // WGL
  GL_WIN_phong_shading,
  GL_WIN_specular_fog,
  WGL_3DFX_multisample,
  WGL_ARB_buffer_region,
  WGL_ARB_extensions_string,
  WGL_ARB_make_current_read,
  WGL_ARB_multisample,
  WGL_ARB_pbuffer,
  WGL_ARB_pixel_format,
  WGL_ARB_pixel_format_float,
  WGL_ARB_render_texture,
  WGL_ARB_create_context,
  WGL_ARB_create_context_profile,
  WGL_ARB_framebuffer_sRGB,
  WGL_ARB_create_context_robustness,
  WGL_ATI_pixel_format_float,
  WGL_AMD_gpu_association,
  WGL_EXT_depth_float,
  WGL_EXT_display_color_table,
  WGL_EXT_extensions_string,
  WGL_EXT_make_current_read,
  WGL_EXT_multisample,
  WGL_EXT_pbuffer,
  WGL_EXT_pixel_format,
  WGL_EXT_swap_control,
  WGL_EXT_create_context_es2_profile,
  WGL_I3D_digital_video_control,
  WGL_I3D_gamma,
  WGL_I3D_genlock,
  WGL_I3D_image_buffer,
  WGL_I3D_swap_frame_lock,
  WGL_I3D_swap_frame_usage,
  WGL_NV_float_buffer,
  WGL_NV_render_depth_texture,
  WGL_NV_render_texture_rectangle,
  WGL_NV_vertex_array_range,
  WGL_NV_present_video,
  WGL_NV_video_output,
  WGL_NV_swap_group,
  WGL_NV_gpu_affinity,
  WGL_NV_video_capture,
  WGL_NV_copy_image,
  WGL_NV_multisample_coverage,
  WGL_NV_DX_interop,
  WGL_OML_sync_control,
  WGL_3DL_stereo_control,
  WGL_ARB_context_flush_control,
  WIN_draw_range_elements,
  WIN_swap_hint,

  // GLX
  GLX_VERSION_1_3,
  GLX_VERSION_1_4,
  GLX_ARB_multisample,
  GLX_ARB_fbconfig_float,
  GLX_ARB_get_proc_address,
  GLX_ARB_create_context,
  GLX_ARB_create_context_profile,
  GLX_ARB_vertex_buffer_object,
  GLX_ARB_framebuffer_sRGB,
  GLX_ARB_create_context_robustness,
  GLX_EXT_visual_info,
  GLX_EXT_visual_rating,
  GLX_EXT_import_context,
  GLX_EXT_fbconfig_packed_float,
  GLX_EXT_framebuffer_sRGB,
  GLX_EXT_texture_from_pixmap,
  GLX_EXT_swap_control,
  GLX_ARB_context_flush_control,
  GLX_EXT_create_context_es2_profile : Boolean;

const
  // GL_VERSION_1_1
  { AttribMask }
  GL_DEPTH_BUFFER_BIT = $00000100;
  GL_STENCIL_BUFFER_BIT = $00000400;
  GL_COLOR_BUFFER_BIT = $00004000;
  { Boolean }
  GL_TRUE: ByteBool = True;
  GL_FALSE: ByteBool = False;
  { BeginMode }
  GL_POINTS = $0000;
  GL_LINES = $0001;
  GL_LINE_LOOP = $0002;
  GL_LINE_STRIP = $0003;
  GL_TRIANGLES = $0004;
  GL_TRIANGLE_STRIP = $0005;
  GL_TRIANGLE_FAN = $0006;
  { AlphaFunction }
  GL_NEVER = $0200;
  GL_LESS = $0201;
  GL_EQUAL = $0202;
  GL_LEQUAL = $0203;
  GL_GREATER = $0204;
  GL_NOTEQUAL = $0205;
  GL_GEQUAL = $0206;
  GL_ALWAYS = $0207;
  { BlendingFactorDest }
  GL_ZERO = 0;
  GL_ONE = 1;
  GL_SRC_COLOR = $0300;
  GL_ONE_MINUS_SRC_COLOR = $0301;
  GL_SRC_ALPHA = $0302;
  GL_ONE_MINUS_SRC_ALPHA = $0303;
  GL_DST_ALPHA = $0304;
  GL_ONE_MINUS_DST_ALPHA = $0305;
  { BlendingFactorSrc }
  GL_DST_COLOR = $0306;
  GL_ONE_MINUS_DST_COLOR = $0307;
  GL_SRC_ALPHA_SATURATE = $0308;
  { DrawBufferMode }
  GL_NONE = 0;
  GL_FRONT_LEFT = $0400;
  GL_FRONT_RIGHT = $0401;
  GL_BACK_LEFT = $0402;
  GL_BACK_RIGHT = $0403;
  GL_FRONT = $0404;
  GL_BACK = $0405;
  GL_LEFT = $0406;
  GL_RIGHT = $0407;
  GL_FRONT_AND_BACK = $0408;
  { ErrorCode }
  GL_NO_ERROR = 0;
  GL_INVALID_ENUM = $0500;
  GL_INVALID_VALUE = $0501;
  GL_INVALID_OPERATION = $0502;
  GL_OUT_OF_MEMORY = $0505;
  { FrontFaceDirection }
  GL_CW = $0900;
  GL_CCW = $0901;
  { GetPName }
  GL_POINT_SIZE = $0B11;
  GL_POINT_SIZE_RANGE = $0B12;
  GL_POINT_SIZE_GRANULARITY = $0B13;
  GL_LINE_SMOOTH = $0B20;
  GL_LINE_WIDTH = $0B21;
  GL_LINE_WIDTH_RANGE = $0B22;
  GL_LINE_WIDTH_GRANULARITY = $0B23;
  GL_POLYGON_SMOOTH = $0B41;
  GL_CULL_FACE = $0B44;
  GL_CULL_FACE_MODE = $0B45;
  GL_FRONT_FACE = $0B46;
  GL_DEPTH_RANGE = $0B70;
  GL_DEPTH_TEST = $0B71;
  GL_DEPTH_WRITEMASK = $0B72;
  GL_DEPTH_CLEAR_VALUE = $0B73;
  GL_DEPTH_FUNC = $0B74;
  GL_STENCIL_TEST = $0B90;
  GL_STENCIL_CLEAR_VALUE = $0B91;
  GL_STENCIL_FUNC = $0B92;
  GL_STENCIL_VALUE_MASK = $0B93;
  GL_STENCIL_FAIL = $0B94;
  GL_STENCIL_PASS_DEPTH_FAIL = $0B95;
  GL_STENCIL_PASS_DEPTH_PASS = $0B96;
  GL_STENCIL_REF = $0B97;
  GL_STENCIL_WRITEMASK = $0B98;
  GL_VIEWPORT = $0BA2;
  GL_DITHER = $0BD0;
  GL_BLEND_DST = $0BE0;
  GL_BLEND_SRC = $0BE1;
  GL_BLEND = $0BE2;
  GL_LOGIC_OP_MODE = $0BF0;
  GL_COLOR_LOGIC_OP = $0BF2;
  GL_DRAW_BUFFER = $0C01;
  GL_READ_BUFFER = $0C02;
  GL_SCISSOR_BOX = $0C10;
  GL_SCISSOR_TEST = $0C11;
  GL_COLOR_CLEAR_VALUE = $0C22;
  GL_COLOR_WRITEMASK = $0C23;
  GL_DOUBLEBUFFER = $0C32;
  GL_STEREO = $0C33;
  GL_LINE_SMOOTH_HINT = $0C52;
  GL_POLYGON_SMOOTH_HINT = $0C53;
  GL_UNPACK_SWAP_BYTES = $0CF0;
  GL_UNPACK_LSB_FIRST = $0CF1;
  GL_UNPACK_ROW_LENGTH = $0CF2;
  GL_UNPACK_SKIP_ROWS = $0CF3;
  GL_UNPACK_SKIP_PIXELS = $0CF4;
  GL_UNPACK_ALIGNMENT = $0CF5;
  GL_PACK_SWAP_BYTES = $0D00;
  GL_PACK_LSB_FIRST = $0D01;
  GL_PACK_ROW_LENGTH = $0D02;
  GL_PACK_SKIP_ROWS = $0D03;
  GL_PACK_SKIP_PIXELS = $0D04;
  GL_PACK_ALIGNMENT = $0D05;
  GL_MAX_TEXTURE_SIZE = $0D33;
  GL_MAX_VIEWPORT_DIMS = $0D3A;
  GL_SUBPIXEL_BITS = $0D50;
  GL_TEXTURE_1D = $0DE0;
  GL_TEXTURE_2D = $0DE1;
  GL_POLYGON_OFFSET_UNITS = $2A00;
  GL_POLYGON_OFFSET_POINT = $2A01;
  GL_POLYGON_OFFSET_LINE = $2A02;
  GL_POLYGON_OFFSET_FILL = $8037;
  GL_POLYGON_OFFSET_FACTOR = $8038;
  GL_TEXTURE_BINDING_1D = $8068;
  GL_TEXTURE_BINDING_2D = $8069;
  { GetTextureParameter }
  GL_TEXTURE_WIDTH = $1000;
  GL_TEXTURE_HEIGHT = $1001;
  GL_TEXTURE_INTERNAL_FORMAT = $1003;
  GL_TEXTURE_BORDER_COLOR = $1004;
  GL_TEXTURE_BORDER = $1005;
  GL_TEXTURE_RED_SIZE = $805C;
  GL_TEXTURE_GREEN_SIZE = $805D;
  GL_TEXTURE_BLUE_SIZE = $805E;
  GL_TEXTURE_ALPHA_SIZE = $805F;
  { HintMode }
  GL_DONT_CARE = $1100;
  GL_FASTEST = $1101;
  GL_NICEST = $1102;
  { DataType }
  GL_BYTE = $1400;
  GL_UNSIGNED_BYTE = $1401;
  GL_SHORT = $1402;
  GL_UNSIGNED_SHORT = $1403;
  GL_INT = $1404;
  GL_UNSIGNED_INT = $1405;
  GL_FLOAT = $1406;
  GL_DOUBLE = $140A;
  { LogicOp }
  GL_CLEAR = $1500;
  GL_AND = $1501;
  GL_AND_REVERSE = $1502;
  GL_COPY = $1503;
  GL_AND_INVERTED = $1504;
  GL_NOOP = $1505;
  GL_XOR = $1506;
  GL_OR = $1507;
  GL_NOR = $1508;
  GL_EQUIV = $1509;
  GL_INVERT = $150A;
  GL_OR_REVERSE = $150B;
  GL_COPY_INVERTED = $150C;
  GL_OR_INVERTED = $150D;
  GL_NAND = $150E;
  GL_SET = $150F;
  { MatrixMode (for gl3.h, FBO attachment type) }
  GL_TEXTURE = $1702;
  { PixelCopyType }
  GL_COLOR = $1800;
  GL_DEPTH = $1801;
  GL_STENCIL = $1802;
  { PixelFormat }
  GL_STENCIL_INDEX = $1901;
  GL_DEPTH_COMPONENT = $1902;
  GL_RED = $1903;
  GL_GREEN = $1904;
  GL_BLUE = $1905;
  GL_ALPHA = $1906;
  GL_RGB = $1907;
  GL_RGBA = $1908;
  { PolygonMode }
  GL_POINT = $1B00;
  GL_LINE = $1B01;
  GL_FILL = $1B02;
  { StencilOp }
  GL_KEEP = $1E00;
  GL_REPLACE = $1E01;
  GL_INCR = $1E02;
  GL_DECR = $1E03;
  { StringName }
  GL_VENDOR = $1F00;
  GL_RENDERER = $1F01;
  GL_VERSION = $1F02;
  GL_EXTENSIONS = $1F03;
  { TextureMagFilter }
  GL_NEAREST = $2600;
  GL_LINEAR = $2601;
  { TextureMinFilter }
  GL_NEAREST_MIPMAP_NEAREST = $2700;
  GL_LINEAR_MIPMAP_NEAREST = $2701;
  GL_NEAREST_MIPMAP_LINEAR = $2702;
  GL_LINEAR_MIPMAP_LINEAR = $2703;
  { TextureParameterName }
  GL_TEXTURE_MAG_FILTER = $2800;
  GL_TEXTURE_MIN_FILTER = $2801;
  GL_TEXTURE_WRAP_S = $2802;
  GL_TEXTURE_WRAP_T = $2803;
  { TextureTarget }
  GL_PROXY_TEXTURE_1D = $8063;
  GL_PROXY_TEXTURE_2D = $8064;
  { TextureWrapMode }
  GL_REPEAT = $2901;
  { PixelInternalFormat }
  GL_R3_G3_B2 = $2A10;
  GL_RGB4 = $804F;
  GL_RGB5 = $8050;
  GL_RGB8 = $8051;
  GL_RGB10 = $8052;
  GL_RGB12 = $8053;
  GL_RGB16 = $8054;
  GL_RGBA2 = $8055;
  GL_RGBA4 = $8056;
  GL_RGB5_A1 = $8057;
  GL_RGBA8 = $8058;
  GL_RGB10_A2 = $8059;
  GL_RGBA12 = $805A;
  GL_RGBA16 = $805B;
  GL_ACCUM = $0100;
  GL_LOAD = $0101;
  GL_RETURN = $0102;
  GL_MULT = $0103;
  GL_ADD = $0104;
  GL_CURRENT_BIT = $00000001;
  GL_POINT_BIT = $00000002;
  GL_LINE_BIT = $00000004;
  GL_POLYGON_BIT = $00000008;
  GL_POLYGON_STIPPLE_BIT = $00000010;
  GL_PIXEL_MODE_BIT = $00000020;
  GL_LIGHTING_BIT = $00000040;
  GL_FOG_BIT = $00000080;
  GL_ACCUM_BUFFER_BIT = $00000200;
  GL_VIEWPORT_BIT = $00000800;
  GL_TRANSFORM_BIT = $00001000;
  GL_ENABLE_BIT = $00002000;
  GL_HINT_BIT = $00008000;
  GL_EVAL_BIT = $00010000;
  GL_LIST_BIT = $00020000;
  GL_TEXTURE_BIT = $00040000;
  GL_SCISSOR_BIT = $00080000;
  GL_ALL_ATTRIB_BITS = $000FFFFF;
  GL_QUADS = $0007;
  GL_QUAD_STRIP = $0008;
  GL_POLYGON = $0009;
  GL_CLIP_PLANE0 = $3000;
  GL_CLIP_PLANE1 = $3001;
  GL_CLIP_PLANE2 = $3002;
  GL_CLIP_PLANE3 = $3003;
  GL_CLIP_PLANE4 = $3004;
  GL_CLIP_PLANE5 = $3005;
  GL_2_BYTES = $1407;
  GL_3_BYTES = $1408;
  GL_4_BYTES = $1409;
  GL_AUX0 = $0409;
  GL_AUX1 = $040A;
  GL_AUX2 = $040B;
  GL_AUX3 = $040C;
  GL_STACK_OVERFLOW = $0503;
  GL_STACK_UNDERFLOW = $0504;
  GL_2D = $0600;
  GL_3D = $0601;
  GL_3D_COLOR = $0602;
  GL_3D_COLOR_TEXTURE = $0603;
  GL_4D_COLOR_TEXTURE = $0604;
  GL_PASS_THROUGH_TOKEN = $0700;
  GL_POINT_TOKEN = $0701;
  GL_LINE_TOKEN = $0702;
  GL_POLYGON_TOKEN = $0703;
  GL_BITMAP_TOKEN = $0704;
  GL_DRAW_PIXEL_TOKEN = $0705;
  GL_COPY_PIXEL_TOKEN = $0706;
  GL_LINE_RESET_TOKEN = $0707;
  GL_EXP = $0800;
  GL_EXP2 = $0801;
  GL_COEFF = $0A00;
  GL_ORDER = $0A01;
  GL_DOMAIN = $0A02;
  GL_CURRENT_COLOR = $0B00;
  GL_CURRENT_INDEX = $0B01;
  GL_CURRENT_NORMAL = $0B02;
  GL_CURRENT_TEXTURE_COORDS = $0B03;
  GL_CURRENT_RASTER_COLOR = $0B04;
  GL_CURRENT_RASTER_INDEX = $0B05;
  GL_CURRENT_RASTER_TEXTURE_COORDS = $0B06;
  GL_CURRENT_RASTER_POSITION = $0B07;
  GL_CURRENT_RASTER_POSITION_VALID = $0B08;
  GL_CURRENT_RASTER_DISTANCE = $0B09;
  GL_POINT_SMOOTH = $0B10;
  GL_LINE_STIPPLE = $0B24;
  GL_LINE_STIPPLE_PATTERN = $0B25;
  GL_LINE_STIPPLE_REPEAT = $0B26;
  GL_LIST_MODE = $0B30;
  GL_MAX_LIST_NESTING = $0B31;
  GL_LIST_BASE = $0B32;
  GL_LIST_INDEX = $0B33;
  GL_POLYGON_MODE = $0B40;
  GL_POLYGON_STIPPLE = $0B42;
  GL_EDGE_FLAG = $0B43;
  GL_LIGHTING = $0B50;
  GL_LIGHT_MODEL_LOCAL_VIEWER = $0B51;
  GL_LIGHT_MODEL_TWO_SIDE = $0B52;
  GL_LIGHT_MODEL_AMBIENT = $0B53;
  GL_SHADE_MODEL = $0B54;
  GL_COLOR_MATERIAL_FACE = $0B55;
  GL_COLOR_MATERIAL_PARAMETER = $0B56;
  GL_COLOR_MATERIAL = $0B57;
  GL_FOG = $0B60;
  GL_FOG_INDEX = $0B61;
  GL_FOG_DENSITY = $0B62;
  GL_FOG_START = $0B63;
  GL_FOG_END = $0B64;
  GL_FOG_MODE = $0B65;
  GL_FOG_COLOR = $0B66;
  GL_ACCUM_CLEAR_VALUE = $0B80;
  GL_MATRIX_MODE = $0BA0;
  GL_NORMALIZE = $0BA1;
  GL_MODELVIEW_STACK_DEPTH = $0BA3;
  GL_PROJECTION_STACK_DEPTH = $0BA4;
  GL_TEXTURE_STACK_DEPTH = $0BA5;
  GL_MODELVIEW_MATRIX = $0BA6;
  GL_PROJECTION_MATRIX = $0BA7;
  GL_TEXTURE_MATRIX = $0BA8;
  GL_ATTRIB_STACK_DEPTH = $0BB0;
  GL_CLIENT_ATTRIB_STACK_DEPTH = $0BB1;
  GL_ALPHA_TEST = $0BC0;
  GL_ALPHA_TEST_FUNC = $0BC1;
  GL_ALPHA_TEST_REF = $0BC2;
  GL_INDEX_LOGIC_OP = $0BF1;
  GL_AUX_BUFFERS = $0C00;
  GL_INDEX_CLEAR_VALUE = $0C20;
  GL_INDEX_WRITEMASK = $0C21;
  GL_INDEX_MODE = $0C30;
  GL_RGBA_MODE = $0C31;
  GL_RENDER_MODE = $0C40;
  GL_PERSPECTIVE_CORRECTION_HINT = $0C50;
  GL_POINT_SMOOTH_HINT = $0C51;
  GL_FOG_HINT = $0C54;
  GL_TEXTURE_GEN_S = $0C60;
  GL_TEXTURE_GEN_T = $0C61;
  GL_TEXTURE_GEN_R = $0C62;
  GL_TEXTURE_GEN_Q = $0C63;
  GL_PIXEL_MAP_I_TO_I = $0C70;
  GL_PIXEL_MAP_S_TO_S = $0C71;
  GL_PIXEL_MAP_I_TO_R = $0C72;
  GL_PIXEL_MAP_I_TO_G = $0C73;
  GL_PIXEL_MAP_I_TO_B = $0C74;
  GL_PIXEL_MAP_I_TO_A = $0C75;
  GL_PIXEL_MAP_R_TO_R = $0C76;
  GL_PIXEL_MAP_G_TO_G = $0C77;
  GL_PIXEL_MAP_B_TO_B = $0C78;
  GL_PIXEL_MAP_A_TO_A = $0C79;
  GL_PIXEL_MAP_I_TO_I_SIZE = $0CB0;
  GL_PIXEL_MAP_S_TO_S_SIZE = $0CB1;
  GL_PIXEL_MAP_I_TO_R_SIZE = $0CB2;
  GL_PIXEL_MAP_I_TO_G_SIZE = $0CB3;
  GL_PIXEL_MAP_I_TO_B_SIZE = $0CB4;
  GL_PIXEL_MAP_I_TO_A_SIZE = $0CB5;
  GL_PIXEL_MAP_R_TO_R_SIZE = $0CB6;
  GL_PIXEL_MAP_G_TO_G_SIZE = $0CB7;
  GL_PIXEL_MAP_B_TO_B_SIZE = $0CB8;
  GL_PIXEL_MAP_A_TO_A_SIZE = $0CB9;
  GL_MAP_COLOR = $0D10;
  GL_MAP_STENCIL = $0D11;
  GL_INDEX_SHIFT = $0D12;
  GL_INDEX_OFFSET = $0D13;
  GL_RED_SCALE = $0D14;
  GL_RED_BIAS = $0D15;
  GL_ZOOM_X = $0D16;
  GL_ZOOM_Y = $0D17;
  GL_GREEN_SCALE = $0D18;
  GL_GREEN_BIAS = $0D19;
  GL_BLUE_SCALE = $0D1A;
  GL_BLUE_BIAS = $0D1B;
  GL_ALPHA_SCALE = $0D1C;
  GL_ALPHA_BIAS = $0D1D;
  GL_DEPTH_SCALE = $0D1E;
  GL_DEPTH_BIAS = $0D1F;
  GL_MAX_EVAL_ORDER = $0D30;
  GL_MAX_LIGHTS = $0D31;
  GL_MAX_CLIP_PLANES = $0D32;
  GL_MAX_PIXEL_MAP_TABLE = $0D34;
  GL_MAX_ATTRIB_STACK_DEPTH = $0D35;
  GL_MAX_MODELVIEW_STACK_DEPTH = $0D36;
  GL_MAX_NAME_STACK_DEPTH = $0D37;
  GL_MAX_PROJECTION_STACK_DEPTH = $0D38;
  GL_MAX_TEXTURE_STACK_DEPTH = $0D39;
  GL_MAX_CLIENT_ATTRIB_STACK_DEPTH = $0D3B;
  GL_INDEX_BITS = $0D51;
  GL_RED_BITS = $0D52;
  GL_GREEN_BITS = $0D53;
  GL_BLUE_BITS = $0D54;
  GL_ALPHA_BITS = $0D55;
  GL_DEPTH_BITS = $0D56;
  GL_STENCIL_BITS = $0D57;
  GL_ACCUM_RED_BITS = $0D58;
  GL_ACCUM_GREEN_BITS = $0D59;
  GL_ACCUM_BLUE_BITS = $0D5A;
  GL_ACCUM_ALPHA_BITS = $0D5B;
  GL_NAME_STACK_DEPTH = $0D70;
  GL_AUTO_NORMAL = $0D80;
  GL_MAP1_COLOR_4 = $0D90;
  GL_MAP1_INDEX = $0D91;
  GL_MAP1_NORMAL = $0D92;
  GL_MAP1_TEXTURE_COORD_1 = $0D93;
  GL_MAP1_TEXTURE_COORD_2 = $0D94;
  GL_MAP1_TEXTURE_COORD_3 = $0D95;
  GL_MAP1_TEXTURE_COORD_4 = $0D96;
  GL_MAP1_VERTEX_3 = $0D97;
  GL_MAP1_VERTEX_4 = $0D98;
  GL_MAP2_COLOR_4 = $0DB0;
  GL_MAP2_INDEX = $0DB1;
  GL_MAP2_NORMAL = $0DB2;
  GL_MAP2_TEXTURE_COORD_1 = $0DB3;
  GL_MAP2_TEXTURE_COORD_2 = $0DB4;
  GL_MAP2_TEXTURE_COORD_3 = $0DB5;
  GL_MAP2_TEXTURE_COORD_4 = $0DB6;
  GL_MAP2_VERTEX_3 = $0DB7;
  GL_MAP2_VERTEX_4 = $0DB8;
  GL_MAP1_GRID_DOMAIN = $0DD0;
  GL_MAP1_GRID_SEGMENTS = $0DD1;
  GL_MAP2_GRID_DOMAIN = $0DD2;
  GL_MAP2_GRID_SEGMENTS = $0DD3;
  GL_FEEDBACK_BUFFER_POINTER = $0DF0;
  GL_FEEDBACK_BUFFER_SIZE = $0DF1;
  GL_FEEDBACK_BUFFER_TYPE = $0DF2;
  GL_SELECTION_BUFFER_POINTER = $0DF3;
  GL_SELECTION_BUFFER_SIZE = $0DF4;
  GL_LIGHT0 = $4000;
  GL_LIGHT1 = $4001;
  GL_LIGHT2 = $4002;
  GL_LIGHT3 = $4003;
  GL_LIGHT4 = $4004;
  GL_LIGHT5 = $4005;
  GL_LIGHT6 = $4006;
  GL_LIGHT7 = $4007;
  GL_AMBIENT = $1200;
  GL_DIFFUSE = $1201;
  GL_SPECULAR = $1202;
  GL_POSITION = $1203;
  GL_SPOT_DIRECTION = $1204;
  GL_SPOT_EXPONENT = $1205;
  GL_SPOT_CUTOFF = $1206;
  GL_CONSTANT_ATTENUATION = $1207;
  GL_LINEAR_ATTENUATION = $1208;
  GL_QUADRATIC_ATTENUATION = $1209;
  GL_COMPILE = $1300;
  GL_COMPILE_AND_EXECUTE = $1301;
  GL_EMISSION = $1600;
  GL_SHININESS = $1601;
  GL_AMBIENT_AND_DIFFUSE = $1602;
  GL_COLOR_INDEXES = $1603;
  GL_MODELVIEW = $1700;
  GL_PROJECTION = $1701;
  GL_COLOR_INDEX = $1900;
  GL_LUMINANCE = $1909;
  GL_LUMINANCE_ALPHA = $190A;
  GL_BITMAP = $1A00;
  GL_RENDER = $1C00;
  GL_FEEDBACK = $1C01;
  GL_SELECT = $1C02;
  GL_FLAT = $1D00;
  GL_SMOOTH = $1D01;
  GL_S = $2000;
  GL_T = $2001;
  GL_R = $2002;
  GL_Q = $2003;
  GL_MODULATE = $2100;
  GL_DECAL = $2101;
  GL_TEXTURE_ENV_MODE = $2200;
  GL_TEXTURE_ENV_COLOR = $2201;
  GL_TEXTURE_ENV = $2300;
  GL_EYE_LINEAR = $2400;
  GL_OBJECT_LINEAR = $2401;
  GL_SPHERE_MAP = $2402;
  GL_TEXTURE_GEN_MODE = $2500;
  GL_OBJECT_PLANE = $2501;
  GL_EYE_PLANE = $2502;
  GL_CLAMP = $2900;
  GL_CLIENT_PIXEL_STORE_BIT = $00000001;
  GL_CLIENT_VERTEX_ARRAY_BIT = $00000002;
  GL_CLIENT_ALL_ATTRIB_BITS = $FFFFFFFF;
  GL_ALPHA4 = $803B;
  GL_ALPHA8 = $803C;
  GL_ALPHA12 = $803D;
  GL_ALPHA16 = $803E;
  GL_LUMINANCE4 = $803F;
  GL_LUMINANCE8 = $8040;
  GL_LUMINANCE12 = $8041;
  GL_LUMINANCE16 = $8042;
  GL_LUMINANCE4_ALPHA4 = $8043;
  GL_LUMINANCE6_ALPHA2 = $8044;
  GL_LUMINANCE8_ALPHA8 = $8045;
  GL_LUMINANCE12_ALPHA4 = $8046;
  GL_LUMINANCE12_ALPHA12 = $8047;
  GL_LUMINANCE16_ALPHA16 = $8048;
  GL_INTENSITY = $8049;
  GL_INTENSITY4 = $804A;
  GL_INTENSITY8 = $804B;
  GL_INTENSITY12 = $804C;
  GL_INTENSITY16 = $804D;
  GL_TEXTURE_LUMINANCE_SIZE = $8060;
  GL_TEXTURE_INTENSITY_SIZE = $8061;
  GL_TEXTURE_PRIORITY = $8066;
  GL_TEXTURE_RESIDENT = $8067;
  GL_VERTEX_ARRAY = $8074;
  GL_NORMAL_ARRAY = $8075;
  GL_COLOR_ARRAY = $8076;
  GL_INDEX_ARRAY = $8077;
  GL_TEXTURE_COORD_ARRAY = $8078;
  GL_EDGE_FLAG_ARRAY = $8079;
  GL_VERTEX_ARRAY_SIZE = $807A;
  GL_VERTEX_ARRAY_TYPE = $807B;
  GL_VERTEX_ARRAY_STRIDE = $807C;
  GL_NORMAL_ARRAY_TYPE = $807E;
  GL_NORMAL_ARRAY_STRIDE = $807F;
  GL_COLOR_ARRAY_SIZE = $8081;
  GL_COLOR_ARRAY_TYPE = $8082;
  GL_COLOR_ARRAY_STRIDE = $8083;
  GL_INDEX_ARRAY_TYPE = $8085;
  GL_INDEX_ARRAY_STRIDE = $8086;
  GL_TEXTURE_COORD_ARRAY_SIZE = $8088;
  GL_TEXTURE_COORD_ARRAY_TYPE = $8089;
  GL_TEXTURE_COORD_ARRAY_STRIDE = $808A;
  GL_EDGE_FLAG_ARRAY_STRIDE = $808C;
  GL_VERTEX_ARRAY_POINTER = $808E;
  GL_NORMAL_ARRAY_POINTER = $808F;
  GL_COLOR_ARRAY_POINTER = $8090;
  GL_INDEX_ARRAY_POINTER = $8091;
  GL_TEXTURE_COORD_ARRAY_POINTER = $8092;
  GL_EDGE_FLAG_ARRAY_POINTER = $8093;
  GL_V2F = $2A20;
  GL_V3F = $2A21;
  GL_C4UB_V2F = $2A22;
  GL_C4UB_V3F = $2A23;
  GL_C3F_V3F = $2A24;
  GL_N3F_V3F = $2A25;
  GL_C4F_N3F_V3F = $2A26;
  GL_T2F_V3F = $2A27;
  GL_T4F_V4F = $2A28;
  GL_T2F_C4UB_V3F = $2A29;
  GL_T2F_C3F_V3F = $2A2A;
  GL_T2F_N3F_V3F = $2A2B;
  GL_T2F_C4F_N3F_V3F = $2A2C;
  GL_T4F_C4F_N3F_V4F = $2A2D;
  GL_COLOR_TABLE_FORMAT_EXT = $80D8;
  GL_COLOR_TABLE_WIDTH_EXT = $80D9;
  GL_COLOR_TABLE_RED_SIZE_EXT = $80DA;
  GL_COLOR_TABLE_GREEN_SIZE_EXT = $80DB;
  GL_COLOR_TABLE_BLUE_SIZE_EXT = $80DC;
  GL_COLOR_TABLE_ALPHA_SIZE_EXT = $80DD;
  GL_COLOR_TABLE_LUMINANCE_SIZE_EXT = $80DE;
  GL_COLOR_TABLE_INTENSITY_SIZE_EXT = $80DF;
  GL_LOGIC_OP = GL_INDEX_LOGIC_OP;
  GL_TEXTURE_COMPONENTS = GL_TEXTURE_INTERNAL_FORMAT;

  // GL_VERSION_1_2
  GL_UNSIGNED_BYTE_3_3_2 = $8032;
  GL_UNSIGNED_SHORT_4_4_4_4 = $8033;
  GL_UNSIGNED_SHORT_5_5_5_1 = $8034;
  GL_UNSIGNED_INT_8_8_8_8 = $8035;
  GL_UNSIGNED_INT_10_10_10_2 = $8036;
  GL_TEXTURE_BINDING_3D = $806A;
  GL_PACK_SKIP_IMAGES = $806B;
  GL_PACK_IMAGE_HEIGHT = $806C;
  GL_UNPACK_SKIP_IMAGES = $806D;
  GL_UNPACK_IMAGE_HEIGHT = $806E;
  GL_TEXTURE_3D = $806F;
  GL_PROXY_TEXTURE_3D = $8070;
  GL_TEXTURE_DEPTH = $8071;
  GL_TEXTURE_WRAP_R = $8072;
  GL_MAX_3D_TEXTURE_SIZE = $8073;
  GL_UNSIGNED_BYTE_2_3_3_REV = $8362;
  GL_UNSIGNED_SHORT_5_6_5 = $8363;
  GL_UNSIGNED_SHORT_5_6_5_REV = $8364;
  GL_UNSIGNED_SHORT_4_4_4_4_REV = $8365;
  GL_UNSIGNED_SHORT_1_5_5_5_REV = $8366;
  GL_UNSIGNED_INT_8_8_8_8_REV = $8367;
  GL_UNSIGNED_INT_2_10_10_10_REV = $8368;
  GL_BGR = $80E0;
  GL_BGRA = $80E1;
  GL_MAX_ELEMENTS_VERTICES = $80E8;
  GL_MAX_ELEMENTS_INDICES = $80E9;
  GL_CLAMP_TO_EDGE = $812F;
  GL_TEXTURE_MIN_LOD = $813A;
  GL_TEXTURE_MAX_LOD = $813B;
  GL_TEXTURE_BASE_LEVEL = $813C;
  GL_TEXTURE_MAX_LEVEL = $813D;
  GL_SMOOTH_POINT_SIZE_RANGE = $0B12;
  GL_SMOOTH_POINT_SIZE_GRANULARITY = $0B13;
  GL_SMOOTH_LINE_WIDTH_RANGE = $0B22;
  GL_SMOOTH_LINE_WIDTH_GRANULARITY = $0B23;
  GL_ALIASED_LINE_WIDTH_RANGE = $846E;
  GL_RESCALE_NORMAL = $803A;
  GL_LIGHT_MODEL_COLOR_CONTROL = $81F8;
  GL_SINGLE_COLOR = $81F9;
  GL_SEPARATE_SPECULAR_COLOR = $81FA;
  GL_ALIASED_POINT_SIZE_RANGE = $846D;
  // GL_VERSION_1_3
  GL_TEXTURE0 = $84C0;
  GL_TEXTURE1 = $84C1;
  GL_TEXTURE2 = $84C2;
  GL_TEXTURE3 = $84C3;
  GL_TEXTURE4 = $84C4;
  GL_TEXTURE5 = $84C5;
  GL_TEXTURE6 = $84C6;
  GL_TEXTURE7 = $84C7;
  GL_TEXTURE8 = $84C8;
  GL_TEXTURE9 = $84C9;
  GL_TEXTURE10 = $84CA;
  GL_TEXTURE11 = $84CB;
  GL_TEXTURE12 = $84CC;
  GL_TEXTURE13 = $84CD;
  GL_TEXTURE14 = $84CE;
  GL_TEXTURE15 = $84CF;
  GL_TEXTURE16 = $84D0;
  GL_TEXTURE17 = $84D1;
  GL_TEXTURE18 = $84D2;
  GL_TEXTURE19 = $84D3;
  GL_TEXTURE20 = $84D4;
  GL_TEXTURE21 = $84D5;
  GL_TEXTURE22 = $84D6;
  GL_TEXTURE23 = $84D7;
  GL_TEXTURE24 = $84D8;
  GL_TEXTURE25 = $84D9;
  GL_TEXTURE26 = $84DA;
  GL_TEXTURE27 = $84DB;
  GL_TEXTURE28 = $84DC;
  GL_TEXTURE29 = $84DD;
  GL_TEXTURE30 = $84DE;
  GL_TEXTURE31 = $84DF;
  GL_ACTIVE_TEXTURE = $84E0;
  GL_MULTISAMPLE = $809D;
  GL_SAMPLE_ALPHA_TO_COVERAGE = $809E;
  GL_SAMPLE_ALPHA_TO_ONE = $809F;
  GL_SAMPLE_COVERAGE = $80A0;
  GL_SAMPLE_BUFFERS = $80A8;
  GL_SAMPLES = $80A9;
  GL_SAMPLE_COVERAGE_VALUE = $80AA;
  GL_SAMPLE_COVERAGE_INVERT = $80AB;
  GL_TEXTURE_CUBE_MAP = $8513;
  GL_TEXTURE_BINDING_CUBE_MAP = $8514;
  GL_TEXTURE_CUBE_MAP_POSITIVE_X = $8515;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_X = $8516;
  GL_TEXTURE_CUBE_MAP_POSITIVE_Y = $8517;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y = $8518;
  GL_TEXTURE_CUBE_MAP_POSITIVE_Z = $8519;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z = $851A;
  GL_PROXY_TEXTURE_CUBE_MAP = $851B;
  GL_MAX_CUBE_MAP_TEXTURE_SIZE = $851C;
  GL_COMPRESSED_RGB = $84ED;
  GL_COMPRESSED_RGBA = $84EE;
  GL_TEXTURE_COMPRESSION_HINT = $84EF;
  GL_TEXTURE_COMPRESSED_IMAGE_SIZE = $86A0;
  GL_TEXTURE_COMPRESSED = $86A1;
  GL_NUM_COMPRESSED_TEXTURE_FORMATS = $86A2;
  GL_COMPRESSED_TEXTURE_FORMATS = $86A3;
  GL_CLAMP_TO_BORDER = $812D;
  GL_CLIENT_ACTIVE_TEXTURE = $84E1;
  GL_MAX_TEXTURE_UNITS = $84E2;
  GL_TRANSPOSE_MODELVIEW_MATRIX = $84E3;
  GL_TRANSPOSE_PROJECTION_MATRIX = $84E4;
  GL_TRANSPOSE_TEXTURE_MATRIX = $84E5;
  GL_TRANSPOSE_COLOR_MATRIX = $84E6;
  GL_MULTISAMPLE_BIT = $20000000;
  GL_NORMAL_MAP = $8511;
  GL_REFLECTION_MAP = $8512;
  GL_COMPRESSED_ALPHA = $84E9;
  GL_COMPRESSED_LUMINANCE = $84EA;
  GL_COMPRESSED_LUMINANCE_ALPHA = $84EB;
  GL_COMPRESSED_INTENSITY = $84EC;
  GL_COMBINE = $8570;
  GL_COMBINE_RGB = $8571;
  GL_COMBINE_ALPHA = $8572;
  GL_SOURCE0_RGB = $8580;
  GL_SOURCE1_RGB = $8581;
  GL_SOURCE2_RGB = $8582;
  GL_SOURCE0_ALPHA = $8588;
  GL_SOURCE1_ALPHA = $8589;
  GL_SOURCE2_ALPHA = $858A;
  GL_OPERAND0_RGB = $8590;
  GL_OPERAND1_RGB = $8591;
  GL_OPERAND2_RGB = $8592;
  GL_OPERAND0_ALPHA = $8598;
  GL_OPERAND1_ALPHA = $8599;
  GL_OPERAND2_ALPHA = $859A;
  GL_RGB_SCALE = $8573;
  GL_ADD_SIGNED = $8574;
  GL_INTERPOLATE = $8575;
  GL_SUBTRACT = $84E7;
  GL_CONSTANT = $8576;
  GL_PRIMARY_COLOR = $8577;
  GL_PREVIOUS = $8578;
  GL_DOT3_RGB = $86AE;
  GL_DOT3_RGBA = $86AF;
  // GL_VERSION_1_4
  GL_BLEND_DST_RGB = $80C8;
  GL_BLEND_SRC_RGB = $80C9;
  GL_BLEND_DST_ALPHA = $80CA;
  GL_BLEND_SRC_ALPHA = $80CB;
  GL_POINT_FADE_THRESHOLD_SIZE = $8128;
  GL_DEPTH_COMPONENT16 = $81A5;
  GL_DEPTH_COMPONENT24 = $81A6;
  GL_DEPTH_COMPONENT32 = $81A7;
  GL_MIRRORED_REPEAT = $8370;
  GL_MAX_TEXTURE_LOD_BIAS = $84FD;
  GL_TEXTURE_LOD_BIAS = $8501;
  GL_INCR_WRAP = $8507;
  GL_DECR_WRAP = $8508;
  GL_TEXTURE_DEPTH_SIZE = $884A;
  GL_TEXTURE_COMPARE_MODE = $884C;
  GL_TEXTURE_COMPARE_FUNC = $884D;
  GL_POINT_SIZE_MIN = $8126;
  GL_POINT_SIZE_MAX = $8127;
  GL_POINT_DISTANCE_ATTENUATION = $8129;
  GL_GENERATE_MIPMAP = $8191;
  GL_GENERATE_MIPMAP_HINT = $8192;
  GL_FOG_COORDINATE_SOURCE = $8450;
  GL_FOG_COORDINATE = $8451;
  GL_FRAGMENT_DEPTH = $8452;
  GL_CURRENT_FOG_COORDINATE = $8453;
  GL_FOG_COORDINATE_ARRAY_TYPE = $8454;
  GL_FOG_COORDINATE_ARRAY_STRIDE = $8455;
  GL_FOG_COORDINATE_ARRAY_POINTER = $8456;
  GL_FOG_COORDINATE_ARRAY = $8457;
  GL_COLOR_SUM = $8458;
  GL_CURRENT_SECONDARY_COLOR = $8459;
  GL_SECONDARY_COLOR_ARRAY_SIZE = $845A;
  GL_SECONDARY_COLOR_ARRAY_TYPE = $845B;
  GL_SECONDARY_COLOR_ARRAY_STRIDE = $845C;
  GL_SECONDARY_COLOR_ARRAY_POINTER = $845D;
  GL_SECONDARY_COLOR_ARRAY = $845E;
  GL_TEXTURE_FILTER_CONTROL = $8500;
  GL_DEPTH_TEXTURE_MODE = $884B;
  GL_COMPARE_R_TO_TEXTURE = $884E;
  // GL_VERSION_1_5
  // GL_VERSION_2_0
  GL_BLEND_EQUATION_RGB = $8009;
  GL_VERTEX_ATTRIB_ARRAY_ENABLED = $8622;
  GL_VERTEX_ATTRIB_ARRAY_SIZE = $8623;
  GL_VERTEX_ATTRIB_ARRAY_STRIDE = $8624;
  GL_VERTEX_ATTRIB_ARRAY_TYPE = $8625;
  GL_CURRENT_VERTEX_ATTRIB = $8626;
  GL_VERTEX_PROGRAM_POINT_SIZE = $8642;
  GL_VERTEX_ATTRIB_ARRAY_POINTER = $8645;
  GL_STENCIL_BACK_FUNC = $8800;
  GL_STENCIL_BACK_FAIL = $8801;
  GL_STENCIL_BACK_PASS_DEPTH_FAIL = $8802;
  GL_STENCIL_BACK_PASS_DEPTH_PASS = $8803;
  GL_MAX_DRAW_BUFFERS = $8824;
  GL_DRAW_BUFFER0 = $8825;
  GL_DRAW_BUFFER1 = $8826;
  GL_DRAW_BUFFER2 = $8827;
  GL_DRAW_BUFFER3 = $8828;
  GL_DRAW_BUFFER4 = $8829;
  GL_DRAW_BUFFER5 = $882A;
  GL_DRAW_BUFFER6 = $882B;
  GL_DRAW_BUFFER7 = $882C;
  GL_DRAW_BUFFER8 = $882D;
  GL_DRAW_BUFFER9 = $882E;
  GL_DRAW_BUFFER10 = $882F;
  GL_DRAW_BUFFER11 = $8830;
  GL_DRAW_BUFFER12 = $8831;
  GL_DRAW_BUFFER13 = $8832;
  GL_DRAW_BUFFER14 = $8833;
  GL_DRAW_BUFFER15 = $8834;
  GL_BLEND_EQUATION_ALPHA = $883D;
  GL_MAX_VERTEX_ATTRIBS = $8869;
  GL_VERTEX_ATTRIB_ARRAY_NORMALIZED = $886A;
  GL_MAX_TEXTURE_IMAGE_UNITS = $8872;
  GL_FRAGMENT_SHADER = $8B30;
  GL_VERTEX_SHADER = $8B31;
  GL_MAX_FRAGMENT_UNIFORM_COMPONENTS = $8B49;
  GL_MAX_VERTEX_UNIFORM_COMPONENTS = $8B4A;
  GL_MAX_VARYING_FLOATS = $8B4B;
  GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS = $8B4C;
  GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS = $8B4D;
  GL_SHADER_TYPE = $8B4F;
  GL_FLOAT_VEC2 = $8B50;
  GL_FLOAT_VEC3 = $8B51;
  GL_FLOAT_VEC4 = $8B52;
  GL_INT_VEC2 = $8B53;
  GL_INT_VEC3 = $8B54;
  GL_INT_VEC4 = $8B55;
  GL_BOOL = $8B56;
  GL_BOOL_VEC2 = $8B57;
  GL_BOOL_VEC3 = $8B58;
  GL_BOOL_VEC4 = $8B59;
  GL_FLOAT_MAT2 = $8B5A;
  GL_FLOAT_MAT3 = $8B5B;
  GL_FLOAT_MAT4 = $8B5C;
  GL_SAMPLER_1D = $8B5D;
  GL_SAMPLER_2D = $8B5E;
  GL_SAMPLER_3D = $8B5F;
  GL_SAMPLER_CUBE = $8B60;
  GL_SAMPLER_1D_SHADOW = $8B61;
  GL_SAMPLER_2D_SHADOW = $8B62;
  GL_DELETE_STATUS = $8B80;
  GL_COMPILE_STATUS = $8B81;
  GL_LINK_STATUS = $8B82;
  GL_VALIDATE_STATUS = $8B83;
  GL_INFO_LOG_LENGTH = $8B84;
  GL_ATTACHED_SHADERS = $8B85;
  GL_ACTIVE_UNIFORMS = $8B86;
  GL_ACTIVE_UNIFORM_MAX_LENGTH = $8B87;
  GL_SHADER_SOURCE_LENGTH = $8B88;
  GL_ACTIVE_ATTRIBUTES = $8B89;
  GL_ACTIVE_ATTRIBUTE_MAX_LENGTH = $8B8A;
  GL_FRAGMENT_SHADER_DERIVATIVE_HINT = $8B8B;
  GL_SHADING_LANGUAGE_VERSION = $8B8C;
  GL_CURRENT_PROGRAM = $8B8D;
  GL_POINT_SPRITE_COORD_ORIGIN = $8CA0;
  GL_LOWER_LEFT = $8CA1;
  GL_UPPER_LEFT = $8CA2;
  GL_STENCIL_BACK_REF = $8CA3;
  GL_STENCIL_BACK_VALUE_MASK = $8CA4;
  GL_STENCIL_BACK_WRITEMASK = $8CA5;
  GL_VERTEX_PROGRAM_TWO_SIDE = $8643;
  GL_POINT_SPRITE = $8861;
  GL_COORD_REPLACE = $8862;
  GL_MAX_TEXTURE_COORDS = $8871;
  // GL_VERSION_2_1
  GL_PIXEL_PACK_BUFFER = $88EB;
  GL_PIXEL_UNPACK_BUFFER = $88EC;
  GL_PIXEL_PACK_BUFFER_BINDING = $88ED;
  GL_PIXEL_UNPACK_BUFFER_BINDING = $88EF;
  GL_FLOAT_MAT2x3 = $8B65;
  GL_FLOAT_MAT2x4 = $8B66;
  GL_FLOAT_MAT3x2 = $8B67;
  GL_FLOAT_MAT3x4 = $8B68;
  GL_FLOAT_MAT4x2 = $8B69;
  GL_FLOAT_MAT4x3 = $8B6A;
  GL_SRGB = $8C40;
  GL_SRGB8 = $8C41;
  GL_SRGB_ALPHA = $8C42;
  GL_SRGB8_ALPHA8 = $8C43;
  GL_COMPRESSED_SRGB = $8C48;
  GL_COMPRESSED_SRGB_ALPHA = $8C49;
  GL_CURRENT_RASTER_SECONDARY_COLOR = $845F;
  GL_SLUMINANCE_ALPHA = $8C44;
  GL_SLUMINANCE8_ALPHA8 = $8C45;
  GL_SLUMINANCE = $8C46;
  GL_SLUMINANCE8 = $8C47;
  GL_COMPRESSED_SLUMINANCE = $8C4A;
  GL_COMPRESSED_SLUMINANCE_ALPHA = $8C4B;
  // GL_VERSION_3_0
  GL_COMPARE_REF_TO_TEXTURE = $884E;
  GL_CLIP_DISTANCE0 = $3000;
  GL_CLIP_DISTANCE1 = $3001;
  GL_CLIP_DISTANCE2 = $3002;
  GL_CLIP_DISTANCE3 = $3003;
  GL_CLIP_DISTANCE4 = $3004;
  GL_CLIP_DISTANCE5 = $3005;
  GL_CLIP_DISTANCE6 = $3006;
  GL_CLIP_DISTANCE7 = $3007;
  GL_MAX_CLIP_DISTANCES = $0D32;
  GL_MAJOR_VERSION = $821B;
  GL_MINOR_VERSION = $821C;
  GL_NUM_EXTENSIONS = $821D;
  GL_CONTEXT_FLAGS = $821E;
  GL_DEPTH_BUFFER = $8223;
  GL_STENCIL_BUFFER = $8224;
  GL_COMPRESSED_RED = $8225;
  GL_COMPRESSED_RG = $8226;
  GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT = $0001;
  GL_RGBA32F = $8814;
  GL_RGB32F = $8815;
  GL_RGBA16F = $881A;
  GL_RGB16F = $881B;
  GL_VERTEX_ATTRIB_ARRAY_INTEGER = $88FD;
  GL_MAX_ARRAY_TEXTURE_LAYERS = $88FF;
  GL_MIN_PROGRAM_TEXEL_OFFSET = $8904;
  GL_MAX_PROGRAM_TEXEL_OFFSET = $8905;
  GL_CLAMP_READ_COLOR = $891C;
  GL_FIXED_ONLY = $891D;
  GL_MAX_VARYING_COMPONENTS = $8B4B;
  GL_TEXTURE_1D_ARRAY = $8C18;
  GL_PROXY_TEXTURE_1D_ARRAY = $8C19;
  GL_TEXTURE_2D_ARRAY = $8C1A;
  GL_PROXY_TEXTURE_2D_ARRAY = $8C1B;
  GL_TEXTURE_BINDING_1D_ARRAY = $8C1C;
  GL_TEXTURE_BINDING_2D_ARRAY = $8C1D;
  GL_R11F_G11F_B10F = $8C3A;
  GL_UNSIGNED_INT_10F_11F_11F_REV = $8C3B;
  GL_RGB9_E5 = $8C3D;
  GL_UNSIGNED_INT_5_9_9_9_REV = $8C3E;
  GL_TEXTURE_SHARED_SIZE = $8C3F;
  GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH = $8C76;
  GL_TRANSFORM_FEEDBACK_BUFFER_MODE = $8C7F;
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS = $8C80;
  GL_TRANSFORM_FEEDBACK_VARYINGS = $8C83;
  GL_TRANSFORM_FEEDBACK_BUFFER_START = $8C84;
  GL_TRANSFORM_FEEDBACK_BUFFER_SIZE = $8C85;
  GL_PRIMITIVES_GENERATED = $8C87;
  GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN = $8C88;
  GL_RASTERIZER_DISCARD = $8C89;
  GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS = $8C8A;
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS = $8C8B;
  GL_INTERLEAVED_ATTRIBS = $8C8C;
  GL_SEPARATE_ATTRIBS = $8C8D;
  GL_TRANSFORM_FEEDBACK_BUFFER = $8C8E;
  GL_TRANSFORM_FEEDBACK_BUFFER_BINDING = $8C8F;
  GL_RGBA32UI = $8D70;
  GL_RGB32UI = $8D71;
  GL_RGBA16UI = $8D76;
  GL_RGB16UI = $8D77;
  GL_RGBA8UI = $8D7C;
  GL_RGB8UI = $8D7D;
  GL_RGBA32I = $8D82;
  GL_RGB32I = $8D83;
  GL_RGBA16I = $8D88;
  GL_RGB16I = $8D89;
  GL_RGBA8I = $8D8E;
  GL_RGB8I = $8D8F;
  GL_RED_INTEGER = $8D94;
  GL_GREEN_INTEGER = $8D95;
  GL_BLUE_INTEGER = $8D96;
  GL_RGB_INTEGER = $8D98;
  GL_RGBA_INTEGER = $8D99;
  GL_BGR_INTEGER = $8D9A;
  GL_BGRA_INTEGER = $8D9B;
  GL_SAMPLER_1D_ARRAY = $8DC0;
  GL_SAMPLER_2D_ARRAY = $8DC1;
  GL_SAMPLER_1D_ARRAY_SHADOW = $8DC3;
  GL_SAMPLER_2D_ARRAY_SHADOW = $8DC4;
  GL_SAMPLER_CUBE_SHADOW = $8DC5;
  GL_UNSIGNED_INT_VEC2 = $8DC6;
  GL_UNSIGNED_INT_VEC3 = $8DC7;
  GL_UNSIGNED_INT_VEC4 = $8DC8;
  GL_INT_SAMPLER_1D = $8DC9;
  GL_INT_SAMPLER_2D = $8DCA;
  GL_INT_SAMPLER_3D = $8DCB;
  GL_INT_SAMPLER_CUBE = $8DCC;
  GL_INT_SAMPLER_1D_ARRAY = $8DCE;
  GL_INT_SAMPLER_2D_ARRAY = $8DCF;
  GL_UNSIGNED_INT_SAMPLER_1D = $8DD1;
  GL_UNSIGNED_INT_SAMPLER_2D = $8DD2;
  GL_UNSIGNED_INT_SAMPLER_3D = $8DD3;
  GL_UNSIGNED_INT_SAMPLER_CUBE = $8DD4;
  GL_UNSIGNED_INT_SAMPLER_1D_ARRAY = $8DD6;
  GL_UNSIGNED_INT_SAMPLER_2D_ARRAY = $8DD7;
  GL_QUERY_WAIT = $8E13;
  GL_QUERY_NO_WAIT = $8E14;
  GL_QUERY_BY_REGION_WAIT = $8E15;
  GL_QUERY_BY_REGION_NO_WAIT = $8E16;
  GL_BUFFER_ACCESS_FLAGS = $911F;
  GL_BUFFER_MAP_LENGTH = $9120;
  GL_BUFFER_MAP_OFFSET = $9121;
  GL_CLAMP_VERTEX_COLOR = $891A;
  GL_CLAMP_FRAGMENT_COLOR = $891B;
  GL_ALPHA_INTEGER = $8D97;
  // GL_VERSION_3_1
  GL_SAMPLER_2D_RECT = $8B63;
  GL_SAMPLER_2D_RECT_SHADOW = $8B64;
  GL_SAMPLER_BUFFER = $8DC2;
  GL_INT_SAMPLER_2D_RECT = $8DCD;
  GL_INT_SAMPLER_BUFFER = $8DD0;
  GL_UNSIGNED_INT_SAMPLER_2D_RECT = $8DD5;
  GL_UNSIGNED_INT_SAMPLER_BUFFER = $8DD8;
  GL_TEXTURE_BUFFER = $8C2A;
  GL_MAX_TEXTURE_BUFFER_SIZE = $8C2B;
  GL_TEXTURE_BINDING_BUFFER = $8C2C;
  GL_TEXTURE_BUFFER_DATA_STORE_BINDING = $8C2D;
  GL_TEXTURE_BUFFER_FORMAT = $8C2E;
  GL_TEXTURE_RECTANGLE = $84F5;
  GL_TEXTURE_BINDING_RECTANGLE = $84F6;
  GL_PROXY_TEXTURE_RECTANGLE = $84F7;
  GL_MAX_RECTANGLE_TEXTURE_SIZE = $84F8;
  GL_RED_SNORM = $8F90;
  GL_RG_SNORM = $8F91;
  GL_RGB_SNORM = $8F92;
  GL_RGBA_SNORM = $8F93;
  GL_R8_SNORM = $8F94;
  GL_RG8_SNORM = $8F95;
  GL_RGB8_SNORM = $8F96;
  GL_RGBA8_SNORM = $8F97;
  GL_R16_SNORM = $8F98;
  GL_RG16_SNORM = $8F99;
  GL_RGB16_SNORM = $8F9A;
  GL_RGBA16_SNORM = $8F9B;
  GL_SIGNED_NORMALIZED = $8F9C;
  GL_PRIMITIVE_RESTART = $8F9D;
  GL_PRIMITIVE_RESTART_INDEX = $8F9E;
  // GL_VERSION_3_2
  GL_CONTEXT_CORE_PROFILE_BIT = $00000001;
  GL_CONTEXT_COMPATIBILITY_PROFILE_BIT = $00000002;
  GL_LINES_ADJACENCY = $000A;
  GL_LINE_STRIP_ADJACENCY = $000B;
  GL_TRIANGLES_ADJACENCY = $000C;
  GL_TRIANGLE_STRIP_ADJACENCY = $000D;
  GL_PROGRAM_POINT_SIZE = $8642;
  GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS = $8C29;
  GL_FRAMEBUFFER_ATTACHMENT_LAYERED = $8DA7;
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS = $8DA8;
  GL_GEOMETRY_SHADER = $8DD9;
  GL_GEOMETRY_VERTICES_OUT = $8916;
  GL_GEOMETRY_INPUT_TYPE = $8917;
  GL_GEOMETRY_OUTPUT_TYPE = $8918;
  GL_MAX_GEOMETRY_UNIFORM_COMPONENTS = $8DDF;
  GL_MAX_GEOMETRY_OUTPUT_VERTICES = $8DE0;
  GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS = $8DE1;
  GL_MAX_VERTEX_OUTPUT_COMPONENTS = $9122;
  GL_MAX_GEOMETRY_INPUT_COMPONENTS = $9123;
  GL_MAX_GEOMETRY_OUTPUT_COMPONENTS = $9124;
  GL_MAX_FRAGMENT_INPUT_COMPONENTS = $9125;
  GL_CONTEXT_PROFILE_MASK = $9126;
  // GL_VERSION_3_3
  GL_VERTEX_ATTRIB_ARRAY_DIVISOR = $88FE;
  // GL_VERSION_4_0
  GL_SAMPLE_SHADING = $8C36;
  GL_MIN_SAMPLE_SHADING_VALUE = $8C37;
  GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET = $8E5E;
  GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET = $8E5F;
  GL_TEXTURE_CUBE_MAP_ARRAY = $9009;
  GL_TEXTURE_BINDING_CUBE_MAP_ARRAY = $900A;
  GL_PROXY_TEXTURE_CUBE_MAP_ARRAY = $900B;
  GL_SAMPLER_CUBE_MAP_ARRAY = $900C;
  GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW = $900D;
  GL_INT_SAMPLER_CUBE_MAP_ARRAY = $900E;
  GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY = $900F;
  // GL_VERSION_4_3
  GL_NUM_SHADING_LANGUAGE_VERSIONS  = $82E9;
  GL_VERTEX_ATTRIB_ARRAY_LONG = $874E;
  // GL_3DFX_multisample
  GL_MULTISAMPLE_3DFX = $86B2;
  GL_SAMPLE_BUFFERS_3DFX = $86B3;
  GL_SAMPLES_3DFX = $86B4;
  GL_MULTISAMPLE_BIT_3DFX = $20000000;
  // GL_3DFX_texture_compression_FXT1
  GL_COMPRESSED_RGB_FXT1_3DFX = $86B0;
  GL_COMPRESSED_RGBA_FXT1_3DFX = $86B1;
  // GL_APPLE_client_storage
  GL_UNPACK_CLIENT_STORAGE_APPLE = $85B2;
  // GL_APPLE_element_array
  GL_ELEMENT_ARRAY_APPLE = $8A0C;
  GL_ELEMENT_ARRAY_TYPE_APPLE = $8A0D;
  GL_ELEMENT_ARRAY_POINTER_APPLE = $8A0E;
  // GL_APPLE_fence
  GL_DRAW_PIXELS_APPLE = $8A0A;
  GL_FENCE_APPLE = $8A0B;
  // GL_APPLE_specular_vector
  GL_LIGHT_MODEL_SPECULAR_VECTOR_APPLE = $85B0;
  // GL_APPLE_transform_hint
  GL_TRANSFORM_HINT_APPLE = $85B1;
  // GL_APPLE_vertex_array_object
  GL_VERTEX_ARRAY_BINDING_APPLE = $85B5;
  // GL_APPLE_vertex_array_range
  GL_VERTEX_ARRAY_RANGE_APPLE = $851D;
  GL_VERTEX_ARRAY_RANGE_LENGTH_APPLE = $851E;
  GL_VERTEX_ARRAY_STORAGE_HINT_APPLE = $851F;
  GL_VERTEX_ARRAY_RANGE_POINTER_APPLE = $8521;
  GL_STORAGE_CLIENT_APPLE = $85B4;
  GL_STORAGE_CACHED_APPLE = $85BE;
  GL_STORAGE_SHARED_APPLE = $85BF;
  // GL_APPLE_ycbcr_422
  GL_YCBCR_422_APPLE = $85B9;
  GL_UNSIGNED_SHORT_8_8_APPLE = $85BA;
  GL_UNSIGNED_SHORT_8_8_REV_APPLE = $85BB;
  GL_RGB_RAW_422_APPLE = $8A51;
  // GL_APPLE_texture_range
  GL_TEXTURE_RANGE_LENGTH_APPLE = $85B7;
  GL_TEXTURE_RANGE_POINTER_APPLE = $85B8;
  GL_TEXTURE_STORAGE_HINT_APPLE = $85BC;
  GL_STORAGE_PRIVATE_APPLE = $85BD;
  // GL_APPLE_float_pixels
  GL_HALF_APPLE = $140B;
  GL_RGBA_FLOAT32_APPLE = $8814;
  GL_RGB_FLOAT32_APPLE = $8815;
  GL_ALPHA_FLOAT32_APPLE = $8816;
  GL_INTENSITY_FLOAT32_APPLE = $8817;
  GL_LUMINANCE_FLOAT32_APPLE = $8818;
  GL_LUMINANCE_ALPHA_FLOAT32_APPLE = $8819;
  GL_RGBA_FLOAT16_APPLE = $881A;
  GL_RGB_FLOAT16_APPLE = $881B;
  GL_ALPHA_FLOAT16_APPLE = $881C;
  GL_INTENSITY_FLOAT16_APPLE = $881D;
  GL_LUMINANCE_FLOAT16_APPLE = $881E;
  GL_LUMINANCE_ALPHA_FLOAT16_APPLE = $881F;
  GL_COLOR_FLOAT_APPLE = $8A0F;
  // GL_APPLE_vertex_program_evaluators
  GL_VERTEX_ATTRIB_MAP1_APPLE = $8A00;
  GL_VERTEX_ATTRIB_MAP2_APPLE = $8A01;
  GL_VERTEX_ATTRIB_MAP1_SIZE_APPLE = $8A02;
  GL_VERTEX_ATTRIB_MAP1_COEFF_APPLE = $8A03;
  GL_VERTEX_ATTRIB_MAP1_ORDER_APPLE = $8A04;
  GL_VERTEX_ATTRIB_MAP1_DOMAIN_APPLE = $8A05;
  GL_VERTEX_ATTRIB_MAP2_SIZE_APPLE = $8A06;
  GL_VERTEX_ATTRIB_MAP2_COEFF_APPLE = $8A07;
  GL_VERTEX_ATTRIB_MAP2_ORDER_APPLE = $8A08;
  GL_VERTEX_ATTRIB_MAP2_DOMAIN_APPLE = $8A09;
  // GL_APPLE_aux_depth_stencil
  GL_AUX_DEPTH_STENCIL_APPLE = $8A14;
  // GL_APPLE_object_purgeable
  GL_BUFFER_OBJECT_APPLE = $85B3;
  GL_RELEASED_APPLE = $8A19;
  GL_VOLATILE_APPLE = $8A1A;
  GL_RETAINED_APPLE = $8A1B;
  GL_UNDEFINED_APPLE = $8A1C;
  GL_PURGEABLE_APPLE = $8A1D;
  // GL_APPLE_row_bytes
  GL_PACK_ROW_BYTES_APPLE = $8A15;
  GL_UNPACK_ROW_BYTES_APPLE = $8A16;
  // GL_ARB_depth_texture
  GL_DEPTH_COMPONENT16_ARB = $81A5;
  GL_DEPTH_COMPONENT24_ARB = $81A6;
  GL_DEPTH_COMPONENT32_ARB = $81A7;
  GL_TEXTURE_DEPTH_SIZE_ARB = $884A;
  GL_DEPTH_TEXTURE_MODE_ARB = $884B;
  // GL_ARB_fragment_program
  GL_FRAGMENT_PROGRAM_ARB = $8804;
  GL_PROGRAM_ALU_INSTRUCTIONS_ARB = $8805;
  GL_PROGRAM_TEX_INSTRUCTIONS_ARB = $8806;
  GL_PROGRAM_TEX_INDIRECTIONS_ARB = $8807;
  GL_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB = $8808;
  GL_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB = $8809;
  GL_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB = $880A;
  GL_MAX_PROGRAM_ALU_INSTRUCTIONS_ARB = $880B;
  GL_MAX_PROGRAM_TEX_INSTRUCTIONS_ARB = $880C;
  GL_MAX_PROGRAM_TEX_INDIRECTIONS_ARB = $880D;
  GL_MAX_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB = $880E;
  GL_MAX_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB = $880F;
  GL_MAX_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB = $8810;
  GL_MAX_TEXTURE_COORDS_ARB = $8871;
  GL_MAX_TEXTURE_IMAGE_UNITS_ARB = $8872;
  // GL_ARB_imaging
  GL_CONSTANT_COLOR_ARB = $8001;
  GL_ONE_MINUS_CONSTANT_COLOR = $8002;
  GL_CONSTANT_ALPHA = $8003;
  GL_ONE_MINUS_CONSTANT_ALPHA = $8004;
  GL_BLEND_COLOR = $8005;
  GL_FUNC_ADD = $8006;
  GL_MIN = $8007;
  GL_MAX = $8008;
  GL_BLEND_EQUATION = $8009;
  GL_FUNC_SUBTRACT = $800A;
  GL_FUNC_REVERSE_SUBTRACT = $800B;
  GL_CONVOLUTION_1D = $8010;
  GL_CONVOLUTION_2D = $8011;
  GL_SEPARABLE_2D = $8012;
  GL_CONVOLUTION_BORDER_MODE = $8013;
  GL_CONVOLUTION_FILTER_SCALE = $8014;
  GL_CONVOLUTION_FILTER_BIAS = $8015;
  GL_REDUCE = $8016;
  GL_CONVOLUTION_FORMAT = $8017;
  GL_CONVOLUTION_WIDTH = $8018;
  GL_CONVOLUTION_HEIGHT = $8019;
  GL_MAX_CONVOLUTION_WIDTH = $801A;
  GL_MAX_CONVOLUTION_HEIGHT = $801B;
  GL_POST_CONVOLUTION_RED_SCALE = $801C;
  GL_POST_CONVOLUTION_GREEN_SCALE = $801D;
  GL_POST_CONVOLUTION_BLUE_SCALE = $801E;
  GL_POST_CONVOLUTION_ALPHA_SCALE = $801F;
  GL_POST_CONVOLUTION_RED_BIAS = $8020;
  GL_POST_CONVOLUTION_GREEN_BIAS = $8021;
  GL_POST_CONVOLUTION_BLUE_BIAS = $8022;
  GL_POST_CONVOLUTION_ALPHA_BIAS = $8023;
  GL_HISTOGRAM = $8024;
  GL_PROXY_HISTOGRAM = $8025;
  GL_HISTOGRAM_WIDTH = $8026;
  GL_HISTOGRAM_FORMAT = $8027;
  GL_HISTOGRAM_RED_SIZE = $8028;
  GL_HISTOGRAM_GREEN_SIZE = $8029;
  GL_HISTOGRAM_BLUE_SIZE = $802A;
  GL_HISTOGRAM_ALPHA_SIZE = $802B;
  GL_HISTOGRAM_LUMINANCE_SIZE = $802C;
  GL_HISTOGRAM_SINK = $802D;
  GL_MINMAX = $802E;
  GL_MINMAX_FORMAT = $802F;
  GL_MINMAX_SINK = $8030;
  GL_TABLE_TOO_LARGE = $8031;
  GL_COLOR_MATRIX = $80B1;
  GL_COLOR_MATRIX_STACK_DEPTH = $80B2;
  GL_MAX_COLOR_MATRIX_STACK_DEPTH = $80B3;
  GL_POST_COLOR_MATRIX_RED_SCALE = $80B4;
  GL_POST_COLOR_MATRIX_GREEN_SCALE = $80B5;
  GL_POST_COLOR_MATRIX_BLUE_SCALE = $80B6;
  GL_POST_COLOR_MATRIX_ALPHA_SCALE = $80B7;
  GL_POST_COLOR_MATRIX_RED_BIAS = $80B8;
  GL_POST_COLOR_MATRIX_GREEN_BIAS = $80B9;
  GL_POST_COLOR_MATRIX_BLUE_BIAS = $80BA;
  GL_POST_COLOR_MATRIX_ALPHA_BIAS = $80BB;
  GL_COLOR_TABLE = $80D0;
  GL_POST_CONVOLUTION_COLOR_TABLE = $80D1;
  GL_POST_COLOR_MATRIX_COLOR_TABLE = $80D2;
  GL_PROXY_COLOR_TABLE = $80D3;
  GL_PROXY_POST_CONVOLUTION_COLOR_TABLE = $80D4;
  GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE = $80D5;
  GL_COLOR_TABLE_SCALE = $80D6;
  GL_COLOR_TABLE_BIAS = $80D7;
  GL_COLOR_TABLE_FORMAT = $80D8;
  GL_COLOR_TABLE_WIDTH = $80D9;
  GL_COLOR_TABLE_RED_SIZE = $80DA;
  GL_COLOR_TABLE_GREEN_SIZE = $80DB;
  GL_COLOR_TABLE_BLUE_SIZE = $80DC;
  GL_COLOR_TABLE_ALPHA_SIZE = $80DD;
  GL_COLOR_TABLE_LUMINANCE_SIZE = $80DE;
  GL_COLOR_TABLE_INTENSITY_SIZE = $80DF;
  GL_CONSTANT_BORDER = $8151;
  GL_REPLICATE_BORDER = $8153;
  GL_CONVOLUTION_BORDER_COLOR = $8154;
  // GL_ARB_matrix_palette
  GL_MATRIX_PALETTE_ARB = $8840;
  GL_MAX_MATRIX_PALETTE_STACK_DEPTH_ARB = $8841;
  GL_MAX_PALETTE_MATRICES_ARB = $8842;
  GL_CURRENT_PALETTE_MATRIX_ARB = $8843;
  GL_MATRIX_INDEX_ARRAY_ARB = $8844;
  GL_CURRENT_MATRIX_INDEX_ARB = $8845;
  GL_MATRIX_INDEX_ARRAY_SIZE_ARB = $8846;
  GL_MATRIX_INDEX_ARRAY_TYPE_ARB = $8847;
  GL_MATRIX_INDEX_ARRAY_STRIDE_ARB = $8848;
  GL_MATRIX_INDEX_ARRAY_POINTER_ARB = $8849;
  // GL_ARB_multisample
  GL_MULTISAMPLE_ARB = $809D;
  GL_SAMPLE_ALPHA_TO_COVERAGE_ARB = $809E;
  GL_SAMPLE_ALPHA_TO_ONE_ARB = $809F;
  GL_SAMPLE_COVERAGE_ARB = $80A0;
  GL_SAMPLE_BUFFERS_ARB = $80A8;
  GL_SAMPLES_ARB = $80A9;
  GL_SAMPLE_COVERAGE_VALUE_ARB = $80AA;
  GL_SAMPLE_COVERAGE_INVERT_ARB = $80AB;
  GL_MULTISAMPLE_BIT_ARB = $20000000;
  // GL_ARB_multitexture
  GL_TEXTURE0_ARB = $84C0;
  GL_TEXTURE1_ARB = $84C1;
  GL_TEXTURE2_ARB = $84C2;
  GL_TEXTURE3_ARB = $84C3;
  GL_TEXTURE4_ARB = $84C4;
  GL_TEXTURE5_ARB = $84C5;
  GL_TEXTURE6_ARB = $84C6;
  GL_TEXTURE7_ARB = $84C7;
  GL_TEXTURE8_ARB = $84C8;
  GL_TEXTURE9_ARB = $84C9;
  GL_TEXTURE10_ARB = $84CA;
  GL_TEXTURE11_ARB = $84CB;
  GL_TEXTURE12_ARB = $84CC;
  GL_TEXTURE13_ARB = $84CD;
  GL_TEXTURE14_ARB = $84CE;
  GL_TEXTURE15_ARB = $84CF;
  GL_TEXTURE16_ARB = $84D0;
  GL_TEXTURE17_ARB = $84D1;
  GL_TEXTURE18_ARB = $84D2;
  GL_TEXTURE19_ARB = $84D3;
  GL_TEXTURE20_ARB = $84D4;
  GL_TEXTURE21_ARB = $84D5;
  GL_TEXTURE22_ARB = $84D6;
  GL_TEXTURE23_ARB = $84D7;
  GL_TEXTURE24_ARB = $84D8;
  GL_TEXTURE25_ARB = $84D9;
  GL_TEXTURE26_ARB = $84DA;
  GL_TEXTURE27_ARB = $84DB;
  GL_TEXTURE28_ARB = $84DC;
  GL_TEXTURE29_ARB = $84DD;
  GL_TEXTURE30_ARB = $84DE;
  GL_TEXTURE31_ARB = $84DF;
  GL_ACTIVE_TEXTURE_ARB = $84E0;
  GL_CLIENT_ACTIVE_TEXTURE_ARB = $84E1;
  GL_MAX_TEXTURE_UNITS_ARB = $84E2;
  // GL_ARB_point_parameters
  GL_POINT_SIZE_MIN_ARB = $8126;
  GL_POINT_SIZE_MAX_ARB = $8127;
  GL_POINT_FADE_THRESHOLD_SIZE_ARB = $8128;
  GL_POINT_DISTANCE_ATTENUATION_ARB = $8129;
  // GL_ARB_shadow
  GL_TEXTURE_COMPARE_MODE_ARB = $884C;
  GL_TEXTURE_COMPARE_FUNC_ARB = $884D;
  GL_COMPARE_R_TO_TEXTURE_ARB = $884E;
  // GL_ARB_shadow_ambient
  GL_TEXTURE_COMPARE_FAIL_VALUE_ARB = $80BF;
  // GL_ARB_sparse_buffer
  GL_SPARSE_STORAGE_BIT_ARB = $0400;
  GL_SPARSE_BUFFER_PAGE_SIZE_ARB = $82F8;
  // GL_ARB_texture_border_clamp
  GL_CLAMP_TO_BORDER_ARB = $812D;
  // GL_ARB_texture_compression
  GL_COMPRESSED_ALPHA_ARB = $84E9;
  GL_COMPRESSED_LUMINANCE_ARB = $84EA;
  GL_COMPRESSED_LUMINANCE_ALPHA_ARB = $84EB;
  GL_COMPRESSED_INTENSITY_ARB = $84EC;
  GL_COMPRESSED_RGB_ARB = $84ED;
  GL_COMPRESSED_RGBA_ARB = $84EE;
  GL_TEXTURE_COMPRESSION_HINT_ARB = $84EF;
  GL_TEXTURE_COMPRESSED_IMAGE_SIZE_ARB = $86A0;
  GL_TEXTURE_COMPRESSED_ARB = $86A1;
  GL_NUM_COMPRESSED_TEXTURE_FORMATS_ARB = $86A2;
  GL_COMPRESSED_TEXTURE_FORMATS_ARB = $86A3;
  // GL_ARB_texture_cube_map
  GL_NORMAL_MAP_ARB = $8511;
  GL_REFLECTION_MAP_ARB = $8512;
  GL_TEXTURE_CUBE_MAP_ARB = $8513;
  GL_TEXTURE_BINDING_CUBE_MAP_ARB = $8514;
  GL_TEXTURE_CUBE_MAP_POSITIVE_X_ARB = $8515;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_X_ARB = $8516;
  GL_TEXTURE_CUBE_MAP_POSITIVE_Y_ARB = $8517;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_ARB = $8518;
  GL_TEXTURE_CUBE_MAP_POSITIVE_Z_ARB = $8519;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_ARB = $851A;
  GL_PROXY_TEXTURE_CUBE_MAP_ARB = $851B;
  GL_MAX_CUBE_MAP_TEXTURE_SIZE_ARB = $851C;
  // GL_ARB_texture_env_combine
  GL_COMBINE_ARB = $8570;
  GL_COMBINE_RGB_ARB = $8571;
  GL_COMBINE_ALPHA_ARB = $8572;
  GL_SOURCE0_RGB_ARB = $8580;
  GL_SOURCE1_RGB_ARB = $8581;
  GL_SOURCE2_RGB_ARB = $8582;
  GL_SOURCE0_ALPHA_ARB = $8588;
  GL_SOURCE1_ALPHA_ARB = $8589;
  GL_SOURCE2_ALPHA_ARB = $858A;
  GL_OPERAND0_RGB_ARB = $8590;
  GL_OPERAND1_RGB_ARB = $8591;
  GL_OPERAND2_RGB_ARB = $8592;
  GL_OPERAND0_ALPHA_ARB = $8598;
  GL_OPERAND1_ALPHA_ARB = $8599;
  GL_OPERAND2_ALPHA_ARB = $859A;
  GL_RGB_SCALE_ARB = $8573;
  GL_ADD_SIGNED_ARB = $8574;
  GL_INTERPOLATE_ARB = $8575;
  GL_SUBTRACT_ARB = $84E7;
  GL_CONSTANT_ARB = $8576;
  GL_PRIMARY_COLOR_ARB = $8577;
  GL_PREVIOUS_ARB = $8578;
  // GL_ARB_texture_env_dot3
  GL_DOT3_RGB_ARB = $86AE;
  GL_DOT3_RGBA_ARB = $86AF;
  // GL_ARB_texture_mirrored_repeat
  GL_MIRRORED_REPEAT_ARB = $8370;
  // GL_ARB_transpose_matrix
  GL_TRANSPOSE_MODELVIEW_MATRIX_ARB = $84E3;
  GL_TRANSPOSE_PROJECTION_MATRIX_ARB = $84E4;
  GL_TRANSPOSE_TEXTURE_MATRIX_ARB = $84E5;
  GL_TRANSPOSE_COLOR_MATRIX_ARB = $84E6;
  // GL_ARB_vertex_blend
  GL_MAX_VERTEX_UNITS_ARB = $86A4;
  GL_ACTIVE_VERTEX_UNITS_ARB = $86A5;
  GL_WEIGHT_SUM_UNITY_ARB = $86A6;
  GL_VERTEX_BLEND_ARB = $86A7;
  GL_CURRENT_WEIGHT_ARB = $86A8;
  GL_WEIGHT_ARRAY_TYPE_ARB = $86A9;
  GL_WEIGHT_ARRAY_STRIDE_ARB = $86AA;
  GL_WEIGHT_ARRAY_SIZE_ARB = $86AB;
  GL_WEIGHT_ARRAY_POINTER_ARB = $86AC;
  GL_WEIGHT_ARRAY_ARB = $86AD;
  GL_MODELVIEW0_ARB = $1700;
  GL_MODELVIEW1_ARB = $850A;
  GL_MODELVIEW2_ARB = $8722;
  GL_MODELVIEW3_ARB = $8723;
  GL_MODELVIEW4_ARB = $8724;
  GL_MODELVIEW5_ARB = $8725;
  GL_MODELVIEW6_ARB = $8726;
  GL_MODELVIEW7_ARB = $8727;
  GL_MODELVIEW8_ARB = $8728;
  GL_MODELVIEW9_ARB = $8729;
  GL_MODELVIEW10_ARB = $872A;
  GL_MODELVIEW11_ARB = $872B;
  GL_MODELVIEW12_ARB = $872C;
  GL_MODELVIEW13_ARB = $872D;
  GL_MODELVIEW14_ARB = $872E;
  GL_MODELVIEW15_ARB = $872F;
  GL_MODELVIEW16_ARB = $8730;
  GL_MODELVIEW17_ARB = $8731;
  GL_MODELVIEW18_ARB = $8732;
  GL_MODELVIEW19_ARB = $8733;
  GL_MODELVIEW20_ARB = $8734;
  GL_MODELVIEW21_ARB = $8735;
  GL_MODELVIEW22_ARB = $8736;
  GL_MODELVIEW23_ARB = $8737;
  GL_MODELVIEW24_ARB = $8738;
  GL_MODELVIEW25_ARB = $8739;
  GL_MODELVIEW26_ARB = $873A;
  GL_MODELVIEW27_ARB = $873B;
  GL_MODELVIEW28_ARB = $873C;
  GL_MODELVIEW29_ARB = $873D;
  GL_MODELVIEW30_ARB = $873E;
  GL_MODELVIEW31_ARB = $873F;
  // GL_ARB_vertex_buffer_object
  GL_BUFFER_SIZE_ARB = $8764;
  GL_BUFFER_USAGE_ARB = $8765;
  GL_ARRAY_BUFFER_ARB = $8892;
  GL_ELEMENT_ARRAY_BUFFER_ARB = $8893;
  GL_ARRAY_BUFFER_BINDING_ARB = $8894;
  GL_ELEMENT_ARRAY_BUFFER_BINDING_ARB = $8895;
  GL_VERTEX_ARRAY_BUFFER_BINDING_ARB = $8896;
  GL_NORMAL_ARRAY_BUFFER_BINDING_ARB = $8897;
  GL_COLOR_ARRAY_BUFFER_BINDING_ARB = $8898;
  GL_INDEX_ARRAY_BUFFER_BINDING_ARB = $8899;
  GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING_ARB = $889A;
  GL_EDGE_FLAG_ARRAY_BUFFER_BINDING_ARB = $889B;
  GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING_ARB = $889C;
  GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING_ARB = $889D;
  GL_WEIGHT_ARRAY_BUFFER_BINDING_ARB = $889E;
  GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING_ARB = $889F;
  GL_READ_ONLY_ARB = $88B8;
  GL_WRITE_ONLY_ARB = $88B9;
  GL_READ_WRITE_ARB = $88BA;
  GL_BUFFER_ACCESS_ARB = $88BB;
  GL_BUFFER_MAPPED_ARB = $88BC;
  GL_BUFFER_MAP_POINTER_ARB = $88BD;
  GL_STREAM_DRAW_ARB = $88E0;
  GL_STREAM_READ_ARB = $88E1;
  GL_STREAM_COPY_ARB = $88E2;
  GL_STATIC_DRAW_ARB = $88E4;
  GL_STATIC_READ_ARB = $88E5;
  GL_STATIC_COPY_ARB = $88E6;
  GL_DYNAMIC_DRAW_ARB = $88E8;
  GL_DYNAMIC_READ_ARB = $88E9;
  GL_DYNAMIC_COPY_ARB = $88EA;
  // GL_ARB_vertex_program
  GL_COLOR_SUM_ARB = $8458;
  GL_VERTEX_PROGRAM_ARB = $8620;
  GL_VERTEX_ATTRIB_ARRAY_ENABLED_ARB = $8622;
  GL_VERTEX_ATTRIB_ARRAY_SIZE_ARB = $8623;
  GL_VERTEX_ATTRIB_ARRAY_STRIDE_ARB = $8624;
  GL_VERTEX_ATTRIB_ARRAY_TYPE_ARB = $8625;
  GL_CURRENT_VERTEX_ATTRIB_ARB = $8626;
  GL_PROGRAM_LENGTH_ARB = $8627;
  GL_PROGRAM_STRING_ARB = $8628;
  GL_MAX_PROGRAM_MATRIX_STACK_DEPTH_ARB = $862E;
  GL_MAX_PROGRAM_MATRICES_ARB = $862F;
  GL_CURRENT_MATRIX_STACK_DEPTH_ARB = $8640;
  GL_CURRENT_MATRIX_ARB = $8641;
  GL_VERTEX_PROGRAM_POINT_SIZE_ARB = $8642;
  GL_VERTEX_PROGRAM_TWO_SIDE_ARB = $8643;
  GL_VERTEX_ATTRIB_ARRAY_POINTER_ARB = $8645;
  GL_PROGRAM_ERROR_POSITION_ARB = $864B;
  GL_PROGRAM_BINDING_ARB = $8677;
  GL_MAX_VERTEX_ATTRIBS_ARB = $8869;
  GL_VERTEX_ATTRIB_ARRAY_NORMALIZED_ARB = $886A;
  GL_PROGRAM_ERROR_STRING_ARB = $8874;
  GL_PROGRAM_FORMAT_ASCII_ARB = $8875;
  GL_PROGRAM_FORMAT_ARB = $8876;
  GL_PROGRAM_INSTRUCTIONS_ARB = $88A0;
  GL_MAX_PROGRAM_INSTRUCTIONS_ARB = $88A1;
  GL_PROGRAM_NATIVE_INSTRUCTIONS_ARB = $88A2;
  GL_MAX_PROGRAM_NATIVE_INSTRUCTIONS_ARB = $88A3;
  GL_PROGRAM_TEMPORARIES_ARB = $88A4;
  GL_MAX_PROGRAM_TEMPORARIES_ARB = $88A5;
  GL_PROGRAM_NATIVE_TEMPORARIES_ARB = $88A6;
  GL_MAX_PROGRAM_NATIVE_TEMPORARIES_ARB = $88A7;
  GL_PROGRAM_PARAMETERS_ARB = $88A8;
  GL_MAX_PROGRAM_PARAMETERS_ARB = $88A9;
  GL_PROGRAM_NATIVE_PARAMETERS_ARB = $88AA;
  GL_MAX_PROGRAM_NATIVE_PARAMETERS_ARB = $88AB;
  GL_PROGRAM_ATTRIBS_ARB = $88AC;
  GL_MAX_PROGRAM_ATTRIBS_ARB = $88AD;
  GL_PROGRAM_NATIVE_ATTRIBS_ARB = $88AE;
  GL_MAX_PROGRAM_NATIVE_ATTRIBS_ARB = $88AF;
  GL_PROGRAM_ADDRESS_REGISTERS_ARB = $88B0;
  GL_MAX_PROGRAM_ADDRESS_REGISTERS_ARB = $88B1;
  GL_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB = $88B2;
  GL_MAX_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB = $88B3;
  GL_MAX_PROGRAM_LOCAL_PARAMETERS_ARB = $88B4;
  GL_MAX_PROGRAM_ENV_PARAMETERS_ARB = $88B5;
  GL_PROGRAM_UNDER_NATIVE_LIMITS_ARB = $88B6;
  GL_TRANSPOSE_CURRENT_MATRIX_ARB = $88B7;
  GL_MATRIX0_ARB = $88C0;
  GL_MATRIX1_ARB = $88C1;
  GL_MATRIX2_ARB = $88C2;
  GL_MATRIX3_ARB = $88C3;
  GL_MATRIX4_ARB = $88C4;
  GL_MATRIX5_ARB = $88C5;
  GL_MATRIX6_ARB = $88C6;
  GL_MATRIX7_ARB = $88C7;
  GL_MATRIX8_ARB = $88C8;
  GL_MATRIX9_ARB = $88C9;
  GL_MATRIX10_ARB = $88CA;
  GL_MATRIX11_ARB = $88CB;
  GL_MATRIX12_ARB = $88CC;
  GL_MATRIX13_ARB = $88CD;
  GL_MATRIX14_ARB = $88CE;
  GL_MATRIX15_ARB = $88CF;
  GL_MATRIX16_ARB = $88D0;
  GL_MATRIX17_ARB = $88D1;
  GL_MATRIX18_ARB = $88D2;
  GL_MATRIX19_ARB = $88D3;
  GL_MATRIX20_ARB = $88D4;
  GL_MATRIX21_ARB = $88D5;
  GL_MATRIX22_ARB = $88D6;
  GL_MATRIX23_ARB = $88D7;
  GL_MATRIX24_ARB = $88D8;
  GL_MATRIX25_ARB = $88D9;
  GL_MATRIX26_ARB = $88DA;
  GL_MATRIX27_ARB = $88DB;
  GL_MATRIX28_ARB = $88DC;
  GL_MATRIX29_ARB = $88DD;
  GL_MATRIX30_ARB = $88DE;
  GL_MATRIX31_ARB = $88DF;

  // GL_ARB_draw_buffers
  GL_MAX_DRAW_BUFFERS_ARB = $8824;
  GL_DRAW_BUFFER0_ARB = $8825;
  GL_DRAW_BUFFER1_ARB = $8826;
  GL_DRAW_BUFFER2_ARB = $8827;
  GL_DRAW_BUFFER3_ARB = $8828;
  GL_DRAW_BUFFER4_ARB = $8829;
  GL_DRAW_BUFFER5_ARB = $882A;
  GL_DRAW_BUFFER6_ARB = $882B;
  GL_DRAW_BUFFER7_ARB = $882C;
  GL_DRAW_BUFFER8_ARB = $882D;
  GL_DRAW_BUFFER9_ARB = $882E;
  GL_DRAW_BUFFER10_ARB = $882F;
  GL_DRAW_BUFFER11_ARB = $8830;
  GL_DRAW_BUFFER12_ARB = $8831;
  GL_DRAW_BUFFER13_ARB = $8832;
  GL_DRAW_BUFFER14_ARB = $8833;
  GL_DRAW_BUFFER15_ARB = $8834;
  // GL_ARB_texture_rectangle
  GL_TEXTURE_RECTANGLE_ARB = $84F5;
  GL_TEXTURE_BINDING_RECTANGLE_ARB = $84F6;
  GL_PROXY_TEXTURE_RECTANGLE_ARB = $84F7;
  GL_MAX_RECTANGLE_TEXTURE_SIZE_ARB = $84F8;
  // GL_ARB_color_buffer_float
  GL_RGBA_FLOAT_MODE_ARB = $8820;
  GL_CLAMP_VERTEX_COLOR_ARB = $891A;
  GL_CLAMP_FRAGMENT_COLOR_ARB = $891B;
  GL_CLAMP_READ_COLOR_ARB = $891C;
  GL_FIXED_ONLY_ARB = $891D;
  WGL_TYPE_RGBA_FLOAT_ARB = $21A0;
  GLX_RGBA_FLOAT_TYPE = $20B9;
  GLX_RGBA_FLOAT_BIT = $00000004;
  // GL_ARB_compute_variable_group_size
  GL_MAX_COMPUTE_VARIABLE_GROUP_INVOCATIONS_ARB = $9344;
  GL_MAX_COMPUTE_FIXED_GROUP_INVOCATIONS_ARB = $90EB;
  GL_MAX_COMPUTE_VARIABLE_GROUP_SIZE_ARB = $9345;
  GL_MAX_COMPUTE_FIXED_GROUP_SIZE_ARB = $91BF;
  // GL_ARB_half_float_pixel
  GL_HALF_FLOAT_ARB = $140B;
  // GL_ARB_texture_float
  GL_TEXTURE_RED_TYPE_ARB = $8C10;
  GL_TEXTURE_GREEN_TYPE_ARB = $8C11;
  GL_TEXTURE_BLUE_TYPE_ARB = $8C12;
  GL_TEXTURE_ALPHA_TYPE_ARB = $8C13;
  GL_TEXTURE_LUMINANCE_TYPE_ARB = $8C14;
  GL_TEXTURE_INTENSITY_TYPE_ARB = $8C15;
  GL_TEXTURE_DEPTH_TYPE_ARB = $8C16;
  GL_UNSIGNED_NORMALIZED_ARB = $8C17;
  GL_RGBA32F_ARB = $8814;
  GL_RGB32F_ARB = $8815;
  GL_ALPHA32F_ARB = $8816;
  GL_INTENSITY32F_ARB = $8817;
  GL_LUMINANCE32F_ARB = $8818;
  GL_LUMINANCE_ALPHA32F_ARB = $8819;
  GL_RGBA16F_ARB = $881A;
  GL_RGB16F_ARB = $881B;
  GL_ALPHA16F_ARB = $881C;
  GL_INTENSITY16F_ARB = $881D;
  GL_LUMINANCE16F_ARB = $881E;
  GL_LUMINANCE_ALPHA16F_ARB = $881F;
  // GL_ARB_pixel_buffer_object
  GL_PIXEL_PACK_BUFFER_ARB = $88EB;
  GL_PIXEL_UNPACK_BUFFER_ARB = $88EC;
  GL_PIXEL_PACK_BUFFER_BINDING_ARB = $88ED;
  GL_PIXEL_UNPACK_BUFFER_BINDING_ARB = $88EF;
  // GL_ARB_depth_buffer_float
  GL_DEPTH_COMPONENT32F = $8CAC;
  GL_DEPTH32F_STENCIL8 = $8CAD;
  GL_FLOAT_32_UNSIGNED_INT_24_8_REV = $8DAD;
  // GL_ARB_framebuffer_object
  GL_INVALID_FRAMEBUFFER_OPERATION = $0506;
  GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING = $8210;
  GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE = $8211;
  GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE = $8212;
  GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE = $8213;
  GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE = $8214;
  GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE = $8215;
  GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE = $8216;
  GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE = $8217;
  GL_FRAMEBUFFER_DEFAULT = $8218;
  GL_FRAMEBUFFER_UNDEFINED = $8219;
  GL_DEPTH_STENCIL_ATTACHMENT = $821A;
  GL_MAX_RENDERBUFFER_SIZE = $84E8;
  GL_DEPTH_STENCIL = $84F9;
  GL_UNSIGNED_INT_24_8 = $84FA;
  GL_DEPTH24_STENCIL8 = $88F0;
  GL_TEXTURE_STENCIL_SIZE = $88F1;
  GL_TEXTURE_RED_TYPE = $8C10;
  GL_TEXTURE_GREEN_TYPE = $8C11;
  GL_TEXTURE_BLUE_TYPE = $8C12;
  GL_TEXTURE_ALPHA_TYPE = $8C13;
  GL_TEXTURE_DEPTH_TYPE = $8C16;
  GL_UNSIGNED_NORMALIZED = $8C17;
  GL_FRAMEBUFFER_BINDING = $8CA6;
  GL_DRAW_FRAMEBUFFER_BINDING = GL_FRAMEBUFFER_BINDING;
  GL_RENDERBUFFER_BINDING = $8CA7;
  GL_READ_FRAMEBUFFER = $8CA8;
  GL_DRAW_FRAMEBUFFER = $8CA9;
  GL_READ_FRAMEBUFFER_BINDING = $8CAA;
  GL_RENDERBUFFER_SAMPLES = $8CAB;
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = $8CD0;
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = $8CD1;
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = $8CD2;
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = $8CD3;
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER = $8CD4;
  GL_FRAMEBUFFER_COMPLETE = $8CD5;
  GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT = $8CD6;
  GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = $8CD7;
  GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER = $8CDB;
  GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER = $8CDC;
  GL_FRAMEBUFFER_UNSUPPORTED = $8CDD;
  GL_MAX_COLOR_ATTACHMENTS = $8CDF;
  GL_COLOR_ATTACHMENT0 = $8CE0;
  GL_COLOR_ATTACHMENT1 = $8CE1;
  GL_COLOR_ATTACHMENT2 = $8CE2;
  GL_COLOR_ATTACHMENT3 = $8CE3;
  GL_COLOR_ATTACHMENT4 = $8CE4;
  GL_COLOR_ATTACHMENT5 = $8CE5;
  GL_COLOR_ATTACHMENT6 = $8CE6;
  GL_COLOR_ATTACHMENT7 = $8CE7;
  GL_COLOR_ATTACHMENT8 = $8CE8;
  GL_COLOR_ATTACHMENT9 = $8CE9;
  GL_COLOR_ATTACHMENT10 = $8CEA;
  GL_COLOR_ATTACHMENT11 = $8CEB;
  GL_COLOR_ATTACHMENT12 = $8CEC;
  GL_COLOR_ATTACHMENT13 = $8CED;
  GL_COLOR_ATTACHMENT14 = $8CEE;
  GL_COLOR_ATTACHMENT15 = $8CEF;
  GL_DEPTH_ATTACHMENT = $8D00;
  GL_STENCIL_ATTACHMENT = $8D20;
  GL_FRAMEBUFFER = $8D40;
  GL_RENDERBUFFER = $8D41;
  GL_RENDERBUFFER_WIDTH = $8D42;
  GL_RENDERBUFFER_HEIGHT = $8D43;
  GL_RENDERBUFFER_INTERNAL_FORMAT = $8D44;
  GL_STENCIL_INDEX1 = $8D46;
  GL_STENCIL_INDEX4 = $8D47;
  GL_STENCIL_INDEX8 = $8D48;
  GL_STENCIL_INDEX16 = $8D49;
  GL_RENDERBUFFER_RED_SIZE = $8D50;
  GL_RENDERBUFFER_GREEN_SIZE = $8D51;
  GL_RENDERBUFFER_BLUE_SIZE = $8D52;
  GL_RENDERBUFFER_ALPHA_SIZE = $8D53;
  GL_RENDERBUFFER_DEPTH_SIZE = $8D54;
  GL_RENDERBUFFER_STENCIL_SIZE = $8D55;
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE = $8D56;
  GL_MAX_SAMPLES = $8D57;
  GL_INDEX = $8222;
  GL_TEXTURE_LUMINANCE_TYPE = $8C14;
  GL_TEXTURE_INTENSITY_TYPE = $8C15;
  // GL_ARB_framebuffer_sRGB
  GL_FRAMEBUFFER_SRGB = $8DB9;
  // GL_ARB_geometry_shader4
  GL_LINES_ADJACENCY_ARB = $000A;
  GL_LINE_STRIP_ADJACENCY_ARB = $000B;
  GL_TRIANGLES_ADJACENCY_ARB = $000C;
  GL_TRIANGLE_STRIP_ADJACENCY_ARB = $000D;
  GL_PROGRAM_POINT_SIZE_ARB = $8642;
  GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_ARB = $8C29;
  GL_FRAMEBUFFER_ATTACHMENT_LAYERED_ARB = $8DA7;
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_ARB = $8DA8;
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_ARB = $8DA9;
  GL_GEOMETRY_SHADER_ARB = $8DD9;
  GL_GEOMETRY_VERTICES_OUT_ARB = $8DDA;
  GL_GEOMETRY_INPUT_TYPE_ARB = $8DDB;
  GL_GEOMETRY_OUTPUT_TYPE_ARB = $8DDC;
  GL_MAX_GEOMETRY_VARYING_COMPONENTS_ARB = $8DDD;
  GL_MAX_VERTEX_VARYING_COMPONENTS_ARB = $8DDE;
  GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_ARB = $8DDF;
  GL_MAX_GEOMETRY_OUTPUT_VERTICES_ARB = $8DE0;
  GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_ARB = $8DE1;
  // GL_ARB_half_float_vertex
  GL_HALF_FLOAT = $140B;
  // GL_ARB_instanced_arrays
  GL_VERTEX_ATTRIB_ARRAY_DIVISOR_ARB = $88FE;
  // GL_ARB_map_buffer_range
  GL_MAP_READ_BIT = $0001;
  GL_MAP_WRITE_BIT = $0002;
  GL_MAP_INVALIDATE_RANGE_BIT = $0004;
  GL_MAP_INVALIDATE_BUFFER_BIT = $0008;
  GL_MAP_FLUSH_EXPLICIT_BIT = $0010;
  GL_MAP_UNSYNCHRONIZED_BIT = $0020;
  // GL_ARB_texture_buffer_object
  GL_TEXTURE_BUFFER_ARB = $8C2A;
  GL_MAX_TEXTURE_BUFFER_SIZE_ARB = $8C2B;
  GL_TEXTURE_BINDING_BUFFER_ARB = $8C2C;
  GL_TEXTURE_BUFFER_DATA_STORE_BINDING_ARB = $8C2D;
  GL_TEXTURE_BUFFER_FORMAT_ARB = $8C2E;
  // GL_ARB_texture_compression_rgtc
  GL_COMPRESSED_RED_RGTC1 = $8DBB;
  GL_COMPRESSED_SIGNED_RED_RGTC1 = $8DBC;
  GL_COMPRESSED_RG_RGTC2 = $8DBD;
  GL_COMPRESSED_SIGNED_RG_RGTC2 = $8DBE;
  // GL_ARB_texture_rg
  GL_RG = $8227;
  GL_RG_INTEGER = $8228;
  GL_R8 = $8229;
  GL_R16 = $822A;
  GL_RG8 = $822B;
  GL_RG16 = $822C;
  GL_R16F = $822D;
  GL_R32F = $822E;
  GL_RG16F = $822F;
  GL_RG32F = $8230;
  GL_R8I = $8231;
  GL_R8UI = $8232;
  GL_R16I = $8233;
  GL_R16UI = $8234;
  GL_R32I = $8235;
  GL_R32UI = $8236;
  GL_RG8I = $8237;
  GL_RG8UI = $8238;
  GL_RG16I = $8239;
  GL_RG16UI = $823A;
  GL_RG32I = $823B;
  GL_RG32UI = $823C;
  // GL_ARB_vertex_array_object
  GL_VERTEX_ARRAY_BINDING = $85B5;
  // GL_ARB_uniform_buffer_object
  GL_UNIFORM_BUFFER = $8A11;
  GL_UNIFORM_BUFFER_BINDING = $8A28;
  GL_UNIFORM_BUFFER_START = $8A29;
  GL_UNIFORM_BUFFER_SIZE = $8A2A;
  GL_MAX_VERTEX_UNIFORM_BLOCKS = $8A2B;
  GL_MAX_GEOMETRY_UNIFORM_BLOCKS = $8A2C;
  GL_MAX_FRAGMENT_UNIFORM_BLOCKS = $8A2D;
  GL_MAX_COMBINED_UNIFORM_BLOCKS = $8A2E;
  GL_MAX_UNIFORM_BUFFER_BINDINGS = $8A2F;
  GL_MAX_UNIFORM_BLOCK_SIZE = $8A30;
  GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS = $8A31;
  GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS = $8A32;
  GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS = $8A33;
  GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT = $8A34;
  GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH = $8A35;
  GL_ACTIVE_UNIFORM_BLOCKS = $8A36;
  GL_UNIFORM_TYPE = $8A37;
  GL_UNIFORM_SIZE = $8A38;
  GL_UNIFORM_NAME_LENGTH = $8A39;
  GL_UNIFORM_BLOCK_INDEX = $8A3A;
  GL_UNIFORM_OFFSET = $8A3B;
  GL_UNIFORM_ARRAY_STRIDE = $8A3C;
  GL_UNIFORM_MATRIX_STRIDE = $8A3D;
  GL_UNIFORM_IS_ROW_MAJOR = $8A3E;
  GL_UNIFORM_BLOCK_BINDING = $8A3F;
  GL_UNIFORM_BLOCK_DATA_SIZE = $8A40;
  GL_UNIFORM_BLOCK_NAME_LENGTH = $8A41;
  GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS = $8A42;
  GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES = $8A43;
  GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER = $8A44;
  GL_UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER = $8A45;
  GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER = $8A46;
  GL_INVALID_INDEX = $FFFFFFFF;
  // GL_ARB_copy_buffer
  GL_COPY_READ_BUFFER_BINDING = $8F36;
  GL_COPY_READ_BUFFER = GL_COPY_READ_BUFFER_BINDING;
  GL_COPY_WRITE_BUFFER_BINDING = $8F37;
  GL_COPY_WRITE_BUFFER = GL_COPY_WRITE_BUFFER_BINDING;
  // GL_ARB_depth_clamp
  GL_DEPTH_CLAMP = $864F;
  // GL_ARB_provoking_vertex
  GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION = $8E4C;
  GL_FIRST_VERTEX_CONVENTION = $8E4D;
  GL_LAST_VERTEX_CONVENTION = $8E4E;
  GL_PROVOKING_VERTEX = $8E4F;
  // GL_ARB_seamless_cube_map
  GL_TEXTURE_CUBE_MAP_SEAMLESS = $884F;
  // GL_ARB_sync
  GL_MAX_SERVER_WAIT_TIMEOUT = $9111;
  GL_OBJECT_TYPE = $9112;
  GL_SYNC_CONDITION = $9113;
  GL_SYNC_STATUS = $9114;
  GL_SYNC_FLAGS = $9115;
  GL_SYNC_FENCE = $9116;
  GL_SYNC_GPU_COMMANDS_COMPLETE = $9117;
  GL_UNSIGNALED = $9118;
  GL_SIGNALED = $9119;
  GL_ALREADY_SIGNALED = $911A;
  GL_TIMEOUT_EXPIRED = $911B;
  GL_CONDITION_SATISFIED = $911C;
  GL_WAIT_FAILED = $911D;
  GL_SYNC_FLUSH_COMMANDS_BIT = $00000001;
  GL_TIMEOUT_IGNORED = $FFFFFFFFFFFFFFFF;
  // GL_ARB_texture_multisample
  GL_SAMPLE_POSITION = $8E50;
  GL_SAMPLE_MASK = $8E51;
  GL_SAMPLE_MASK_VALUE = $8E52;
  GL_MAX_SAMPLE_MASK_WORDS = $8E59;
  GL_TEXTURE_2D_MULTISAMPLE = $9100;
  GL_PROXY_TEXTURE_2D_MULTISAMPLE = $9101;
  GL_TEXTURE_2D_MULTISAMPLE_ARRAY = $9102;
  GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY = $9103;
  GL_TEXTURE_BINDING_2D_MULTISAMPLE = $9104;
  GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY = $9105;
  GL_TEXTURE_SAMPLES = $9106;
  GL_TEXTURE_FIXED_SAMPLE_LOCATIONS = $9107;
  GL_SAMPLER_2D_MULTISAMPLE = $9108;
  GL_INT_SAMPLER_2D_MULTISAMPLE = $9109;
  GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE = $910A;
  GL_SAMPLER_2D_MULTISAMPLE_ARRAY = $910B;
  GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = $910C;
  GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = $910D;
  GL_MAX_COLOR_TEXTURE_SAMPLES = $910E;
  GL_MAX_DEPTH_TEXTURE_SAMPLES = $910F;
  GL_MAX_INTEGER_SAMPLES = $9110;
  // GL_ARB_sample_shading
  GL_SAMPLE_SHADING_ARB = $8C36;
  GL_MIN_SAMPLE_SHADING_VALUE_ARB = $8C37;
  // GL_ARB_texture_cube_map_array
  GL_TEXTURE_CUBE_MAP_ARRAY_ARB = $9009;
  GL_TEXTURE_BINDING_CUBE_MAP_ARRAY_ARB = $900A;
  GL_PROXY_TEXTURE_CUBE_MAP_ARRAY_ARB = $900B;
  GL_SAMPLER_CUBE_MAP_ARRAY_ARB = $900C;
  GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW_ARB = $900D;
  GL_INT_SAMPLER_CUBE_MAP_ARRAY_ARB = $900E;
  GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY_ARB = $900F;
  // GL_ARB_texture_gather
  GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET_ARB = $8E5E;
  GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET_ARB = $8E5F;
  // GL_ARB_shading_language_include
  GL_SHADER_INCLUDE_ARB = $8DAE;
  GL_NAMED_STRING_LENGTH_ARB = $8DE9;
  GL_NAMED_STRING_TYPE_ARB = $8DEA;
  // GL_ARB_texture_compression_bptc
  GL_COMPRESSED_RGBA_BPTC_UNORM_ARB = $8E8C;
  GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM_ARB = $8E8D;
  GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT_ARB = $8E8E;
  GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT_ARB = $8E8F;
  // GL_ARB_blend_func_extended
  GL_SRC1_COLOR = $88F9;
  GL_ONE_MINUS_SRC1_COLOR = $88FA;
  GL_ONE_MINUS_SRC1_ALPHA = $88FB;
  GL_MAX_DUAL_SOURCE_DRAW_BUFFERS = $88FC;
  // GL_ARB_occlusion_query2
  GL_ANY_SAMPLES_PASSED = $8C2F;
  // GL_ARB_sampler_objects
  GL_SAMPLER_BINDING = $8919;
  // GL_ARB_texture_rgb10_a2ui
  GL_RGB10_A2UI = $906F;
  // GL_ARB_texture_swizzle
  GL_TEXTURE_SWIZZLE_R = $8E42;
  GL_TEXTURE_SWIZZLE_G = $8E43;
  GL_TEXTURE_SWIZZLE_B = $8E44;
  GL_TEXTURE_SWIZZLE_A = $8E45;
  GL_TEXTURE_SWIZZLE_RGBA = $8E46;
  // GL_ARB_SPARSE_TEXTURE
  GL_TEXTURE_SPARSE_ARB = $91A6;
  GL_VIRTUAL_PAGE_SIZE_INDEX_ARB = $91A7;
  GL_NUM_VIRTUAL_PAGE_SIZES_ARB = $91A8;
  GL_SPARSE_TEXTURE_FULL_ARRAY_CUBE_MIPMAPS_ARB = $91A9;
  GL_NUM_SPARSE_LEVELS_ARB = $91AA;
  GL_VIRTUAL_PAGE_SIZE_X_ARB = $9195;
  GL_VIRTUAL_PAGE_SIZE_Y_ARB = $9196;
  GL_VIRTUAL_PAGE_SIZE_Z_ARB = $9197;
  GL_MAX_SPARSE_TEXTURE_SIZE_ARB = $9198;
  GL_MAX_SPARSE_3D_TEXTURE_SIZE_ARB = $9199;
  GL_MAX_SPARSE_ARRAY_TEXTURE_LAYERS_ARB = $919A;
  GL_MIN_SPARSE_LEVEL_ARB = $919B;
  // GL_ARB_timer_query
  GL_TIME_ELAPSED = $88BF;
  GL_TIMESTAMP = $8E28;
  // GL_ARB_vertex_type_2_10_10_10_rev
  GL_INT_2_10_10_10_REV = $8D9F;
  // GL_ARB_draw_indirect
  GL_DRAW_INDIRECT_BUFFER = $8F3F;
  GL_DRAW_INDIRECT_BUFFER_BINDING = $8F43;
  // GL_ARB_gpu_shader5
  GL_GEOMETRY_SHADER_INVOCATIONS = $887F;
  GL_MAX_GEOMETRY_SHADER_INVOCATIONS = $8E5A;
  GL_MIN_FRAGMENT_INTERPOLATION_OFFSET = $8E5B;
  GL_MAX_FRAGMENT_INTERPOLATION_OFFSET = $8E5C;
  GL_FRAGMENT_INTERPOLATION_OFFSET_BITS = $8E5D;
  // GL_ARB_gpu_shader_fp64
  GL_DOUBLE_VEC2 = $8FFC;
  GL_DOUBLE_VEC3 = $8FFD;
  GL_DOUBLE_VEC4 = $8FFE;
  GL_DOUBLE_MAT2 = $8F46;
  GL_DOUBLE_MAT3 = $8F47;
  GL_DOUBLE_MAT4 = $8F48;
  GL_DOUBLE_MAT2x3 = $8F49;
  GL_DOUBLE_MAT2x4 = $8F4A;
  GL_DOUBLE_MAT3x2 = $8F4B;
  GL_DOUBLE_MAT3x4 = $8F4C;
  GL_DOUBLE_MAT4x2 = $8F4D;
  GL_DOUBLE_MAT4x3 = $8F4E;
  // GL_ARB_shader_subroutine
  GL_ACTIVE_SUBROUTINES = $8DE5;
  GL_ACTIVE_SUBROUTINE_UNIFORMS = $8DE6;
  GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS = $8E47;
  GL_ACTIVE_SUBROUTINE_MAX_LENGTH = $8E48;
  GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH = $8E49;
  GL_MAX_SUBROUTINES = $8DE7;
  GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS = $8DE8;
  GL_NUM_COMPATIBLE_SUBROUTINES = $8E4A;
  GL_COMPATIBLE_SUBROUTINES = $8E4B;
  // GL_ARB_tessellation_shader
  GL_PATCHES = $000E;
  GL_PATCH_VERTICES = $8E72;
  GL_PATCH_DEFAULT_INNER_LEVEL = $8E73;
  GL_PATCH_DEFAULT_OUTER_LEVEL = $8E74;
  GL_TESS_CONTROL_OUTPUT_VERTICES = $8E75;
  GL_TESS_GEN_MODE = $8E76;
  GL_TESS_GEN_SPACING = $8E77;
  GL_TESS_GEN_VERTEX_ORDER = $8E78;
  GL_TESS_GEN_POINT_MODE = $8E79;
  GL_ISOLINES = $8E7A;
  GL_FRACTIONAL_ODD = $8E7B;
  GL_FRACTIONAL_EVEN = $8E7C;
  GL_MAX_PATCH_VERTICES = $8E7D;
  GL_MAX_TESS_GEN_LEVEL = $8E7E;
  GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS = $8E7F;
  GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS = $8E80;
  GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS = $8E81;
  GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS = $8E82;
  GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS = $8E83;
  GL_MAX_TESS_PATCH_COMPONENTS = $8E84;
  GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS = $8E85;
  GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS = $8E86;
  GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS = $8E89;
  GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS = $8E8A;
  GL_MAX_TESS_CONTROL_INPUT_COMPONENTS = $886C;
  GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS = $886D;
  GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS = $8E1E;
  GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS = $8E1F;
  GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER = $84F0;
  GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER = $84F1;
  GL_TESS_EVALUATION_SHADER = $8E87;
  GL_TESS_CONTROL_SHADER = $8E88;
  // GL_ARB_transform_feedback2
  GL_TRANSFORM_FEEDBACK = $8E22;
  GL_TRANSFORM_FEEDBACK_PAUSED = $8E23;
  GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED = GL_TRANSFORM_FEEDBACK_PAUSED;
  GL_TRANSFORM_FEEDBACK_ACTIVE = $8E24;
  GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE = GL_TRANSFORM_FEEDBACK_ACTIVE;
  GL_TRANSFORM_FEEDBACK_BINDING = $8E25;
  // GL_ARB_transform_feedback_overflow_query
  GL_TRANSFORM_FEEDBACK_OVERFLOW_ARB = $82EC;
  GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW_ARB = $82ED;
  // GL_ARB_transform_feedback3
  GL_MAX_TRANSFORM_FEEDBACK_BUFFERS = $8E70;
  GL_MAX_VERTEX_STREAMS = $8E71;
  // GL_ARB_ES2_compatibility
  GL_FIXED = $140C;
  GL_IMPLEMENTATION_COLOR_READ_TYPE = $8B9A;
  GL_IMPLEMENTATION_COLOR_READ_FORMAT = $8B9B;
  GL_LOW_FLOAT = $8DF0;
  GL_MEDIUM_FLOAT = $8DF1;
  GL_HIGH_FLOAT = $8DF2;
  GL_LOW_INT = $8DF3;
  GL_MEDIUM_INT = $8DF4;
  GL_HIGH_INT = $8DF5;
  GL_SHADER_COMPILER = $8DFA;
  GL_NUM_SHADER_BINARY_FORMATS = $8DF9;
  GL_MAX_VERTEX_UNIFORM_VECTORS = $8DFB;
  GL_MAX_VARYING_VECTORS = $8DFC;
  GL_MAX_FRAGMENT_UNIFORM_VECTORS = $8DFD;
  GL_RGB565 = $8D62;
  // GL_ARB_get_program_binary
  GL_PROGRAM_BINARY_RETRIEVABLE_HINT = $8257;
  GL_PROGRAM_BINARY_LENGTH = $8741;
  GL_NUM_PROGRAM_BINARY_FORMATS = $87FE;
  GL_PROGRAM_BINARY_FORMATS = $87FF;
  // GL_ARB_separate_shader_objects
  GL_VERTEX_SHADER_BIT = $00000001;
  GL_FRAGMENT_SHADER_BIT = $00000002;
  GL_GEOMETRY_SHADER_BIT = $00000004;
  GL_TESS_CONTROL_SHADER_BIT = $00000008;
  GL_TESS_EVALUATION_SHADER_BIT = $00000010;
  GL_ALL_SHADER_BITS = $FFFFFFFF;
  GL_PROGRAM_SEPARABLE = $8258;
  GL_ACTIVE_PROGRAM = $8259;
  GL_PROGRAM_PIPELINE_BINDING = $825A;
  // GL_ARB_viewport_array
  GL_MAX_VIEWPORTS = $825B;
  GL_VIEWPORT_SUBPIXEL_BITS = $825C;
  GL_VIEWPORT_BOUNDS_RANGE = $825D;
  GL_LAYER_PROVOKING_VERTEX = $825E;
  GL_VIEWPORT_INDEX_PROVOKING_VERTEX = $825F;
  GL_UNDEFINED_VERTEX = $8260;
  // GL_ARB_cl_event
  GL_SYNC_CL_EVENT_ARB = $8240;
  GL_SYNC_CL_EVENT_COMPLETE_ARB = $8241;
  // GL_ARB_debug_output
  GL_DEBUG_OUTPUT_SYNCHRONOUS_ARB = $8242;
  GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH_ARB = $8243;
  GL_DEBUG_CALLBACK_FUNCTION_ARB = $8244;
  GL_DEBUG_CALLBACK_USER_PARAM_ARB = $8245;
  GL_DEBUG_SOURCE_API_ARB = $8246;
  GL_DEBUG_SOURCE_WINDOW_SYSTEM_ARB = $8247;
  GL_DEBUG_SOURCE_SHADER_COMPILER_ARB = $8248;
  GL_DEBUG_SOURCE_THIRD_PARTY_ARB = $8249;
  GL_DEBUG_SOURCE_APPLICATION_ARB = $824A;
  GL_DEBUG_SOURCE_OTHER_ARB = $824B;
  GL_DEBUG_TYPE_ERROR_ARB = $824C;
  GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR_ARB = $824D;
  GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR_ARB = $824E;
  GL_DEBUG_TYPE_PORTABILITY_ARB = $824F;
  GL_DEBUG_TYPE_PERFORMANCE_ARB = $8250;
  GL_DEBUG_TYPE_OTHER_ARB = $8251;
  GL_MAX_DEBUG_MESSAGE_LENGTH_ARB = $9143;
  GL_MAX_DEBUG_LOGGED_MESSAGES_ARB = $9144;
  GL_DEBUG_LOGGED_MESSAGES_ARB = $9145;
  GL_DEBUG_SEVERITY_HIGH_ARB = $9146;
  GL_DEBUG_SEVERITY_MEDIUM_ARB = $9147;
  GL_DEBUG_SEVERITY_LOW_ARB = $9148;
  // GL_ARB_robustness
  GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT_ARB = $00000004;
  GL_LOSE_CONTEXT_ON_RESET_ARB = $8252;
  GL_GUILTY_CONTEXT_RESET_ARB = $8253;
  GL_INNOCENT_CONTEXT_RESET_ARB = $8254;
  GL_UNKNOWN_CONTEXT_RESET_ARB = $8255;
  GL_RESET_NOTIFICATION_STRATEGY_ARB = $8256;
  GL_NO_RESET_NOTIFICATION_ARB = $8261;
  //  GL_ARB_compressed_texture_pixel_storage
  GL_UNPACK_COMPRESSED_BLOCK_WIDTH  = $09127;
  GL_UNPACK_COMPRESSED_BLOCK_HEIGHT = $09128;
  GL_UNPACK_COMPRESSED_BLOCK_DEPTH  = $09129;
  GL_UNPACK_COMPRESSED_BLOCK_SIZE   = $0912A;
  GL_PACK_COMPRESSED_BLOCK_WIDTH    = $0912B;
  GL_PACK_COMPRESSED_BLOCK_HEIGHT   = $0912C;
  GL_PACK_COMPRESSED_BLOCK_DEPTH    = $0912D;
  GL_PACK_COMPRESSED_BLOCK_SIZE     = $0912E;
  // GL_ARB_internalformat_query
  GL_NUM_SAMPLE_COUNTS              = $09380;
  // GL_ARB_map_buffer_alignment
  GL_MIN_MAP_BUFFER_ALIGNMENT       = $090BC;
  // GL_ARB_shader_atomic_counters
  GL_ATOMIC_COUNTER_BUFFER          = $92C0;
  GL_ATOMIC_COUNTER_BUFFER_BINDING  = $92C1;
  GL_ATOMIC_COUNTER_BUFFER_START    = $92C2;
  GL_ATOMIC_COUNTER_BUFFER_SIZE     = $92C3;
  GL_ATOMIC_COUNTER_BUFFER_DATA_SIZE = $92C4;
  GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS = $92C5;
  GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES = $92C6;
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER = $92C7;
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER = $92C8;
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER = $92C9;
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER = $92CA;
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER = $92CB;
  GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS = $92CC;
  GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS = $92CD;
  GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS = $92CE;
  GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS = $92CF;
  GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS = $92D0;
  GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS = $92D1;
  GL_MAX_VERTEX_ATOMIC_COUNTERS     = $92D2;
  GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS = $92D3;
  GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS = $92D4;
  GL_MAX_GEOMETRY_ATOMIC_COUNTERS   = $92D5;
  GL_MAX_FRAGMENT_ATOMIC_COUNTERS   = $92D6;
  GL_MAX_COMBINED_ATOMIC_COUNTERS   = $92D7;
  GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE = $92D8;
  GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS = $92DC;
  GL_ACTIVE_ATOMIC_COUNTER_BUFFERS  = $92D9;
  GL_UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX = $92DA;
  GL_UNSIGNED_INT_ATOMIC_COUNTER    = $92DB;
  // GL_ARB_shader_image_load_store
  GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT = $00000001;
  GL_ELEMENT_ARRAY_BARRIER_BIT      = $00000002;
  GL_UNIFORM_BARRIER_BIT            = $00000004;
  GL_TEXTURE_FETCH_BARRIER_BIT      = $00000008;
  GL_SHADER_IMAGE_ACCESS_BARRIER_BIT = $00000020;
  GL_COMMAND_BARRIER_BIT            = $00000040;
  GL_PIXEL_BUFFER_BARRIER_BIT       = $00000080;
  GL_TEXTURE_UPDATE_BARRIER_BIT     = $00000100;
  GL_BUFFER_UPDATE_BARRIER_BIT      = $00000200;
  GL_FRAMEBUFFER_BARRIER_BIT        = $00000400;
  GL_TRANSFORM_FEEDBACK_BARRIER_BIT = $00000800;
  GL_ATOMIC_COUNTER_BARRIER_BIT     = $00001000;
  GL_ALL_BARRIER_BITS               = $FFFFFFFF;
  GL_MAX_IMAGE_UNITS                = $8F38;
  GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS = $8F39;
  GL_IMAGE_BINDING_NAME             = $8F3A;
  GL_IMAGE_BINDING_LEVEL            = $8F3B;
  GL_IMAGE_BINDING_LAYERED          = $8F3C;
  GL_IMAGE_BINDING_LAYER            = $8F3D;
  GL_IMAGE_BINDING_ACCESS           = $8F3E;
  GL_IMAGE_1D                       = $904C;
  GL_IMAGE_2D                       = $904D;
  GL_IMAGE_3D                       = $904E;
  GL_IMAGE_2D_RECT                  = $904F;
  GL_IMAGE_CUBE                     = $9050;
  GL_IMAGE_BUFFER                   = $9051;
  GL_IMAGE_1D_ARRAY                 = $9052;
  GL_IMAGE_2D_ARRAY                 = $9053;
  GL_IMAGE_CUBE_MAP_ARRAY           = $9054;
  GL_IMAGE_2D_MULTISAMPLE           = $9055;
  GL_IMAGE_2D_MULTISAMPLE_ARRAY     = $9056;
  GL_INT_IMAGE_1D                   = $9057;
  GL_INT_IMAGE_2D                   = $9058;
  GL_INT_IMAGE_3D                   = $9059;
  GL_INT_IMAGE_2D_RECT              = $905A;
  GL_INT_IMAGE_CUBE                 = $905B;
  GL_INT_IMAGE_BUFFER               = $905C;
  GL_INT_IMAGE_1D_ARRAY             = $905D;
  GL_INT_IMAGE_2D_ARRAY             = $905E;
  GL_INT_IMAGE_CUBE_MAP_ARRAY       = $905F;
  GL_INT_IMAGE_2D_MULTISAMPLE       = $9060;
  GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY = $9061;
  GL_UNSIGNED_INT_IMAGE_1D          = $9062;
  GL_UNSIGNED_INT_IMAGE_2D          = $9063;
  GL_UNSIGNED_INT_IMAGE_3D          = $9064;
  GL_UNSIGNED_INT_IMAGE_2D_RECT     = $9065;
  GL_UNSIGNED_INT_IMAGE_CUBE        = $9066;
  GL_UNSIGNED_INT_IMAGE_BUFFER      = $9067;
  GL_UNSIGNED_INT_IMAGE_1D_ARRAY    = $9068;
  GL_UNSIGNED_INT_IMAGE_2D_ARRAY    = $9069;
  GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY = $906A;
  GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE = $906B;
  GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY = $906C;
  GL_MAX_IMAGE_SAMPLES              = $906D;
  GL_IMAGE_BINDING_FORMAT           = $906E;
  GL_IMAGE_FORMAT_COMPATIBILITY_TYPE = $90C7;
  GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE = $90C8;
  GL_IMAGE_FORMAT_COMPATIBILITY_BY_CLASS = $90C9;
  GL_MAX_VERTEX_IMAGE_UNIFORMS      = $90CA;
  GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS = $90CB;
  GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS = $90CC;
  GL_MAX_GEOMETRY_IMAGE_UNIFORMS    = $90CD;
  GL_MAX_FRAGMENT_IMAGE_UNIFORMS    = $90CE;
  GL_MAX_COMBINED_IMAGE_UNIFORMS    = $90CF;
  // GL_ARB_texture_storage
  GL_TEXTURE_IMMUTABLE_FORMAT       = $912F;
  // 4.3
  // GL_KHR_texture_compression_astc_hdr
  GL_COMPRESSED_RGBA_ASTC_4x4_KHR = $93B0;
  GL_COMPRESSED_RGBA_ASTC_5x4_KHR = $93B1;
  GL_COMPRESSED_RGBA_ASTC_5x5_KHR = $93B2;
  GL_COMPRESSED_RGBA_ASTC_6x5_KHR = $93B3;
  GL_COMPRESSED_RGBA_ASTC_6x6_KHR = $93B4;
  GL_COMPRESSED_RGBA_ASTC_8x5_KHR = $93B5;
  GL_COMPRESSED_RGBA_ASTC_8x6_KHR = $93B6;
  GL_COMPRESSED_RGBA_ASTC_8x8_KHR = $93B7;
  GL_COMPRESSED_RGBA_ASTC_105_KHR = $93B8;
  GL_COMPRESSED_RGBA_ASTC_106_KHR = $93B9;
  GL_COMPRESSED_RGBA_ASTC_108_KHR = $93BA;
  GL_COMPRESSED_RGBA_ASTC_110_KHR = $93BB;
  GL_COMPRESSED_RGBA_ASTC_12x10_KHR = $93BC;
  GL_COMPRESSED_RGBA_ASTC_12x12_KHR = $93BD;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4_KHR = $93D0;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x4_KHR = $93D1;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5_KHR = $93D2;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x5_KHR = $93D3;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6_KHR = $93D4;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x5_KHR = $93D5;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x6_KHR = $93D6;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x8_KHR = $93D7;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x5_KHR = $93D8;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x6_KHR = $93D9;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x8_KHR = $93DA;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x10_KHR = $93DB;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x10_KHR = $93DC;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x12_KHR = $93DD;
  // (4.3) GL_KHR_debug
  GL_DEBUG_OUTPUT_SYNCHRONOUS       = $8242;
  GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH = $8243;
  GL_DEBUG_CALLBACK_FUNCTION        = $8244;
  GL_DEBUG_CALLBACK_USER_PARAM      = $8245;
  GL_DEBUG_SOURCE_API               = $8246;
  GL_DEBUG_SOURCE_WINDOW_SYSTEM     = $8247;
  GL_DEBUG_SOURCE_SHADER_COMPILER   = $8248;
  GL_DEBUG_SOURCE_THIRD_PARTY       = $8249;
  GL_DEBUG_SOURCE_APPLICATION       = $824A;
  GL_DEBUG_SOURCE_OTHER             = $824B;
  GL_DEBUG_TYPE_ERROR               = $824C;
  GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR = $824D;
  GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR  = $824E;
  GL_DEBUG_TYPE_PORTABILITY         = $824F;
  GL_DEBUG_TYPE_PERFORMANCE         = $8250;
  GL_DEBUG_TYPE_OTHER               = $8251;
  GL_DEBUG_TYPE_MARKER              = $8268;
  GL_DEBUG_TYPE_PUSH_GROUP          = $8269;
  GL_DEBUG_TYPE_POP_GROUP           = $826A;
  GL_DEBUG_SEVERITY_NOTIFICATION    = $826B;
  GL_MAX_DEBUG_GROUP_STACK_DEPTH    = $826C;
  GL_DEBUG_GROUP_STACK_DEPTH        = $826D;
  GL_BUFFER                         = $82E0;
  GL_SHADER                         = $82E1;
  GL_PROGRAM                        = $82E2;
  GL_QUERY                          = $82E3;
  GL_PROGRAM_PIPELINE               = $82E4;
  GL_SAMPLER                        = $82E6;
  GL_DISPLAY_LIST                   = $82E7;
  GL_MAX_LABEL_LENGTH               = $82E8;
  GL_MAX_DEBUG_MESSAGE_LENGTH       = $9143;
  GL_MAX_DEBUG_LOGGED_MESSAGES      = $9144;
  GL_DEBUG_LOGGED_MESSAGES          = $9145;
  GL_DEBUG_SEVERITY_HIGH            = $9146;
  GL_DEBUG_SEVERITY_MEDIUM          = $9147;
  GL_DEBUG_SEVERITY_LOW             = $9148;
  GL_DEBUG_OUTPUT                   = $92E0;
  GL_CONTEXT_FLAG_DEBUG_BIT         = $00000002;
  GL_COMPUTE_SHADER                 = $91B9;
  GL_MAX_COMPUTE_UNIFORM_BLOCKS     = $91BB;
  GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS = $91BC;
  GL_MAX_COMPUTE_IMAGE_UNIFORMS     = $91BD;
  GL_MAX_COMPUTE_SHARED_MEMORY_SIZE = $8262;
  GL_MAX_COMPUTE_UNIFORM_COMPONENTS = $8263;
  GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS = $8264;
  GL_MAX_COMPUTE_ATOMIC_COUNTERS    = $8265;
  GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS = $8266;
  GL_MAX_COMPUTE_LOCAL_INVOCATIONS  = $90EB;
  GL_MAX_COMPUTE_WORK_GROUP_COUNT   = $91BE;
  GL_MAX_COMPUTE_WORK_GROUP_SIZE    = $91BF;
  GL_COMPUTE_LOCAL_WORK_SIZE        = $8267;
  GL_UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER = $90EC;
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER = $90ED;
  GL_DISPATCH_INDIRECT_BUFFER       = $90EE;
  GL_DISPATCH_INDIRECT_BUFFER_BINDING = $90EF;
  GL_COMPUTE_SHADER_BIT             = $00000020;
  GL_COMPRESSED_RGB8_ETC2           = $9274;
  GL_COMPRESSED_SRGB8_ETC2          = $9275;
  GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2 = $9276;
  GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2 = $9277;
  GL_COMPRESSED_RGBA8_ETC2_EAC      = $9278;
  GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC = $9279;
  GL_COMPRESSED_R11_EAC             = $9270;
  GL_COMPRESSED_SIGNED_R11_EAC      = $9271;
  GL_COMPRESSED_RG11_EAC            = $9272;
  GL_COMPRESSED_SIGNED_RG11_EAC     = $9273;
  GL_PRIMITIVE_RESTART_FIXED_INDEX  = $8D69;
  GL_ANY_SAMPLES_PASSED_CONSERVATIVE = $8D6A;
  GL_MAX_ELEMENT_INDEX              = $8D6B;
  GL_MAX_UNIFORM_LOCATIONS          = $826E;
  GL_FRAMEBUFFER_DEFAULT_WIDTH      = $9310;
  GL_FRAMEBUFFER_DEFAULT_HEIGHT     = $9311;
  GL_FRAMEBUFFER_DEFAULT_LAYERS     = $9312;
  GL_FRAMEBUFFER_DEFAULT_SAMPLES    = $9313;
  GL_FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS = $9314;
  GL_MAX_FRAMEBUFFER_WIDTH          = $9315;
  GL_MAX_FRAMEBUFFER_HEIGHT         = $9316;
  GL_MAX_FRAMEBUFFER_LAYERS         = $9317;
  GL_MAX_FRAMEBUFFER_SAMPLES        = $9318;
  GL_INTERNALFORMAT_SUPPORTED       = $826F;
  GL_INTERNALFORMAT_PREFERRED       = $8270;
  GL_INTERNALFORMAT_RED_SIZE        = $8271;
  GL_INTERNALFORMAT_GREEN_SIZE      = $8272;
  GL_INTERNALFORMAT_BLUE_SIZE       = $8273;
  GL_INTERNALFORMAT_ALPHA_SIZE      = $8274;
  GL_INTERNALFORMAT_DEPTH_SIZE      = $8275;
  GL_INTERNALFORMAT_STENCIL_SIZE    = $8276;
  GL_INTERNALFORMAT_SHARED_SIZE     = $8277;
  GL_INTERNALFORMAT_RED_TYPE        = $8278;
  GL_INTERNALFORMAT_GREEN_TYPE      = $8279;
  GL_INTERNALFORMAT_BLUE_TYPE       = $827A;
  GL_INTERNALFORMAT_ALPHA_TYPE      = $827B;
  GL_INTERNALFORMAT_DEPTH_TYPE      = $827C;
  GL_INTERNALFORMAT_STENCIL_TYPE    = $827D;
  GL_MAX_WIDTH                      = $827E;
  GL_MAX_HEIGHT                     = $827F;
  GL_MAX_DEPTH                      = $8280;
  GL_MAX_LAYERS                     = $8281;
  GL_MAX_COMBINED_DIMENSIONS        = $8282;
  GL_COLOR_COMPONENTS               = $8283;
  GL_DEPTH_COMPONENTS               = $8284;
  GL_STENCIL_COMPONENTS             = $8285;
  GL_COLOR_RENDERABLE               = $8286;
  GL_DEPTH_RENDERABLE               = $8287;
  GL_STENCIL_RENDERABLE             = $8288;
  GL_FRAMEBUFFER_RENDERABLE         = $8289;
  GL_FRAMEBUFFER_RENDERABLE_LAYERED = $828A;
  GL_FRAMEBUFFER_BLEND              = $828B;
  GL_READ_PIXELS                    = $828C;
  GL_READ_PIXELS_FORMAT             = $828D;
  GL_READ_PIXELS_TYPE               = $828E;
  GL_TEXTURE_IMAGE_FORMAT           = $828F;
  GL_TEXTURE_IMAGE_TYPE             = $8290;
  GL_GET_TEXTURE_IMAGE_FORMAT       = $8291;
  GL_GET_TEXTURE_IMAGE_TYPE         = $8292;
  GL_MIPMAP                         = $8293;
  GL_MANUAL_GENERATE_MIPMAP         = $8294;
  GL_AUTO_GENERATE_MIPMAP           = $8295;
  GL_COLOR_ENCODING                 = $8296;
  GL_SRGB_READ                      = $8297;
  GL_SRGB_WRITE                     = $8298;
  GL_SRGB_DECODE_ARB                = $8299;
  GL_FILTER                         = $829A;
  GL_VERTEX_TEXTURE                 = $829B;
  GL_TESS_CONTROL_TEXTURE           = $829C;
  GL_TESS_EVALUATION_TEXTURE        = $829D;
  GL_GEOMETRY_TEXTURE               = $829E;
  GL_FRAGMENT_TEXTURE               = $829F;
  GL_COMPUTE_TEXTURE                = $82A0;
  GL_TEXTURE_SHADOW                 = $82A1;
  GL_TEXTURE_GATHER                 = $82A2;
  GL_TEXTURE_GATHER_SHADOW          = $82A3;
  GL_SHADER_IMAGE_LOAD              = $82A4;
  GL_SHADER_IMAGE_STORE             = $82A5;
  GL_SHADER_IMAGE_ATOMIC            = $82A6;
  GL_IMAGE_TEXEL_SIZE               = $82A7;
  GL_IMAGE_COMPATIBILITY_CLASS      = $82A8;
  GL_IMAGE_PIXEL_FORMAT             = $82A9;
  GL_IMAGE_PIXEL_TYPE               = $82AA;
  GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_TEST = $82AC;
  GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_TEST = $82AD;
  GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_WRITE = $82AE;
  GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_WRITE = $82AF;
  GL_TEXTURE_COMPRESSED_BLOCK_WIDTH = $82B1;
  GL_TEXTURE_COMPRESSED_BLOCK_HEIGHT = $82B2;
  GL_TEXTURE_COMPRESSED_BLOCK_SIZE  = $82B3;
  GL_CLEAR_BUFFER                   = $82B4;
  GL_TEXTURE_VIEW                   = $82B5;
  GL_VIEW_COMPATIBILITY_CLASS       = $82B6;
  GL_FULL_SUPPORT                   = $82B7;
  GL_CAVEAT_SUPPORT                 = $82B8;
  GL_IMAGE_CLASS_4_X_32             = $82B9;
  GL_IMAGE_CLASS_2_X_32             = $82BA;
  GL_IMAGE_CLASS_1_X_32             = $82BB;
  GL_IMAGE_CLASS_4_X_16             = $82BC;
  GL_IMAGE_CLASS_2_X_16             = $82BD;
  GL_IMAGE_CLASS_1_X_16             = $82BE;
  GL_IMAGE_CLASS_4_X_8              = $82BF;
  GL_IMAGE_CLASS_2_X_8              = $82C0;
  GL_IMAGE_CLASS_1_X_8              = $82C1;
  GL_IMAGE_CLASS_11_11_10           = $82C2;
  GL_IMAGE_CLASS_10_10_10_2         = $82C3;
  GL_VIEW_CLASS_128_BITS            = $82C4;
  GL_VIEW_CLASS_96_BITS             = $82C5;
  GL_VIEW_CLASS_64_BITS             = $82C6;
  GL_VIEW_CLASS_48_BITS             = $82C7;
  GL_VIEW_CLASS_32_BITS             = $82C8;
  GL_VIEW_CLASS_24_BITS             = $82C9;
  GL_VIEW_CLASS_16_BITS             = $82CA;
  GL_VIEW_CLASS_8_BITS              = $82CB;
  GL_VIEW_CLASS_S3TC_DXT1_RGB       = $82CC;
  GL_VIEW_CLASS_S3TC_DXT1_RGBA      = $82CD;
  GL_VIEW_CLASS_S3TC_DXT3_RGBA      = $82CE;
  GL_VIEW_CLASS_S3TC_DXT5_RGBA      = $82CF;
  GL_VIEW_CLASS_RGTC1_RED           = $82D0;
  GL_VIEW_CLASS_RGTC2_RG            = $82D1;
  GL_VIEW_CLASS_BPTC_UNORM          = $82D2;
  GL_VIEW_CLASS_BPTC_FLOAT          = $82D3;
  GL_UNIFORM                        = $92E1;
  GL_UNIFORM_BLOCK                  = $92E2;
  GL_PROGRAM_INPUT                  = $92E3;
  GL_PROGRAM_OUTPUT                 = $92E4;
  GL_BUFFER_VARIABLE                = $92E5;
  GL_SHADER_STORAGE_BLOCK           = $92E6;
  GL_VERTEX_SUBROUTINE              = $92E8;
  GL_TESS_CONTROL_SUBROUTINE        = $92E9;
  GL_TESS_EVALUATION_SUBROUTINE     = $92EA;
  GL_GEOMETRY_SUBROUTINE            = $92EB;
  GL_FRAGMENT_SUBROUTINE            = $92EC;
  GL_COMPUTE_SUBROUTINE             = $92ED;
  GL_VERTEX_SUBROUTINE_UNIFORM      = $92EE;
  GL_TESS_CONTROL_SUBROUTINE_UNIFORM = $92EF;
  GL_TESS_EVALUATION_SUBROUTINE_UNIFORM = $92F0;
  GL_GEOMETRY_SUBROUTINE_UNIFORM    = $92F1;
  GL_FRAGMENT_SUBROUTINE_UNIFORM    = $92F2;
  GL_COMPUTE_SUBROUTINE_UNIFORM     = $92F3;
  GL_TRANSFORM_FEEDBACK_VARYING     = $92F4;
  GL_ACTIVE_RESOURCES               = $92F5;
  GL_MAX_NAME_LENGTH                = $92F6;
  GL_MAX_NUM_ACTIVE_VARIABLES       = $92F7;
  GL_MAX_NUM_COMPATIBLE_SUBROUTINES = $92F8;
  GL_NAME_LENGTH                    = $92F9;
  GL_TYPE                           = $92FA;
  GL_ARRAY_SIZE                     = $92FB;
  GL_OFFSET                         = $92FC;
  GL_BLOCK_INDEX                    = $92FD;
  GL_ARRAY_STRIDE                   = $92FE;
  GL_MATRIX_STRIDE                  = $92FF;
  GL_IS_ROW_MAJOR                   = $9300;
  GL_ATOMIC_COUNTER_BUFFER_INDEX    = $9301;
  GL_BUFFER_BINDING                 = $9302;
  GL_BUFFER_DATA_SIZE               = $9303;
  GL_NUM_ACTIVE_VARIABLES           = $9304;
  GL_ACTIVE_VARIABLES               = $9305;
  GL_REFERENCED_BY_VERTEX_SHADER    = $9306;
  GL_REFERENCED_BY_TESS_CONTROL_SHADER = $9307;
  GL_REFERENCED_BY_TESS_EVALUATION_SHADER = $9308;
  GL_REFERENCED_BY_GEOMETRY_SHADER  = $9309;
  GL_REFERENCED_BY_FRAGMENT_SHADER  = $930A;
  GL_REFERENCED_BY_COMPUTE_SHADER   = $930B;
  GL_TOP_LEVEL_ARRAY_SIZE           = $930C;
  GL_TOP_LEVEL_ARRAY_STRIDE         = $930D;
  GL_LOCATION                       = $930E;
  GL_LOCATION_INDEX                 = $930F;
  GL_IS_PER_PATCH                   = $92E7;
  GL_SHADER_STORAGE_BUFFER          = $90D2;
  GL_SHADER_STORAGE_BUFFER_BINDING  = $90D3;
  GL_SHADER_STORAGE_BUFFER_START    = $90D4;
  GL_SHADER_STORAGE_BUFFER_SIZE     = $90D5;
  GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS = $90D6;
  GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS = $90D7;
  GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS = $90D8;
  GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS = $90D9;
  GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS = $90DA;
  GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS = $90DB;
  GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS = $90DC;
  GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS = $90DD;
  GL_MAX_SHADER_STORAGE_BLOCK_SIZE  = $90DE;
  GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT = $90DF;
  GL_SHADER_STORAGE_BARRIER_BIT     = $2000;
  GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES = GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS;
  GL_DEPTH_STENCIL_TEXTURE_MODE     = $90EA;

  GL_TEXTURE_BUFFER_OFFSET          = $919D;
  GL_TEXTURE_BUFFER_SIZE            = $919E;
  GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT = $919F;
  GL_TEXTURE_VIEW_MIN_LEVEL         = $82DB;
  GL_TEXTURE_VIEW_NUM_LEVELS        = $82DC;
  GL_TEXTURE_VIEW_MIN_LAYER         = $82DD;
  GL_TEXTURE_VIEW_NUM_LAYERS        = $82DE;
  GL_TEXTURE_IMMUTABLE_LEVELS       = $82DF;
  GL_VERTEX_ATTRIB_BINDING          = $82D4;
  GL_VERTEX_ATTRIB_RELATIVE_OFFSET  = $82D5;
  GL_VERTEX_BINDING_DIVISOR         = $82D6;
  GL_VERTEX_BINDING_OFFSET          = $82D7;
  GL_VERTEX_BINDING_STRIDE          = $82D8;
  GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET = $82D9;
  GL_MAX_VERTEX_ATTRIB_BINDINGS     = $82DA;

  // GL 4.4
  GL_MAX_VERTEX_ATTRIB_STRIDE         = $82E5;
  GL_MAP_PERSISTENT_BIT               = $0040;
  GL_MAP_COHERENT_BIT                 = $0080;
  GL_DYNAMIC_STORAGE_BIT              = $0100;
  GL_CLIENT_STORAGE_BIT               = $0200;
  GL_CLIENT_MAPPED_BUFFER_BARRIER_BIT = $00004000;
  GL_BUFFER_IMMUTABLE_STORAGE       	= $821F;
  GL_BUFFER_STORAGE_FLAGS           	= $8220;
  GL_CLEAR_TEXTURE                  	= $9365;
  GL_LOCATION_COMPONENT             	= $934A;
  GL_TRANSFORM_FEEDBACK_BUFFER_INDEX 	= $934B;
  GL_TRANSFORM_FEEDBACK_BUFFER_STRIDE = $934C;
  GL_QUERY_BUFFER                   	= $9192;
  GL_QUERY_BUFFER_BARRIER_BIT       	= $00008000;
  GL_QUERY_BUFFER_BINDING           	= $9193;
  GL_QUERY_RESULT_NO_WAIT           	= $9194;
  GL_MIRROR_CLAMP_TO_EDGE           	= $8743;
  // GL 4.5
  GL_CONTEXT_LOST                   = $0507;
  GL_NEGATIVE_ONE_TO_ONE            = $935E;
  GL_ZERO_TO_ONE                    = $935F;
  GL_CLIP_ORIGIN                    = $935C;
  GL_CLIP_DEPTH_MODE                = $935D;
  GL_QUERY_WAIT_INVERTED            = $8E17;
  GL_QUERY_NO_WAIT_INVERTED         = $8E18;
  GL_QUERY_BY_REGION_WAIT_INVERTED  = $8E19;
  GL_QUERY_BY_REGION_NO_WAIT_INVERTED = $8E1A;
  GL_MAX_CULL_DISTANCES             = $82F9;
  GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES = $82FA;
  GL_TEXTURE_TARGET                 = $1006;
  GL_QUERY_TARGET                   = $82EA;
  GL_TEXTURE_BINDING                = $82EB;
  GL_GUILTY_CONTEXT_RESET           = $8253;
  GL_INNOCENT_CONTEXT_RESET         = $8254;
  GL_UNKNOWN_CONTEXT_RESET          = $8255;
  GL_RESET_NOTIFICATION_STRATEGY    = $8256;
  GL_LOSE_CONTEXT_ON_RESET          = $8252;
  GL_NO_RESET_NOTIFICATION          = $8261;
  GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT = $00000004;
  GL_CONTEXT_RELEASE_BEHAVIOR       = $82FB;
  GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH = $82FC;
  // GL_ATI_draw_buffers
  GL_MAX_DRAW_BUFFERS_ATI = $8824;
  GL_DRAW_BUFFER0_ATI = $8825;
  GL_DRAW_BUFFER1_ATI = $8826;
  GL_DRAW_BUFFER2_ATI = $8827;
  GL_DRAW_BUFFER3_ATI = $8828;
  GL_DRAW_BUFFER4_ATI = $8829;
  GL_DRAW_BUFFER5_ATI = $882A;
  GL_DRAW_BUFFER6_ATI = $882B;
  GL_DRAW_BUFFER7_ATI = $882C;
  GL_DRAW_BUFFER8_ATI = $882D;
  GL_DRAW_BUFFER9_ATI = $882E;
  GL_DRAW_BUFFER10_ATI = $882F;
  GL_DRAW_BUFFER11_ATI = $8830;
  GL_DRAW_BUFFER12_ATI = $8831;
  GL_DRAW_BUFFER13_ATI = $8832;
  GL_DRAW_BUFFER14_ATI = $8833;
  GL_DRAW_BUFFER15_ATI = $8834;
  // GL_ATI_element_array
  GL_ELEMENT_ARRAY_ATI = $8768;
  GL_ELEMENT_ARRAY_TYPE_ATI = $8769;
  GL_ELEMENT_ARRAY_POINTER_ATI = $876A;
  // GL_ATI_envmap_bumpmap
  GL_BUMP_ROT_MATRIX_ATI = $8775;
  GL_BUMP_ROT_MATRIX_SIZE_ATI = $8776;
  GL_BUMP_NUM_TEX_UNITS_ATI = $8777;
  GL_BUMP_TEX_UNITS_ATI = $8778;
  GL_DUDV_ATI = $8779;
  GL_DU8DV8_ATI = $877A;
  GL_BUMP_ENVMAP_ATI = $877B;
  GL_BUMP_TARGET_ATI = $877C;
  // GL_ATI_fragment_shader
  GL_FRAGMENT_SHADER_ATI = $8920;
  GL_REG_0_ATI = $8921;
  GL_REG_1_ATI = $8922;
  GL_REG_2_ATI = $8923;
  GL_REG_3_ATI = $8924;
  GL_REG_4_ATI = $8925;
  GL_REG_5_ATI = $8926;
  GL_REG_6_ATI = $8927;
  GL_REG_7_ATI = $8928;
  GL_REG_8_ATI = $8929;
  GL_REG_9_ATI = $892A;
  GL_REG_10_ATI = $892B;
  GL_REG_11_ATI = $892C;
  GL_REG_12_ATI = $892D;
  GL_REG_13_ATI = $892E;
  GL_REG_14_ATI = $892F;
  GL_REG_15_ATI = $8930;
  GL_REG_16_ATI = $8931;
  GL_REG_17_ATI = $8932;
  GL_REG_18_ATI = $8933;
  GL_REG_19_ATI = $8934;
  GL_REG_20_ATI = $8935;
  GL_REG_21_ATI = $8936;
  GL_REG_22_ATI = $8937;
  GL_REG_23_ATI = $8938;
  GL_REG_24_ATI = $8939;
  GL_REG_25_ATI = $893A;
  GL_REG_26_ATI = $893B;
  GL_REG_27_ATI = $893C;
  GL_REG_28_ATI = $893D;
  GL_REG_29_ATI = $893E;
  GL_REG_30_ATI = $893F;
  GL_REG_31_ATI = $8940;
  GL_CON_0_ATI = $8941;
  GL_CON_1_ATI = $8942;
  GL_CON_2_ATI = $8943;
  GL_CON_3_ATI = $8944;
  GL_CON_4_ATI = $8945;
  GL_CON_5_ATI = $8946;
  GL_CON_6_ATI = $8947;
  GL_CON_7_ATI = $8948;
  GL_CON_8_ATI = $8949;
  GL_CON_9_ATI = $894A;
  GL_CON_10_ATI = $894B;
  GL_CON_11_ATI = $894C;
  GL_CON_12_ATI = $894D;
  GL_CON_13_ATI = $894E;
  GL_CON_14_ATI = $894F;
  GL_CON_15_ATI = $8950;
  GL_CON_16_ATI = $8951;
  GL_CON_17_ATI = $8952;
  GL_CON_18_ATI = $8953;
  GL_CON_19_ATI = $8954;
  GL_CON_20_ATI = $8955;
  GL_CON_21_ATI = $8956;
  GL_CON_22_ATI = $8957;
  GL_CON_23_ATI = $8958;
  GL_CON_24_ATI = $8959;
  GL_CON_25_ATI = $895A;
  GL_CON_26_ATI = $895B;
  GL_CON_27_ATI = $895C;
  GL_CON_28_ATI = $895D;
  GL_CON_29_ATI = $895E;
  GL_CON_30_ATI = $895F;
  GL_CON_31_ATI = $8960;
  GL_MOV_ATI = $8961;
  GL_ADD_ATI = $8963;
  GL_MUL_ATI = $8964;
  GL_SUB_ATI = $8965;
  GL_DOT3_ATI = $8966;
  GL_DOT4_ATI = $8967;
  GL_MAD_ATI = $8968;
  GL_LERP_ATI = $8969;
  GL_CND_ATI = $896A;
  GL_CND0_ATI = $896B;
  GL_DOT2_ADD_ATI = $896C;
  GL_SECONDARY_INTERPOLATOR_ATI = $896D;
  GL_NUM_FRAGMENT_REGISTERS_ATI = $896E;
  GL_NUM_FRAGMENT_CONSTANTS_ATI = $896F;
  GL_NUM_PASSES_ATI = $8970;
  GL_NUM_INSTRUCTIONS_PER_PASS_ATI = $8971;
  GL_NUM_INSTRUCTIONS_TOTAL_ATI = $8972;
  GL_NUM_INPUT_INTERPOLATOR_COMPONENTS_ATI = $8973;
  GL_NUM_LOOPBACK_COMPONENTS_ATI = $8974;
  GL_COLOR_ALPHA_PAIRING_ATI = $8975;
  GL_SWIZZLE_STR_ATI = $8976;
  GL_SWIZZLE_STQ_ATI = $8977;
  GL_SWIZZLE_STR_DR_ATI = $8978;
  GL_SWIZZLE_STQ_DQ_ATI = $8979;
  GL_SWIZZLE_STRQ_ATI = $897A;
  GL_SWIZZLE_STRQ_DQ_ATI = $897B;
  GL_RED_BIT_ATI = $00000001;
  GL_GREEN_BIT_ATI = $00000002;
  GL_BLUE_BIT_ATI = $00000004;
  GL_2X_BIT_ATI = $00000001;
  GL_4X_BIT_ATI = $00000002;
  GL_8X_BIT_ATI = $00000004;
  GL_HALF_BIT_ATI = $00000008;
  GL_QUARTER_BIT_ATI = $00000010;
  GL_EIGHTH_BIT_ATI = $00000020;
  GL_SATURATE_BIT_ATI = $00000040;
  GL_COMP_BIT_ATI = $00000002;
  GL_NEGATE_BIT_ATI = $00000004;
  GL_BIAS_BIT_ATI = $00000008;
  // GL_ATI_pn_triangles
  GL_PN_TRIANGLES_ATI = $87F0;
  GL_MAX_PN_TRIANGLES_TESSELATION_LEVEL_ATI = $87F1;
  GL_PN_TRIANGLES_POINT_MODE_ATI = $87F2;
  GL_PN_TRIANGLES_NORMAL_MODE_ATI = $87F3;
  GL_PN_TRIANGLES_TESSELATION_LEVEL_ATI = $87F4;
  GL_PN_TRIANGLES_POINT_MODE_LINEAR_ATI = $87F5;
  GL_PN_TRIANGLES_POINT_MODE_CUBIC_ATI = $87F6;
  GL_PN_TRIANGLES_NORMAL_MODE_LINEAR_ATI = $87F7;
  GL_PN_TRIANGLES_NORMAL_MODE_QUADRATIC_ATI = $87F8;
  // GL_ATI_separate_stencil
  GL_STENCIL_BACK_FUNC_ATI = $8800;
  GL_STENCIL_BACK_FAIL_ATI = $8801;
  GL_STENCIL_BACK_PASS_DEPTH_FAIL_ATI = $8802;
  GL_STENCIL_BACK_PASS_DEPTH_PASS_ATI = $8803;
  // GL_ATI_text_fragment_shader
  GL_TEXT_FRAGMENT_SHADER_ATI = $8200;
  // GL_ATI_texture_env_combine3
  GL_MODULATE_ADD_ATI = $8744;
  GL_MODULATE_SIGNED_ADD_ATI = $8745;
  GL_MODULATE_SUBTRACT_ATI = $8746;
  // GL_ATI_texture_float
  GL_RGBA_FLOAT32_ATI = $8814;
  GL_RGB_FLOAT32_ATI = $8815;
  GL_ALPHA_FLOAT32_ATI = $8816;
  GL_INTENSITY_FLOAT32_ATI = $8817;
  GL_LUMINANCE_FLOAT32_ATI = $8818;
  GL_LUMINANCE_ALPHA_FLOAT32_ATI = $8819;
  GL_RGBA_FLOAT16_ATI = $881A;
  GL_RGB_FLOAT16_ATI = $881B;
  GL_ALPHA_FLOAT16_ATI = $881C;
  GL_INTENSITY_FLOAT16_ATI = $881D;
  GL_LUMINANCE_FLOAT16_ATI = $881E;
  GL_LUMINANCE_ALPHA_FLOAT16_ATI = $881F;
  // GL_ATI_texture_mirror_once
  GL_MIRROR_CLAMP_ATI = $8742;
  GL_MIRROR_CLAMP_TO_EDGE_ATI = $8743;
  // GL_ATI_vertex_array_object
  GL_STATIC_ATI = $8760;
  GL_DYNAMIC_ATI = $8761;
  GL_PRESERVE_ATI = $8762;
  GL_DISCARD_ATI = $8763;
  GL_OBJECT_BUFFER_SIZE_ATI = $8764;
  GL_OBJECT_BUFFER_USAGE_ATI = $8765;
  GL_ARRAY_OBJECT_BUFFER_ATI = $8766;
  GL_ARRAY_OBJECT_OFFSET_ATI = $8767;
  // GL_ATI_vertex_streams
  GL_MAX_VERTEX_STREAMS_ATI = $876B;
  GL_VERTEX_STREAM0_ATI = $876C;
  GL_VERTEX_STREAM1_ATI = $876D;
  GL_VERTEX_STREAM2_ATI = $876E;
  GL_VERTEX_STREAM3_ATI = $876F;
  GL_VERTEX_STREAM4_ATI = $8770;
  GL_VERTEX_STREAM5_ATI = $8771;
  GL_VERTEX_STREAM6_ATI = $8772;
  GL_VERTEX_STREAM7_ATI = $8773;
  GL_VERTEX_SOURCE_ATI = $8774;
  // GL_ATI_meminfo
  GL_VBO_FREE_MEMORY_ATI = $87FB;
  GL_TEXTURE_FREE_MEMORY_ATI = $87FC;
  GL_RENDERBUFFER_FREE_MEMORY_ATI = $87FD;
  // GL_AMD_performance_monitor
  GL_COUNTER_TYPE_AMD = $8BC0;
  GL_COUNTER_RANGE_AMD = $8BC1;
  GL_UNSIGNED_INT64_AMD = $8BC2;
  GL_PERCENTAGE_AMD = $8BC3;
  GL_PERFMON_RESULT_AVAILABLE_AMD = $8BC4;
  GL_PERFMON_RESULT_SIZE_AMD = $8BC5;
  GL_PERFMON_RESULT_AMD = $8BC6;
  // GL_AMD_vertex_shader_tesselator
  GL_SAMPLER_BUFFER_AMD = $9001;
  GL_INT_SAMPLER_BUFFER_AMD = $9002;
  GL_UNSIGNED_INT_SAMPLER_BUFFER_AMD = $9003;
  GL_TESSELLATION_MODE_AMD = $9004;
  GL_TESSELLATION_FACTOR_AMD = $9005;
  GL_DISCRETE_AMD = $9006;
  GL_CONTINUOUS_AMD = $9007;
  // GL_AMD_name_gen_delete
  GL_DATA_BUFFER_AMD = $9151;
  GL_PERFORMANCE_MONITOR_AMD = $9152;
  GL_QUERY_OBJECT_AMD = $9153;
  GL_VERTEX_ARRAY_OBJECT_AMD = $9154;
  GL_SAMPLER_OBJECT_AMD = $9155;
  // GL_AMD_debug_output
  GL_MAX_DEBUG_LOGGED_MESSAGES_AMD = $9144;
  GL_DEBUG_LOGGED_MESSAGES_AMD = $9145;
  GL_DEBUG_SEVERITY_HIGH_AMD = $9146;
  GL_DEBUG_SEVERITY_MEDIUM_AMD = $9147;
  GL_DEBUG_SEVERITY_LOW_AMD = $9148;
  GL_DEBUG_CATEGORY_API_ERROR_AMD = $9149;
  GL_DEBUG_CATEGORY_WINDOW_SYSTEM_AMD = $914A;
  GL_DEBUG_CATEGORY_DEPRECATION_AMD = $914B;
  GL_DEBUG_CATEGORY_UNDEFINED_BEHAVIOR_AMD = $914C;
  GL_DEBUG_CATEGORY_PERFORMANCE_AMD = $914D;
  GL_DEBUG_CATEGORY_SHADER_COMPILER_AMD = $914E;
  GL_DEBUG_CATEGORY_APPLICATION_AMD = $914F;
  GL_DEBUG_CATEGORY_OTHER_AMD = $9150;
  // GL_AMD_depth_clamp_separate
  GL_DEPTH_CLAMP_NEAR_AMD = $901E;
  GL_DEPTH_CLAMP_FAR_AMD = $901F;
  // GL_EXT_422_pixels
  GL_422_EXT = $80CC;
  GL_422_REV_EXT = $80CD;
  GL_422_AVERAGE_EXT = $80CE;
  GL_422_REV_AVERAGE_EXT = $80CF;
  // GL_EXT_abgr
  GL_ABGR_EXT = $8000;
  // GL_EXT_bgra
  GL_BGR_EXT = $80E0;
  GL_BGRA_EXT = $80E1;
  // GL_EXT_blend_color
  GL_CONSTANT_COLOR_EXT = $8001;
  GL_ONE_MINUS_CONSTANT_COLOR_EXT = $8002;
  GL_CONSTANT_ALPHA_EXT = $8003;
  GL_ONE_MINUS_CONSTANT_ALPHA_EXT = $8004;
  GL_BLEND_COLOR_EXT = $8005;
  // GL_EXT_blend_func_separate
  GL_BLEND_DST_RGB_EXT = $80C8;
  GL_BLEND_SRC_RGB_EXT = $80C9;
  GL_BLEND_DST_ALPHA_EXT = $80CA;
  GL_BLEND_SRC_ALPHA_EXT = $80CB;
  // GL_EXT_blend_minmax
  GL_FUNC_ADD_EXT = $8006;
  GL_MIN_EXT = $8007;
  GL_MAX_EXT = $8008;
  GL_BLEND_EQUATION_EXT = $8009;
  // GL_EXT_blend_subtract
  GL_FUNC_SUBTRACT_EXT = $800A;
  GL_FUNC_REVERSE_SUBTRACT_EXT = $800B;
  // GL_EXT_clip_volume_hint
  GL_CLIP_VOLUME_CLIPPING_HINT_EXT = $80F0;
  // GL_EXT_cmyka
  GL_CMYK_EXT = $800C;
  GL_CMYKA_EXT = $800D;
  GL_PACK_CMYK_HINT_EXT = $800E;
  GL_UNPACK_CMYK_HINT_EXT = $800F;
  // GL_EXT_compiled_vertex_array
  GL_ARRAY_ELEMENT_LOCK_FIRST_EXT = $81A8;
  GL_ARRAY_ELEMENT_LOCK_COUNT_EXT = $81A9;
  // GL_EXT_convolution
  GL_CONVOLUTION_1D_EXT = $8010;
  GL_CONVOLUTION_2D_EXT = $8011;
  GL_SEPARABLE_2D_EXT = $8012;
  GL_CONVOLUTION_BORDER_MODE_EXT = $8013;
  GL_CONVOLUTION_FILTER_SCALE_EXT = $8014;
  GL_CONVOLUTION_FILTER_BIAS_EXT = $8015;
  GL_REDUCE_EXT = $8016;
  GL_CONVOLUTION_FORMAT_EXT = $8017;
  GL_CONVOLUTION_WIDTH_EXT = $8018;
  GL_CONVOLUTION_HEIGHT_EXT = $8019;
  GL_MAX_CONVOLUTION_WIDTH_EXT = $801A;
  GL_MAX_CONVOLUTION_HEIGHT_EXT = $801B;
  GL_POST_CONVOLUTION_RED_SCALE_EXT = $801C;
  GL_POST_CONVOLUTION_GREEN_SCALE_EXT = $801D;
  GL_POST_CONVOLUTION_BLUE_SCALE_EXT = $801E;
  GL_POST_CONVOLUTION_ALPHA_SCALE_EXT = $801F;
  GL_POST_CONVOLUTION_RED_BIAS_EXT = $8020;
  GL_POST_CONVOLUTION_GREEN_BIAS_EXT = $8021;
  GL_POST_CONVOLUTION_BLUE_BIAS_EXT = $8022;
  GL_POST_CONVOLUTION_ALPHA_BIAS_EXT = $8023;
  // GL_EXT_coordinate_frame
  GL_TANGENT_ARRAY_EXT = $8439;
  GL_BINORMAL_ARRAY_EXT = $843A;
  GL_CURRENT_TANGENT_EXT = $843B;
  GL_CURRENT_BINORMAL_EXT = $843C;
  GL_TANGENT_ARRAY_TYPE_EXT = $843E;
  GL_TANGENT_ARRAY_STRIDE_EXT = $843F;
  GL_BINORMAL_ARRAY_TYPE_EXT = $8440;
  GL_BINORMAL_ARRAY_STRIDE_EXT = $8441;
  GL_TANGENT_ARRAY_POINTER_EXT = $8442;
  GL_BINORMAL_ARRAY_POINTER_EXT = $8443;
  GL_MAP1_TANGENT_EXT = $8444;
  GL_MAP2_TANGENT_EXT = $8445;
  GL_MAP1_BINORMAL_EXT = $8446;
  GL_MAP2_BINORMAL_EXT = $8447;
  // GL_EXT_cull_vertex
  GL_CULL_VERTEX_EXT = $81AA;
  GL_CULL_VERTEX_EYE_POSITION_EXT = $81AB;
  GL_CULL_VERTEX_OBJECT_POSITION_EXT = $81AC;
  // GL_EXT_draw_range_elements
  GL_MAX_ELEMENTS_VERTICES_EXT = $80E8;
  GL_MAX_ELEMENTS_INDICES_EXT = $80E9;
  // GL_EXT_fog_coord
  GL_FOG_COORDINATE_SOURCE_EXT = $8450;
  GL_FOG_COORDINATE_EXT = $8451;
  GL_FRAGMENT_DEPTH_EXT = $8452;
  GL_CURRENT_FOG_COORDINATE_EXT = $8453;
  GL_FOG_COORDINATE_ARRAY_TYPE_EXT = $8454;
  GL_FOG_COORDINATE_ARRAY_STRIDE_EXT = $8455;
  GL_FOG_COORDINATE_ARRAY_POINTER_EXT = $8456;
  GL_FOG_COORDINATE_ARRAY_EXT = $8457;
  // GL_EXT_framebuffer_object
  GL_FRAMEBUFFER_EXT = $8D40;
  GL_RENDERBUFFER_EXT = $8D41;
  GL_STENCIL_INDEX_EXT = $8D45;
  GL_STENCIL_INDEX1_EXT = $8D46;
  GL_STENCIL_INDEX4_EXT = $8D47;
  GL_STENCIL_INDEX8_EXT = $8D48;
  GL_STENCIL_INDEX16_EXT = $8D49;
  GL_RENDERBUFFER_WIDTH_EXT = $8D42;
  GL_RENDERBUFFER_HEIGHT_EXT = $8D43;
  GL_RENDERBUFFER_INTERNAL_FORMAT_EXT = $8D44;
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE_EXT = $8CD0;
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME_EXT = $8CD1;
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL_EXT = $8CD2;
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE_EXT = $8CD3;
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_3D_ZOFFSET_EXT = $8CD4;
  GL_COLOR_ATTACHMENT0_EXT = $8CE0;
  GL_COLOR_ATTACHMENT1_EXT = $8CE1;
  GL_COLOR_ATTACHMENT2_EXT = $8CE2;
  GL_COLOR_ATTACHMENT3_EXT = $8CE3;
  GL_COLOR_ATTACHMENT4_EXT = $8CE4;
  GL_COLOR_ATTACHMENT5_EXT = $8CE5;
  GL_COLOR_ATTACHMENT6_EXT = $8CE6;
  GL_COLOR_ATTACHMENT7_EXT = $8CE7;
  GL_COLOR_ATTACHMENT8_EXT = $8CE8;
  GL_COLOR_ATTACHMENT9_EXT = $8CE9;
  GL_COLOR_ATTACHMENT10_EXT = $8CEA;
  GL_COLOR_ATTACHMENT11_EXT = $8CEB;
  GL_COLOR_ATTACHMENT12_EXT = $8CEC;
  GL_COLOR_ATTACHMENT13_EXT = $8CED;
  GL_COLOR_ATTACHMENT14_EXT = $8CEE;
  GL_COLOR_ATTACHMENT15_EXT = $8CEF;
  GL_DEPTH_ATTACHMENT_EXT = $8D00;
  GL_STENCIL_ATTACHMENT_EXT = $8D20;
  GL_FRAMEBUFFER_COMPLETE_EXT = $8CD5;
  GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT_EXT = $8CD6;
  GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT_EXT = $8CD7;
  GL_FRAMEBUFFER_INCOMPLETE_DUPLICATE_ATTACHMENT_EXT = $8CD8;
  GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS_EXT = $8CD9;
  GL_FRAMEBUFFER_INCOMPLETE_FORMATS_EXT = $8CDA;
  GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER_EXT = $8CDB;
  GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER_EXT = $8CDC;
  GL_FRAMEBUFFER_UNSUPPORTED_EXT = $8CDD;
  GL_FRAMEBUFFER_STATUS_ERROR_EXT = $8CDE;
  GL_FRAMEBUFFER_BINDING_EXT = $8CA6;
  GL_RENDERBUFFER_BINDING_EXT = $8CA7;
  GL_MAX_COLOR_ATTACHMENTS_EXT = $8CDF;
  GL_MAX_RENDERBUFFER_SIZE_EXT = $84E8;
  GL_INVALID_FRAMEBUFFER_OPERATION_EXT = $0506;
  // GL_EXT_histogram
  GL_HISTOGRAM_EXT = $8024;
  GL_PROXY_HISTOGRAM_EXT = $8025;
  GL_HISTOGRAM_WIDTH_EXT = $8026;
  GL_HISTOGRAM_FORMAT_EXT = $8027;
  GL_HISTOGRAM_RED_SIZE_EXT = $8028;
  GL_HISTOGRAM_GREEN_SIZE_EXT = $8029;
  GL_HISTOGRAM_BLUE_SIZE_EXT = $802A;
  GL_HISTOGRAM_ALPHA_SIZE_EXT = $802B;
  GL_HISTOGRAM_LUMINANCE_SIZE_EXT = $802C;
  GL_HISTOGRAM_SINK_EXT = $802D;
  GL_MINMAX_EXT = $802E;
  GL_MINMAX_FORMAT_EXT = $802F;
  GL_MINMAX_SINK_EXT = $8030;
  GL_TABLE_TOO_LARGE_EXT = $8031;
  // GL_EXT_index_array_formats
  GL_IUI_V2F_EXT = $81AD;
  GL_IUI_V3F_EXT = $81AE;
  GL_IUI_N3F_V2F_EXT = $81AF;
  GL_IUI_N3F_V3F_EXT = $81B0;
  GL_T2F_IUI_V2F_EXT = $81B1;
  GL_T2F_IUI_V3F_EXT = $81B2;
  GL_T2F_IUI_N3F_V2F_EXT = $81B3;
  GL_T2F_IUI_N3F_V3F_EXT = $81B4;
  // GL_EXT_index_func
  GL_INDEX_TEST_EXT = $81B5;
  GL_INDEX_TEST_FUNC_EXT = $81B6;
  GL_INDEX_TEST_REF_EXT = $81B7;
  // GL_EXT_index_material
  GL_INDEX_MATERIAL_EXT = $81B8;
  GL_INDEX_MATERIAL_PARAMETER_EXT = $81B9;
  GL_INDEX_MATERIAL_FACE_EXT = $81BA;
  // GL_EXT_light_texture
  GL_FRAGMENT_MATERIAL_EXT = $8349;
  GL_FRAGMENT_NORMAL_EXT = $834A;
  GL_FRAGMENT_COLOR_EXT = $834C;
  GL_ATTENUATION_EXT = $834D;
  GL_SHADOW_ATTENUATION_EXT = $834E;
  GL_TEXTURE_APPLICATION_MODE_EXT = $834F;
  GL_TEXTURE_LIGHT_EXT = $8350;
  GL_TEXTURE_MATERIAL_FACE_EXT = $8351;
  GL_TEXTURE_MATERIAL_PARAMETER_EXT = $8352;
  // GL_EXT_multisample
  GL_MULTISAMPLE_EXT = $809D;
  GL_SAMPLE_ALPHA_TO_MASK_EXT = $809E;
  GL_SAMPLE_ALPHA_TO_ONE_EXT = $809F;
  GL_SAMPLE_MASK_EXT = $80A0;
  GL_1PASS_EXT = $80A1;
  GL_2PASS_0_EXT = $80A2;
  GL_2PASS_1_EXT = $80A3;
  GL_4PASS_0_EXT = $80A4;
  GL_4PASS_1_EXT = $80A5;
  GL_4PASS_2_EXT = $80A6;
  GL_4PASS_3_EXT = $80A7;
  GL_SAMPLE_BUFFERS_EXT = $80A8;
  GL_SAMPLES_EXT = $80A9;
  GL_SAMPLE_MASK_VALUE_EXT = $80AA;
  GL_SAMPLE_MASK_INVERT_EXT = $80AB;
  GL_SAMPLE_PATTERN_EXT = $80AC;
  GL_MULTISAMPLE_BIT_EXT = $20000000;
  // GL_EXT_packed_pixels
  GL_UNSIGNED_BYTE_3_3_2_EXT = $8032;
  GL_UNSIGNED_SHORT_4_4_4_4_EXT = $8033;
  GL_UNSIGNED_SHORT_5_5_5_1_EXT = $8034;
  GL_UNSIGNED_INT_8_8_8_8_EXT = $8035;
  GL_UNSIGNED_INT_10_10_10_2_EXT = $8036;
  // GL_EXT_paletted_texture
  GL_COLOR_INDEX1_EXT = $80E2;
  GL_COLOR_INDEX2_EXT = $80E3;
  GL_COLOR_INDEX4_EXT = $80E4;
  GL_COLOR_INDEX8_EXT = $80E5;
  GL_COLOR_INDEX12_EXT = $80E6;
  GL_COLOR_INDEX16_EXT = $80E7;
  GL_TEXTURE_INDEX_SIZE_EXT = $80ED;
  // GL_EXT_pixel_transform
  GL_PIXEL_TRANSFORM_2D_EXT = $8330;
  GL_PIXEL_MAG_FILTER_EXT = $8331;
  GL_PIXEL_MIN_FILTER_EXT = $8332;
  GL_PIXEL_CUBIC_WEIGHT_EXT = $8333;
  GL_CUBIC_EXT = $8334;
  GL_AVERAGE_EXT = $8335;
  GL_PIXEL_TRANSFORM_2D_STACK_DEPTH_EXT = $8336;
  GL_MAX_PIXEL_TRANSFORM_2D_STACK_DEPTH_EXT = $8337;
  GL_PIXEL_TRANSFORM_2D_MATRIX_EXT = $8338;
  // GL_EXT_point_parameters
  GL_POINT_SIZE_MIN_EXT = $8126;
  GL_POINT_SIZE_MAX_EXT = $8127;
  GL_POINT_FADE_THRESHOLD_SIZE_EXT = $8128;
  GL_DISTANCE_ATTENUATION_EXT = $8129;
  // GL_EXT_polygon_offset
  GL_POLYGON_OFFSET_EXT = $8037;
  GL_POLYGON_OFFSET_FACTOR_EXT = $8038;
  GL_POLYGON_OFFSET_BIAS_EXT = $8039;
  // GL_EXT_rescale_normal
  GL_RESCALE_NORMAL_EXT = $803A;
  // GL_EXT_secondary_color
  GL_COLOR_SUM_EXT = $8458;
  GL_CURRENT_SECONDARY_COLOR_EXT = $8459;
  GL_SECONDARY_COLOR_ARRAY_SIZE_EXT = $845A;
  GL_SECONDARY_COLOR_ARRAY_TYPE_EXT = $845B;
  GL_SECONDARY_COLOR_ARRAY_STRIDE_EXT = $845C;
  GL_SECONDARY_COLOR_ARRAY_POINTER_EXT = $845D;
  GL_SECONDARY_COLOR_ARRAY_EXT = $845E;
  // GL_EXT_separate_specular_color
  GL_LIGHT_MODEL_COLOR_CONTROL_EXT = $81F8;
  GL_SINGLE_COLOR_EXT = $81F9;
  GL_SEPARATE_SPECULAR_COLOR_EXT = $81FA;
  // GL_EXT_shared_texture_palette
  GL_SHARED_TEXTURE_PALETTE_EXT = $81FB;
  // GL_EXT_stencil_two_side
  GL_STENCIL_TEST_TWO_SIDE_EXT = $8910;
  GL_ACTIVE_STENCIL_FACE_EXT = $8911;
  // GL_EXT_stencil_wrap
  GL_INCR_WRAP_EXT = $8507;
  GL_DECR_WRAP_EXT = $8508;
  // GL_EXT_texture
  GL_ALPHA4_EXT = $803B;
  GL_ALPHA8_EXT = $803C;
  GL_ALPHA12_EXT = $803D;
  GL_ALPHA16_EXT = $803E;
  GL_LUMINANCE4_EXT = $803F;
  GL_LUMINANCE8_EXT = $8040;
  GL_LUMINANCE12_EXT = $8041;
  GL_LUMINANCE16_EXT = $8042;
  GL_LUMINANCE4_ALPHA4_EXT = $8043;
  GL_LUMINANCE6_ALPHA2_EXT = $8044;
  GL_LUMINANCE8_ALPHA8_EXT = $8045;
  GL_LUMINANCE12_ALPHA4_EXT = $8046;
  GL_LUMINANCE12_ALPHA12_EXT = $8047;
  GL_LUMINANCE16_ALPHA16_EXT = $8048;
  GL_INTENSITY_EXT = $8049;
  GL_INTENSITY4_EXT = $804A;
  GL_INTENSITY8_EXT = $804B;
  GL_INTENSITY12_EXT = $804C;
  GL_INTENSITY16_EXT = $804D;
  GL_RGB2_EXT = $804E;
  GL_RGB4_EXT = $804F;
  GL_RGB5_EXT = $8050;
  GL_RGB8_EXT = $8051;
  GL_RGB10_EXT = $8052;
  GL_RGB12_EXT = $8053;
  GL_RGB16_EXT = $8054;
  GL_RGBA2_EXT = $8055;
  GL_RGBA4_EXT = $8056;
  GL_RGB5_A1_EXT = $8057;
  GL_RGBA8_EXT = $8058;
  GL_RGB10_A2_EXT = $8059;
  GL_RGBA12_EXT = $805A;
  GL_RGBA16_EXT = $805B;
  GL_TEXTURE_RED_SIZE_EXT = $805C;
  GL_TEXTURE_GREEN_SIZE_EXT = $805D;
  GL_TEXTURE_BLUE_SIZE_EXT = $805E;
  GL_TEXTURE_ALPHA_SIZE_EXT = $805F;
  GL_TEXTURE_LUMINANCE_SIZE_EXT = $8060;
  GL_TEXTURE_INTENSITY_SIZE_EXT = $8061;
  GL_REPLACE_EXT = $8062;
  GL_PROXY_TEXTURE_1D_EXT = $8063;
  GL_PROXY_TEXTURE_2D_EXT = $8064;
  GL_TEXTURE_TOO_LARGE_EXT = $8065;
  // GL_EXT_texture3D
  GL_PACK_SKIP_IMAGES_EXT = $806B;
  GL_PACK_IMAGE_HEIGHT_EXT = $806C;
  GL_UNPACK_SKIP_IMAGES_EXT = $806D;
  GL_UNPACK_IMAGE_HEIGHT_EXT = $806E;
  GL_TEXTURE_3D_EXT = $806F;
  GL_PROXY_TEXTURE_3D_EXT = $8070;
  GL_TEXTURE_DEPTH_EXT = $8071;
  GL_TEXTURE_WRAP_R_EXT = $8072;
  GL_MAX_3D_TEXTURE_SIZE_EXT = $8073;
  // GL_EXT_texture_compression_s3tc
  GL_COMPRESSED_RGB_S3TC_DXT1_EXT = $83F0;
  GL_COMPRESSED_RGBA_S3TC_DXT1_EXT = $83F1;
  GL_COMPRESSED_RGBA_S3TC_DXT3_EXT = $83F2;
  GL_COMPRESSED_RGBA_S3TC_DXT5_EXT = $83F3;
  // GL_EXT_texture_cube_map
  GL_NORMAL_MAP_EXT = $8511;
  GL_REFLECTION_MAP_EXT = $8512;
  GL_TEXTURE_CUBE_MAP_EXT = $8513;
  GL_TEXTURE_BINDING_CUBE_MAP_EXT = $8514;
  GL_TEXTURE_CUBE_MAP_POSITIVE_X_EXT = $8515;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_X_EXT = $8516;
  GL_TEXTURE_CUBE_MAP_POSITIVE_Y_EXT = $8517;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_EXT = $8518;
  GL_TEXTURE_CUBE_MAP_POSITIVE_Z_EXT = $8519;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_EXT = $851A;
  GL_PROXY_TEXTURE_CUBE_MAP_EXT = $851B;
  GL_MAX_CUBE_MAP_TEXTURE_SIZE_EXT = $851C;
  // GL_EXT_texture_edge_clamp
  GL_CLAMP_TO_EDGE_EXT = $812F;
  // GL_EXT_texture_env_combine
  GL_COMBINE_EXT = $8570;
  GL_COMBINE_RGB_EXT = $8571;
  GL_COMBINE_ALPHA_EXT = $8572;
  GL_RGB_SCALE_EXT = $8573;
  GL_ADD_SIGNED_EXT = $8574;
  GL_INTERPOLATE_EXT = $8575;
  GL_CONSTANT_EXT = $8576;
  GL_PRIMARY_COLOR_EXT = $8577;
  GL_PREVIOUS_EXT = $8578;
  GL_SOURCE0_RGB_EXT = $8580;
  GL_SOURCE1_RGB_EXT = $8581;
  GL_SOURCE2_RGB_EXT = $8582;
  GL_SOURCE0_ALPHA_EXT = $8588;
  GL_SOURCE1_ALPHA_EXT = $8589;
  GL_SOURCE2_ALPHA_EXT = $858A;
  GL_OPERAND0_RGB_EXT = $8590;
  GL_OPERAND1_RGB_EXT = $8591;
  GL_OPERAND2_RGB_EXT = $8592;
  GL_OPERAND0_ALPHA_EXT = $8598;
  GL_OPERAND1_ALPHA_EXT = $8599;
  GL_OPERAND2_ALPHA_EXT = $859A;
  // GL_EXT_texture_env_dot3
  GL_DOT3_RGB_EXT = $8740;
  GL_DOT3_RGBA_EXT = $8741;
  // GL_EXT_texture_filter_anisotropic
  GL_TEXTURE_MAX_ANISOTROPY_EXT = $84FE;
  GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT = $84FF;
  // GL_EXT_texture_lod_bias
  GL_MAX_TEXTURE_LOD_BIAS_EXT = $84FD;
  GL_TEXTURE_FILTER_CONTROL_EXT = $8500;
  GL_TEXTURE_LOD_BIAS_EXT = $8501;
  // GL_EXT_texture_object
  GL_TEXTURE_PRIORITY_EXT = $8066;
  GL_TEXTURE_RESIDENT_EXT = $8067;
  GL_TEXTURE_1D_BINDING_EXT = $8068;
  GL_TEXTURE_2D_BINDING_EXT = $8069;
  GL_TEXTURE_3D_BINDING_EXT = $806A;
  // GL_EXT_texture_perturb_normal
  GL_PERTURB_EXT = $85AE;
  GL_TEXTURE_NORMAL_EXT = $85AF;
  // GL_EXT_texture_rectangle
  GL_TEXTURE_RECTANGLE_EXT = $84F5;
  GL_TEXTURE_BINDING_RECTANGLE_EXT = $84F6;
  GL_PROXY_TEXTURE_RECTANGLE_EXT = $84F7;
  GL_MAX_RECTANGLE_TEXTURE_SIZE_EXT = $84F8;
  // GL_EXT_vertex_array
  GL_VERTEX_ARRAY_EXT = $8074;
  GL_NORMAL_ARRAY_EXT = $8075;
  GL_COLOR_ARRAY_EXT = $8076;
  GL_INDEX_ARRAY_EXT = $8077;
  GL_TEXTURE_COORD_ARRAY_EXT = $8078;
  GL_EDGE_FLAG_ARRAY_EXT = $8079;
  GL_VERTEX_ARRAY_SIZE_EXT = $807A;
  GL_VERTEX_ARRAY_TYPE_EXT = $807B;
  GL_VERTEX_ARRAY_STRIDE_EXT = $807C;
  GL_VERTEX_ARRAY_COUNT_EXT = $807D;
  GL_NORMAL_ARRAY_TYPE_EXT = $807E;
  GL_NORMAL_ARRAY_STRIDE_EXT = $807F;
  GL_NORMAL_ARRAY_COUNT_EXT = $8080;
  GL_COLOR_ARRAY_SIZE_EXT = $8081;
  GL_COLOR_ARRAY_TYPE_EXT = $8082;
  GL_COLOR_ARRAY_STRIDE_EXT = $8083;
  GL_COLOR_ARRAY_COUNT_EXT = $8084;
  GL_INDEX_ARRAY_TYPE_EXT = $8085;
  GL_INDEX_ARRAY_STRIDE_EXT = $8086;
  GL_INDEX_ARRAY_COUNT_EXT = $8087;
  GL_TEXTURE_COORD_ARRAY_SIZE_EXT = $8088;
  GL_TEXTURE_COORD_ARRAY_TYPE_EXT = $8089;
  GL_TEXTURE_COORD_ARRAY_STRIDE_EXT = $808A;
  GL_TEXTURE_COORD_ARRAY_COUNT_EXT = $808B;
  GL_EDGE_FLAG_ARRAY_STRIDE_EXT = $808C;
  GL_EDGE_FLAG_ARRAY_COUNT_EXT = $808D;
  GL_VERTEX_ARRAY_POINTER_EXT = $808E;
  GL_NORMAL_ARRAY_POINTER_EXT = $808F;
  GL_COLOR_ARRAY_POINTER_EXT = $8090;
  GL_INDEX_ARRAY_POINTER_EXT = $8091;
  GL_TEXTURE_COORD_ARRAY_POINTER_EXT = $8092;
  GL_EDGE_FLAG_ARRAY_POINTER_EXT = $8093;
  // GL_EXT_vertex_shader
  GL_VERTEX_SHADER_EXT = $8780;
  GL_VERTEX_SHADER_BINDING_EXT = $8781;
  GL_OP_INDEX_EXT = $8782;
  GL_OP_NEGATE_EXT = $8783;
  GL_OP_DOT3_EXT = $8784;
  GL_OP_DOT4_EXT = $8785;
  GL_OP_MUL_EXT = $8786;
  GL_OP_ADD_EXT = $8787;
  GL_OP_MADD_EXT = $8788;
  GL_OP_FRAC_EXT = $8789;
  GL_OP_MAX_EXT = $878A;
  GL_OP_MIN_EXT = $878B;
  GL_OP_SET_GE_EXT = $878C;
  GL_OP_SET_LT_EXT = $878D;
  GL_OP_CLAMP_EXT = $878E;
  GL_OP_FLOOR_EXT = $878F;
  GL_OP_ROUND_EXT = $8790;
  GL_OP_EXP_BASE_2_EXT = $8791;
  GL_OP_LOG_BASE_2_EXT = $8792;
  GL_OP_POWER_EXT = $8793;
  GL_OP_RECIP_EXT = $8794;
  GL_OP_RECIP_SQRT_EXT = $8795;
  GL_OP_SUB_EXT = $8796;
  GL_OP_CROSS_PRODUCT_EXT = $8797;
  GL_OP_MULTIPLY_MATRIX_EXT = $8798;
  GL_OP_MOV_EXT = $8799;
  GL_OUTPUT_VERTEX_EXT = $879A;
  GL_OUTPUT_COLOR0_EXT = $879B;
  GL_OUTPUT_COLOR1_EXT = $879C;
  GL_OUTPUT_TEXTURE_COORD0_EXT = $879D;
  GL_OUTPUT_TEXTURE_COORD1_EXT = $879E;
  GL_OUTPUT_TEXTURE_COORD2_EXT = $879F;
  GL_OUTPUT_TEXTURE_COORD3_EXT = $87A0;
  GL_OUTPUT_TEXTURE_COORD4_EXT = $87A1;
  GL_OUTPUT_TEXTURE_COORD5_EXT = $87A2;
  GL_OUTPUT_TEXTURE_COORD6_EXT = $87A3;
  GL_OUTPUT_TEXTURE_COORD7_EXT = $87A4;
  GL_OUTPUT_TEXTURE_COORD8_EXT = $87A5;
  GL_OUTPUT_TEXTURE_COORD9_EXT = $87A6;
  GL_OUTPUT_TEXTURE_COORD10_EXT = $87A7;
  GL_OUTPUT_TEXTURE_COORD11_EXT = $87A8;
  GL_OUTPUT_TEXTURE_COORD12_EXT = $87A9;
  GL_OUTPUT_TEXTURE_COORD13_EXT = $87AA;
  GL_OUTPUT_TEXTURE_COORD14_EXT = $87AB;
  GL_OUTPUT_TEXTURE_COORD15_EXT = $87AC;
  GL_OUTPUT_TEXTURE_COORD16_EXT = $87AD;
  GL_OUTPUT_TEXTURE_COORD17_EXT = $87AE;
  GL_OUTPUT_TEXTURE_COORD18_EXT = $87AF;
  GL_OUTPUT_TEXTURE_COORD19_EXT = $87B0;
  GL_OUTPUT_TEXTURE_COORD20_EXT = $87B1;
  GL_OUTPUT_TEXTURE_COORD21_EXT = $87B2;
  GL_OUTPUT_TEXTURE_COORD22_EXT = $87B3;
  GL_OUTPUT_TEXTURE_COORD23_EXT = $87B4;
  GL_OUTPUT_TEXTURE_COORD24_EXT = $87B5;
  GL_OUTPUT_TEXTURE_COORD25_EXT = $87B6;
  GL_OUTPUT_TEXTURE_COORD26_EXT = $87B7;
  GL_OUTPUT_TEXTURE_COORD27_EXT = $87B8;
  GL_OUTPUT_TEXTURE_COORD28_EXT = $87B9;
  GL_OUTPUT_TEXTURE_COORD29_EXT = $87BA;
  GL_OUTPUT_TEXTURE_COORD30_EXT = $87BB;
  GL_OUTPUT_TEXTURE_COORD31_EXT = $87BC;
  GL_OUTPUT_FOG_EXT = $87BD;
  GL_SCALAR_EXT = $87BE;
  GL_VECTOR_EXT = $87BF;
  GL_MATRIX_EXT = $87C0;
  GL_VARIANT_EXT = $87C1;
  GL_INVARIANT_EXT = $87C2;
  GL_LOCAL_CONSTANT_EXT = $87C3;
  GL_LOCAL_EXT = $87C4;
  GL_MAX_VERTEX_SHADER_INSTRUCTIONS_EXT = $87C5;
  GL_MAX_VERTEX_SHADER_VARIANTS_EXT = $87C6;
  GL_MAX_VERTEX_SHADER_INVARIANTS_EXT = $87C7;
  GL_MAX_VERTEX_SHADER_LOCAL_CONSTANTS_EXT = $87C8;
  GL_MAX_VERTEX_SHADER_LOCALS_EXT = $87C9;
  GL_MAX_OPTIMIZED_VERTEX_SHADER_INSTRUCTIONS_EXT = $87CA;
  GL_MAX_OPTIMIZED_VERTEX_SHADER_VARIANTS_EXT = $87CB;
  GL_MAX_OPTIMIZED_VERTEX_SHADER_LOCAL_CONSTANTS_EXT = $87CC;
  GL_MAX_OPTIMIZED_VERTEX_SHADER_INVARIANTS_EXT = $87CD;
  GL_MAX_OPTIMIZED_VERTEX_SHADER_LOCALS_EXT = $87CE;
  GL_VERTEX_SHADER_INSTRUCTIONS_EXT = $87CF;
  GL_VERTEX_SHADER_VARIANTS_EXT = $87D0;
  GL_VERTEX_SHADER_INVARIANTS_EXT = $87D1;
  GL_VERTEX_SHADER_LOCAL_CONSTANTS_EXT = $87D2;
  GL_VERTEX_SHADER_LOCALS_EXT = $87D3;
  GL_VERTEX_SHADER_OPTIMIZED_EXT = $87D4;
  GL_X_EXT = $87D5;
  GL_Y_EXT = $87D6;
  GL_Z_EXT = $87D7;
  GL_W_EXT = $87D8;
  GL_NEGATIVE_X_EXT = $87D9;
  GL_NEGATIVE_Y_EXT = $87DA;
  GL_NEGATIVE_Z_EXT = $87DB;
  GL_NEGATIVE_W_EXT = $87DC;
  GL_ZERO_EXT = $87DD;
  GL_ONE_EXT = $87DE;
  GL_NEGATIVE_ONE_EXT = $87DF;
  GL_NORMALIZED_RANGE_EXT = $87E0;
  GL_FULL_RANGE_EXT = $87E1;
  GL_CURRENT_VERTEX_EXT = $87E2;
  GL_MVP_MATRIX_EXT = $87E3;
  GL_VARIANT_VALUE_EXT = $87E4;
  GL_VARIANT_DATATYPE_EXT = $87E5;
  GL_VARIANT_ARRAY_STRIDE_EXT = $87E6;
  GL_VARIANT_ARRAY_TYPE_EXT = $87E7;
  GL_VARIANT_ARRAY_EXT = $87E8;
  GL_VARIANT_ARRAY_POINTER_EXT = $87E9;
  GL_INVARIANT_VALUE_EXT = $87EA;
  GL_INVARIANT_DATATYPE_EXT = $87EB;
  GL_LOCAL_CONSTANT_VALUE_EXT = $87EC;
  GL_LOCAL_CONSTANT_DATATYPE_EXT = $87ED;
  // GL_EXT_vertex_weighting
  GL_MODELVIEW0_STACK_DEPTH_EXT = $0BA3;
  GL_MODELVIEW1_STACK_DEPTH_EXT = $8502;
  GL_MODELVIEW0_MATRIX_EXT = $0BA6;
  GL_MODELVIEW1_MATRIX_EXT = $8506;
  GL_VERTEX_WEIGHTING_EXT = $8509;
  GL_MODELVIEW0_EXT = $1700;
  GL_MODELVIEW1_EXT = $850A;
  GL_CURRENT_VERTEX_WEIGHT_EXT = $850B;
  GL_VERTEX_WEIGHT_ARRAY_EXT = $850C;
  GL_VERTEX_WEIGHT_ARRAY_SIZE_EXT = $850D;
  GL_VERTEX_WEIGHT_ARRAY_TYPE_EXT = $850E;
  GL_VERTEX_WEIGHT_ARRAY_STRIDE_EXT = $850F;
  GL_VERTEX_WEIGHT_ARRAY_POINTER_EXT = $8510;
  // GL_EXT_depth_bounds_test
  GL_DEPTH_BOUNDS_TEST_EXT = $8890;
  GL_DEPTH_BOUNDS_EXT = $8891;
  // GL_EXT_texture_mirror_clamp
  GL_MIRROR_CLAMP_EXT = $8742;
  GL_MIRROR_CLAMP_TO_EDGE_EXT = $8743;
  GL_MIRROR_CLAMP_TO_BORDER_EXT = $8912;
  // GL_EXT_blend_equation_separate
  GL_BLEND_EQUATION_RGB_EXT = $8009;
  GL_BLEND_EQUATION_ALPHA_EXT = $883D;
  // GL_EXT_pixel_buffer_object
  GL_PIXEL_PACK_BUFFER_EXT = $88EB;
  GL_PIXEL_UNPACK_BUFFER_EXT = $88EC;
  GL_PIXEL_PACK_BUFFER_BINDING_EXT = $88ED;
  GL_PIXEL_UNPACK_BUFFER_BINDING_EXT = $88EF;
  // GL_EXT_stencil_clear_tag
  GL_STENCIL_TAG_BITS_EXT = $88F2;
  GL_STENCIL_CLEAR_TAG_VALUE_EXT = $88F3;
  // GL_EXT_packed_depth_stencil
  GL_DEPTH_STENCIL_EXT = $84F9;
  GL_UNSIGNED_INT_24_8_EXT = $84FA;
  GL_DEPTH24_STENCIL8_EXT = $88F0;
  GL_TEXTURE_STENCIL_SIZE_EXT = $88F1;
  // GL_EXT_texture_sRGB
  GL_SRGB_EXT = $8C40;
  GL_SRGB8_EXT = $8C41;
  GL_SRGB_ALPHA_EXT = $8C42;
  GL_SRGB8_ALPHA8_EXT = $8C43;
  GL_SLUMINANCE_ALPHA_EXT = $8C44;
  GL_SLUMINANCE8_ALPHA8_EXT = $8C45;
  GL_SLUMINANCE_EXT = $8C46;
  GL_SLUMINANCE8_EXT = $8C47;
  GL_COMPRESSED_SRGB_EXT = $8C48;
  GL_COMPRESSED_SRGB_ALPHA_EXT = $8C49;
  GL_COMPRESSED_SLUMINANCE_EXT = $8C4A;
  GL_COMPRESSED_SLUMINANCE_ALPHA_EXT = $8C4B;
  GL_COMPRESSED_SRGB_S3TC_DXT1_EXT = $8C4C;
  GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT1_EXT = $8C4D;
  GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT3_EXT = $8C4E;
  GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT5_EXT = $8C4F;
  // GL_EXT_framebuffer_blit
  GL_READ_FRAMEBUFFER_EXT = $8CA8;
  GL_DRAW_FRAMEBUFFER_EXT = $8CA9;
  GL_READ_FRAMEBUFFER_BINDING_EXT = GL_FRAMEBUFFER_BINDING_EXT;
  GL_DRAW_FRAMEBUFFER_BINDING_EXT = $8CAA;
  // GL_EXT_framebuffer_multisample
  GL_RENDERBUFFER_SAMPLES_EXT = $8CAB;
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_EXT = $8D56;
  GL_MAX_SAMPLES_EXT = $8D57;
  // GL_EXT_timer_query
  GL_TIME_ELAPSED_EXT = $88BF;
  // GL_EXT_bindable_uniform
  GL_MAX_VERTEX_BINDABLE_UNIFORMS_EXT = $8DE2;
  GL_MAX_FRAGMENT_BINDABLE_UNIFORMS_EXT = $8DE3;
  GL_MAX_GEOMETRY_BINDABLE_UNIFORMS_EXT = $8DE4;
  GL_MAX_BINDABLE_UNIFORM_SIZE_EXT = $8DED;
  GL_UNIFORM_BUFFER_EXT = $8DEE;
  GL_UNIFORM_BUFFER_BINDING_EXT = $8DEF;
  // GL_EXT_framebuffer_sRGB
  GLX_FRAMEBUFFER_SRGB_CAPABLE_EXT = $20B2;
  WGL_FRAMEBUFFER_SRGB_CAPABLE_EXT = $20A9;
  GL_FRAMEBUFFER_SRGB_EXT = $8DB9;
  GL_FRAMEBUFFER_SRGB_CAPABLE_EXT = $8DBA;

  // GL_EXT_geometry_shader4
  GL_GEOMETRY_SHADER_EXT = $8DD9;
  GL_GEOMETRY_VERTICES_OUT_EXT = $8DDA;
  GL_GEOMETRY_INPUT_TYPE_EXT = $8DDB;
  GL_GEOMETRY_OUTPUT_TYPE_EXT = $8DDC;
  GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_EXT = $8C29;
  GL_MAX_GEOMETRY_VARYING_COMPONENTS_EXT = $8DDD;
  GL_MAX_VERTEX_VARYING_COMPONENTS_EXT = $8DDE;
  GL_MAX_VARYING_COMPONENTS_EXT = $8B4B;
  GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_EXT = $8DDF;
  GL_MAX_GEOMETRY_OUTPUT_VERTICES_EXT = $8DE0;
  GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_EXT = $8DE1;
  GL_LINES_ADJACENCY_EXT = $A;
  GL_LINE_STRIP_ADJACENCY_EXT = $B;
  GL_TRIANGLES_ADJACENCY_EXT = $C;
  GL_TRIANGLE_STRIP_ADJACENCY_EXT = $D;
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_EXT = $8DA8;
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_EXT = $8DA9;
  GL_FRAMEBUFFER_ATTACHMENT_LAYERED_EXT = $8DA7;
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER_EXT = $8CD4;
  GL_PROGRAM_POINT_SIZE_EXT = $8642;

  // GL_EXT_gpu_shader4
  GL_VERTEX_ATTRIB_ARRAY_INTEGER_EXT = $88FD;
  GL_SAMPLER_1D_ARRAY_EXT = $8DC0;
  GL_SAMPLER_2D_ARRAY_EXT = $8DC1;
  GL_SAMPLER_BUFFER_EXT = $8DC2;
  GL_SAMPLER_1D_ARRAY_SHADOW_EXT = $8DC3;
  GL_SAMPLER_2D_ARRAY_SHADOW_EXT = $8DC4;
  GL_SAMPLER_CUBE_SHADOW_EXT = $8DC5;
  GL_UNSIGNED_INT_VEC2_EXT = $8DC6;
  GL_UNSIGNED_INT_VEC3_EXT = $8DC7;
  GL_UNSIGNED_INT_VEC4_EXT = $8DC8;
  GL_INT_SAMPLER_1D_EXT = $8DC9;
  GL_INT_SAMPLER_2D_EXT = $8DCA;
  GL_INT_SAMPLER_3D_EXT = $8DCB;
  GL_INT_SAMPLER_CUBE_EXT = $8DCC;
  GL_INT_SAMPLER_2D_RECT_EXT = $8DCD;
  GL_INT_SAMPLER_1D_ARRAY_EXT = $8DCE;
  GL_INT_SAMPLER_2D_ARRAY_EXT = $8DCF;
  GL_INT_SAMPLER_BUFFER_EXT = $8DD0;
  GL_UNSIGNED_INT_SAMPLER_1D_EXT = $8DD1;
  GL_UNSIGNED_INT_SAMPLER_2D_EXT = $8DD2;
  GL_UNSIGNED_INT_SAMPLER_3D_EXT = $8DD3;
  GL_UNSIGNED_INT_SAMPLER_CUBE_EXT = $8DD4;
  GL_UNSIGNED_INT_SAMPLER_2D_RECT_EXT = $8DD5;
  GL_UNSIGNED_INT_SAMPLER_1D_ARRAY_EXT = $8DD6;
  GL_UNSIGNED_INT_SAMPLER_2D_ARRAY_EXT = $8DD7;
  GL_UNSIGNED_INT_SAMPLER_BUFFER_EXT = $8DD8;
  GL_MIN_PROGRAM_TEXEL_OFFSET_EXT = $8904;
  GL_MAX_PROGRAM_TEXEL_OFFSET_EXT = $8905;

  // GL_EXT_packed_float
  GL_R11F_G11F_B10F_EXT = $8C3A;
  GL_UNSIGNED_INT_10F_11F_11F_REV_EXT = $8C3B;
  RGBA_SIGNED_COMPONENTS_EXT = $8C3C;
  WGL_TYPE_RGBA_UNSIGNED_FLOAT_EXT = $20A8;
  GLX_RGBA_UNSIGNED_FLOAT_TYPE_EXT = $20B1;
  GLX_RGBA_UNSIGNED_FLOAT_BIT_EXT = $00000008;

  // GL_EXT_texture_array
  GL_TEXTURE_1D_ARRAY_EXT = $8C18;
  GL_TEXTURE_2D_ARRAY_EXT = $8C1A;
  GL_PROXY_TEXTURE_2D_ARRAY_EXT = $8C1B;
  GL_PROXY_TEXTURE_1D_ARRAY_EXT = $8C19;
  GL_TEXTURE_BINDING_1D_ARRAY_EXT = $8C1C;
  GL_TEXTURE_BINDING_2D_ARRAY_EXT = $8C1D;
  GL_MAX_ARRAY_TEXTURE_LAYERS_EXT = $88FF;
  GL_COMPARE_REF_DEPTH_TO_TEXTURE_EXT = $884E;

  // GL_EXT_texture_buffer_object
  GL_TEXTURE_BUFFER_EXT = $8C2A;
  GL_MAX_TEXTURE_BUFFER_SIZE_EXT = $8C2B;
  GL_TEXTURE_BINDING_BUFFER_EXT = $8C2C;
  GL_TEXTURE_BUFFER_DATA_STORE_BINDING_EXT = $8C2D;
  GL_TEXTURE_BUFFER_FORMAT_EXT = $8C2E;

  // GL_EXT_texture_compression_latc
  GL_COMPRESSED_LUMINANCE_LATC1_EXT = $8C70;
  GL_COMPRESSED_SIGNED_LUMINANCE_LATC1_EXT = $8C71;
  GL_COMPRESSED_LUMINANCE_ALPHA_LATC2_EXT = $8C72;
  GL_COMPRESSED_SIGNED_LUMINANCE_ALPHA_LATC2_EXT = $8C73;

  // GL_EXT_texture_compression_rgtc
  GL_COMPRESSED_RED_RGTC1_EXT = $8DBB;
  GL_COMPRESSED_SIGNED_RED_RGTC1_EXT = $8DBC;
  GL_COMPRESSED_RED_GREEN_RGTC2_EXT = $8DBD;
  GL_COMPRESSED_SIGNED_RED_GREEN_RGTC2_EXT = $8DBE;

  // GL_EXT_texture_integer
  GL_RGBA_INTEGER_MODE_EXT = $8D9E;
  GL_RGBA32UI_EXT = $8D70;
  GL_RGB32UI_EXT = $8D71;
  GL_ALPHA32UI_EXT = $8D72;
  GL_INTENSITY32UI_EXT = $8D73;
  GL_LUMINANCE32UI_EXT = $8D74;
  GL_LUMINANCE_ALPHA32UI_EXT = $8D75;
  GL_RGBA16UI_EXT = $8D76;
  GL_RGB16UI_EXT = $8D77;
  GL_ALPHA16UI_EXT = $8D78;
  GL_INTENSITY16UI_EXT = $8D79;
  GL_LUMINANCE16UI_EXT = $8D7A;
  GL_LUMINANCE_ALPHA16UI_EXT = $8D7B;
  GL_RGBA8UI_EXT = $8D7C;
  GL_RGB8UI_EXT = $8D7D;
  GL_ALPHA8UI_EXT = $8D7E;
  GL_INTENSITY8UI_EXT = $8D7F;
  GL_LUMINANCE8UI_EXT = $8D80;
  GL_LUMINANCE_ALPHA8UI_EXT = $8D81;
  GL_RGBA32I_EXT = $8D82;
  GL_RGB32I_EXT = $8D83;
  GL_ALPHA32I_EXT = $8D84;
  GL_INTENSITY32I_EXT = $8D85;
  GL_LUMINANCE32I_EXT = $8D86;
  GL_LUMINANCE_ALPHA32I_EXT = $8D87;
  GL_RGBA16I_EXT = $8D88;
  GL_RGB16I_EXT = $8D89;
  GL_ALPHA16I_EXT = $8D8A;
  GL_INTENSITY16I_EXT = $8D8B;
  GL_LUMINANCE16I_EXT = $8D8C;
  GL_LUMINANCE_ALPHA16I_EXT = $8D8D;
  GL_RGBA8I_EXT = $8D8E;
  GL_RGB8I_EXT = $8D8F;
  GL_ALPHA8I_EXT = $8D90;
  GL_INTENSITY8I_EXT = $8D91;
  GL_LUMINANCE8I_EXT = $8D92;
  GL_LUMINANCE_ALPHA8I_EXT = $8D93;
  GL_RED_INTEGER_EXT = $8D94;
  GL_GREEN_INTEGER_EXT = $8D95;
  GL_BLUE_INTEGER_EXT = $8D96;
  GL_ALPHA_INTEGER_EXT = $8D97;
  GL_RGB_INTEGER_EXT = $8D98;
  GL_RGBA_INTEGER_EXT = $8D99;
  GL_BGR_INTEGER_EXT = $8D9A;
  GL_BGRA_INTEGER_EXT = $8D9B;
  GL_LUMINANCE_INTEGER_EXT = $8D9C;
  GL_LUMINANCE_ALPHA_INTEGER_EXT = $8D9D;

  // GL_EXT_texture_shared_exponent
  GL_RGB9_E5_EXT = $8C3D;
  GL_UNSIGNED_INT_5_9_9_9_REV_EXT = $8C3E;
  GL_TEXTURE_SHARED_SIZE_EXT = $8C3F;

  // GL_EXT_transform_feedback
  GL_TRANSFORM_FEEDBACK_BUFFER_EXT = $8C8E;
  GL_TRANSFORM_FEEDBACK_BUFFER_START_EXT = $8C84;
  GL_TRANSFORM_FEEDBACK_BUFFER_SIZE_EXT = $8C85;
  GL_TRANSFORM_FEEDBACK_BUFFER_BINDING_EXT = $8C8F;
  GL_INTERLEAVED_ATTRIBS_EXT = $8C8C;
  GL_SEPARATE_ATTRIBS_EXT = $8C8D;
  GL_PRIMITIVES_GENERATED_EXT = $8C87;
  GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN_EXT = $8C88;
  GL_RASTERIZER_DISCARD_EXT = $8C89;
  GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS_EXT = $8C8A;
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS_EXT = $8C8B;
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS_EXT = $8C80;
  GL_TRANSFORM_FEEDBACK_VARYINGS_EXT = $8C83;
  GL_TRANSFORM_FEEDBACK_BUFFER_MODE_EXT = $8C7F;
  GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH_EXT = $8C76;

  // GL_EXT_direct_state_access
  GL_PROGRAM_MATRIX_EXT = $8E2D;
  GL_TRANSPOSE_PROGRAM_MATRIX_EXT = $8E2E;
  GL_PROGRAM_MATRIX_STACK_DEPTH_EXT = $8E2F;

  // GL_EXT_texture_swizzle
  GL_TEXTURE_SWIZZLE_R_EXT = $8E42;
  GL_TEXTURE_SWIZZLE_G_EXT = $8E43;
  GL_TEXTURE_SWIZZLE_B_EXT = $8E44;
  GL_TEXTURE_SWIZZLE_A_EXT = $8E45;
  GL_TEXTURE_SWIZZLE_RGBA_EXT = $8E46;

  // GL_EXT_provoking_vertex
  GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION_EXT = $8E4C;
  GL_FIRST_VERTEX_CONVENTION_EXT = $8E4D;
  GL_LAST_VERTEX_CONVENTION_EXT = $8E4E;
  GL_PROVOKING_VERTEX_EXT = $8E4F;

  // GL_EXT_texture_snorm
  GL_ALPHA_SNORM = $9010;
  GL_LUMINANCE_SNORM = $9011;
  GL_LUMINANCE_ALPHA_SNORM = $9012;
  GL_INTENSITY_SNORM = $9013;
  GL_ALPHA8_SNORM = $9014;
  GL_LUMINANCE8_SNORM = $9015;
  GL_LUMINANCE8_ALPHA8_SNORM = $9016;
  GL_INTENSITY8_SNORM = $9017;
  GL_ALPHA16_SNORM = $9018;
  GL_LUMINANCE16_SNORM = $9019;
  GL_LUMINANCE16_ALPHA16_SNORM = $901A;
  GL_INTENSITY16_SNORM = $901B;
  { reuse GL_RED_SNORM }
  { reuse GL_RG_SNORM }
  { reuse GL_RGB_SNORM }
  { reuse GL_RGBA_SNORM }
  { reuse GL_R8_SNORM }
  { reuse GL_RG8_SNORM }
  { reuse GL_RGB8_SNORM }
  { reuse GL_RGBA8_SNORM }
  { reuse GL_R16_SNORM }
  { reuse GL_RG16_SNORM }
  { reuse GL_RGB16_SNORM }
  { reuse GL_RGBA16_SNORM }
  { reuse GL_SIGNED_NORMALIZED }

  // GL_EXT_separate_shader_objects
  GL_ACTIVE_PROGRAM_EXT = $8B8D;

  // GL_EXT_shader_image_load_store
  GL_MAX_IMAGE_UNITS_EXT = $8F38;
  GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS_EXT = $8F39;
  GL_IMAGE_BINDING_NAME_EXT = $8F3A;
  GL_IMAGE_BINDING_LEVEL_EXT = $8F3B;
  GL_IMAGE_BINDING_LAYERED_EXT = $8F3C;
  GL_IMAGE_BINDING_LAYER_EXT = $8F3D;
  GL_IMAGE_BINDING_ACCESS_EXT = $8F3E;
  GL_IMAGE_1D_EXT = $904C;
  GL_IMAGE_2D_EXT = $904D;
  GL_IMAGE_3D_EXT = $904E;
  GL_IMAGE_2D_RECT_EXT = $904F;
  GL_IMAGE_CUBE_EXT = $9050;
  GL_IMAGE_BUFFER_EXT = $9051;
  GL_IMAGE_1D_ARRAY_EXT = $9052;
  GL_IMAGE_2D_ARRAY_EXT = $9053;
  GL_IMAGE_CUBE_MAP_ARRAY_EXT = $9054;
  GL_IMAGE_2D_MULTISAMPLE_EXT = $9055;
  GL_IMAGE_2D_MULTISAMPLE_ARRAY_EXT = $9056;
  GL_INT_IMAGE_1D_EXT = $9057;
  GL_INT_IMAGE_2D_EXT = $9058;
  GL_INT_IMAGE_3D_EXT = $9059;
  GL_INT_IMAGE_2D_RECT_EXT = $905A;
  GL_INT_IMAGE_CUBE_EXT = $905B;
  GL_INT_IMAGE_BUFFER_EXT = $905C;
  GL_INT_IMAGE_1D_ARRAY_EXT = $905D;
  GL_INT_IMAGE_2D_ARRAY_EXT = $905E;
  GL_INT_IMAGE_CUBE_MAP_ARRAY_EXT = $905F;
  GL_INT_IMAGE_2D_MULTISAMPLE_EXT = $9060;
  GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY_EXT = $9061;
  GL_UNSIGNED_INT_IMAGE_1D_EXT = $9062;
  GL_UNSIGNED_INT_IMAGE_2D_EXT = $9063;
  GL_UNSIGNED_INT_IMAGE_3D_EXT = $9064;
  GL_UNSIGNED_INT_IMAGE_2D_RECT_EXT = $9065;
  GL_UNSIGNED_INT_IMAGE_CUBE_EXT = $9066;
  GL_UNSIGNED_INT_IMAGE_BUFFER_EXT = $9067;
  GL_UNSIGNED_INT_IMAGE_1D_ARRAY_EXT = $9068;
  GL_UNSIGNED_INT_IMAGE_2D_ARRAY_EXT = $9069;
  GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY_EXT = $906A;
  GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_EXT = $906B;
  GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY_EXT = $906C;
  GL_MAX_IMAGE_SAMPLES_EXT = $906D;
  GL_IMAGE_BINDING_FORMAT_EXT = $906E;
  GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT_EXT = $00000001;
  GL_ELEMENT_ARRAY_BARRIER_BIT_EXT = $00000002;
  GL_UNIFORM_BARRIER_BIT_EXT = $00000004;
  GL_TEXTURE_FETCH_BARRIER_BIT_EXT = $00000008;
  GL_SHADER_IMAGE_ACCESS_BARRIER_BIT_EXT = $00000020;
  GL_COMMAND_BARRIER_BIT_EXT = $00000040;
  GL_PIXEL_BUFFER_BARRIER_BIT_EXT = $00000080;
  GL_TEXTURE_UPDATE_BARRIER_BIT_EXT = $00000100;
  GL_BUFFER_UPDATE_BARRIER_BIT_EXT = $00000200;
  GL_FRAMEBUFFER_BARRIER_BIT_EXT = $00000400;
  GL_TRANSFORM_FEEDBACK_BARRIER_BIT_EXT = $00000800;
  GL_ATOMIC_COUNTER_BARRIER_BIT_EXT = $00001000;
  GL_ALL_BARRIER_BITS_EXT = $FFFFFFFF;

  // GL_EXT_vertex_attrib_64bit
  GL_DOUBLE_VEC2_EXT = $8FFC;
  GL_DOUBLE_VEC3_EXT = $8FFD;
  GL_DOUBLE_VEC4_EXT = $8FFE;
  GL_DOUBLE_MAT2_EXT = $8F46;
  GL_DOUBLE_MAT3_EXT = $8F47;
  GL_DOUBLE_MAT4_EXT = $8F48;
  GL_DOUBLE_MAT2x3_EXT = $8F49;
  GL_DOUBLE_MAT2x4_EXT = $8F4A;
  GL_DOUBLE_MAT3x2_EXT = $8F4B;
  GL_DOUBLE_MAT3x4_EXT = $8F4C;
  GL_DOUBLE_MAT4x2_EXT = $8F4D;
  GL_DOUBLE_MAT4x3_EXT = $8F4E;

  // GL_EXT_texture_sRGB_decode
  GL_TEXTURE_SRGB_DECODE_EXT = $8A48;
  GL_DECODE_EXT = $8A49;
  GL_SKIP_DECODE_EXT = $8A4A;

  // GL_NV_texture_multisample
  GL_TEXTURE_COVERAGE_SAMPLES_NV    = $9045;
  GL_TEXTURE_COLOR_SAMPLES_NV       = $9046;

  // GL_AMD_blend_minmax_factor
  GL_FACTOR_MIN_AMD                 = $901C;
  GL_FACTOR_MAX_AMD                 = $901D;

  // GL_AMD_sample_positions
  GL_SUBSAMPLE_DISTANCE_AMD         = $883F;

  // GL_EXT_x11_sync_object
  GL_SYNC_X11_FENCE_EXT             = $90E1;

  // GL_EXT_framebuffer_multisample_blit_scaled
  GL_SCALED_RESOLVE_FASTEST_EXT     = $90BA;
  GL_SCALED_RESOLVE_NICEST_EXT      = $90BB;

  // (4.3) GL_NV_path_rendering
 	GL_PATH_FORMAT_SVG_NV            = $9070;
 	GL_PATH_FORMAT_PS_NV             = $9071;
 	GL_STANDARD_FONT_NAME_NV         = $9072;
 	GL_SYSTEM_FONT_NAME_NV           = $9073;
 	GL_FILE_NAME_NV                  = $9074;
 	GL_PATH_STROKE_WIDTH_NV          = $9075;
 	GL_PATH_END_CAPS_NV              = $9076;
 	GL_PATH_INITIAL_END_CAP_NV       = $9077;
 	GL_PATH_TERMINAL_END_CAP_NV      = $9078;
 	GL_PATH_JOIN_STYLE_NV            = $9079;
 	GL_PATH_MITER_LIMIT_NV           = $907A;
 	GL_PATH_DASH_CAPS_NV             = $907B;
 	GL_PATH_INITIAL_DASH_CAP_NV      = $907C;
 	GL_PATH_TERMINAL_DASH_CAP_NV     = $907D;
 	GL_PATH_DASH_OFFSET_NV           = $907E;
 	GL_PATH_CLIENT_LENGTH_NV         = $907F;
 	GL_PATH_FILL_MODE_NV             = $9080;
 	GL_PATH_FILL_MASK_NV             = $9081;
 	GL_PATH_FILL_COVER_MODE_NV       = $9082;
 	GL_PATH_STROKE_COVER_MODE_NV     = $9083;
 	GL_PATH_STROKE_MASK_NV           = $9084;
 	GL_PATH_SAMPLE_QUALITY_NV        = $9085;
 	GL_PATH_STROKE_BOUND_NV          = $9086;
 	GL_PATH_STROKE_OVERSAMPLE_COUNT_NV= $9087;
 	GL_COUNT_UP_NV                   = $9088;
 	GL_COUNT_DOWN_NV                 = $9089;
 	GL_PATH_OBJECT_BOUNDING_BOX_NV   = $908A;
 	GL_CONVEX_HULL_NV                = $908B;
 	GL_MULTI_HULLS_NV                = $908C;
 	GL_BOUNDING_BOX_NV               = $908D;
 	GL_TRANSLATE_X_NV                = $908E;
 	GL_TRANSLATE_Y_NV                = $908F;
 	GL_TRANSLATE_2D_NV               = $9090;
 	GL_TRANSLATE_3D_NV               = $9091;
 	GL_AFFINE_2D_NV                  = $9092;
 	GL_PROJECTIVE_2D_NV              = $9093;
 	GL_AFFINE_3D_NV                  = $9094;
 	GL_PROJECTIVE_3D_NV              = $9095;
 	GL_TRANSPOSE_AFFINE_2D_NV        = $9096;
 	GL_TRANSPOSE_PROJECTIVE_2D_NV    = $9097;
	GL_TRANSPOSE_AFFINE_3D_NV        = $9098;
 	GL_TRANSPOSE_PROJECTIVE_3D_NV    = $9099;
 	GL_UTF8_NV                       = $909A;
 	GL_UTF16_NV                      = $909B;
 	GL_BOUNDING_BOX_OF_BOUNDING_BOXES_NV= $909C;
 	GL_PATH_COMMAND_COUNT_NV         = $909D;
 	GL_PATH_COORD_COUNT_NV           = $909E;
  GL_PATH_DASH_ARRAY_COUNT_NV      = $909F;
  GL_PATH_COMPUTED_LENGTH_NV       = $90A0;
  GL_PATH_FILL_BOUNDING_BOX_NV     = $90A1;
  GL_PATH_STROKE_BOUNDING_BOX_NV   = $90A2;
  GL_SQUARE_NV                     = $90A3;
  GL_ROUND_NV                      = $90A4;
  GL_TRIANGULAR_NV                 = $90A5;
  GL_BEVEL_NV                      = $90A6;
  GL_MITER_REVERT_NV               = $90A7;
  GL_MITER_TRUNCATE_NV             = $90A8;
  GL_SKIP_MISSING_GLYPH_NV         = $90A9;
  GL_USE_MISSING_GLYPH_NV          = $90AA;
  GL_PATH_ERROR_POSITION_NV        = $90AB;
  GL_PATH_FOG_GEN_MODE_NV          = $90AC;
  GL_ACCUM_ADJACENT_PAIRS_NV       = $90AD;
  GL_ADJACENT_PAIRS_NV             = $90AE;
  GL_FIRST_TO_REST_NV              = $90AF;
  GL_PATH_GEN_MODE_NV              = $90B0;
  GL_PATH_GEN_COEFF_NV             = $90B1;
  GL_PATH_GEN_COLOR_FORMAT_NV      = $90B2;
  GL_PATH_GEN_COMPONENTS_NV        = $90B3;
  GL_PATH_STENCIL_FUNC_NV          = $90B7;
  GL_PATH_STENCIL_REF_NV           = $90B8;
  GL_PATH_STENCIL_VALUE_MASK_NV    = $90B9;
  GL_PATH_STENCIL_DEPTH_OFFSET_FACTOR_NV= $90BD;
  GL_PATH_STENCIL_DEPTH_OFFSET_UNITS_NV= $90BE;
  GL_PATH_COVER_DEPTH_FUNC_NV      = $90BF;
  GL_PATH_DASH_OFFSET_RESET_NV     = $90B4;
  GL_MOVE_TO_RESETS_NV             = $90B5;
  GL_MOVE_TO_CONTINUES_NV          = $90B6;
  GL_CLOSE_PATH_NV                 = $00;
  GL_MOVE_TO_NV                    = $02;
  GL_RELATIVE_MOVE_TO_NV           = $03;
  GL_LINE_TO_NV                    = $04;
  GL_RELATIVE_LINE_TO_NV           = $05;
  GL_HORIZONTAL_LINE_TO_NV         = $06;
  GL_RELATIVE_HORIZONTAL_LINE_TO_NV= $07;
  GL_VERTICAL_LINE_TO_NV           = $08;
  GL_RELATIVE_VERTICAL_LINE_TO_NV  = $09;
  GL_QUADRATIC_CURVE_TO_NV         = $0A;
  GL_RELATIVE_QUADRATIC_CURVE_TO_NV= $0B;
  GL_CUBIC_CURVE_TO_NV             = $0C;
  GL_RELATIVE_CUBIC_CURVE_TO_NV    = $0D;
  GL_SMOOTH_QUADRATIC_CURVE_TO_NV  = $0E;
  GL_RELATIVE_SMOOTH_QUADRATIC_CURVE_TO_NV= $0F;
  GL_SMOOTH_CUBIC_CURVE_TO_NV      = $10;
  GL_RELATIVE_SMOOTH_CUBIC_CURVE_TO_NV= $11;
  GL_SMALL_CCW_ARC_TO_NV           = $12;
  GL_RELATIVE_SMALL_CCW_ARC_TO_NV  = $13;
  GL_SMALL_CW_ARC_TO_NV            = $14;
  GL_RELATIVE_SMALL_CW_ARC_TO_NV   = $15;
  GL_LARGE_CCW_ARC_TO_NV           = $16;
  GL_RELATIVE_LARGE_CCW_ARC_TO_NV  = $17;
  GL_LARGE_CW_ARC_TO_NV            = $18;
  GL_RELATIVE_LARGE_CW_ARC_TO_NV   = $19;
  GL_RESTART_PATH_NV               = $F0;
  GL_DUP_FIRST_CUBIC_CURVE_TO_NV   = $F2;
  GL_DUP_LAST_CUBIC_CURVE_TO_NV    = $F4;
  GL_RECT_NV                       = $F6;
  GL_CIRCULAR_CCW_ARC_TO_NV        = $F8;
  GL_CIRCULAR_CW_ARC_TO_NV         = $FA;
  GL_CIRCULAR_TANGENT_ARC_TO_NV    = $FC;
  GL_ARC_TO_NV                     = $FE;
  GL_RELATIVE_ARC_TO_NV            = $FF;
  GL_BOLD_BIT_NV                   = $01;
  GL_ITALIC_BIT_NV                 = $02;
  GL_GLYPH_WIDTH_BIT_NV            = $01;
  GL_GLYPH_HEIGHT_BIT_NV           = $02;
  GL_GLYPH_HORIZONTAL_BEARING_X_BIT_NV= $04;
  GL_GLYPH_HORIZONTAL_BEARING_Y_BIT_NV= $08;
  GL_GLYPH_HORIZONTAL_BEARING_ADVANCE_BIT_NV= $10;
  GL_GLYPH_VERTICAL_BEARING_X_BIT_NV= $20;
  GL_GLYPH_VERTICAL_BEARING_Y_BIT_NV= $40;
  GL_GLYPH_VERTICAL_BEARING_ADVANCE_BIT_NV= $80;
  GL_GLYPH_HAS_KERNING_NV          = $100;
  GL_FONT_X_MIN_BOUNDS_NV          = $00010000;
  GL_FONT_Y_MIN_BOUNDS_NV          = $00020000;
  GL_FONT_X_MAX_BOUNDS_NV          = $00040000;
  GL_FONT_Y_MAX_BOUNDS_NV          = $00080000;
  GL_FONT_UNITS_PER_EM_NV          = $00100000;
  GL_FONT_ASCENDER_NV              = $00200000;
  GL_FONT_DESCENDER_NV             = $00400000;
  GL_FONT_HEIGHT_NV                = $00800000;
  GL_FONT_MAX_ADVANCE_WIDTH_NV     = $01000000;
  GL_FONT_MAX_ADVANCE_HEIGHT_NV    = $02000000;
  GL_FONT_UNDERLINE_POSITION_NV    = $04000000;
  GL_FONT_UNDERLINE_THICKNESS_NV   = $08000000;
  GL_FONT_HAS_KERNING_NV           = $10000000;

  // (4.3) GL_AMD_pinned_memory
  GL_EXTERNAL_VIRTUAL_MEMORY_BUFFER_AMD= $9160;

  // (4.3) GL_AMD_stencil_operation_extended
  GL_SET_AMD                       = $874A;
  GL_REPLACE_VALUE_AMD             = $874B;
  GL_STENCIL_OP_VALUE_AMD          = $874C;
  GL_STENCIL_BACK_OP_VALUE_AMD     = $874D;

  // (4.3) GL_AMD_query_buffer_object
  GL_QUERY_BUFFER_AMD              = $9192;
  GL_QUERY_BUFFER_BINDING_AMD      = $9193;
  GL_QUERY_RESULT_NO_WAIT_AMD      = $9194;

  // GL_FfdMaskSGIX
  GL_TEXTURE_DEFORMATION_BIT_SGIX = $00000001;
  GL_GEOMETRY_DEFORMATION_BIT_SGIX = $00000002;

  // GL_HP_convolution_border_modes
  GL_IGNORE_BORDER_HP = $8150;
  GL_CONSTANT_BORDER_HP = $8151;
  GL_REPLICATE_BORDER_HP = $8153;
  GL_CONVOLUTION_BORDER_COLOR_HP = $8154;

  // GL_HP_image_transform
  GL_IMAGE_SCALE_X_HP = $8155;
  GL_IMAGE_SCALE_Y_HP = $8156;
  GL_IMAGE_TRANSLATE_X_HP = $8157;
  GL_IMAGE_TRANSLATE_Y_HP = $8158;
  GL_IMAGE_ROTATE_ANGLE_HP = $8159;
  GL_IMAGE_ROTATE_ORIGIN_X_HP = $815A;
  GL_IMAGE_ROTATE_ORIGIN_Y_HP = $815B;
  GL_IMAGE_MAG_FILTER_HP = $815C;
  GL_IMAGE_MIN_FILTER_HP = $815D;
  GL_IMAGE_CUBIC_WEIGHT_HP = $815E;
  GL_CUBIC_HP = $815F;
  GL_AVERAGE_HP = $8160;
  GL_IMAGE_TRANSFORM_2D_HP = $8161;
  GL_POST_IMAGE_TRANSFORM_COLOR_TABLE_HP = $8162;
  GL_PROXY_POST_IMAGE_TRANSFORM_COLOR_TABLE_HP = $8163;

  // GL_HP_occlusion_test
  GL_OCCLUSION_TEST_HP = $8165;
  GL_OCCLUSION_TEST_RESULT_HP = $8166;

  // GL_HP_texture_lighting
  GL_TEXTURE_LIGHTING_MODE_HP = $8167;
  GL_TEXTURE_POST_SPECULAR_HP = $8168;
  GL_TEXTURE_PRE_SPECULAR_HP = $8169;

  // GL_IBM_cull_vertex
  GL_CULL_VERTEX_IBM = 103050;

  // GL_IBM_rasterpos_clip
  GL_RASTER_POSITION_UNCLIPPED_IBM = $19262;

  // GL_IBM_texture_mirrored_repeat
  GL_MIRRORED_REPEAT_IBM = $8370;

  // GL_IBM_vertex_array_lists
  GL_VERTEX_ARRAY_LIST_IBM = 103070;
  GL_NORMAL_ARRAY_LIST_IBM = 103071;
  GL_COLOR_ARRAY_LIST_IBM = 103072;
  GL_INDEX_ARRAY_LIST_IBM = 103073;
  GL_TEXTURE_COORD_ARRAY_LIST_IBM = 103074;
  GL_EDGE_FLAG_ARRAY_LIST_IBM = 103075;
  GL_FOG_COORDINATE_ARRAY_LIST_IBM = 103076;
  GL_SECONDARY_COLOR_ARRAY_LIST_IBM = 103077;
  GL_VERTEX_ARRAY_LIST_STRIDE_IBM = 103080;
  GL_NORMAL_ARRAY_LIST_STRIDE_IBM = 103081;
  GL_COLOR_ARRAY_LIST_STRIDE_IBM = 103082;
  GL_INDEX_ARRAY_LIST_STRIDE_IBM = 103083;
  GL_TEXTURE_COORD_ARRAY_LIST_STRIDE_IBM = 103084;
  GL_EDGE_FLAG_ARRAY_LIST_STRIDE_IBM = 103085;
  GL_FOG_COORDINATE_ARRAY_LIST_STRIDE_IBM = 103086;
  GL_SECONDARY_COLOR_ARRAY_LIST_STRIDE_IBM = 103087;

  // GL_INGR_color_clamp
  GL_RED_MIN_CLAMP_INGR = $8560;
  GL_GREEN_MIN_CLAMP_INGR = $8561;
  GL_BLUE_MIN_CLAMP_INGR = $8562;
  GL_ALPHA_MIN_CLAMP_INGR = $8563;
  GL_RED_MAX_CLAMP_INGR = $8564;
  GL_GREEN_MAX_CLAMP_INGR = $8565;
  GL_BLUE_MAX_CLAMP_INGR = $8566;
  GL_ALPHA_MAX_CLAMP_INGR = $8567;

  // GL_INGR_interlace_read
  GL_INTERLACE_READ_INGR = $8568;

  // GL_INTEL_parallel_arrays
  GL_PARALLEL_ARRAYS_INTEL = $83F4;
  GL_VERTEX_ARRAY_PARALLEL_POINTERS_INTEL = $83F5;
  GL_NORMAL_ARRAY_PARALLEL_POINTERS_INTEL = $83F6;
  GL_COLOR_ARRAY_PARALLEL_POINTERS_INTEL = $83F7;
  GL_TEXTURE_COORD_ARRAY_PARALLEL_POINTERS_INTEL = $83F8;

  // GL_NV_copy_depth_to_color
  GL_DEPTH_STENCIL_TO_RGBA_NV = $886E;
  GL_DEPTH_STENCIL_TO_BGRA_NV = $886F;

  // GL_NV_depth_clamp
  GL_DEPTH_CLAMP_NV = $864F;

  // GL_NV_evaluators
  GL_EVAL_2D_NV = $86C0;
  GL_EVAL_TRIANGULAR_2D_NV = $86C1;
  GL_MAP_TESSELLATION_NV = $86C2;
  GL_MAP_ATTRIB_U_ORDER_NV = $86C3;
  GL_MAP_ATTRIB_V_ORDER_NV = $86C4;
  GL_EVAL_FRACTIONAL_TESSELLATION_NV = $86C5;
  GL_EVAL_VERTEX_ATTRIB0_NV = $86C6;
  GL_EVAL_VERTEX_ATTRIB1_NV = $86C7;
  GL_EVAL_VERTEX_ATTRIB2_NV = $86C8;
  GL_EVAL_VERTEX_ATTRIB3_NV = $86C9;
  GL_EVAL_VERTEX_ATTRIB4_NV = $86CA;
  GL_EVAL_VERTEX_ATTRIB5_NV = $86CB;
  GL_EVAL_VERTEX_ATTRIB6_NV = $86CC;
  GL_EVAL_VERTEX_ATTRIB7_NV = $86CD;
  GL_EVAL_VERTEX_ATTRIB8_NV = $86CE;
  GL_EVAL_VERTEX_ATTRIB9_NV = $86CF;
  GL_EVAL_VERTEX_ATTRIB10_NV = $86D0;
  GL_EVAL_VERTEX_ATTRIB11_NV = $86D1;
  GL_EVAL_VERTEX_ATTRIB12_NV = $86D2;
  GL_EVAL_VERTEX_ATTRIB13_NV = $86D3;
  GL_EVAL_VERTEX_ATTRIB14_NV = $86D4;
  GL_EVAL_VERTEX_ATTRIB15_NV = $86D5;
  GL_MAX_MAP_TESSELLATION_NV = $86D6;
  GL_MAX_RATIONAL_EVAL_ORDER_NV = $86D7;

  // GL_NV_fence
  GL_ALL_COMPLETED_NV = $84F2;
  GL_FENCE_STATUS_NV = $84F3;
  GL_FENCE_CONDITION_NV = $84F4;

  // GL_NV_float_buffer
  GL_FLOAT_R_NV = $8880;
  GL_FLOAT_RG_NV = $8881;
  GL_FLOAT_RGB_NV = $8882;
  GL_FLOAT_RGBA_NV = $8883;
  GL_FLOAT_R16_NV = $8884;
  GL_FLOAT_R32_NV = $8885;
  GL_FLOAT_RG16_NV = $8886;
  GL_FLOAT_RG32_NV = $8887;
  GL_FLOAT_RGB16_NV = $8888;
  GL_FLOAT_RGB32_NV = $8889;
  GL_FLOAT_RGBA16_NV = $888A;
  GL_FLOAT_RGBA32_NV = $888B;
  GL_TEXTURE_FLOAT_COMPONENTS_NV = $888C;
  GL_FLOAT_CLEAR_COLOR_VALUE_NV = $888D;
  GL_FLOAT_RGBA_MODE_NV = $888E;

  // GL_NV_fog_distance
  GL_FOG_DISTANCE_MODE_NV = $855A;
  GL_EYE_RADIAL_NV = $855B;
  GL_EYE_PLANE_ABSOLUTE_NV = $855C;

  // GL_NV_fragment_program
  GL_MAX_FRAGMENT_PROGRAM_LOCAL_PARAMETERS_NV = $8868;
  GL_FRAGMENT_PROGRAM_NV = $8870;
  GL_MAX_TEXTURE_COORDS_NV = $8871;
  GL_MAX_TEXTURE_IMAGE_UNITS_NV = $8872;
  GL_FRAGMENT_PROGRAM_BINDING_NV = $8873;
  GL_PROGRAM_ERROR_STRING_NV = $8874;

  // GL_NV_half_float
  GL_HALF_FLOAT_NV = $140B;

  // GL_NV_light_max_exponent
  GL_MAX_SHININESS_NV = $8504;
  GL_MAX_SPOT_EXPONENT_NV = $8505;

  // GL_NV_multisample_filter_hint
  GL_MULTISAMPLE_FILTER_HINT_NV = $8534;

  // GL_NV_occlusion_query
  GL_PIXEL_COUNTER_BITS_NV = $8864;
  GL_CURRENT_OCCLUSION_QUERY_ID_NV = $8865;
  GL_PIXEL_COUNT_NV = $8866;
  GL_PIXEL_COUNT_AVAILABLE_NV = $8867;

  // GL_NV_packed_depth_stencil
  GL_DEPTH_STENCIL_NV = $84F9;
  GL_UNSIGNED_INT_24_8_NV = $84FA;

  // GL_NV_pixel_data_range
  GL_WRITE_PIXEL_DATA_RANGE_NV = $8878;
  GL_READ_PIXEL_DATA_RANGE_NV = $8879;
  GL_WRITE_PIXEL_DATA_RANGE_LENGTH_NV = $887A;
  GL_READ_PIXEL_DATA_RANGE_LENGTH_NV = $887B;
  GL_WRITE_PIXEL_DATA_RANGE_POINTER_NV = $887C;
  GL_READ_PIXEL_DATA_RANGE_POINTER_NV = $887D;

  // GL_NV_point_sprite
  GL_POINT_SPRITE_NV = $8861;
  GL_COORD_REPLACE_NV = $8862;
  GL_POINT_SPRITE_R_MODE_NV = $8863;

  // GL_NV_primitive_restart
  GL_PRIMITIVE_RESTART_NV = $8558;
  GL_PRIMITIVE_RESTART_INDEX_NV = $8559;

  // GL_NV_register_combiners
  GL_REGISTER_COMBINERS_NV = $8522;
  GL_VARIABLE_A_NV = $8523;
  GL_VARIABLE_B_NV = $8524;
  GL_VARIABLE_C_NV = $8525;
  GL_VARIABLE_D_NV = $8526;
  GL_VARIABLE_E_NV = $8527;
  GL_VARIABLE_F_NV = $8528;
  GL_VARIABLE_G_NV = $8529;
  GL_CONSTANT_COLOR0_NV = $852A;
  GL_CONSTANT_COLOR1_NV = $852B;
  GL_PRIMARY_COLOR_NV = $852C;
  GL_SECONDARY_COLOR_NV = $852D;
  GL_SPARE0_NV = $852E;
  GL_SPARE1_NV = $852F;
  GL_DISCARD_NV = $8530;
  GL_E_TIMES_F_NV = $8531;
  GL_SPARE0_PLUS_SECONDARY_COLOR_NV = $8532;
  GL_UNSIGNED_IDENTITY_NV = $8536;
  GL_UNSIGNED_INVERT_NV = $8537;
  GL_EXPAND_NORMAL_NV = $8538;
  GL_EXPAND_NEGATE_NV = $8539;
  GL_HALF_BIAS_NORMAL_NV = $853A;
  GL_HALF_BIAS_NEGATE_NV = $853B;
  GL_SIGNED_IDENTITY_NV = $853C;
  GL_SIGNED_NEGATE_NV = $853D;
  GL_SCALE_BY_TWO_NV = $853E;
  GL_SCALE_BY_FOUR_NV = $853F;
  GL_SCALE_BY_ONE_HALF_NV = $8540;
  GL_BIAS_BY_NEGATIVE_ONE_HALF_NV = $8541;
  GL_COMBINER_INPUT_NV = $8542;
  GL_COMBINER_MAPPING_NV = $8543;
  GL_COMBINER_COMPONENT_USAGE_NV = $8544;
  GL_COMBINER_AB_DOT_PRODUCT_NV = $8545;
  GL_COMBINER_CD_DOT_PRODUCT_NV = $8546;
  GL_COMBINER_MUX_SUM_NV = $8547;
  GL_COMBINER_SCALE_NV = $8548;
  GL_COMBINER_BIAS_NV = $8549;
  GL_COMBINER_AB_OUTPUT_NV = $854A;
  GL_COMBINER_CD_OUTPUT_NV = $854B;
  GL_COMBINER_SUM_OUTPUT_NV = $854C;
  GL_MAX_GENERAL_COMBINERS_NV = $854D;
  GL_NUM_GENERAL_COMBINERS_NV = $854E;
  GL_COLOR_SUM_CLAMP_NV = $854F;
  GL_COMBINER0_NV = $8550;
  GL_COMBINER1_NV = $8551;
  GL_COMBINER2_NV = $8552;
  GL_COMBINER3_NV = $8553;
  GL_COMBINER4_NV = $8554;
  GL_COMBINER5_NV = $8555;
  GL_COMBINER6_NV = $8556;
  GL_COMBINER7_NV = $8557;

  // GL_NV_register_combiners2
  GL_PER_STAGE_CONSTANTS_NV = $8535;

  // GL_NV_texgen_emboss
  GL_EMBOSS_LIGHT_NV = $855D;
  GL_EMBOSS_CONSTANT_NV = $855E;
  GL_EMBOSS_MAP_NV = $855F;

  // GL_NV_texgen_reflection
  GL_NORMAL_MAP_NV = $8511;
  GL_REFLECTION_MAP_NV = $8512;

  // GL_NV_texture_env_combine4
  GL_COMBINE4_NV = $8503;
  GL_SOURCE3_RGB_NV = $8583;
  GL_SOURCE3_ALPHA_NV = $858B;
  GL_OPERAND3_RGB_NV = $8593;
  GL_OPERAND3_ALPHA_NV = $859B;

  // GL_NV_texture_expand_normal
  GL_TEXTURE_UNSIGNED_REMAP_MODE_NV = $888F;

  // GL_NV_texture_rectangle
  GL_TEXTURE_RECTANGLE_NV = $84F5;
  GL_TEXTURE_BINDING_RECTANGLE_NV = $84F6;
  GL_PROXY_TEXTURE_RECTANGLE_NV = $84F7;
  GL_MAX_RECTANGLE_TEXTURE_SIZE_NV = $84F8;

  // GL_NV_texture_shader
  GL_OFFSET_TEXTURE_RECTANGLE_NV = $864C;
  GL_OFFSET_TEXTURE_RECTANGLE_SCALE_NV = $864D;
  GL_DOT_PRODUCT_TEXTURE_RECTANGLE_NV = $864E;
  GL_RGBA_UNSIGNED_DOT_PRODUCT_MAPPING_NV = $86D9;
  GL_UNSIGNED_INT_S8_S8_8_8_NV = $86DA;
  GL_UNSIGNED_INT_8_8_S8_S8_REV_NV = $86DB;
  GL_DSDT_MAG_INTENSITY_NV = $86DC;
  GL_SHADER_CONSISTENT_NV = $86DD;
  GL_TEXTURE_SHADER_NV = $86DE;
  GL_SHADER_OPERATION_NV = $86DF;
  GL_CULL_MODES_NV = $86E0;
  GL_OFFSET_TEXTURE_MATRIX_NV = $86E1;
  GL_OFFSET_TEXTURE_SCALE_NV = $86E2;
  GL_OFFSET_TEXTURE_BIAS_NV = $86E3;
  GL_OFFSET_TEXTURE_2D_MATRIX_NV = GL_OFFSET_TEXTURE_MATRIX_NV;
  GL_OFFSET_TEXTURE_2D_SCALE_NV = GL_OFFSET_TEXTURE_SCALE_NV;
  GL_OFFSET_TEXTURE_2D_BIAS_NV = GL_OFFSET_TEXTURE_BIAS_NV;
  GL_PREVIOUS_TEXTURE_INPUT_NV = $86E4;
  GL_CONST_EYE_NV = $86E5;
  GL_PASS_THROUGH_NV = $86E6;
  GL_CULL_FRAGMENT_NV = $86E7;
  GL_OFFSET_TEXTURE_2D_NV = $86E8;
  GL_DEPENDENT_AR_TEXTURE_2D_NV = $86E9;
  GL_DEPENDENT_GB_TEXTURE_2D_NV = $86EA;
  GL_DOT_PRODUCT_NV = $86EC;
  GL_DOT_PRODUCT_DEPTH_REPLACE_NV = $86ED;
  GL_DOT_PRODUCT_TEXTURE_2D_NV = $86EE;
  GL_DOT_PRODUCT_TEXTURE_CUBE_MAP_NV = $86F0;
  GL_DOT_PRODUCT_DIFFUSE_CUBE_MAP_NV = $86F1;
  GL_DOT_PRODUCT_REFLECT_CUBE_MAP_NV = $86F2;
  GL_DOT_PRODUCT_CONST_EYE_REFLECT_CUBE_MAP_NV = $86F3;
  GL_HILO_NV = $86F4;
  GL_DSDT_NV = $86F5;
  GL_DSDT_MAG_NV = $86F6;
  GL_DSDT_MAG_VIB_NV = $86F7;
  GL_HILO16_NV = $86F8;
  GL_SIGNED_HILO_NV = $86F9;
  GL_SIGNED_HILO16_NV = $86FA;
  GL_SIGNED_RGBA_NV = $86FB;
  GL_SIGNED_RGBA8_NV = $86FC;
  GL_SIGNED_RGB_NV = $86FE;
  GL_SIGNED_RGB8_NV = $86FF;
  GL_SIGNED_LUMINANCE_NV = $8701;
  GL_SIGNED_LUMINANCE8_NV = $8702;
  GL_SIGNED_LUMINANCE_ALPHA_NV = $8703;
  GL_SIGNED_LUMINANCE8_ALPHA8_NV = $8704;
  GL_SIGNED_ALPHA_NV = $8705;
  GL_SIGNED_ALPHA8_NV = $8706;
  GL_SIGNED_INTENSITY_NV = $8707;
  GL_SIGNED_INTENSITY8_NV = $8708;
  GL_DSDT8_NV = $8709;
  GL_DSDT8_MAG8_NV = $870A;
  GL_DSDT8_MAG8_INTENSITY8_NV = $870B;
  GL_SIGNED_RGB_UNSIGNED_ALPHA_NV = $870C;
  GL_SIGNED_RGB8_UNSIGNED_ALPHA8_NV = $870D;
  GL_HI_SCALE_NV = $870E;
  GL_LO_SCALE_NV = $870F;
  GL_DS_SCALE_NV = $8710;
  GL_DT_SCALE_NV = $8711;
  GL_MAGNITUDE_SCALE_NV = $8712;
  GL_VIBRANCE_SCALE_NV = $8713;
  GL_HI_BIAS_NV = $8714;
  GL_LO_BIAS_NV = $8715;
  GL_DS_BIAS_NV = $8716;
  GL_DT_BIAS_NV = $8717;
  GL_MAGNITUDE_BIAS_NV = $8718;
  GL_VIBRANCE_BIAS_NV = $8719;
  GL_TEXTURE_BORDER_VALUES_NV = $871A;
  GL_TEXTURE_HI_SIZE_NV = $871B;
  GL_TEXTURE_LO_SIZE_NV = $871C;
  GL_TEXTURE_DS_SIZE_NV = $871D;
  GL_TEXTURE_DT_SIZE_NV = $871E;
  GL_TEXTURE_MAG_SIZE_NV = $871F;

  // GL_NV_texture_shader2
  GL_DOT_PRODUCT_TEXTURE_3D_NV = $86EF;

  // GL_NV_texture_shader3
  GL_OFFSET_PROJECTIVE_TEXTURE_2D_NV = $8850;
  GL_OFFSET_PROJECTIVE_TEXTURE_2D_SCALE_NV = $8851;
  GL_OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_NV = $8852;
  GL_OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_SCALE_NV = $8853;
  GL_OFFSET_HILO_TEXTURE_2D_NV = $8854;
  GL_OFFSET_HILO_TEXTURE_RECTANGLE_NV = $8855;
  GL_OFFSET_HILO_PROJECTIVE_TEXTURE_2D_NV = $8856;
  GL_OFFSET_HILO_PROJECTIVE_TEXTURE_RECTANGLE_NV = $8857;
  GL_DEPENDENT_HILO_TEXTURE_2D_NV = $8858;
  GL_DEPENDENT_RGB_TEXTURE_3D_NV = $8859;
  GL_DEPENDENT_RGB_TEXTURE_CUBE_MAP_NV = $885A;
  GL_DOT_PRODUCT_PASS_THROUGH_NV = $885B;
  GL_DOT_PRODUCT_TEXTURE_1D_NV = $885C;
  GL_DOT_PRODUCT_AFFINE_DEPTH_REPLACE_NV = $885D;
  GL_HILO8_NV = $885E;
  GL_SIGNED_HILO8_NV = $885F;
  GL_FORCE_BLUE_TO_ONE_NV = $8860;

  // GL_NV_vertex_array_range
  GL_VERTEX_ARRAY_RANGE_NV = $851D;
  GL_VERTEX_ARRAY_RANGE_LENGTH_NV = $851E;
  GL_VERTEX_ARRAY_RANGE_VALID_NV = $851F;
  GL_MAX_VERTEX_ARRAY_RANGE_ELEMENT_NV = $8520;
  GL_VERTEX_ARRAY_RANGE_POINTER_NV = $8521;

  // GL_NV_vertex_array_range2
  GL_VERTEX_ARRAY_RANGE_WITHOUT_FLUSH_NV = $8533;

  // GL_NV_vertex_program
  GL_VERTEX_PROGRAM_NV = $8620;
  GL_VERTEX_STATE_PROGRAM_NV = $8621;
  GL_ATTRIB_ARRAY_SIZE_NV = $8623;
  GL_ATTRIB_ARRAY_STRIDE_NV = $8624;
  GL_ATTRIB_ARRAY_TYPE_NV = $8625;
  GL_CURRENT_ATTRIB_NV = $8626;
  GL_PROGRAM_LENGTH_NV = $8627;
  GL_PROGRAM_STRING_NV = $8628;
  GL_MODELVIEW_PROJECTION_NV = $8629;
  GL_IDENTITY_NV = $862A;
  GL_INVERSE_NV = $862B;
  GL_TRANSPOSE_NV = $862C;
  GL_INVERSE_TRANSPOSE_NV = $862D;
  GL_MAX_TRACK_MATRIX_STACK_DEPTH_NV = $862E;
  GL_MAX_TRACK_MATRICES_NV = $862F;
  GL_MATRIX0_NV = $8630;
  GL_MATRIX1_NV = $8631;
  GL_MATRIX2_NV = $8632;
  GL_MATRIX3_NV = $8633;
  GL_MATRIX4_NV = $8634;
  GL_MATRIX5_NV = $8635;
  GL_MATRIX6_NV = $8636;
  GL_MATRIX7_NV = $8637;
  GL_CURRENT_MATRIX_STACK_DEPTH_NV = $8640;
  GL_CURRENT_MATRIX_NV = $8641;
  GL_VERTEX_PROGRAM_POINT_SIZE_NV = $8642;
  GL_VERTEX_PROGRAM_TWO_SIDE_NV = $8643;
  GL_PROGRAM_PARAMETER_NV = $8644;
  GL_ATTRIB_ARRAY_POINTER_NV = $8645;
  GL_PROGRAM_TARGET_NV = $8646;
  GL_PROGRAM_RESIDENT_NV = $8647;
  GL_TRACK_MATRIX_NV = $8648;
  GL_TRACK_MATRIX_TRANSFORM_NV = $8649;
  GL_VERTEX_PROGRAM_BINDING_NV = $864A;
  GL_PROGRAM_ERROR_POSITION_NV = $864B;
  GL_VERTEX_ATTRIB_ARRAY0_NV = $8650;
  GL_VERTEX_ATTRIB_ARRAY1_NV = $8651;
  GL_VERTEX_ATTRIB_ARRAY2_NV = $8652;
  GL_VERTEX_ATTRIB_ARRAY3_NV = $8653;
  GL_VERTEX_ATTRIB_ARRAY4_NV = $8654;
  GL_VERTEX_ATTRIB_ARRAY5_NV = $8655;
  GL_VERTEX_ATTRIB_ARRAY6_NV = $8656;
  GL_VERTEX_ATTRIB_ARRAY7_NV = $8657;
  GL_VERTEX_ATTRIB_ARRAY8_NV = $8658;
  GL_VERTEX_ATTRIB_ARRAY9_NV = $8659;
  GL_VERTEX_ATTRIB_ARRAY10_NV = $865A;
  GL_VERTEX_ATTRIB_ARRAY11_NV = $865B;
  GL_VERTEX_ATTRIB_ARRAY12_NV = $865C;
  GL_VERTEX_ATTRIB_ARRAY13_NV = $865D;
  GL_VERTEX_ATTRIB_ARRAY14_NV = $865E;
  GL_VERTEX_ATTRIB_ARRAY15_NV = $865F;
  GL_MAP1_VERTEX_ATTRIB0_4_NV = $8660;
  GL_MAP1_VERTEX_ATTRIB1_4_NV = $8661;
  GL_MAP1_VERTEX_ATTRIB2_4_NV = $8662;
  GL_MAP1_VERTEX_ATTRIB3_4_NV = $8663;
  GL_MAP1_VERTEX_ATTRIB4_4_NV = $8664;
  GL_MAP1_VERTEX_ATTRIB5_4_NV = $8665;
  GL_MAP1_VERTEX_ATTRIB6_4_NV = $8666;
  GL_MAP1_VERTEX_ATTRIB7_4_NV = $8667;
  GL_MAP1_VERTEX_ATTRIB8_4_NV = $8668;
  GL_MAP1_VERTEX_ATTRIB9_4_NV = $8669;
  GL_MAP1_VERTEX_ATTRIB10_4_NV = $866A;
  GL_MAP1_VERTEX_ATTRIB11_4_NV = $866B;
  GL_MAP1_VERTEX_ATTRIB12_4_NV = $866C;
  GL_MAP1_VERTEX_ATTRIB13_4_NV = $866D;
  GL_MAP1_VERTEX_ATTRIB14_4_NV = $866E;
  GL_MAP1_VERTEX_ATTRIB15_4_NV = $866F;
  GL_MAP2_VERTEX_ATTRIB0_4_NV = $8670;
  GL_MAP2_VERTEX_ATTRIB1_4_NV = $8671;
  GL_MAP2_VERTEX_ATTRIB2_4_NV = $8672;
  GL_MAP2_VERTEX_ATTRIB3_4_NV = $8673;
  GL_MAP2_VERTEX_ATTRIB4_4_NV = $8674;
  GL_MAP2_VERTEX_ATTRIB5_4_NV = $8675;
  GL_MAP2_VERTEX_ATTRIB6_4_NV = $8676;
  GL_MAP2_VERTEX_ATTRIB7_4_NV = $8677;
  GL_MAP2_VERTEX_ATTRIB8_4_NV = $8678;
  GL_MAP2_VERTEX_ATTRIB9_4_NV = $8679;
  GL_MAP2_VERTEX_ATTRIB10_4_NV = $867A;
  GL_MAP2_VERTEX_ATTRIB11_4_NV = $867B;
  GL_MAP2_VERTEX_ATTRIB12_4_NV = $867C;
  GL_MAP2_VERTEX_ATTRIB13_4_NV = $867D;
  GL_MAP2_VERTEX_ATTRIB14_4_NV = $867E;
  GL_MAP2_VERTEX_ATTRIB15_4_NV = $867F;

  // GL_NV_fragment_program2 and GL_NV_vertex_program2_option
  GL_MAX_PROGRAM_EXEC_INSTRUCTIONS_NV = $88F4;
  GL_MAX_PROGRAM_CALL_DEPTH_NV = $88F5;

  // GL_NV_fragment_program2
  GL_MAX_PROGRAM_IF_DEPTH_NV = $88F6;
  GL_MAX_PROGRAM_LOOP_DEPTH_NV = $88F7;
  GL_MAX_PROGRAM_LOOP_COUNT_NV = $88F8;

  // GL_NV_vertex_program3
  MAX_VERTEX_TEXTURE_IMAGE_UNITS_ARB = $8B4C;

  // GL_NV_depth_buffer_float
  GL_FLOAT_32_UNSIGNED_INT_24_8_REV_NV = $8DAD;
  GL_DEPTH_BUFFER_FLOAT_MODE_NV = $8DAF;

  // GL_NV_framebuffer_multisample_coverage
  GL_RENDERBUFFER_COVERAGE_SAMPLES_NV = $8CAB;
  GL_RENDERBUFFER_COLOR_SAMPLES_NV = $8E10;

  // GL_NV_geometry_program4
  GL_GEOMETRY_PROGRAM_NV = $8C26;
  GL_MAX_PROGRAM_OUTPUT_VERTICES_NV = $8C27;
  GL_MAX_PROGRAM_TOTAL_OUTPUT_COMPONENTS_NV = $8C28;

  // GL_NV_gpu_program4
  GL_PROGRAM_ATTRIB_COMPONENTS_NV = $8906;
  GL_PROGRAM_RESULT_COMPONENTS_NV = $8907;
  GL_MAX_PROGRAM_ATTRIB_COMPONENTS_NV = $8908;
  GL_MAX_PROGRAM_RESULT_COMPONENTS_NV = $8909;
  GL_MAX_PROGRAM_GENERIC_ATTRIBS_NV = $8DA5;
  GL_MAX_PROGRAM_GENERIC_RESULTS_NV = $8DA6;

  // GL_NV_parameter_buffer_object
  GL_MAX_PROGRAM_PARAMETER_BUFFER_BINDINGS_NV = $8DA0;
  GL_MAX_PROGRAM_PARAMETER_BUFFER_SIZE_NV = $8DA1;
  GL_VERTEX_PROGRAM_PARAMETER_BUFFER_NV = $8DA2;
  GL_GEOMETRY_PROGRAM_PARAMETER_BUFFER_NV = $8DA3;
  GL_FRAGMENT_PROGRAM_PARAMETER_BUFFER_NV = $8DA4;

  // GL_NV_transform_feedback
  GL_TRANSFORM_FEEDBACK_BUFFER_NV = $8C8E;
  GL_TRANSFORM_FEEDBACK_BUFFER_START_NV = $8C84;
  GL_TRANSFORM_FEEDBACK_BUFFER_SIZE_NV = $8C85;
  GL_TRANSFORM_FEEDBACK_RECORD_NV = $8C86;
  GL_TRANSFORM_FEEDBACK_BUFFER_BINDING_NV = $8C8F;
  GL_INTERLEAVED_ATTRIBS_NV = $8C8C;
  GL_SEPARATE_ATTRIBS_NV = $8C8D;
  GL_PRIMITIVES_GENERATED_NV = $8C87;
  GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN_NV = $8C88;
  GL_RASTERIZER_DISCARD_NV = $8C89;
  GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS_NV = $8C8A;
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS_NV = $8C8B;
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS_NV = $8C80;
  GL_TRANSFORM_FEEDBACK_ATTRIBS_NV = $8C7E;
  GL_ACTIVE_VARYINGS_NV = $8C81;
  GL_ACTIVE_VARYING_MAX_LENGTH_NV = $8C82;
  GL_TRANSFORM_FEEDBACK_VARYINGS_NV = $8C83;
  GL_TRANSFORM_FEEDBACK_BUFFER_MODE_NV = $8C7F;
  GL_BACK_PRIMARY_COLOR_NV = $8C77;
  GL_BACK_SECONDARY_COLOR_NV = $8C78;
  GL_TEXTURE_COORD_NV = $8C79;
  GL_CLIP_DISTANCE_NV = $8C7A;
  GL_VERTEX_ID_NV = $8C7B;
  GL_PRIMITIVE_ID_NV = $8C7C;
  GL_GENERIC_ATTRIB_NV = $8C7D;
  GL_LAYER_NV = $8DAA;
  GL_NEXT_BUFFER_NV = -2;
  GL_SKIP_COMPONENTS4_NV = -3;
  GL_SKIP_COMPONENTS3_NV = -4;
  GL_SKIP_COMPONENTS2_NV = -5;
  GL_SKIP_COMPONENTS1_NV = -6;

  // GL_NV_conditional_render
  GL_QUERY_WAIT_NV = $8E13;
  GL_QUERY_NO_WAIT_NV = $8E14;
  GL_QUERY_BY_REGION_WAIT_NV = $8E15;
  GL_QUERY_BY_REGION_NO_WAIT_NV = $8E16;

  // GL_NV_present_video
  GL_FRAME_NV = $8E26;
  GL_FIELDS_NV = $8E27;
  GL_CURRENT_TIME_NV = $8E28;
  GL_NUM_FILL_STREAMS_NV = $8E29;
  GL_PRESENT_TIME_NV = $8E2A;
  GL_PRESENT_DURATION_NV = $8E2B;

  // GL_NV_explicit_multisample
  GL_SAMPLE_POSITION_NV = $8E50;
  GL_SAMPLE_MASK_NV = $8E51;
  GL_SAMPLE_MASK_VALUE_NV = $8E52;
  GL_TEXTURE_BINDING_RENDERBUFFER_NV = $8E53;
  GL_TEXTURE_RENDERBUFFER_DATA_STORE_BINDING_NV = $8E54;
  GL_TEXTURE_RENDERBUFFER_NV = $8E55;
  GL_SAMPLER_RENDERBUFFER_NV = $8E56;
  GL_INT_SAMPLER_RENDERBUFFER_NV = $8E57;
  GL_UNSIGNED_INT_SAMPLER_RENDERBUFFER_NV = $8E58;
  GL_MAX_SAMPLE_MASK_WORDS_NV = $8E59;

  // GL_NV_transform_feedback2
  GL_TRANSFORM_FEEDBACK_NV = $8E22;
  GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED_NV = $8E23;
  GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE_NV = $8E24;
  GL_TRANSFORM_FEEDBACK_BINDING_NV = $8E25;

  // GL_NV_video_capture
  GL_VIDEO_BUFFER_NV = $9020;
  GL_VIDEO_BUFFER_BINDING_NV = $9021;
  GL_FIELD_UPPER_NV = $9022;
  GL_FIELD_LOWER_NV = $9023;
  GL_NUM_VIDEO_CAPTURE_STREAMS_NV = $9024;
  GL_NEXT_VIDEO_CAPTURE_BUFFER_STATUS_NV = $9025;
  GL_VIDEO_CAPTURE_TO_422_SUPPORTED_NV = $9026;
  GL_LAST_VIDEO_CAPTURE_STATUS_NV = $9027;
  GL_VIDEO_BUFFER_PITCH_NV = $9028;
  GL_VIDEO_COLOR_CONVERSION_MATRIX_NV = $9029;
  GL_VIDEO_COLOR_CONVERSION_MAX_NV = $902A;
  GL_VIDEO_COLOR_CONVERSION_MIN_NV = $902B;
  GL_VIDEO_COLOR_CONVERSION_OFFSET_NV = $902C;
  GL_VIDEO_BUFFER_INTERNAL_FORMAT_NV = $902D;
  GL_PARTIAL_SUCCESS_NV = $902E;
  GL_SUCCESS_NV = $902F;
  GL_FAILURE_NV = $9030;
  GL_YCBYCR8_422_NV = $9031;
  GL_YCBAYCR8A_4224_NV = $9032;
  GL_Z6Y10Z6CB10Z6Y10Z6CR10_422_NV = $9033;
  GL_Z6Y10Z6CB10Z6A10Z6Y10Z6CR10Z6A10_4224_NV = $9034;
  GL_Z4Y12Z4CB12Z4Y12Z4CR12_422_NV = $9035;
  GL_Z4Y12Z4CB12Z4A12Z4Y12Z4CR12Z4A12_4224_NV = $9036;
  GL_Z4Y12Z4CB12Z4CR12_444_NV = $9037;
  GL_VIDEO_CAPTURE_FRAME_WIDTH_NV = $9038;
  GL_VIDEO_CAPTURE_FRAME_HEIGHT_NV = $9039;
  GL_VIDEO_CAPTURE_FIELD_UPPER_HEIGHT_NV = $903A;
  GL_VIDEO_CAPTURE_FIELD_LOWER_HEIGHT_NV = $903B;
  GL_VIDEO_CAPTURE_SURFACE_ORIGIN_NV = $903C;

  // GL_NV_shader_buffer_load
  GL_BUFFER_GPU_ADDRESS_NV = $8F1D;
  GL_GPU_ADDRESS_NV = $8F34;
  GL_MAX_SHADER_BUFFER_ADDRESS_NV = $8F35;

  // GL_NV_vertex_buffer_unified_memory
  GL_VERTEX_ATTRIB_ARRAY_UNIFIED_NV = $8F1E;
  GL_ELEMENT_ARRAY_UNIFIED_NV = $8F1F;
  GL_VERTEX_ATTRIB_ARRAY_ADDRESS_NV = $8F20;
  GL_VERTEX_ARRAY_ADDRESS_NV = $8F21;
  GL_NORMAL_ARRAY_ADDRESS_NV = $8F22;
  GL_COLOR_ARRAY_ADDRESS_NV = $8F23;
  GL_INDEX_ARRAY_ADDRESS_NV = $8F24;
  GL_TEXTURE_COORD_ARRAY_ADDRESS_NV = $8F25;
  GL_EDGE_FLAG_ARRAY_ADDRESS_NV = $8F26;
  GL_SECONDARY_COLOR_ARRAY_ADDRESS_NV = $8F27;
  GL_FOG_COORD_ARRAY_ADDRESS_NV = $8F28;
  GL_ELEMENT_ARRAY_ADDRESS_NV = $8F29;
  GL_VERTEX_ATTRIB_ARRAY_LENGTH_NV = $8F2A;
  GL_VERTEX_ARRAY_LENGTH_NV = $8F2B;
  GL_NORMAL_ARRAY_LENGTH_NV = $8F2C;
  GL_COLOR_ARRAY_LENGTH_NV = $8F2D;
  GL_INDEX_ARRAY_LENGTH_NV = $8F2E;
  GL_TEXTURE_COORD_ARRAY_LENGTH_NV = $8F2F;
  GL_EDGE_FLAG_ARRAY_LENGTH_NV = $8F30;
  GL_SECONDARY_COLOR_ARRAY_LENGTH_NV = $8F31;
  GL_FOG_COORD_ARRAY_LENGTH_NV = $8F32;
  GL_ELEMENT_ARRAY_LENGTH_NV = $8F33;
  GL_DRAW_INDIRECT_UNIFIED_NV = $8F40;
  GL_DRAW_INDIRECT_ADDRESS_NV = $8F41;
  GL_DRAW_INDIRECT_LENGTH_NV = $8F42;

  // GL_NV_gpu_program5
  GL_MAX_GEOMETRY_PROGRAM_INVOCATIONS_NV = $8E5A;
  GL_MIN_FRAGMENT_INTERPOLATION_OFFSET_NV = $8E5B;
  GL_MAX_FRAGMENT_INTERPOLATION_OFFSET_NV = $8E5C;
  GL_FRAGMENT_PROGRAM_INTERPOLATION_OFFSET_BITS_NV = $8E5D;
  GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET_NV = $8E5E;
  GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET_NV = $8E5F;
  GL_MAX_PROGRAM_SUBROUTINE_PARAMETERS_NV = $8F44;
  GL_MAX_PROGRAM_SUBROUTINE_NUM_NV = $8F45;

  // GL_NV_gpu_shader5
  GL_INT64_NV = $140E;
  GL_UNSIGNED_INT64_NV = $140F;
  GL_INT8_NV = $8FE0;
  GL_INT8_VEC2_NV = $8FE1;
  GL_INT8_VEC3_NV = $8FE2;
  GL_INT8_VEC4_NV = $8FE3;
  GL_INT16_NV = $8FE4;
  GL_INT16_VEC2_NV = $8FE5;
  GL_INT16_VEC3_NV = $8FE6;
  GL_INT16_VEC4_NV = $8FE7;
  GL_INT64_VEC2_NV = $8FE9;
  GL_INT64_VEC3_NV = $8FEA;
  GL_INT64_VEC4_NV = $8FEB;
  GL_UNSIGNED_INT8_NV = $8FEC;
  GL_UNSIGNED_INT8_VEC2_NV = $8FED;
  GL_UNSIGNED_INT8_VEC3_NV = $8FEE;
  GL_UNSIGNED_INT8_VEC4_NV = $8FEF;
  GL_UNSIGNED_INT16_NV = $8FF0;
  GL_UNSIGNED_INT16_VEC2_NV = $8FF1;
  GL_UNSIGNED_INT16_VEC3_NV = $8FF2;
  GL_UNSIGNED_INT16_VEC4_NV = $8FF3;
  GL_UNSIGNED_INT64_VEC2_NV = $8FF5;
  GL_UNSIGNED_INT64_VEC3_NV = $8FF6;
  GL_UNSIGNED_INT64_VEC4_NV = $8FF7;
  GL_FLOAT16_NV = $8FF8;
  GL_FLOAT16_VEC2_NV = $8FF9;
  GL_FLOAT16_VEC3_NV = $8FFA;
  GL_FLOAT16_VEC4_NV = $8FFB;
  { reuse GL_PATCHES }

  // GL_NV_shader_buffer_store
  GL_SHADER_GLOBAL_ACCESS_BARRIER_BIT_NV = $00000010;
  { reuse GL_READ_WRITE }
  { reuse GL_WRITE_ONLY }

  // GL_NV_tessellation_program5
  GL_MAX_PROGRAM_PATCH_ATTRIBS_NV = $86D8;
  GL_TESS_CONTROL_PROGRAM_NV = $891E;
  GL_TESS_EVALUATION_PROGRAM_NV = $891F;
  GL_TESS_CONTROL_PROGRAM_PARAMETER_BUFFER_NV = $8C74;
  GL_TESS_EVALUATION_PROGRAM_PARAMETER_BUFFER_NV = $8C75;

  // GL_NV_vertex_attrib_integer_64bit
  { reuse GL_INT64_NV }
  { reuse GL_UNSIGNED_INT64_NV }

  // GL_NV_multisample_coverage
  GL_COVERAGE_SAMPLES_NV = $80A9;
  GL_COLOR_SAMPLES_NV = $8E20;

  // GL_NV_vdpau_interop
  GL_SURFACE_STATE_NV = $86EB;
  GL_SURFACE_REGISTERED_NV = $86FD;
  GL_SURFACE_MAPPED_NV = $8700;
  GL_WRITE_DISCARD_NV = $88BE;

  // GL_OML_interlace
  GL_INTERLACE_OML = $8980;
  GL_INTERLACE_READ_OML = $8981;

  // GL_OML_resample
  GL_PACK_RESAMPLE_OML = $8984;
  GL_UNPACK_RESAMPLE_OML = $8985;
  GL_RESAMPLE_REPLICATE_OML = $8986;
  GL_RESAMPLE_ZERO_FILL_OML = $8987;
  GL_RESAMPLE_AVERAGE_OML = $8988;
  GL_RESAMPLE_DECIMATE_OML = $8989;

  // GL_OML_subsample
  GL_FORMAT_SUBSAMPLE_24_24_OML = $8982;
  GL_FORMAT_SUBSAMPLE_244_244_OML = $8983;

  // GL_PGI_misc_hints
  GL_PREFER_DOUBLEBUFFER_HINT_PGI = $1A1F8;
  GL_CONSERVE_MEMORY_HINT_PGI = $1A1FD;
  GL_RECLAIM_MEMORY_HINT_PGI = $1A1FE;
  GL_NATIVE_GRAPHICS_HANDLE_PGI = $1A202;
  GL_NATIVE_GRAPHICS_BEGIN_HINT_PGI = $1A203;
  GL_NATIVE_GRAPHICS_END_HINT_PGI = $1A204;
  GL_ALWAYS_FAST_HINT_PGI = $1A20C;
  GL_ALWAYS_SOFT_HINT_PGI = $1A20D;
  GL_ALLOW_DRAW_OBJ_HINT_PGI = $1A20E;
  GL_ALLOW_DRAW_WIN_HINT_PGI = $1A20F;
  GL_ALLOW_DRAW_FRG_HINT_PGI = $1A210;
  GL_ALLOW_DRAW_MEM_HINT_PGI = $1A211;
  GL_STRICT_DEPTHFUNC_HINT_PGI = $1A216;
  GL_STRICT_LIGHTING_HINT_PGI = $1A217;
  GL_STRICT_SCISSOR_HINT_PGI = $1A218;
  GL_FULL_STIPPLE_HINT_PGI = $1A219;
  GL_CLIP_NEAR_HINT_PGI = $1A220;
  GL_CLIP_FAR_HINT_PGI = $1A221;
  GL_WIDE_LINE_HINT_PGI = $1A222;
  GL_BACK_NORMALS_HINT_PGI = $1A223;

  // GL_PGI_vertex_hints
  GL_VERTEX_DATA_HINT_PGI = $1A22A;
  GL_VERTEX_CONSISTENT_HINT_PGI = $1A22B;
  GL_MATERIAL_SIDE_HINT_PGI = $1A22C;
  GL_MAX_VERTEX_HINT_PGI = $1A22D;
  GL_COLOR3_BIT_PGI = $00010000;
  GL_COLOR4_BIT_PGI = $00020000;
  GL_EDGEFLAG_BIT_PGI = $00040000;
  GL_INDEX_BIT_PGI = $00080000;
  GL_MAT_AMBIENT_BIT_PGI = $00100000;
  GL_MAT_AMBIENT_AND_DIFFUSE_BIT_PGI = $00200000;
  GL_MAT_DIFFUSE_BIT_PGI = $00400000;
  GL_MAT_EMISSION_BIT_PGI = $00800000;
  GL_MAT_COLOR_INDEXES_BIT_PGI = $01000000;
  GL_MAT_SHININESS_BIT_PGI = $02000000;
  GL_MAT_SPECULAR_BIT_PGI = $04000000;
  GL_NORMAL_BIT_PGI = $08000000;
  GL_TEXCOORD1_BIT_PGI = $10000000;
  GL_TEXCOORD2_BIT_PGI = $20000000;
  GL_TEXCOORD3_BIT_PGI = $40000000;
  GL_TEXCOORD4_BIT_PGI = $80000000;
  GL_VERTEX23_BIT_PGI = $00000004;
  GL_VERTEX4_BIT_PGI = $00000008;

  // GL_REND_screen_coordinates
  GL_SCREEN_COORDINATES_REND = $8490;
  GL_INVERTED_SCREEN_W_REND = $8491;

  // GL_S3_s3tc
  GL_RGB_S3TC = $83A0;
  GL_RGB4_S3TC = $83A1;
  GL_RGBA_S3TC = $83A2;
  GL_RGBA4_S3TC = $83A3;

  // GL_SGIS_detail_texture
  GL_DETAIL_TEXTURE_2D_SGIS = $8095;
  GL_DETAIL_TEXTURE_2D_BINDING_SGIS = $8096;
  GL_LINEAR_DETAIL_SGIS = $8097;
  GL_LINEAR_DETAIL_ALPHA_SGIS = $8098;
  GL_LINEAR_DETAIL_COLOR_SGIS = $8099;
  GL_DETAIL_TEXTURE_LEVEL_SGIS = $809A;
  GL_DETAIL_TEXTURE_MODE_SGIS = $809B;
  GL_DETAIL_TEXTURE_FUNC_POINTS_SGIS = $809C;

  // GL_SGIS_fog_function
  GL_FOG_FUNC_SGIS = $812A;
  GL_FOG_FUNC_POINTS_SGIS = $812B;
  GL_MAX_FOG_FUNC_POINTS_SGIS = $812C;

  // GL_SGIS_generate_mipmap
  GL_GENERATE_MIPMAP_SGIS = $8191;
  GL_GENERATE_MIPMAP_HINT_SGIS = $8192;

  // GL_SGIS_multisample
  GL_MULTISAMPLE_SGIS = $809D;
  GL_SAMPLE_ALPHA_TO_MASK_SGIS = $809E;
  GL_SAMPLE_ALPHA_TO_ONE_SGIS = $809F;
  GL_SAMPLE_MASK_SGIS = $80A0;
  GL_1PASS_SGIS = $80A1;
  GL_2PASS_0_SGIS = $80A2;
  GL_2PASS_1_SGIS = $80A3;
  GL_4PASS_0_SGIS = $80A4;
  GL_4PASS_1_SGIS = $80A5;
  GL_4PASS_2_SGIS = $80A6;
  GL_4PASS_3_SGIS = $80A7;
  GL_SAMPLE_BUFFERS_SGIS = $80A8;
  GL_SAMPLES_SGIS = $80A9;
  GL_SAMPLE_MASK_VALUE_SGIS = $80AA;
  GL_SAMPLE_MASK_INVERT_SGIS = $80AB;
  GL_SAMPLE_PATTERN_SGIS = $80AC;

  // GL_SGIS_pixel_texture
  GL_PIXEL_TEXTURE_SGIS = $8353;
  GL_PIXEL_FRAGMENT_RGB_SOURCE_SGIS = $8354;
  GL_PIXEL_FRAGMENT_ALPHA_SOURCE_SGIS = $8355;
  GL_PIXEL_GROUP_COLOR_SGIS = $8356;

  // GL_SGIS_point_line_texgen
  GL_EYE_DISTANCE_TO_POINT_SGIS = $81F0;
  GL_OBJECT_DISTANCE_TO_POINT_SGIS = $81F1;
  GL_EYE_DISTANCE_TO_LINE_SGIS = $81F2;
  GL_OBJECT_DISTANCE_TO_LINE_SGIS = $81F3;
  GL_EYE_POINT_SGIS = $81F4;
  GL_OBJECT_POINT_SGIS = $81F5;
  GL_EYE_LINE_SGIS = $81F6;
  GL_OBJECT_LINE_SGIS = $81F7;

  // GL_SGIS_point_parameters
  GL_POINT_SIZE_MIN_SGIS = $8126;
  GL_POINT_SIZE_MAX_SGIS = $8127;
  GL_POINT_FADE_THRESHOLD_SIZE_SGIS = $8128;
  GL_DISTANCE_ATTENUATION_SGIS = $8129;

  // GL_SGIS_sharpen_texture
  GL_LINEAR_SHARPEN_SGIS = $80AD;
  GL_LINEAR_SHARPEN_ALPHA_SGIS = $80AE;
  GL_LINEAR_SHARPEN_COLOR_SGIS = $80AF;
  GL_SHARPEN_TEXTURE_FUNC_POINTS_SGIS = $80B0;

  // GL_SGIS_texture4D
  GL_PACK_SKIP_VOLUMES_SGIS = $8130;
  GL_PACK_IMAGE_DEPTH_SGIS = $8131;
  GL_UNPACK_SKIP_VOLUMES_SGIS = $8132;
  GL_UNPACK_IMAGE_DEPTH_SGIS = $8133;
  GL_TEXTURE_4D_SGIS = $8134;
  GL_PROXY_TEXTURE_4D_SGIS = $8135;
  GL_TEXTURE_4DSIZE_SGIS = $8136;
  GL_TEXTURE_WRAP_Q_SGIS = $8137;
  GL_MAX_4D_TEXTURE_SIZE_SGIS = $8138;
  GL_TEXTURE_4D_BINDING_SGIS = $814F;

  // GL_SGIS_texture_color_mask
  GL_TEXTURE_COLOR_WRITEMASK_SGIS = $81EF;

  // GL_SGIS_texture_edge_clamp
  GL_CLAMP_TO_EDGE_SGIS = $812F;

  // GL_SGIS_texture_filter4
  GL_FILTER4_SGIS = $8146;
  GL_TEXTURE_FILTER4_SIZE_SGIS = $8147;

  // GL_SGIS_texture_lod
  GL_TEXTURE_MIN_LOD_SGIS = $813A;
  GL_TEXTURE_MAX_LOD_SGIS = $813B;
  GL_TEXTURE_BASE_LEVEL_SGIS = $813C;
  GL_TEXTURE_MAX_LEVEL_SGIS = $813D;

  // GL_SGIS_texture_select
  GL_DUAL_ALPHA4_SGIS = $8110;
  GL_DUAL_ALPHA8_SGIS = $8111;
  GL_DUAL_ALPHA12_SGIS = $8112;
  GL_DUAL_ALPHA16_SGIS = $8113;
  GL_DUAL_LUMINANCE4_SGIS = $8114;
  GL_DUAL_LUMINANCE8_SGIS = $8115;
  GL_DUAL_LUMINANCE12_SGIS = $8116;
  GL_DUAL_LUMINANCE16_SGIS = $8117;
  GL_DUAL_INTENSITY4_SGIS = $8118;
  GL_DUAL_INTENSITY8_SGIS = $8119;
  GL_DUAL_INTENSITY12_SGIS = $811A;
  GL_DUAL_INTENSITY16_SGIS = $811B;
  GL_DUAL_LUMINANCE_ALPHA4_SGIS = $811C;
  GL_DUAL_LUMINANCE_ALPHA8_SGIS = $811D;
  GL_QUAD_ALPHA4_SGIS = $811E;
  GL_QUAD_ALPHA8_SGIS = $811F;
  GL_QUAD_LUMINANCE4_SGIS = $8120;
  GL_QUAD_LUMINANCE8_SGIS = $8121;
  GL_QUAD_INTENSITY4_SGIS = $8122;
  GL_QUAD_INTENSITY8_SGIS = $8123;
  GL_DUAL_TEXTURE_SELECT_SGIS = $8124;
  GL_QUAD_TEXTURE_SELECT_SGIS = $8125;

  // GL_SGIX_async
  GL_ASYNC_MARKER_SGIX = $8329;

  // GL_SGIX_async_histogram
  GL_ASYNC_HISTOGRAM_SGIX = $832C;
  GL_MAX_ASYNC_HISTOGRAM_SGIX = $832D;

  // GL_SGIX_async_pixel
  GL_ASYNC_TEX_IMAGE_SGIX = $835C;
  GL_ASYNC_DRAW_PIXELS_SGIX = $835D;
  GL_ASYNC_READ_PIXELS_SGIX = $835E;
  GL_MAX_ASYNC_TEX_IMAGE_SGIX = $835F;
  GL_MAX_ASYNC_DRAW_PIXELS_SGIX = $8360;
  GL_MAX_ASYNC_READ_PIXELS_SGIX = $8361;

  // GL_SGIX_blend_alpha_minmax
  GL_ALPHA_MIN_SGIX = $8320;
  GL_ALPHA_MAX_SGIX = $8321;

  // GL_SGIX_calligraphic_fragment
  GL_CALLIGRAPHIC_FRAGMENT_SGIX = $8183;

  // GL_SGIX_clipmap
  GL_LINEAR_CLIPMAP_LINEAR_SGIX = $8170;
  GL_TEXTURE_CLIPMAP_CENTER_SGIX = $8171;
  GL_TEXTURE_CLIPMAP_FRAME_SGIX = $8172;
  GL_TEXTURE_CLIPMAP_OFFSET_SGIX = $8173;
  GL_TEXTURE_CLIPMAP_VIRTUAL_DEPTH_SGIX = $8174;
  GL_TEXTURE_CLIPMAP_LOD_OFFSET_SGIX = $8175;
  GL_TEXTURE_CLIPMAP_DEPTH_SGIX = $8176;
  GL_MAX_CLIPMAP_DEPTH_SGIX = $8177;
  GL_MAX_CLIPMAP_VIRTUAL_DEPTH_SGIX = $8178;
  GL_NEAREST_CLIPMAP_NEAREST_SGIX = $844D;
  GL_NEAREST_CLIPMAP_LINEAR_SGIX = $844E;
  GL_LINEAR_CLIPMAP_NEAREST_SGIX = $844F;

  // GL_SGIX_convolution_accuracy
  GL_CONVOLUTION_HINT_SGIX = $8316;

  // GL_SGIX_depth_texture
  GL_DEPTH_COMPONENT16_SGIX = $81A5;
  GL_DEPTH_COMPONENT24_SGIX = $81A6;
  GL_DEPTH_COMPONENT32_SGIX = $81A7;

  // GL_SGIX_fog_offset
  GL_FOG_OFFSET_SGIX = $8198;
  GL_FOG_OFFSET_VALUE_SGIX = $8199;

  // GL_SGIX_fog_scale
  GL_FOG_SCALE_SGIX = $81FC;
  GL_FOG_SCALE_VALUE_SGIX = $81FD;

  // GL_SGIX_fragment_lighting
  GL_FRAGMENT_LIGHTING_SGIX = $8400;
  GL_FRAGMENT_COLOR_MATERIAL_SGIX = $8401;
  GL_FRAGMENT_COLOR_MATERIAL_FACE_SGIX = $8402;
  GL_FRAGMENT_COLOR_MATERIAL_PARAMETER_SGIX = $8403;
  GL_MAX_FRAGMENT_LIGHTS_SGIX = $8404;
  GL_MAX_ACTIVE_LIGHTS_SGIX = $8405;
  GL_CURRENT_RASTER_NORMAL_SGIX = $8406;
  GL_LIGHT_ENV_MODE_SGIX = $8407;
  GL_FRAGMENT_LIGHT_MODEL_LOCAL_VIEWER_SGIX = $8408;
  GL_FRAGMENT_LIGHT_MODEL_TWO_SIDE_SGIX = $8409;
  GL_FRAGMENT_LIGHT_MODEL_AMBIENT_SGIX = $840A;
  GL_FRAGMENT_LIGHT_MODEL_NORMAL_INTERPOLATION_SGIX = $840B;
  GL_FRAGMENT_LIGHT0_SGIX = $840C;
  GL_FRAGMENT_LIGHT1_SGIX = $840D;
  GL_FRAGMENT_LIGHT2_SGIX = $840E;
  GL_FRAGMENT_LIGHT3_SGIX = $840F;
  GL_FRAGMENT_LIGHT4_SGIX = $8410;
  GL_FRAGMENT_LIGHT5_SGIX = $8411;
  GL_FRAGMENT_LIGHT6_SGIX = $8412;
  GL_FRAGMENT_LIGHT7_SGIX = $8413;

  // GL_SGIX_framezoom
  GL_FRAMEZOOM_SGIX = $818B;
  GL_FRAMEZOOM_FACTOR_SGIX = $818C;
  GL_MAX_FRAMEZOOM_FACTOR_SGIX = $818D;

  // GL_SGIX_impact_pixel_texture
  GL_PIXEL_TEX_GEN_Q_CEILING_SGIX = $8184;
  GL_PIXEL_TEX_GEN_Q_ROUND_SGIX = $8185;
  GL_PIXEL_TEX_GEN_Q_FLOOR_SGIX = $8186;
  GL_PIXEL_TEX_GEN_ALPHA_REPLACE_SGIX = $8187;
  GL_PIXEL_TEX_GEN_ALPHA_NO_REPLACE_SGIX = $8188;
  GL_PIXEL_TEX_GEN_ALPHA_LS_SGIX = $8189;
  GL_PIXEL_TEX_GEN_ALPHA_MS_SGIX = $818A;

  // GL_SGIX_instruments
  GL_INSTRUMENT_BUFFER_POINTER_SGIX = $8180;
  GL_INSTRUMENT_MEASUREMENTS_SGIX = $8181;

  // GL_SGIX_interlace
  GL_INTERLACE_SGIX = $8094;

  // GL_SGIX_ir_instrument1
  GL_IR_INSTRUMENT1_SGIX = $817F;

  // GL_SGIX_list_priority
  GL_LIST_PRIORITY_SGIX = $8182;

  // GL_SGIX_pixel_texture
  GL_PIXEL_TEX_GEN_SGIX = $8139;
  GL_PIXEL_TEX_GEN_MODE_SGIX = $832B;

  // GL_SGIX_pixel_tiles
  GL_PIXEL_TILE_BEST_ALIGNMENT_SGIX = $813E;
  GL_PIXEL_TILE_CACHE_INCREMENT_SGIX = $813F;
  GL_PIXEL_TILE_WIDTH_SGIX = $8140;
  GL_PIXEL_TILE_HEIGHT_SGIX = $8141;
  GL_PIXEL_TILE_GRID_WIDTH_SGIX = $8142;
  GL_PIXEL_TILE_GRID_HEIGHT_SGIX = $8143;
  GL_PIXEL_TILE_GRID_DEPTH_SGIX = $8144;
  GL_PIXEL_TILE_CACHE_SIZE_SGIX = $8145;

  // GL_SGIX_polynomial_ffd
  GL_GEOMETRY_DEFORMATION_SGIX = $8194;
  GL_TEXTURE_DEFORMATION_SGIX = $8195;
  GL_DEFORMATIONS_MASK_SGIX = $8196;
  GL_MAX_DEFORMATION_ORDER_SGIX = $8197;

  // GL_SGIX_reference_plane
  GL_REFERENCE_PLANE_SGIX = $817D;
  GL_REFERENCE_PLANE_EQUATION_SGIX = $817E;

  // GL_SGIX_resample
  GL_PACK_RESAMPLE_SGIX = $842C;
  GL_UNPACK_RESAMPLE_SGIX = $842D;
  GL_RESAMPLE_REPLICATE_SGIX = $842E;
  GL_RESAMPLE_ZERO_FILL_SGIX = $842F;
  GL_RESAMPLE_DECIMATE_SGIX = $8430;

  // GL_SGIX_scalebias_hint
  GL_SCALEBIAS_HINT_SGIX = $8322;

  // GL_SGIX_shadow
  GL_TEXTURE_COMPARE_SGIX = $819A;
  GL_TEXTURE_COMPARE_OPERATOR_SGIX = $819B;
  GL_TEXTURE_LEQUAL_R_SGIX = $819C;
  GL_TEXTURE_GEQUAL_R_SGIX = $819D;

  // GL_SGIX_shadow_ambient
  GL_SHADOW_AMBIENT_SGIX = $80BF;

  // GL_SGIX_sprite
  GL_SPRITE_SGIX = $8148;
  GL_SPRITE_MODE_SGIX = $8149;
  GL_SPRITE_AXIS_SGIX = $814A;
  GL_SPRITE_TRANSLATION_SGIX = $814B;
  GL_SPRITE_AXIAL_SGIX = $814C;
  GL_SPRITE_OBJECT_ALIGNED_SGIX = $814D;
  GL_SPRITE_EYE_ALIGNED_SGIX = $814E;

  // GL_SGIX_subsample
  GL_PACK_SUBSAMPLE_RATE_SGIX = $85A0;
  GL_UNPACK_SUBSAMPLE_RATE_SGIX = $85A1;
  GL_PIXEL_SUBSAMPLE_4444_SGIX = $85A2;
  GL_PIXEL_SUBSAMPLE_2424_SGIX = $85A3;
  GL_PIXEL_SUBSAMPLE_4242_SGIX = $85A4;

  // GL_SGIX_texture_add_env
  GL_TEXTURE_ENV_BIAS_SGIX = $80BE;

  // GL_SGIX_texture_coordinate_clamp
  GL_TEXTURE_MAX_CLAMP_S_SGIX = $8369;
  GL_TEXTURE_MAX_CLAMP_T_SGIX = $836A;
  GL_TEXTURE_MAX_CLAMP_R_SGIX = $836B;

  // GL_SGIX_texture_lod_bias
  GL_TEXTURE_LOD_BIAS_S_SGIX = $818E;
  GL_TEXTURE_LOD_BIAS_T_SGIX = $818F;
  GL_TEXTURE_LOD_BIAS_R_SGIX = $8190;

  // GL_SGIX_texture_multi_buffer
  GL_TEXTURE_MULTI_BUFFER_HINT_SGIX = $812E;

  // GL_SGIX_texture_scale_bias
  GL_POST_TEXTURE_FILTER_BIAS_SGIX = $8179;
  GL_POST_TEXTURE_FILTER_SCALE_SGIX = $817A;
  GL_POST_TEXTURE_FILTER_BIAS_RANGE_SGIX = $817B;
  GL_POST_TEXTURE_FILTER_SCALE_RANGE_SGIX = $817C;

  // GL_SGIX_vertex_preclip
  GL_VERTEX_PRECLIP_SGIX = $83EE;
  GL_VERTEX_PRECLIP_HINT_SGIX = $83EF;

  // GL_SGIX_ycrcb
  GL_YCRCB_422_SGIX = $81BB;
  GL_YCRCB_444_SGIX = $81BC;

  // GL_SGIX_ycrcba
  GL_YCRCB_SGIX = $8318;
  GL_YCRCBA_SGIX = $8319;

  // GL_SGI_color_matrix
  GL_COLOR_MATRIX_SGI = $80B1;
  GL_COLOR_MATRIX_STACK_DEPTH_SGI = $80B2;
  GL_MAX_COLOR_MATRIX_STACK_DEPTH_SGI = $80B3;
  GL_POST_COLOR_MATRIX_RED_SCALE_SGI = $80B4;
  GL_POST_COLOR_MATRIX_GREEN_SCALE_SGI = $80B5;
  GL_POST_COLOR_MATRIX_BLUE_SCALE_SGI = $80B6;
  GL_POST_COLOR_MATRIX_ALPHA_SCALE_SGI = $80B7;
  GL_POST_COLOR_MATRIX_RED_BIAS_SGI = $80B8;
  GL_POST_COLOR_MATRIX_GREEN_BIAS_SGI = $80B9;
  GL_POST_COLOR_MATRIX_BLUE_BIAS_SGI = $80BA;
  GL_POST_COLOR_MATRIX_ALPHA_BIAS_SGI = $80BB;

  // GL_SGI_color_table
  GL_COLOR_TABLE_SGI = $80D0;
  GL_POST_CONVOLUTION_COLOR_TABLE_SGI = $80D1;
  GL_POST_COLOR_MATRIX_COLOR_TABLE_SGI = $80D2;
  GL_PROXY_COLOR_TABLE_SGI = $80D3;
  GL_PROXY_POST_CONVOLUTION_COLOR_TABLE_SGI = $80D4;
  GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE_SGI = $80D5;
  GL_COLOR_TABLE_SCALE_SGI = $80D6;
  GL_COLOR_TABLE_BIAS_SGI = $80D7;
  GL_COLOR_TABLE_FORMAT_SGI = $80D8;
  GL_COLOR_TABLE_WIDTH_SGI = $80D9;
  GL_COLOR_TABLE_RED_SIZE_SGI = $80DA;
  GL_COLOR_TABLE_GREEN_SIZE_SGI = $80DB;
  GL_COLOR_TABLE_BLUE_SIZE_SGI = $80DC;
  GL_COLOR_TABLE_ALPHA_SIZE_SGI = $80DD;
  GL_COLOR_TABLE_LUMINANCE_SIZE_SGI = $80DE;
  GL_COLOR_TABLE_INTENSITY_SIZE_SGI = $80DF;

  // GL_SGI_depth_pass_instrument
  GL_DEPTH_PASS_INSTRUMENT_SGIX = $8310;
  GL_DEPTH_PASS_INSTRUMENT_COUNTERS_SGIX = $8311;
  GL_DEPTH_PASS_INSTRUMENT_MAX_SGIX = $8312;

  // GL_SGI_texture_color_table
  GL_TEXTURE_COLOR_TABLE_SGI = $80BC;
  GL_PROXY_TEXTURE_COLOR_TABLE_SGI = $80BD;

  // GL_SUNX_constant_data
  GL_UNPACK_CONSTANT_DATA_SUNX = $81D5;
  GL_TEXTURE_CONSTANT_DATA_SUNX = $81D6;

  // GL_SUN_convolution_border_modes
  GL_WRAP_BORDER_SUN = $81D4;

  // GL_SUN_global_alpha
  GL_GLOBAL_ALPHA_SUN = $81D9;
  GL_GLOBAL_ALPHA_FACTOR_SUN = $81DA;

  // GL_SUN_mesh_array
  GL_QUAD_MESH_SUN = $8614;
  GL_TRIANGLE_MESH_SUN = $8615;

  // GL_SUN_slice_accum
  GL_SLICE_ACCUM_SUN = $85CC;

  // GL_SUN_triangle_list
  GL_RESTART_SUN = $0001;
  GL_REPLACE_MIDDLE_SUN = $0002;
  GL_REPLACE_OLDEST_SUN = $0003;
  GL_TRIANGLE_LIST_SUN = $81D7;
  GL_REPLACEMENT_CODE_SUN = $81D8;
  GL_REPLACEMENT_CODE_ARRAY_SUN = $85C0;
  GL_REPLACEMENT_CODE_ARRAY_TYPE_SUN = $85C1;
  GL_REPLACEMENT_CODE_ARRAY_STRIDE_SUN = $85C2;
  GL_REPLACEMENT_CODE_ARRAY_POINTER_SUN = $85C3;
  GL_R1UI_V3F_SUN = $85C4;
  GL_R1UI_C4UB_V3F_SUN = $85C5;
  GL_R1UI_C3F_V3F_SUN = $85C6;
  GL_R1UI_N3F_V3F_SUN = $85C7;
  GL_R1UI_C4F_N3F_V3F_SUN = $85C8;
  GL_R1UI_T2F_V3F_SUN = $85C9;
  GL_R1UI_T2F_N3F_V3F_SUN = $85CA;
  GL_R1UI_T2F_C4F_N3F_V3F_SUN = $85CB;

  // GL_WIN_phong_shading
  GL_PHONG_WIN = $80EA;
  GL_PHONG_HINT_WIN = $80EB;

  // GL_WIN_specular_fog
  GL_FOG_SPECULAR_TEXTURE_WIN = $80EC;

  // GL_ARB_vertex_shader
  GL_VERTEX_SHADER_ARB = $8B31;
  GL_MAX_VERTEX_UNIFORM_COMPONENTS_ARB = $8B4A;
  GL_MAX_VARYING_FLOATS_ARB = $8B4B;
  GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS_ARB = $8B4C;
  GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS_ARB = $8B4D;
  GL_OBJECT_ACTIVE_ATTRIBUTES_ARB = $8B89;
  GL_OBJECT_ACTIVE_ATTRIBUTE_MAX_LENGTH_ARB = $8B8A;

  // GL_KHR_blend_equation_advanced
  GL_MULTIPLY_KHR = $9294;
  GL_SCREEN_KHR = $9295;
  GL_OVERLAY_KHR = $9296;
  GL_DARKEN_KHR = $9297;
  GL_LIGHTEN_KHR = $9298;
  GL_COLORDODGE_KHR = $9299;
  GL_COLORBURN_KHR = $929A;
  GL_HARDLIGHT_KHR = $929B;
  GL_SOFTLIGHT_KHR = $929C;
  GL_DIFFERENCE_KHR = $929E;
  GL_EXCLUSION_KHR = $92A0;
  GL_HSL_HUE_KHR = $92AD;
  GL_HSL_SATURATION_KHR = $92AE;
  GL_HSL_COLOR_KHR = $92AF;
  GL_HSL_LUMINOSITY_KHR = $92B0;

  // GL_KHR_blend_equation_advanced_coherent
  GL_BLEND_ADVANCED_COHERENT_KHR = $9285;

  // GL_KHR_robustness
  GL_CONTEXT_ROBUST_ACCESS = $90F3;

  // GL_ARB_fragment_shader
  GL_FRAGMENT_SHADER_ARB = $8B30;
  GL_MAX_FRAGMENT_UNIFORM_COMPONENTS_ARB = $8B49; // 1.4
  GL_FRAGMENT_SHADER_DERIVATIVE_HINT_ARB = $8B8B; // 1.4

  // GL_ARB_occlusion_query
  GL_SAMPLES_PASSED_ARB = $8914;
  GL_QUERY_COUNTER_BITS_ARB = $8864;
  GL_CURRENT_QUERY_ARB = $8865;
  GL_QUERY_RESULT_ARB = $8866;
  GL_QUERY_RESULT_AVAILABLE_ARB = $8867;

  // GL_ARB_pipeline_statistics_query
  GL_VERTICES_SUBMITTED_ARB         = $82EE;
  GL_PRIMITIVES_SUBMITTED_ARB       = $82EF;
  GL_VERTEX_SHADER_INVOCATIONS_ARB  = $82F0;
  GL_TESS_CONTROL_SHADER_PATCHES_ARB = $82F1;
  GL_TESS_EVALUATION_SHADER_INVOCATIONS_ARB = $82F2;
  GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED_ARB = $82F3;
  GL_FRAGMENT_SHADER_INVOCATIONS_ARB = $82F4;
  GL_COMPUTE_SHADER_INVOCATIONS_ARB = $82F5;
  GL_CLIPPING_INPUT_PRIMITIVES_ARB  = $82F6;
  GL_CLIPPING_OUTPUT_PRIMITIVES_ARB = $82F7;

  // GL_ARB_point_sprite
  GL_POINT_SPRITE_ARB = $8861;
  GL_COORD_REPLACE_ARB = $8862;

  // GL_ARB_shading_language_100
  GL_SHADING_LANGUAGE_VERSION_ARB = $8B8C; // 1.4

  // GL_ARB_shader_objects
  GL_PROGRAM_OBJECT_ARB = $8B40;

  GL_OBJECT_TYPE_ARB = $8B4E;
  GL_OBJECT_SUBTYPE_ARB = $8B4F;
  GL_OBJECT_DELETE_STATUS_ARB = $8B80;
  GL_OBJECT_COMPILE_STATUS_ARB = $8B81;
  GL_OBJECT_LINK_STATUS_ARB = $8B82;
  GL_OBJECT_VALIDATE_STATUS_ARB = $8B83;
  GL_OBJECT_INFO_LOG_LENGTH_ARB = $8B84;
  GL_OBJECT_ATTACHED_OBJECTS_ARB = $8B85;
  GL_OBJECT_ACTIVE_UNIFORMS_ARB = $8B86;
  GL_OBJECT_ACTIVE_UNIFORM_MAX_LENGTH_ARB = $8B87;
  GL_OBJECT_SHADER_SOURCE_LENGTH_ARB = $8B88;

  GL_SHADER_OBJECT_ARB = $8B48;

  GL_FLOAT_VEC2_ARB = $8B50;
  GL_FLOAT_VEC3_ARB = $8B51;
  GL_FLOAT_VEC4_ARB = $8B52;
  GL_INT_VEC2_ARB = $8B53;
  GL_INT_VEC3_ARB = $8B54;
  GL_INT_VEC4_ARB = $8B55;
  GL_BOOL_ARB = $8B56;
  GL_BOOL_VEC2_ARB = $8B57;
  GL_BOOL_VEC3_ARB = $8B58;
  GL_BOOL_VEC4_ARB = $8B59;
  GL_FLOAT_MAT2_ARB = $8B5A;
  GL_FLOAT_MAT3_ARB = $8B5B;
  GL_FLOAT_MAT4_ARB = $8B5C;
  GL_SAMPLER_1D_ARB = $8B5D;
  GL_SAMPLER_2D_ARB = $8B5E;
  GL_SAMPLER_3D_ARB = $8B5F;
  GL_SAMPLER_CUBE_ARB = $8B60;
  GL_SAMPLER_1D_SHADOW_ARB = $8B61;
  GL_SAMPLER_2D_SHADOW_ARB = $8B62;
  GL_SAMPLER_2D_RECT_ARB = $8B63;
  GL_SAMPLER_2D_RECT_SHADOW_ARB = $8B64;

  // WGL_3DFX_multisample
  WGL_SAMPLE_BUFFERS_3DFX = $2060;
  WGL_SAMPLES_3DFX = $2061;

  // WGL_ARB_buffer_region
  WGL_FRONT_COLOR_BUFFER_BIT_ARB = $00000001;
  WGL_BACK_COLOR_BUFFER_BIT_ARB = $00000002;
  WGL_DEPTH_BUFFER_BIT_ARB = $00000004;
  WGL_STENCIL_BUFFER_BIT_ARB = $00000008;

  // WGL_ARB_context_flush_control
  WGL_CONTEXT_RELEASE_BEHAVIOR_ARB = $2097;
  WGL_CONTEXT_RELEASE_BEHAVIOR_NONE_ARB = 0;
  WGL_CONTEXT_RELEASE_BEHAVIOR_FLUSH_ARB = $2098;

  // WGL_ARB_make_current_read
  ERROR_INVALID_PIXEL_TYPE_ARB = $2043;
  ERROR_INCOMPATIBLE_DEVICE_CONTEXTS_ARB = $2054;

  // WGL_ARB_multisample
  WGL_SAMPLE_BUFFERS_ARB = $2041;
  WGL_SAMPLES_ARB = $2042;

  // WGL_ARB_pbuffer
  WGL_DRAW_TO_PBUFFER_ARB = $202D;
  WGL_MAX_PBUFFER_PIXELS_ARB = $202E;
  WGL_MAX_PBUFFER_WIDTH_ARB = $202F;
  WGL_MAX_PBUFFER_HEIGHT_ARB = $2030;
  WGL_PBUFFER_LARGEST_ARB = $2033;
  WGL_PBUFFER_WIDTH_ARB = $2034;
  WGL_PBUFFER_HEIGHT_ARB = $2035;
  WGL_PBUFFER_LOST_ARB = $2036;

  // WGL_ARB_pixel_format
  WGL_NUMBER_PIXEL_FORMATS_ARB = $2000;
  WGL_DRAW_TO_WINDOW_ARB = $2001;
  WGL_DRAW_TO_BITMAP_ARB = $2002;
  WGL_ACCELERATION_ARB = $2003;
  WGL_NEED_PALETTE_ARB = $2004;
  WGL_NEED_SYSTEM_PALETTE_ARB = $2005;
  WGL_SWAP_LAYER_BUFFERS_ARB = $2006;
  WGL_SWAP_METHOD_ARB = $2007;
  WGL_NUMBER_OVERLAYS_ARB = $2008;
  WGL_NUMBER_UNDERLAYS_ARB = $2009;
  WGL_TRANSPARENT_ARB = $200A;
  WGL_TRANSPARENT_RED_VALUE_ARB = $2037;
  WGL_TRANSPARENT_GREEN_VALUE_ARB = $2038;
  WGL_TRANSPARENT_BLUE_VALUE_ARB = $2039;
  WGL_TRANSPARENT_ALPHA_VALUE_ARB = $203A;
  WGL_TRANSPARENT_INDEX_VALUE_ARB = $203B;
  WGL_SHARE_DEPTH_ARB = $200C;
  WGL_SHARE_STENCIL_ARB = $200D;
  WGL_SHARE_ACCUM_ARB = $200E;
  WGL_SUPPORT_GDI_ARB = $200F;
  WGL_SUPPORT_OPENGL_ARB = $2010;
  WGL_DOUBLE_BUFFER_ARB = $2011;
  WGL_STEREO_ARB = $2012;
  WGL_PIXEL_TYPE_ARB = $2013;
  WGL_COLOR_BITS_ARB = $2014;
  WGL_RED_BITS_ARB = $2015;
  WGL_RED_SHIFT_ARB = $2016;
  WGL_GREEN_BITS_ARB = $2017;
  WGL_GREEN_SHIFT_ARB = $2018;
  WGL_BLUE_BITS_ARB = $2019;
  WGL_BLUE_SHIFT_ARB = $201A;
  WGL_ALPHA_BITS_ARB = $201B;
  WGL_ALPHA_SHIFT_ARB = $201C;
  WGL_ACCUM_BITS_ARB = $201D;
  WGL_ACCUM_RED_BITS_ARB = $201E;
  WGL_ACCUM_GREEN_BITS_ARB = $201F;
  WGL_ACCUM_BLUE_BITS_ARB = $2020;
  WGL_ACCUM_ALPHA_BITS_ARB = $2021;
  WGL_DEPTH_BITS_ARB = $2022;
  WGL_STENCIL_BITS_ARB = $2023;
  WGL_AUX_BUFFERS_ARB = $2024;
  WGL_NO_ACCELERATION_ARB = $2025;
  WGL_GENERIC_ACCELERATION_ARB = $2026;
  WGL_FULL_ACCELERATION_ARB = $2027;
  WGL_SWAP_EXCHANGE_ARB = $2028;
  WGL_SWAP_COPY_ARB = $2029;
  WGL_SWAP_UNDEFINED_ARB = $202A;
  WGL_TYPE_RGBA_ARB = $202B;
  WGL_TYPE_COLORINDEX_ARB = $202C;

  // WGL_ARB_pixel_format_float
  WGL_RGBA_FLOAT_MODE_ARB = $8820;
  WGL_CLAMP_VERTEX_COLOR_ARB = $891A;
  WGL_CLAMP_FRAGMENT_COLOR_ARB = $891B;
  WGL_CLAMP_READ_COLOR_ARB = $891C;
  WGL_FIXED_ONLY_ARB = $891D;

  // WGL_ARB_render_texture
  WGL_BIND_TO_TEXTURE_RGB_ARB = $2070;
  WGL_BIND_TO_TEXTURE_RGBA_ARB = $2071;
  WGL_TEXTURE_FORMAT_ARB = $2072;
  WGL_TEXTURE_TARGET_ARB = $2073;
  WGL_MIPMAP_TEXTURE_ARB = $2074;
  WGL_TEXTURE_RGB_ARB = $2075;
  WGL_TEXTURE_RGBA_ARB = $2076;
  WGL_NO_TEXTURE_ARB = $2077;
  WGL_TEXTURE_CUBE_MAP_ARB = $2078;
  WGL_TEXTURE_1D_ARB = $2079;
  WGL_TEXTURE_2D_ARB = $207A;
  WGL_MIPMAP_LEVEL_ARB = $207B;
  WGL_CUBE_MAP_FACE_ARB = $207C;
  WGL_TEXTURE_CUBE_MAP_POSITIVE_X_ARB = $207D;
  WGL_TEXTURE_CUBE_MAP_NEGATIVE_X_ARB = $207E;
  WGL_TEXTURE_CUBE_MAP_POSITIVE_Y_ARB = $207F;
  WGL_TEXTURE_CUBE_MAP_NEGATIVE_Y_ARB = $2080;
  WGL_TEXTURE_CUBE_MAP_POSITIVE_Z_ARB = $2081;
  WGL_TEXTURE_CUBE_MAP_NEGATIVE_Z_ARB = $2082;
  WGL_FRONT_LEFT_ARB = $2083;
  WGL_FRONT_RIGHT_ARB = $2084;
  WGL_BACK_LEFT_ARB = $2085;
  WGL_BACK_RIGHT_ARB = $2086;
  WGL_AUX0_ARB = $2087;
  WGL_AUX1_ARB = $2088;
  WGL_AUX2_ARB = $2089;
  WGL_AUX3_ARB = $208A;
  WGL_AUX4_ARB = $208B;
  WGL_AUX5_ARB = $208C;
  WGL_AUX6_ARB = $208D;
  WGL_AUX7_ARB = $208E;
  WGL_AUX8_ARB = $208F;
  WGL_AUX9_ARB = $2090;

  // WGL_ARB_robustness_application_isolation
  WGL_CONTEXT_RESET_ISOLATION_BIT_ARB = $00000008;

  // WGL_ARB_create_context
  WGL_CONTEXT_DEBUG_BIT_ARB = $00000001;
  WGL_CONTEXT_FORWARD_COMPATIBLE_BIT_ARB = $00000002;
  WGL_CONTEXT_MAJOR_VERSION_ARB = $2091;
  WGL_CONTEXT_MINOR_VERSION_ARB = $2092;
  WGL_CONTEXT_LAYER_PLANE_ARB = $2093;
  WGL_CONTEXT_FLAGS_ARB = $2094;
  ERROR_INVALID_VERSION_ARB = $2095;

  // WGL_ARB_create_context_profile
  WGL_CONTEXT_PROFILE_MASK_ARB = $9126;
  WGL_CONTEXT_CORE_PROFILE_BIT_ARB = $00000001;
  WGL_CONTEXT_COMPATIBILITY_PROFILE_BIT_ARB = $00000002;
  ERROR_INVALID_PROFILE_ARB = $2096;

  // WGL_ARB_framebuffer_sRGB
  WGL_FRAMEBUFFER_SRGB_CAPABLE_ARB = $20A9;

  // WGL_ARB_create_context_robustness
  WGL_CONTEXT_ROBUST_ACCESS_BIT_ARB = $00000004;
  WGL_LOSE_CONTEXT_ON_RESET_ARB = $8252;
  WGL_CONTEXT_RESET_NOTIFICATION_STRATEGY_ARB = $8256;
  WGL_NO_RESET_NOTIFICATION_ARB = $8261;

  // WGL_ATI_pixel_format_float
  WGL_TYPE_RGBA_FLOAT_ATI = $21A0;
  GL_TYPE_RGBA_FLOAT_ATI = $8820;
  GL_COLOR_CLEAR_UNCLAMPED_VALUE_ATI = $8835;

  // WGL_AMD_gpu_association
  WGL_GPU_VENDOR_AMD = $1F00;
  WGL_GPU_RENDERER_STRING_AMD = $1F01;
  WGL_GPU_OPENGL_VERSION_STRING_AMD = $1F02;
  WGL_GPU_FASTEST_TARGET_GPUS_AMD = $21A2;
  WGL_GPU_RAM_AMD = $21A3;
  WGL_GPU_CLOCK_AMD = $21A4;
  WGL_GPU_NUM_PIPES_AMD = $21A5;
  WGL_GPU_NUM_SIMD_AMD = $21A6;
  WGL_GPU_NUM_RB_AMD = $21A7;
  WGL_GPU_NUM_SPI_AMD = $21A8;

  // WGL_EXT_depth_float
  WGL_DEPTH_FLOAT_EXT = $2040;

  // WGL_EXT_make_current_read
  ERROR_INVALID_PIXEL_TYPE_EXT = $2043;

  // WGL_EXT_multisample
  WGL_SAMPLE_BUFFERS_EXT = $2041;
  WGL_SAMPLES_EXT = $2042;

  // WGL_EXT_pbuffer
  WGL_DRAW_TO_PBUFFER_EXT = $202D;
  WGL_MAX_PBUFFER_PIXELS_EXT = $202E;
  WGL_MAX_PBUFFER_WIDTH_EXT = $202F;
  WGL_MAX_PBUFFER_HEIGHT_EXT = $2030;
  WGL_OPTIMAL_PBUFFER_WIDTH_EXT = $2031;
  WGL_OPTIMAL_PBUFFER_HEIGHT_EXT = $2032;
  WGL_PBUFFER_LARGEST_EXT = $2033;
  WGL_PBUFFER_WIDTH_EXT = $2034;
  WGL_PBUFFER_HEIGHT_EXT = $2035;

  // WGL_EXT_pixel_format
  WGL_NUMBER_PIXEL_FORMATS_EXT = $2000;
  WGL_DRAW_TO_WINDOW_EXT = $2001;
  WGL_DRAW_TO_BITMAP_EXT = $2002;
  WGL_ACCELERATION_EXT = $2003;
  WGL_NEED_PALETTE_EXT = $2004;
  WGL_NEED_SYSTEM_PALETTE_EXT = $2005;
  WGL_SWAP_LAYER_BUFFERS_EXT = $2006;
  WGL_SWAP_METHOD_EXT = $2007;
  WGL_NUMBER_OVERLAYS_EXT = $2008;
  WGL_NUMBER_UNDERLAYS_EXT = $2009;
  WGL_TRANSPARENT_EXT = $200A;
  WGL_TRANSPARENT_VALUE_EXT = $200B;
  WGL_SHARE_DEPTH_EXT = $200C;
  WGL_SHARE_STENCIL_EXT = $200D;
  WGL_SHARE_ACCUM_EXT = $200E;
  WGL_SUPPORT_GDI_EXT = $200F;
  WGL_SUPPORT_OPENGL_EXT = $2010;
  WGL_DOUBLE_BUFFER_EXT = $2011;
  WGL_STEREO_EXT = $2012;
  WGL_PIXEL_TYPE_EXT = $2013;
  WGL_COLOR_BITS_EXT = $2014;
  WGL_RED_BITS_EXT = $2015;
  WGL_RED_SHIFT_EXT = $2016;
  WGL_GREEN_BITS_EXT = $2017;
  WGL_GREEN_SHIFT_EXT = $2018;
  WGL_BLUE_BITS_EXT = $2019;
  WGL_BLUE_SHIFT_EXT = $201A;
  WGL_ALPHA_BITS_EXT = $201B;
  WGL_ALPHA_SHIFT_EXT = $201C;
  WGL_ACCUM_BITS_EXT = $201D;
  WGL_ACCUM_RED_BITS_EXT = $201E;
  WGL_ACCUM_GREEN_BITS_EXT = $201F;
  WGL_ACCUM_BLUE_BITS_EXT = $2020;
  WGL_ACCUM_ALPHA_BITS_EXT = $2021;
  WGL_DEPTH_BITS_EXT = $2022;
  WGL_STENCIL_BITS_EXT = $2023;
  WGL_AUX_BUFFERS_EXT = $2024;
  WGL_NO_ACCELERATION_EXT = $2025;
  WGL_GENERIC_ACCELERATION_EXT = $2026;
  WGL_FULL_ACCELERATION_EXT = $2027;
  WGL_SWAP_EXCHANGE_EXT = $2028;
  WGL_SWAP_COPY_EXT = $2029;
  WGL_SWAP_UNDEFINED_EXT = $202A;
  WGL_TYPE_RGBA_EXT = $202B;
  WGL_TYPE_COLORINDEX_EXT = $202C;

  // WGL_I3D_digital_video_control
  WGL_DIGITAL_VIDEO_CURSOR_ALPHA_FRAMEBUFFER_I3D = $2050;
  WGL_DIGITAL_VIDEO_CURSOR_ALPHA_VALUE_I3D = $2051;
  WGL_DIGITAL_VIDEO_CURSOR_INCLUDED_I3D = $2052;
  WGL_DIGITAL_VIDEO_GAMMA_CORRECTED_I3D = $2053;

  // WGL_I3D_gamma
  WGL_GAMMA_TABLE_SIZE_I3D = $204E;
  WGL_GAMMA_EXCLUDE_DESKTOP_I3D = $204F;

  // WGL_I3D_genlock
  WGL_GENLOCK_SOURCE_MULTIVIEW_I3D = $2044;
  WGL_GENLOCK_SOURCE_EXTENAL_SYNC_I3D = $2045;
  WGL_GENLOCK_SOURCE_EXTENAL_FIELD_I3D = $2046;
  WGL_GENLOCK_SOURCE_EXTENAL_TTL_I3D = $2047;
  WGL_GENLOCK_SOURCE_DIGITAL_SYNC_I3D = $2048;
  WGL_GENLOCK_SOURCE_DIGITAL_FIELD_I3D = $2049;
  WGL_GENLOCK_SOURCE_EDGE_FALLING_I3D = $204A;
  WGL_GENLOCK_SOURCE_EDGE_RISING_I3D = $204B;
  WGL_GENLOCK_SOURCE_EDGE_BOTH_I3D = $204C;

  // WGL_I3D_image_buffer
  WGL_IMAGE_BUFFER_MIN_ACCESS_I3D = $00000001;
  WGL_IMAGE_BUFFER_LOCK_I3D = $00000002;

  // WGL_NV_float_buffer
  WGL_FLOAT_COMPONENTS_NV = $20B0;
  WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_R_NV = $20B1;
  WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_RG_NV = $20B2;
  WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_RGB_NV = $20B3;
  WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_RGBA_NV = $20B4;
  WGL_TEXTURE_FLOAT_R_NV = $20B5;
  WGL_TEXTURE_FLOAT_RG_NV = $20B6;
  WGL_TEXTURE_FLOAT_RGB_NV = $20B7;
  WGL_TEXTURE_FLOAT_RGBA_NV = $20B8;

  // WGL_NV_render_depth_texture
  WGL_BIND_TO_TEXTURE_DEPTH_NV = $20A3;
  WGL_BIND_TO_TEXTURE_RECTANGLE_DEPTH_NV = $20A4;
  WGL_DEPTH_TEXTURE_FORMAT_NV = $20A5;
  WGL_TEXTURE_DEPTH_COMPONENT_NV = $20A6;
  WGL_DEPTH_COMPONENT_NV = $20A7;

  // WGL_NV_render_texture_rectangle
  WGL_BIND_TO_TEXTURE_RECTANGLE_RGB_NV = $20A0;
  WGL_BIND_TO_TEXTURE_RECTANGLE_RGBA_NV = $20A1;
  WGL_TEXTURE_RECTANGLE_NV = $20A2;

  // WGL_NV_present_video
  WGL_NUM_VIDEO_SLOTS_NV = $20F0;

  // WGL_NV_video_output
  WGL_BIND_TO_VIDEO_RGB_NV = $20C0;
  WGL_BIND_TO_VIDEO_RGBA_NV = $20C1;
  WGL_BIND_TO_VIDEO_RGB_AND_DEPTH_NV = $20C2;
  WGL_VIDEO_OUT_COLOR_NV = $20C3;
  WGL_VIDEO_OUT_ALPHA_NV = $20C4;
  WGL_VIDEO_OUT_DEPTH_NV = $20C5;
  WGL_VIDEO_OUT_COLOR_AND_ALPHA_NV = $20C6;
  WGL_VIDEO_OUT_COLOR_AND_DEPTH_NV = $20C7;
  WGL_VIDEO_OUT_FRAME = $20C8;
  WGL_VIDEO_OUT_FIELD_1 = $20C9;
  WGL_VIDEO_OUT_FIELD_2 = $20CA;
  WGL_VIDEO_OUT_STACKED_FIELDS_1_2 = $20CB;
  WGL_VIDEO_OUT_STACKED_FIELDS_2_1 = $20CC;

  // WGL_NV_gpu_affinity
  WGL_ERROR_INCOMPATIBLE_AFFINITY_MASKS_NV = $20D0;
  WGL_ERROR_MISSING_AFFINITY_MASK_NV = $20D1;

  // WGL_NV_video_capture
  WGL_UNIQUE_ID_NV = $20CE;
  WGL_NUM_VIDEO_CAPTURE_SLOTS_NV = $20CF;

  // WGL_NV_multisample_coverage
  WGL_COVERAGE_SAMPLES_NV = $2042;
  WGL_COLOR_SAMPLES_NV = $20B9;

  // WGL_EXT_create_context_es2_profile
  WGL_CONTEXT_ES2_PROFILE_BIT_EXT = $00000004;

  // WGL_NV_DX_interop
  WGL_ACCESS_READ_ONLY_NV        = $00000000;
  WGL_ACCESS_READ_WRITE_NV       = $00000001;
  WGL_ACCESS_WRITE_DISCARD_NV    = $00000002;

  // WIN_draw_range_elements
  GL_MAX_ELEMENTS_VERTICES_WIN = $80E8;
  GL_MAX_ELEMENTS_INDICES_WIN = $80E9;

  // GLX 1.1 and later:
  GLX_VENDOR = 1;
  GLX_VERSION = 2;
  GLX_EXTENSIONS = 3;

  GLX_USE_GL = 1;
  GLX_BUFFER_SIZE = 2;
  GLX_LEVEL = 3;
  GLX_RGBA = 4;
  GLX_DOUBLEBUFFER = 5;
  GLX_STEREO = 6;
  GLX_AUX_BUFFERS = 7;
  GLX_RED_SIZE = 8;
  GLX_GREEN_SIZE = 9;
  GLX_BLUE_SIZE = 10;
  GLX_ALPHA_SIZE = 11;
  GLX_DEPTH_SIZE = 12;
  GLX_STENCIL_SIZE = 13;
  GLX_ACCUM_RED_SIZE = 14;
  GLX_ACCUM_GREEN_SIZE = 15;
  GLX_ACCUM_BLUE_SIZE = 16;
  GLX_ACCUM_ALPHA_SIZE = 17;

  // GLX_VERSION_1_3
  GLX_WINDOW_BIT = $00000001;
  GLX_PIXMAP_BIT = $00000002;
  GLX_PBUFFER_BIT = $00000004;
  GLX_RGBA_BIT = $00000001;
  GLX_COLOR_INDEX_BIT = $00000002;
  GLX_PBUFFER_CLOBBER_MASK = $08000000;
  GLX_FRONT_LEFT_BUFFER_BIT = $00000001;
  GLX_FRONT_RIGHT_BUFFER_BIT = $00000002;
  GLX_BACK_LEFT_BUFFER_BIT = $00000004;
  GLX_BACK_RIGHT_BUFFER_BIT = $00000008;
  GLX_AUX_BUFFERS_BIT = $00000010;
  GLX_DEPTH_BUFFER_BIT = $00000020;
  GLX_STENCIL_BUFFER_BIT = $00000040;
  GLX_ACCUM_BUFFER_BIT = $00000080;
  GLX_CONFIG_CAVEAT = $20;
  GLX_X_VISUAL_TYPE = $22;
  GLX_TRANSPARENT_TYPE = $23;
  GLX_TRANSPARENT_INDEX_VALUE = $24;
  GLX_TRANSPARENT_RED_VALUE = $25;
  GLX_TRANSPARENT_GREEN_VALUE = $26;
  GLX_TRANSPARENT_BLUE_VALUE = $27;
  GLX_TRANSPARENT_ALPHA_VALUE = $28;
  GLX_DONT_CARE = $FFFFFFFF;
  GLX_NONE = $8000;
  GLX_SLOW_CONFIG = $8001;
  GLX_TRUE_COLOR = $8002;
  GLX_DIRECT_COLOR = $8003;
  GLX_PSEUDO_COLOR = $8004;
  GLX_STATIC_COLOR = $8005;
  GLX_GRAY_SCALE = $8006;
  GLX_STATIC_GRAY = $8007;
  GLX_TRANSPARENT_RGB = $8008;
  GLX_TRANSPARENT_INDEX = $8009;
  GLX_VISUAL_ID = $800B;
  GLX_SCREEN = $800C;
  GLX_NON_CONFORMANT_CONFIG = $800D;
  GLX_DRAWABLE_TYPE = $8010;
  GLX_RENDER_TYPE = $8011;
  GLX_X_RENDERABLE = $8012;
  GLX_FBCONFIG_ID = $8013;
  GLX_RGBA_TYPE = $8014;
  GLX_COLOR_INDEX_TYPE = $8015;
  GLX_MAX_PBUFFER_WIDTH = $8016;
  GLX_MAX_PBUFFER_HEIGHT = $8017;
  GLX_MAX_PBUFFER_PIXELS = $8018;
  GLX_PRESERVED_CONTENTS = $801B;
  GLX_LARGEST_PBUFFER = $801C;
  GLX_WIDTH = $801D;
  GLX_HEIGHT = $801E;
  GLX_EVENT_MASK = $801F;
  GLX_DAMAGED = $8020;
  GLX_SAVED = $8021;
  GLX_WINDOW = $8022;
  GLX_PBUFFER = $8023;
  GLX_PBUFFER_HEIGHT = $8040;
  GLX_PBUFFER_WIDTH = $8041;

  // GLX_VERSION_1_4
  GLX_SAMPLE_BUFFERS = 100000;
  GLX_SAMPLES = 100001;

  // GLX_ARB_multisample
  GLX_SAMPLE_BUFFERS_ARB = 100000;
  GLX_SAMPLES_ARB = 100001;

  // GLX_ARB_robustness_application_isolation
  GLX_CONTEXT_RESET_ISOLATION_BIT_ARB = $00000008;

  // GLX_ARB_fbconfig_float
  GLX_RGBA_FLOAT_TYPE_ARB = $20B9;
  GLX_RGBA_FLOAT_BIT_ARB = $00000004;

  // GLX_ARB_context_flush_control
  GLX_CONTEXT_RELEASE_BEHAVIOR_ARB = $2097;
  GLX_CONTEXT_RELEASE_BEHAVIOR_NONE_ARB = 0;
  GLX_CONTEXT_RELEASE_BEHAVIOR_FLUSH_ARB = $2098;

  // GLX_ARB_create_context
  GLX_CONTEXT_DEBUG_BIT_ARB = $00000001;
  GLX_CONTEXT_FORWARD_COMPATIBLE_BIT_ARB = $00000002;
  GLX_CONTEXT_MAJOR_VERSION_ARB = $2091;
  GLX_CONTEXT_MINOR_VERSION_ARB = $2092;
  GLX_CONTEXT_FLAGS_ARB = $2094;

  // GLX_ARB_create_context_profile
  GLX_CONTEXT_CORE_PROFILE_BIT_ARB = $00000001;
  GLX_CONTEXT_COMPATIBILITY_PROFILE_BIT_ARB = $00000002;
  GLX_CONTEXT_PROFILE_MASK_ARB = $9126;

  // GLX_ARB_vertex_buffer_object
  GLX_CONTEXT_ALLOW_BUFFER_BYTE_ORDER_MISMATCH_ARB = $2095;

  // GLX_ARB_framebuffer_sRGB
  GLX_FRAMEBUFFER_SRGB_CAPABLE_ARB = $20B2;

  // GLX_ARB_create_context_robustness
  GLX_CONTEXT_ROBUST_ACCESS_BIT_ARB = $00000004;
  GLX_LOSE_CONTEXT_ON_RESET_ARB = $8252;
  GLX_CONTEXT_RESET_NOTIFICATION_STRATEGY_ARB = $8256;
  GLX_NO_RESET_NOTIFICATION_ARB = $8261;

  // GLX_EXT_visual_info
  GLX_X_VISUAL_TYPE_EXT = $22;
  GLX_TRANSPARENT_TYPE_EXT = $23;
  GLX_TRANSPARENT_INDEX_VALUE_EXT = $24;
  GLX_TRANSPARENT_RED_VALUE_EXT = $25;
  GLX_TRANSPARENT_GREEN_VALUE_EXT = $26;
  GLX_TRANSPARENT_BLUE_VALUE_EXT = $27;
  GLX_TRANSPARENT_ALPHA_VALUE_EXT = $28;
  GLX_NONE_EXT = $8000;
  GLX_TRUE_COLOR_EXT = $8002;
  GLX_DIRECT_COLOR_EXT = $8003;
  GLX_PSEUDO_COLOR_EXT = $8004;
  GLX_STATIC_COLOR_EXT = $8005;
  GLX_GRAY_SCALE_EXT = $8006;
  GLX_STATIC_GRAY_EXT = $8007;
  GLX_TRANSPARENT_RGB_EXT = $8008;
  GLX_TRANSPARENT_INDEX_EXT = $8009;

  // GLX_EXT_visual_rating
  GLX_VISUAL_CAVEAT_EXT = $20;
  GLX_SLOW_VISUAL_EXT = $8001;
  GLX_NON_CONFORMANT_VISUAL_EXT = $800D;
  (* reuse GLX_NONE_EXT *)

  // GLX_EXT_import_context
  GLX_SHARE_CONTEXT_EXT = $800A;
  GLX_VISUAL_ID_EXT = $800B;
  GLX_SCREEN_EXT = $800C;

  // GLX_EXT_fbconfig_packed_float
//  GLX_RGBA_UNSIGNED_FLOAT_TYPE_EXT = $20B1;
//  GLX_RGBA_UNSIGNED_FLOAT_BIT_EXT = $00000008;

  // GLX_EXT_framebuffer_sRGB
//  GLX_FRAMEBUFFER_SRGB_CAPABLE_EXT = $20B2;

  // GLX_EXT_texture_from_pixmap
  GLX_TEXTURE_1D_BIT_EXT = $00000001;
  GLX_TEXTURE_2D_BIT_EXT = $00000002;
  GLX_TEXTURE_RECTANGLE_BIT_EXT = $00000004;
  GLX_BIND_TO_TEXTURE_RGB_EXT = $20D0;
  GLX_BIND_TO_TEXTURE_RGBA_EXT = $20D1;
  GLX_BIND_TO_MIPMAP_TEXTURE_EXT = $20D2;
  GLX_BIND_TO_TEXTURE_TARGETS_EXT = $20D3;
  GLX_Y_INVERTED_EXT = $20D4;
  GLX_TEXTURE_FORMAT_EXT = $20D5;
  GLX_TEXTURE_TARGET_EXT = $20D6;
  GLX_MIPMAP_TEXTURE_EXT = $20D7;
  GLX_TEXTURE_FORMAT_NONE_EXT = $20D8;
  GLX_TEXTURE_FORMAT_RGB_EXT = $20D9;
  GLX_TEXTURE_FORMAT_RGBA_EXT = $20DA;
  GLX_TEXTURE_1D_EXT = $20DB;
  GLX_TEXTURE_2D_EXT = $20DC;
  GLX_TEXTURE_RECTANGLE_EXT = $20DD;
  GLX_FRONT_LEFT_EXT = $20DE;
  GLX_FRONT_RIGHT_EXT = $20DF;
  GLX_BACK_LEFT_EXT = $20E0;
  GLX_BACK_RIGHT_EXT = $20E1;
  GLX_FRONT_EXT = GLX_FRONT_LEFT_EXT;
  GLX_BACK_EXT = GLX_BACK_LEFT_EXT;
  GLX_AUX0_EXT = $20E2;
  GLX_AUX1_EXT = $20E3;
  GLX_AUX2_EXT = $20E4;
  GLX_AUX3_EXT = $20E5;
  GLX_AUX4_EXT = $20E6;
  GLX_AUX5_EXT = $20E7;
  GLX_AUX6_EXT = $20E8;
  GLX_AUX7_EXT = $20E9;
  GLX_AUX8_EXT = $20EA;
  GLX_AUX9_EXT = $20EB;

  // GLX_EXT_swap_control
  GLX_SWAP_INTERVAL_EXT = $20F1;
  GLX_MAX_SWAP_INTERVAL_EXT = $20F2;

  // GLX_EXT_create_context_es2_profile
  GLX_CONTEXT_ES2_PROFILE_BIT_EXT = $00000004;

  // GL_EXT_Late_Swaps
  GLX_LATE_SWAPS_TEAR_EXT         = $20F3;

  // GLU
  GLU_INVALID_ENUM = 100900;
  GLU_INVALID_VALUE = 100901;
  GLU_OUT_OF_MEMORY = 100902;
  GLU_INCOMPATIBLE_GL_VERSION = 100903;
  GLU_VERSION = 100800;
  GLU_EXTENSIONS = 100801;
  GLU_TRUE: ByteBool = True;
  GLU_FALSE: ByteBool = False;
  GLU_SMOOTH = 100000;
  GLU_FLAT = 100001;
  GLU_NONE = 100002;
  GLU_POINT = 100010;
  GLU_LINE = 100011;
  GLU_FILL = 100012;
  GLU_SILHOUETTE = 100013;
  GLU_OUTSIDE = 100020;
  GLU_INSIDE = 100021;
  GLU_TESS_MAX_COORD = 1.0E150;
  GLU_TESS_WINDING_RULE = 100140;
  GLU_TESS_BOUNDARY_ONLY = 100141;
  GLU_TESS_TOLERANCE = 100142;
  GLU_TESS_WINDING_ODD = 100130;
  GLU_TESS_WINDING_NONZERO = 100131;
  GLU_TESS_WINDING_POSITIVE = 100132;
  GLU_TESS_WINDING_NEGATIVE = 100133;
  GLU_TESS_WINDING_ABS_GEQ_TWO = 100134;
  GLU_TESS_BEGIN = 100100; // TGLUTessBeginProc
  GLU_TESS_VERTEX = 100101; // TGLUTessVertexProc
  GLU_TESS_END = 100102; // TGLUTessEndProc
  GLU_TESS_ERROR = 100103; // TGLUTessErrorProc
  GLU_TESS_EDGE_FLAG = 100104; // TGLUTessEdgeFlagProc
  GLU_TESS_COMBINE = 100105; // TGLUTessCombineProc
  GLU_TESS_BEGIN_DATA = 100106; // TGLUTessBeginDataProc
  GLU_TESS_VERTEX_DATA = 100107; // TGLUTessVertexDataProc
  GLU_TESS_END_DATA = 100108; // TGLUTessEndDataProc
  GLU_TESS_ERROR_DATA = 100109; // TGLUTessErrorDataProc
  GLU_TESS_EDGE_FLAG_DATA = 100110; // TGLUTessEdgeFlagDataProc
  GLU_TESS_COMBINE_DATA = 100111; // TGLUTessCombineDataProc
  GLU_TESS_ERROR1 = 100151;
  GLU_TESS_ERROR2 = 100152;
  GLU_TESS_ERROR3 = 100153;
  GLU_TESS_ERROR4 = 100154;
  GLU_TESS_ERROR5 = 100155;
  GLU_TESS_ERROR6 = 100156;
  GLU_TESS_ERROR7 = 100157;
  GLU_TESS_ERROR8 = 100158;
  GLU_TESS_MISSING_BEGIN_POLYGON = GLU_TESS_ERROR1;
  GLU_TESS_MISSING_BEGIN_CONTOUR = GLU_TESS_ERROR2;
  GLU_TESS_MISSING_END_POLYGON = GLU_TESS_ERROR3;
  GLU_TESS_MISSING_END_CONTOUR = GLU_TESS_ERROR4;
  GLU_TESS_COORD_TOO_LARGE = GLU_TESS_ERROR5;
  GLU_TESS_NEED_COMBINE_CALLBACK = GLU_TESS_ERROR6;
  GLU_AUTO_LOAD_MATRIX = 100200;
  GLU_CULLING = 100201;
  GLU_SAMPLING_TOLERANCE = 100203;
  GLU_DISPLAY_MODE = 100204;
  GLU_PARAMETRIC_TOLERANCE = 100202;
  GLU_SAMPLING_METHOD = 100205;
  GLU_U_STEP = 100206;
  GLU_V_STEP = 100207;
  GLU_PATH_LENGTH = 100215;
  GLU_PARAMETRIC_ERROR = 100216;
  GLU_DOMAIN_DISTANCE = 100217;
  GLU_MAP1_TRIM_2 = 100210;
  GLU_MAP1_TRIM_3 = 100211;
  GLU_OUTLINE_POLYGON = 100240;
  GLU_OUTLINE_PATCH = 100241;
  GLU_NURBS_ERROR1 = 100251;
  GLU_NURBS_ERROR2 = 100252;
  GLU_NURBS_ERROR3 = 100253;
  GLU_NURBS_ERROR4 = 100254;
  GLU_NURBS_ERROR5 = 100255;
  GLU_NURBS_ERROR6 = 100256;
  GLU_NURBS_ERROR7 = 100257;
  GLU_NURBS_ERROR8 = 100258;
  GLU_NURBS_ERROR9 = 100259;
  GLU_NURBS_ERROR10 = 100260;
  GLU_NURBS_ERROR11 = 100261;
  GLU_NURBS_ERROR12 = 100262;
  GLU_NURBS_ERROR13 = 100263;
  GLU_NURBS_ERROR14 = 100264;
  GLU_NURBS_ERROR15 = 100265;
  GLU_NURBS_ERROR16 = 100266;
  GLU_NURBS_ERROR17 = 100267;
  GLU_NURBS_ERROR18 = 100268;
  GLU_NURBS_ERROR19 = 100269;
  GLU_NURBS_ERROR20 = 100270;
  GLU_NURBS_ERROR21 = 100271;
  GLU_NURBS_ERROR22 = 100272;
  GLU_NURBS_ERROR23 = 100273;
  GLU_NURBS_ERROR24 = 100274;
  GLU_NURBS_ERROR25 = 100275;
  GLU_NURBS_ERROR26 = 100276;
  GLU_NURBS_ERROR27 = 100277;
  GLU_NURBS_ERROR28 = 100278;
  GLU_NURBS_ERROR29 = 100279;
  GLU_NURBS_ERROR30 = 100280;
  GLU_NURBS_ERROR31 = 100281;
  GLU_NURBS_ERROR32 = 100282;
  GLU_NURBS_ERROR33 = 100283;
  GLU_NURBS_ERROR34 = 100284;
  GLU_NURBS_ERROR35 = 100285;
  GLU_NURBS_ERROR36 = 100286;
  GLU_NURBS_ERROR37 = 100287;
  GLU_CW = 100120;
  GLU_CCW = 100121;
  GLU_INTERIOR = 100122;
  GLU_EXTERIOR = 100123;
  GLU_UNKNOWN = 100124;
  GLU_BEGIN = GLU_TESS_BEGIN;
  GLU_VERTEX = GLU_TESS_VERTEX;
  GLU_END = GLU_TESS_END;
  GLU_ERROR = GLU_TESS_ERROR;
  GLU_EDGE_FLAG = GLU_TESS_EDGE_FLAG;

type
  // GL_VERSION_1_2
  TglBlendColor = procedure(red: GLclampf; green: GLclampf; blue: GLclampf; alpha: GLclampf); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBlendEquation = procedure(mode: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDrawRangeElements = procedure(mode: GLenum; start: GLuint; _end: GLuint; count: GLsizei; _type: GLenum; const indices: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTexImage3D = procedure(target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; _type: GLenum; const pixels: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTexSubImage3D = procedure(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; _type: GLenum; const pixels: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCopyTexSubImage3D = procedure(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglColorTable = procedure(target: GLenum; internalformat: GLenum; width: GLsizei; format: GLenum; _type: GLenum; const table: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglColorTableParameterfv = procedure(target: GLenum; pname: GLenum; const params: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglColorTableParameteriv = procedure(target: GLenum; pname: GLenum; const params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCopyColorTable = procedure(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetColorTable = procedure(target: GLenum; format: GLenum; _type: GLenum; table: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetColorTableParameterfv = procedure(target: GLenum; pname: GLenum; params: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetColorTableParameteriv = procedure(target: GLenum; pname: GLenum; params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglColorSubTable = procedure(target: GLenum; start: GLsizei; count: GLsizei; format: GLenum; _type: GLenum; const data: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCopyColorSubTable = procedure(target: GLenum; start: GLsizei; x: GLint; y: GLint; width: GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglConvolutionFilter1D = procedure(target: GLenum; internalformat: GLenum; width: GLsizei; format: GLenum; _type: GLenum; const image: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglConvolutionFilter2D = procedure(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; const image: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglConvolutionParameterf = procedure(target: GLenum; pname: GLenum; params: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglConvolutionParameterfv = procedure(target: GLenum; pname: GLenum; const params: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglConvolutionParameteri = procedure(target: GLenum; pname: GLenum; params: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglConvolutionParameteriv = procedure(target: GLenum; pname: GLenum; const params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCopyConvolutionFilter1D = procedure(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCopyConvolutionFilter2D = procedure(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetConvolutionFilter = procedure(target: GLenum; format: GLenum; _type: GLenum; image: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetConvolutionParameterfv = procedure(target: GLenum; pname: GLenum; params: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetConvolutionParameteriv = procedure(target: GLenum; pname: GLenum; params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetSeparableFilter = procedure(target: GLenum; format: GLenum; _type: GLenum; row: PGLvoid; column: PGLvoid; span: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSeparableFilter2D = procedure(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; const row: PGLvoid; const column: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetHistogram = procedure(target: GLenum; reset: GLboolean; format: GLenum; _type: GLenum; values: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetHistogramParameterfv = procedure(target: GLenum; pname: GLenum; params: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetHistogramParameteriv = procedure(target: GLenum; pname: GLenum; params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetMinmax = procedure(target: GLenum; reset: GLboolean; format: GLenum; _type: GLenum; values: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetMinmaxParameterfv = procedure(target: GLenum; pname: GLenum; params: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetMinmaxParameteriv = procedure(target: GLenum; pname: GLenum; params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglHistogram = procedure(target: GLenum; width: GLsizei; internalformat: GLenum; sink: GLboolean); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMinmax = procedure(target: GLenum; internalformat: GLenum; sink: GLboolean); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglResetHistogram = procedure(target: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglResetMinmax = procedure(target: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  // GL_VERSION_1_3
  TglActiveTexture = procedure(texture: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSampleCoverage = procedure(value: GLclampf; invert: GLboolean); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCompressedTexImage3D = procedure(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei; const data: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCompressedTexImage2D = procedure(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; imageSize: GLsizei; const data: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCompressedTexImage1D = procedure(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; imageSize: GLsizei; const data: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCompressedTexSubImage3D = procedure(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei; const data: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCompressedTexSubImage2D = procedure(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei; const data: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCompressedTexSubImage1D = procedure(target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; imageSize: GLsizei; const data: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetCompressedTexImage = procedure(target: GLenum; level: GLint; img: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglClientActiveTexture = procedure(texture: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord1d = procedure(target: GLenum; s: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord1dv = procedure(target: GLenum; const v: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord1f = procedure(target: GLenum; s: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord1fv = procedure(target: GLenum; const v: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord1i = procedure(target: GLenum; s: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord1iv = procedure(target: GLenum; const v: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord1s = procedure(target: GLenum; s: GLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord1sv = procedure(target: GLenum; const v: PGLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord2d = procedure(target: GLenum; s: GLdouble; t: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord2dv = procedure(target: GLenum; const v: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord2f = procedure(target: GLenum; s: GLfloat; t: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord2fv = procedure(target: GLenum; const v: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord2i = procedure(target: GLenum; s: GLint; t: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord2iv = procedure(target: GLenum; const v: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord2s = procedure(target: GLenum; s: GLshort; t: GLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord2sv = procedure(target: GLenum; const v: PGLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord3d = procedure(target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord3dv = procedure(target: GLenum; const v: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord3f = procedure(target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord3fv = procedure(target: GLenum; const v: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord3i = procedure(target: GLenum; s: GLint; t: GLint; r: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord3iv = procedure(target: GLenum; const v: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord3s = procedure(target: GLenum; s: GLshort; t: GLshort; r: GLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord3sv = procedure(target: GLenum; const v: PGLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord4d = procedure(target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble; q: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord4dv = procedure(target: GLenum; const v: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord4f = procedure(target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat; q: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord4fv = procedure(target: GLenum; const v: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord4i = procedure(target: GLenum; s: GLint; t: GLint; r: GLint; q: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord4iv = procedure(target: GLenum; const v: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord4s = procedure(target: GLenum; s: GLshort; t: GLshort; r: GLshort; q: GLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoord4sv = procedure(target: GLenum; const v: PGLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglLoadTransposeMatrixf = procedure(const m: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglLoadTransposeMatrixd = procedure(const m: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultTransposeMatrixf = procedure(const m: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultTransposeMatrixd = procedure(const m: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  // GL_VERSION_1_4
  TglBlendFuncSeparate = procedure(sfactorRGB: GLenum; dfactorRGB: GLenum; sfactorAlpha: GLenum; dfactorAlpha: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiDrawArrays = procedure(mode: GLenum; const first: PGLint; const count: PGLsizei; primcount: GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiDrawElements = procedure(mode: GLenum; const count: PGLsizei; _type: GLenum; const indices: PGLvoid; primcount: GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglPointParameterf = procedure(pname: GLenum; param: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglPointParameterfv = procedure(pname: GLenum; const params: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglPointParameteri = procedure(pname: GLenum; param: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglPointParameteriv = procedure(pname: GLenum; const params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglFogCoordf = procedure(coord: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglFogCoordfv = procedure(const coord: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglFogCoordd = procedure(coord: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglFogCoorddv = procedure(const coord: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglFogCoordPointer = procedure(_type: GLenum; stride: GLsizei; const _pointer: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSecondaryColor3b = procedure(red: GLbyte; green: GLbyte; blue: GLbyte); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSecondaryColor3bv = procedure(const v: PGLbyte); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSecondaryColor3d = procedure(red: GLdouble; green: GLdouble; blue: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSecondaryColor3dv = procedure(const v: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSecondaryColor3f = procedure(red: GLfloat; green: GLfloat; blue: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSecondaryColor3fv = procedure(const v: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSecondaryColor3i = procedure(red: GLint; green: GLint; blue: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSecondaryColor3iv = procedure(const v: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSecondaryColor3s = procedure(red: GLshort; green: GLshort; blue: GLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSecondaryColor3sv = procedure(const v: PGLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSecondaryColor3ub = procedure(red: GLubyte; green: GLubyte; blue: GLubyte); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSecondaryColor3ubv = procedure(const v: PGLubyte); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSecondaryColor3ui = procedure(red: GLuint; green: GLuint; blue: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSecondaryColor3uiv = procedure(const v: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSecondaryColor3us = procedure(red: GLushort; green: GLushort; blue: GLushort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSecondaryColor3usv = procedure(const v: PGLushort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSecondaryColorPointer = procedure(size: GLint; _type: GLenum; stride: GLsizei; const _pointer: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglWindowPos2d = procedure(x: GLdouble; y: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglWindowPos2dv = procedure(const v: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglWindowPos2f = procedure(x: GLfloat; y: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglWindowPos2fv = procedure(const v: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglWindowPos2i = procedure(x: GLint; y: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglWindowPos2iv = procedure(const v: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglWindowPos2s = procedure(x: GLshort; y: GLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglWindowPos2sv = procedure(const v: PGLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglWindowPos3d = procedure(x: GLdouble; y: GLdouble; z: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglWindowPos3dv = procedure(const v: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglWindowPos3f = procedure(x: GLfloat; y: GLfloat; z: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglWindowPos3fv = procedure(const v: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglWindowPos3i = procedure(x: GLint; y: GLint; z: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglWindowPos3iv = procedure(const v: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglWindowPos3s = procedure(x: GLshort; y: GLshort; z: GLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglWindowPos3sv = procedure(const v: PGLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  // GL_VERSION_1_5
  TglGenQueries = procedure(n: GLsizei; ids: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDeleteQueries = procedure(n: GLsizei; const ids: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglIsQuery = function(id: GLuint): boolean; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBeginQuery = procedure(target: GLenum; id: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglEndQuery = procedure(target: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetQueryiv = procedure(target, pname: GLenum; params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetQueryObjectiv = procedure(id: GLuint; pname: GLenum; params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetQueryObjectuiv = procedure(id: GLuint; pname: GLenum; params: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBindBuffer = procedure(target: GLenum; buffer: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDeleteBuffers = procedure(n: GLsizei; const buffers: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGenBuffers = procedure(n: GLsizei; buffers: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglIsBuffer = function(buffer: GLuint): GLboolean; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBufferData = procedure(target: GLenum; size: GLsizeiptr; const data: PGLvoid; usage: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBufferSubData = procedure(target: GLenum; offset: GLintptr; size: GLsizeiptr; const data: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetBufferSubData = procedure(target: GLenum; offset: GLintptr; size: GLsizeiptr; data: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMapBuffer = function(target: GLenum; access: GLenum): PGLvoid; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUnmapBuffer = function(target: GLenum): GLboolean; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetBufferParameteriv = procedure(target: GLenum; pname: GLenum; params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetBufferPointerv = procedure(target: GLenum; pname: GLenum; params: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  // GL_VERSION_2_0
  TglBlendEquationSeparate = procedure(modeRGB: GLenum; modeAlpha: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDrawBuffers = procedure(n: GLsizei; const bufs: PGLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglStencilOpSeparate = procedure(face: GLenum; sfail: GLenum; dpfail: GLenum; dppass: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglStencilFuncSeparate = procedure(face: GLenum; func: GLenum; ref: GLint; mask: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglStencilMaskSeparate = procedure(face: GLenum; mask: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglAttachShader = procedure(programObj, shaderObj: GLhandle); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBindAttribLocation = procedure(programObj: GLhandle; index: GLuint; name: PGLChar); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCompileShader = procedure(shaderObj: GLhandle); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCreateProgram = function: GLhandle; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCreateShader = function(shaderType: GLenum): GLhandle; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDeleteProgram = procedure(programObj: GLhandle); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDeleteShader = procedure(shaderObj: GLhandle); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDetachShader = procedure(programObj, shaderObj: GLhandle); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDisableVertexAttribArray = procedure(index: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglEnableVertexAttribArray = procedure(index: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetActiveAttrib = procedure(programObj: GLhandle; index: GLuint; maxlength: GLsizei; var length: GLint; var size: GLint; var _type: GLenum; name: PGLChar); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetActiveUniform = procedure(programObj: GLhandle; index: GLuint; maxLength: GLsizei; var length: GLsizei; var size: GLint; var _type: GLenum; name: PGLChar); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetAttachedShaders = procedure(programObj: GLhandle; MaxCount: GLsizei; var Count: GLint; shaders: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetAttribLocation = function(programObj: GLhandle; char: PGLChar): glint; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetProgramiv = procedure(programObj: GLhandle; pname: GLenum; params: PGLInt); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetProgramInfoLog = procedure(programObj: GLHandle; maxLength: glsizei; length: PGLSizei; infoLog: PGLChar); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetShaderiv = procedure(shaderObj: GLhandle; pname: GLenum; params: PGLInt); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetShaderInfoLog = procedure(shaderObj: GLHandle; maxLength: glsizei; length: PGLSizei; infoLog: PGLChar); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetShaderSource = procedure(shaderObj: GLhandle; maxlength: GLsizei; var length: GLsizei; source: PGLChar); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetUniformLocation = function(programObj: GLhandle; const char: PGLChar): glint; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetUniformfv = procedure(programObj: GLhandle; location: GLint; params: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetUniformiv = procedure(programObj: GLhandle; location: GLint; params: PGLInt); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetVertexAttribfv = procedure(index: GLuint; pname: GLenum; params: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetVertexAttribiv = procedure(index: GLuint; pname: GLenum; params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetVertexAttribPointerv = procedure(index: GLuint; pname: GLenum; _pointer: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglIsProgram = function(programObj: GLhandle) : GLboolean; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglIsShader = function(shaderObj: GLhandle) : GLboolean; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglLinkProgram = procedure(programObj: GLHandle); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglShaderSource = procedure(shaderObj: GLHandle; count: glsizei; const _string: PPGLChar; lengths: pglint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUseProgram = procedure(programObj: GLhandle); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform1f = procedure(location: GLint; v0: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform2f = procedure(location: GLint; v0, v1: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform3f = procedure(location: GLint; v0, v1, v2: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform4f = procedure(location: GLint; v0, v1, v2, v3: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform1i = procedure(location: GLint; v0: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform2i = procedure(location: GLint; v0, v1: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform3i = procedure(location: GLint; v0, v1, v2: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform4i = procedure(location: GLint; v0, v1, v2, v3: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform1fv = procedure(location: GLint; count: GLsizei; value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform2fv = procedure(location: GLint; count: GLsizei; value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform3fv = procedure(location: GLint; count: GLsizei; value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform4fv = procedure(location: GLint; count: GLsizei; value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform1iv = procedure(location: GLint; count: GLsizei; value: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform2iv = procedure(location: GLint; count: GLsizei; value: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform3iv = procedure(location: GLint; count: GLsizei; value: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform4iv = procedure(location: GLint; count: GLsizei; value: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniformMatrix2fv = procedure(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniformMatrix3fv = procedure(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniformMatrix4fv = procedure(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglValidateProgram = procedure(programObj: GLhandle); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib1d = procedure(index: GLuint; x: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib1dv = procedure(index: GLuint; const v: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib1f = procedure(index: GLuint; x: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib1fv = procedure(index: GLuint; const v: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib1s = procedure(index: GLuint; x: GLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib1sv = procedure(index: GLuint; const v: PGLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib2d = procedure(index: GLuint; x: GLdouble; y: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib2dv = procedure(index: GLuint; const v: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib2f = procedure(index: GLuint; x: GLfloat; y: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib2fv = procedure(index: GLuint; const v: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib2s = procedure(index: GLuint; x: GLshort; y: GLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib2sv = procedure(index: GLuint; const v: PGLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib3d = procedure(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib3dv = procedure(index: GLuint; const v: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib3f = procedure(index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib3fv = procedure(index: GLuint; const v: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib3s = procedure(index: GLuint; x: GLshort; y: GLshort; z: GLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib3sv = procedure(index: GLuint; const v: PGLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib4Nbv = procedure(index: GLuint; const v: PGLbyte); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib4Niv = procedure(index: GLuint; const v: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib4Nsv = procedure(index: GLuint; const v: PGLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib4Nub = procedure(index: GLuint; x: GLubyte; y: GLubyte; z: GLubyte; w: GLubyte); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib4Nubv = procedure(index: GLuint; const v: PGLubyte); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib4Nuiv = procedure(index: GLuint; const v: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib4Nusv = procedure(index: GLuint; const v: PGLushort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib4bv = procedure(index: GLuint; const v: PGLbyte); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib4d = procedure(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib4dv = procedure(index: GLuint; const v: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib4f = procedure(index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib4fv = procedure(index: GLuint; const v: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib4iv = procedure(index: GLuint; const v: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib4s = procedure(index: GLuint; x: GLshort; y: GLshort; z: GLshort; w: GLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib4sv = procedure(index: GLuint; const v: PGLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib4ubv = procedure(index: GLuint; const v: PGLubyte); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib4uiv = procedure(index: GLuint; const v: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttrib4usv = procedure(index: GLuint; const v: PGLushort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribPointer = procedure(index: GLuint; size: GLint; _type: GLenum; normalized: GLboolean; stride: GLsizei; const _pointer: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  // GL_VERSION_2_1
  TglUniformMatrix2x3fv = procedure(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniformMatrix3x2fv = procedure(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniformMatrix2x4fv = procedure(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniformMatrix4x2fv = procedure(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniformMatrix3x4fv = procedure(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniformMatrix4x3fv = procedure(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  // GL_VERSION_3_0
  { OpenGL 3.0 also reuses entry points from these extensions: }
  { ARB_framebuffer_object }
  { ARB_map_buffer_range }
  { ARB_vertex_array_object }
  TglColorMaski = procedure(index_: GLuint; r: GLboolean; g: GLboolean; b: GLboolean; a: GLboolean); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetBooleani_v = procedure(target: GLenum; index_: GLuint; data: PGLboolean); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetIntegeri_v = procedure(target: GLenum; index_: GLuint; data: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglEnablei = procedure(target: GLenum; index_: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDisablei = procedure(target: GLenum; index_: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglIsEnabledi = function(target: GLenum; index_: GLuint): GLboolean; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBeginTransformFeedback = procedure(primitiveMode: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglEndTransformFeedback = procedure(); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBindBufferRange = procedure(target: GLenum; index_: GLuint; buffer: GLuint; offset: GLintptr; size: GLsizeiptr); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBindBufferBase = procedure(target: GLenum; index_: GLuint; buffer: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTransformFeedbackVaryings = procedure(program_: GLuint; count: GLsizei; const varyings: PPGLchar; bufferMode: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetTransformFeedbackVarying = procedure(program_: GLuint; index_: GLuint; bufSize: GLsizei; length: PGLsizei; size: PGLsizei; type_: PGLsizei; name: PGLchar); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglClampColor = procedure(targe: GLenum; clamp: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBeginConditionalRender = procedure(id: GLuint; mode: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglEndConditionalRender = procedure(); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribIPointer = procedure(index_: GLuint; size: GLint; type_: GLenum; stride: GLsizei; const pointer: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetVertexAttribIiv = procedure(index_: GLuint; pname: GLenum; params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetVertexAttribIuiv = procedure(index_: GLuint; pname: GLenum; params: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI1i = procedure(index_: GLuint; x: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI2i = procedure(index_: GLuint; x: GLint; y: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI3i = procedure(index_: GLuint; x: GLint; y: GLint; z: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI4i = procedure(index_: GLuint; x: GLint; y: GLint; z: GLint; w: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI1ui = procedure(index_: GLuint; x: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI2ui = procedure(index_: GLuint; x: GLuint; y: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI3ui = procedure(index_: GLuint; x: GLuint; y: GLuint; z: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI4ui = procedure(index_: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI1iv = procedure(index_: GLuint; const v: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI2iv = procedure(index_: GLuint; const v: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI3iv = procedure(index_: GLuint; const v: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI4iv = procedure(index_: GLuint; const v: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI1uiv = procedure(index_: GLuint; const v: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI2uiv = procedure(index_: GLuint; const v: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI3uiv = procedure(index_: GLuint; const v: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI4uiv = procedure(index_: GLuint; const v: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI4bv = procedure(index_: GLuint; const v: PGLbyte); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI4sv = procedure(index_: GLuint; const v: PGLshort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI4ubv = procedure(index_: GLuint; const v: PGLubyte); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribI4usv = procedure(index_: GLuint; const v: PGLushort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetUniformuiv = procedure(program_: GLuint; location: GLint; params: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBindFragDataLocation = procedure(program_: GLuint; color: GLuint; const name: PGLChar); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetFragDataLocation = function(program_: GLuint; const name: PGLChar): GLint; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform1ui = procedure(location: GLint; v0: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform2ui = procedure(location: GLint; v0: GLuint; v1: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform3ui = procedure(location: GLint; v0: GLuint; v1: GLuint; v2: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform4ui = procedure(location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform1uiv = procedure(location: GLint; count: GLsizei; const value: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform2uiv = procedure(location: GLint; count: GLsizei; const value: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform3uiv = procedure(location: GLint; count: GLsizei; const value: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform4uiv = procedure(location: GLint; count: GLsizei; const value: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTexParameterIiv = procedure(target: GLenum; pname: GLenum; const params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTexParameterIuiv = procedure(target: GLenum; pname: GLenum; const params: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetTexParameterIiv = procedure(target: GLenum; pname: GLenum; params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetTexParameterIuiv = procedure(target: GLenum; pname: GLenum; params: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglClearBufferiv = procedure(buffer: GLenum; drawbuffer: GLint; const value: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglClearBufferuiv = procedure(buffer: GLenum; drawbuffer: GLint; const value: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglClearBufferfv = procedure(buffer: GLenum; drawbuffer: GLint; const value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglClearBufferfi = procedure(buffer: GLenum; drawbuffer: GLint; depth: GLfloat; stencil: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetStringi = function(name: GLenum; index: GLuint): PGLubyte; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  // GL_VERSION_2_1
  TglEnableVertexArrayEXT = procedure(vaobj: GLuint; array_: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglEnableVertexArrayAttribEXT = procedure(vaobj: GLuint; index: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexArrayVertexAttribOffsetEXT = procedure(vaobj: GLuint; buffer: GLuint; index: GLuint; size: GLint; type_: GLenum; normalized: GLboolean; stride: GLsizei; offset: GLintptr); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_VERSION_3_1
  { OpenGL 3.1 also reuses entry points from these extensions: }
  { ARB_copy_buffer }
  { ARB_uniform_buffer_object }
  TglDrawArraysInstanced = procedure(mode: GLenum; first: GLint; count: GLsizei; primcount: GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDrawElementsInstanced = procedure(mode: GLenum; count: GLsizei; type_: GLenum; const indices: PGLvoid; primcount: GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTexBuffer = procedure(target: GLenum; internalformat: GLenum; buffer: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglPrimitiveRestartIndex = procedure(index_: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_VERSION_3_2
  { OpenGL 3.2 also reuses entry points from these extensions: }
  { ARB_draw_elements_base_vertex }
  { ARB_provoking_vertex }
  { ARB_sync }
  { ARB_texture_multisample }
  TglGetInteger64i_v = procedure(target: GLenum; index_: GLuint; data: PGLint64); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetBufferParameteri64v = procedure(target: GLenum; pname: GLenum; params: PGLint64); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglFramebufferTexture = procedure(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
//  TglFramebufferTextureFace = procedure(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; face: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_VERSION_3_3
  { OpenGL 3.3 also reuses entry points from these extensions: }
  { ARB_blend_func_extended }
  { ARB_sampler_objects }
  { ARB_explicit_attrib_location, but it has none }
  { ARB_occlusion_query2 (no entry points) }
  { ARB_shader_bit_encoding (no entry points) }
  { ARB_texture_rgb10_a2ui (no entry points) }
  { ARB_texture_swizzle (no entry points) }
  { ARB_timer_query }
  { ARB_vertex_type_2_10_10_10_rev }
  TglVertexAttribDivisor = procedure(index: GLuint; divisor: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_VERSION_4_0
  { OpenGL 4.0 also reuses entry points from these extensions: }
  { ARB_texture_query_lod (no entry points) }
  { ARB_draw_indirect }
  { ARB_gpu_shader5 (no entry points) }
  { ARB_gpu_shader_fp64 }
  { ARB_shader_subroutine }
  { ARB_tessellation_shader }
  { ARB_texture_buffer_object_rgb32 (no entry points) }
  { ARB_texture_cube_map_array (no entry points) }
  { ARB_texture_gather (no entry points) }
  { ARB_transform_feedback2 }
  { ARB_transform_feedback3 }
  TglMinSampleShading = procedure(value: GLclampf); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBlendEquationi = procedure(buf: GLuint; mode: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBlendEquationSeparatei = procedure(buf: GLuint; modeRGB: GLenum; modeAlpha: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBlendFunci = procedure(buf: GLuint; src: GLenum; dst: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBlendFuncSeparatei = procedure(buf: GLuint; srcRGB: GLenum; dstRGB: GLenum; srcAlpha: GLenum; dstAlpha: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_VERSION_4_1
  { OpenGL 4.1 also reuses entry points from these extensions: }
  { ARB_ES2_compatibility }
  { ARB_get_program_binary }
  { ARB_separate_shader_objects }
  { ARB_shader_precision (no entry points) }
  { ARB_vertex_attrib_64bit }
  { ARB_viewport_array }

  // GL_ARB_framebuffer_object
  TglIsRenderbuffer = function(renderbuffer: GLuint): GLboolean; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBindRenderbuffer = procedure(target: GLenum; renderbuffer: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDeleteRenderbuffers = procedure(n: GLsizei; const renderbuffers: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGenRenderbuffers = procedure(n: GLsizei; renderbuffers: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglRenderbufferStorage = procedure(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetRenderbufferParameteriv = procedure(target: GLenum; pname: GLenum; params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglIsFramebuffer = function(framebuffer: GLuint): GLboolean; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBindFramebuffer = procedure(target: GLenum; framebuffer: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDeleteFramebuffers = procedure(n: GLsizei; const framebuffers: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGenFramebuffers = procedure(n: GLsizei; framebuffers: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCheckFramebufferStatus = function(target: GLenum): GLenum; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglFramebufferTexture1D = procedure(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglFramebufferTexture2D = procedure(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglFramebufferTexture3D = procedure(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; zoffset: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglFramebufferRenderbuffer = procedure(target: GLenum; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetFramebufferAttachmentParameteriv = procedure(target: GLenum; attachment: GLenum; pname: GLenum; params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGenerateMipmap = procedure(target: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBlitFramebuffer = procedure(srcX0: GLint; srcY0: GLint; srcX1: GLint; srcY1: GLint; dstX0: GLint; dstY0: GLint; dstX1: GLint; dstY1: GLint; mask: GLbitfield; filter: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglRenderbufferStorageMultisample = procedure(target: GLenum; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglFramebufferTextureLayer = procedure(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_map_buffer_range
  TglMapBufferRange = function(target: GLenum; offset: GLintptr; length: GLsizeiptr; access: GLbitfield): PGLvoid; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglFlushMappedBufferRange = procedure(target: GLenum; offset: GLintptr; length: GLsizeiptr); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_vertex_array_object
  TglBindVertexArray = procedure(array_: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDeleteVertexArrays = procedure(n: GLsizei; const arrays: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGenVertexArrays = procedure(n: GLsizei; arrays: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglIsVertexArray = function(array_: GLuint): GLboolean; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_uniform_buffer_object
  TglGetUniformIndices = procedure(program_: GLuint; uniformCount: GLsizei; const uniformNames: PPGLchar; uniformIndices: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetActiveUniformsiv = procedure(program_: GLuint; uniformCount: GLsizei; const uniformIndices: PGLuint; pname: GLenum; params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetActiveUniformName = procedure(program_: GLuint; uniformIndex: GLuint; bufSize: GLsizei; length: PGLsizei; uniformName: PGLchar); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetUniformBlockIndex = function(program_: GLuint; const uniformBlockName: PGLchar): GLuint; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetActiveUniformBlockiv = procedure(program_: GLuint; uniformBlockIndex: GLuint; pname: GLenum; params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetActiveUniformBlockName = procedure(program_: GLuint; uniformBlockIndex: GLuint; bufSize: GLsizei; length: PGLsizei; uniformBlockName: PGLchar); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniformBlockBinding = procedure(program_: GLuint; uniformBlockIndex: GLuint; uniformBlockBinding: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_copy_buffer
  TglCopyBufferSubData = procedure(readTarget: GLenum; writeTarget: GLenum; readOffset: GLintptr; writeOffset: GLintptr; size: GLsizeiptr); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_draw_elements_base_vertex
  TglDrawElementsBaseVertex = procedure(mode: GLenum; count: GLsizei; type_: GLenum; const indices: PGLvoid; basevertex: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDrawRangeElementsBaseVertex = procedure(mode: GLenum; start: GLuint; end_: GLuint; count: GLsizei; type_: GLenum; const indices: PGLvoid; basevertex: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDrawElementsInstancedBaseVertex = procedure(mode: GLenum; count: GLsizei; type_: GLenum; const indices: PGLvoid; primcount: GLsizei; basevertex: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiDrawElementsBaseVertex = procedure(mode: GLenum; const count: PGLsizei; type_: GLenum; const indices: PPGLvoid; primcount: GLsizei; const basevertex: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_provoking_vertex
  TglProvokingVertex = procedure(mode: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_sync
  TglFenceSync = function(condition: GLenum; flags: GLbitfield): GLsync; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglIsSync = function(sync: GLsync): GLboolean; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDeleteSync = procedure(sync: GLsync); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglClientWaitSync = function(sync: GLsync; flags: GLbitfield; timeout: GLuint64): GLenum; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglWaitSync = procedure(sync: GLsync; flags: GLbitfield; timeout: GLuint64); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetInteger64v = procedure(pname: GLenum; params: PGLint64); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetSynciv = procedure(sync: GLsync; pname: GLenum; butSize: GLsizei; length: PGLsizei; values: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_texture_multisample
  TglTexImage2DMultisample = procedure(target: GLenum; samples: GLsizei; internalformat: GLint; width: GLsizei; height: GLsizei; fixedsamplelocations: GLboolean); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTexImage3DMultisample = procedure(target: GLenum; samples: GLsizei; internalformat: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; fixedsamplelocations: GLboolean); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetMultisamplefv = procedure(pname: GLenum; index_: GLuint; val: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSampleMaski = procedure(index_: GLuint; mask: GLbitfield); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_blend_func_extended
  TglBindFragDataLocationIndexed = procedure(program_: GLuint; colorNumber: GLuint; index: GLuint; const name: PGLchar); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetFragDataIndex = function(program_: GLuint; const name: PGLchar): GLint; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_sampler_objects
  TglGenSamplers = procedure(count: GLsizei; samplers: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDeleteSamplers = procedure(count: GLsizei; const samplers: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglIsSampler = function(sampler: GLuint): GLboolean; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBindSampler = procedure(unit_: GLuint; sampler: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSamplerParameteri = procedure(sampler: GLuint; pname: GLenum; param: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSamplerParameteriv = procedure(sampler: GLuint; pname: GLenum; const param: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSamplerParameterf = procedure(sampler: GLuint; pname: GLenum; param: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSamplerParameterfv = procedure(sampler: GLuint; pname: GLenum; const param: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSamplerParameterIiv = procedure(sampler: GLuint; pname: GLenum; const param: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSamplerParameterIuiv = procedure(sampler: GLuint; pname: GLenum; const param: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetSamplerParameteriv = procedure(sampler: GLuint; pname: GLenum; params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetSamplerParameterIiv = procedure(sampler: GLuint; pname: GLenum; params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetSamplerParameterfv = procedure(sampler: GLuint; pname: GLenum; params: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetSamplerParameterIuiv = procedure(sampler: GLuint; pname: GLenum; params: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_timer_query
  TglQueryCounter = procedure(id: GLuint; target: GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetQueryObjecti64v = procedure(id: GLuint; pname: GLenum; params: PGLint64); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetQueryObjectui64v = procedure(id: GLuint; pname: GLenum; params: PGLuint64); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_vertex_type_2_10_10_10_rev
  TglVertexP2ui = procedure(type_: GLenum; value: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexP2uiv = procedure(type_: GLenum; const value: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexP3ui = procedure(type_: GLenum; value: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexP3uiv = procedure(type_: GLenum; const value: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexP4ui = procedure(type_: GLenum; value: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexP4uiv = procedure(type_: GLenum; const value: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTexCoordP1ui = procedure(type_: GLenum; coords: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTexCoordP1uiv = procedure(type_: GLenum; const coords: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTexCoordP2ui = procedure(type_: GLenum; coords: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTexCoordP2uiv = procedure(type_: GLenum; const coords: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTexCoordP3ui = procedure(type_: GLenum; coords: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTexCoordP3uiv = procedure(type_: GLenum; const coords: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTexCoordP4ui = procedure(type_: GLenum; coords: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTexCoordP4uiv = procedure(type_: GLenum; const coords: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoordP1ui = procedure(texture: GLenum; type_: GLenum; coords: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoordP1uiv = procedure(texture: GLenum; type_: GLenum; const coords: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoordP2ui = procedure(texture: GLenum; type_: GLenum; coords: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoordP2uiv = procedure(texture: GLenum; type_: GLenum; const coords: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoordP3ui = procedure(texture: GLenum; type_: GLenum; coords: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoordP3uiv = procedure(texture: GLenum; type_: GLenum; const coords: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoordP4ui = procedure(texture: GLenum; type_: GLenum; coords: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiTexCoordP4uiv = procedure(texture: GLenum; type_: GLenum; const coords: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglNormalP3ui = procedure(type_: GLenum; coords: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglNormalP3uiv = procedure(type_: GLenum; const coords: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglColorP3ui = procedure(type_: GLenum; color: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglColorP3uiv = procedure(type_: GLenum; const color: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglColorP4ui = procedure(type_: GLenum; color: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglColorP4uiv = procedure(type_: GLenum; const color: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSecondaryColorP3ui = procedure(type_: GLenum; color: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglSecondaryColorP3uiv = procedure(type_: GLenum; const color: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribP1ui = procedure(index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribP1uiv = procedure(index: GLuint; type_: GLenum; normalized: GLboolean; const value: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribP2ui = procedure(index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribP2uiv = procedure(index: GLuint; type_: GLenum; normalized: GLboolean; const value: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribP3ui = procedure(index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribP3uiv = procedure(index: GLuint; type_: GLenum; normalized: GLboolean; const value: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribP4ui = procedure(index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribP4uiv = procedure(index: GLuint; type_: GLenum; normalized: GLboolean; const value: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_draw_indirect
  TglDrawArraysIndirect = procedure(mode: GLenum; const indirect: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDrawElementsIndirect = procedure(mode: GLenum; type_: GLenum; const indirect: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_gpu_shader_fp64
  TglUniform1d = procedure(location: GLint; x: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform2d = procedure(location: GLint; x: GLdouble; y: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform3d = procedure(location: GLint; x: GLdouble; y: GLdouble; z: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform4d = procedure(location: GLint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform1dv = procedure(location: GLint; count: GLsizei; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform2dv = procedure(location: GLint; count: GLsizei; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform3dv = procedure(location: GLint; count: GLsizei; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniform4dv = procedure(location: GLint; count: GLsizei; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniformMatrix2dv = procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniformMatrix3dv = procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniformMatrix4dv = procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniformMatrix2x3dv = procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniformMatrix2x4dv = procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniformMatrix3x2dv = procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniformMatrix3x4dv = procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniformMatrix4x2dv = procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniformMatrix4x3dv = procedure(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetUniformdv = procedure(program_: GLuint; location: GLint; params: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_shader_subroutine
  TglGetSubroutineUniformLocation = function(program_: GLuint; shadertype: GLenum; const name: PGLchar): GLint; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetSubroutineIndex = function(program_: GLuint; shadertype: GLenum; const name: PGLchar): GLuint; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetActiveSubroutineUniformiv = procedure(program_: GLuint; shadertype: GLenum; index: GLuint; pname: GLenum; values: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetActiveSubroutineUniformName = procedure(program_: GLuint; shadertype: GLenum; index: GLuint; bufsize: GLsizei; length: PGLsizei; name: PGLchar); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetActiveSubroutineName = procedure(program_: GLuint; shadertype: GLenum; index: GLuint; bufsize: GLsizei; length: PGLsizei; name: PGLchar); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUniformSubroutinesuiv = procedure(shadertype: GLenum; count: GLsizei; const indices: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetUniformSubroutineuiv = procedure(shadertype: GLenum; location: GLint; params: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetProgramStageiv = procedure(program_: GLuint; shadertype: GLenum; pname: GLenum; values: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_tessellation_shader
  TglPatchParameteri = procedure(pname: GLenum; value: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglPatchParameterfv = procedure(pname: GLenum; const values: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_transform_feedback2
  TglBindTransformFeedback = procedure(target: GLenum; id: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDeleteTransformFeedbacks = procedure(n: GLsizei; const ids: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGenTransformFeedbacks = procedure(n: GLsizei; ids: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglIsTransformFeedback = function(id: GLuint): GLboolean; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglPauseTransformFeedback = procedure(); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglResumeTransformFeedback = procedure(); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDrawTransformFeedback = procedure(mode: GLenum; id: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_transform_feedback3
  TglDrawTransformFeedbackStream = procedure(mode: GLenum; id: GLuint; stream: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBeginQueryIndexed = procedure(target: GLenum; index: GLuint; id: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglEndQueryIndexed = procedure(target: GLenum; index: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetQueryIndexediv = procedure(target: GLenum; index: GLuint; pname: GLenum; params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_ES2_compatibility
  TglReleaseShaderCompiler = procedure(); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglShaderBinary = procedure(count: GLsizei; const shaders: PGLuint; binaryformat: GLenum; const binary: PGLvoid; length: GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetShaderPrecisionFormat = procedure(shadertype: GLenum; precisiontype: GLenum; range: PGLint; precision: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDepthRangef = procedure(n: GLclampf; f: GLclampf); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglClearDepthf = procedure(d: GLclampf); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_get_program_binary
  TglGetProgramBinary = procedure(program_: GLuint; bufSize: GLsizei; length: PGLsizei; binaryFormat: PGLenum; binary: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramBinary = procedure(program_: GLuint; binaryFormat: GLenum; const binary: PGLvoid; length: GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramParameteri = procedure(program_: GLuint; pname: GLenum; value: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_separate_shader_objects
  TglUseProgramStages = procedure(pipeline: GLuint; stages: GLbitfield; program_: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglActiveShaderProgram = procedure(pipeline: GLuint; program_: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCreateShaderProgramv = function(type_: GLenum; count: GLsizei; const strings: PPGLchar): GLuint; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBindProgramPipeline = procedure(pipeline: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDeleteProgramPipelines = procedure(n: GLsizei; const pipelines: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGenProgramPipelines = procedure(n: GLsizei; pipelines: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglIsProgramPipeline = function(pipeline: GLuint): GLboolean; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetProgramPipelineiv = procedure(pipeline: GLuint; pname: GLenum; params: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform1i = procedure(program_: GLuint; location: GLint; v0: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform1iv = procedure(program_: GLuint; location: GLint; count: GLsizei; const value: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform1f = procedure(program_: GLuint; location: GLint; v0: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform1fv = procedure(program_: GLuint; location: GLint; count: GLsizei; const value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform1d = procedure(program_: GLuint; location: GLint; v0: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform1dv = procedure(program_: GLuint; location: GLint; count: GLsizei; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform1ui = procedure(program_: GLuint; location: GLint; v0: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform1uiv = procedure(program_: GLuint; location: GLint; count: GLsizei; const value: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform2i = procedure(program_: GLuint; location: GLint; v0: GLint; v1: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform2iv = procedure(program_: GLuint; location: GLint; count: GLsizei; const value: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform2f = procedure(program_: GLuint; location: GLint; v0: GLfloat; v1: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform2fv = procedure(program_: GLuint; location: GLint; count: GLsizei; const value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform2d = procedure(program_: GLuint; location: GLint; v0: GLdouble; v1: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform2dv = procedure(program_: GLuint; location: GLint; count: GLsizei; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform2ui = procedure(program_: GLuint; location: GLint; v0: GLuint; v1: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform2uiv = procedure(program_: GLuint; location: GLint; count: GLsizei; const value: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform3i = procedure(program_: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform3iv = procedure(program_: GLuint; location: GLint; count: GLsizei; const value: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform3f = procedure(program_: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform3fv = procedure(program_: GLuint; location: GLint; count: GLsizei; const value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform3d = procedure(program_: GLuint; location: GLint; v0: GLdouble; v1: GLdouble; v2: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform3dv = procedure(program_: GLuint; location: GLint; count: GLsizei; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform3ui = procedure(program_: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform3uiv = procedure(program_: GLuint; location: GLint; count: GLsizei; const value: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform4i = procedure(program_: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint; v3: GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform4iv = procedure(program_: GLuint; location: GLint; count: GLsizei; const value: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform4f = procedure(program_: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat; v3: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform4fv = procedure(program_: GLuint; location: GLint; count: GLsizei; const value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform4d = procedure(program_: GLuint; location: GLint; v0: GLdouble; v1: GLdouble; v2: GLdouble; v3: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform4dv = procedure(program_: GLuint; location: GLint; count: GLsizei; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform4ui = procedure(program_: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniform4uiv = procedure(program_: GLuint; location: GLint; count: GLsizei; const value: PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniformMatrix2fv = procedure(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniformMatrix3fv = procedure(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniformMatrix4fv = procedure(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniformMatrix2dv = procedure(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniformMatrix3dv = procedure(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniformMatrix4dv = procedure(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniformMatrix2x3fv = procedure(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniformMatrix3x2fv = procedure(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniformMatrix2x4fv = procedure(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniformMatrix4x2fv = procedure(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniformMatrix3x4fv = procedure(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniformMatrix4x3fv = procedure(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniformMatrix2x3dv = procedure(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniformMatrix3x2dv = procedure(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniformMatrix2x4dv = procedure(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniformMatrix4x2dv = procedure(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniformMatrix3x4dv = procedure(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglProgramUniformMatrix4x3dv = procedure(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglValidateProgramPipeline = procedure(pipeline: GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetProgramPipelineInfoLog = procedure(pipeline: GLuint; bufSize: GLsizei; length: PGLsizei; infoLog: PGLchar); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_vertex_attrib_64bit
  TglVertexAttribL1d = procedure(index: GLuint; x: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribL2d = procedure(index: GLuint; x: GLdouble; y: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribL3d = procedure(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribL4d = procedure(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribL1dv = procedure(index: GLuint; const v: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribL2dv = procedure(index: GLuint; const v: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribL3dv = procedure(index: GLuint; const v: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribL4dv = procedure(index: GLuint; const v: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribLPointer = procedure(index: GLuint; size: GLint; type_: GLenum; stride: GLsizei; const pointer: PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetVertexAttribLdv = procedure(index: GLuint; pname: GLenum; params: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_viewport_array
  TglViewportArrayv = procedure(first: GLuint; count: GLsizei; const v: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglViewportIndexedf = procedure(index: GLuint; x: GLfloat; y: GLfloat; w: GLfloat; h: GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglViewportIndexedfv = procedure(index: GLuint; const v: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglScissorArrayv = procedure(first: GLuint; count: GLsizei; const v: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglScissorIndexed = procedure(index: GLuint; left: GLint; bottom: GLint; width: GLsizei; height: GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglScissorIndexedv = procedure(index: GLuint; const v: PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDepthRangeArrayv = procedure(first: GLuint; count: GLsizei; const v: PGLclampd); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDepthRangeIndexed = procedure(index: GLuint; n: GLclampd; f: GLclampd); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetFloati_v = procedure(target: GLenum; index: GLuint; data: PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetDoublei_v = procedure(target: GLenum; index: GLuint; data: PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL 4.2

  // GL_ARB_base_instance
  TglDrawArraysInstancedBaseInstance = procedure(mode : GLenum; first : GLint; count :GLsizei; primcount : GLsizei; baseinstance : GLUint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDrawElementsInstancedBaseInstance = procedure(mode : GLEnum; count : GLsizei; _type : GLenum; const indices : PGLVoid; primcount : GLsizei; baseinstance : GLUInt); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDrawElementsInstancedBaseVertexBaseInstance = procedure(mode : GLEnum; count : GLsizei; _type : GLenum; const indices : PGLVoid; primcount :GLsizei; basevertex : GLint; baseinstance : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_transform_feedback_instanced
  TglDrawTransformFeedbackInstanced = procedure(mode : GLenum; id : GLuint; primcount : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDrawTransformFeedbackStreamInstanced = procedure(mode : GLenum; id : GLUInt; stream : GLUint; primcount : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_internalformat_query
  TglGetInternalformativ = procedure(target : GLenum; internalformat : GLenum; pname : GLenum; bufSize : GLsizei; params : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_shader_atomic_counters
  TglGetActiveAtomicCounterBufferiv = procedure(_program : GLuint; bufferIndex : GLuint; pname : GLenum; params : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  /// GL_ARB_shader_image_load_store
  TglBindImageTexture = procedure(_unit : GLuint; texture : GLuint; level :GLint; layered : GLboolean; layer : GLint; access : GLenum; format : GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMemoryBarrier = procedure(barriers : GLbitfield); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_texture_storage
  TglTexStorage1D = procedure(target : GLenum; levels :GLsizei; internalformat : GLenum; width : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTexStorage2D = procedure(target : GLenum; levels :GLsizei; internalformat : GLenum; width : GLsizei; height : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTexStorage3D = procedure(target : GLenum; levels :GLsizei; internalformat : GLenum; width : GLsizei; height : GLsizei; depth : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL 4.3
  // GL_ARB_clear_buffer_object
  TglClearBufferData = procedure(target : GLenum; internalformat : GLenum; format : GLEnum; type_ : GLEnum; const data : Pointer); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglClearBufferSubData = procedure(target : GLenum; internalformat : GLenum; offset : GLintptr; size : GLsizeiptr; format : GLenum; type_ : GLenum; const data : Pointer); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_compute_shader
  TglDispatchCompute = procedure(num_groups_x : GLuint; num_groups_y : GLuint; num_groups_z : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDispatchComputeIndirect = procedure(indirect : GLintptr); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_copy_image
  TglCopyImageSubData = procedure(srcName : GLUInt; srcTarget : GLenum; srcLevel : GLint; srcX : GLint; srcY : GLint; srcZ : GLint; dstName : GLUInt; dstTarget : GLEnum; dstLevel : GLInt; dstX : GLInt; dstY : GLint; dstZ : GLint; srcWidth : GLsizei; srcHeight : GLsizei; srcDepth : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_framebuffer_no_attachments
  TglFramebufferParameteri = procedure(target : GLenum; pname : GLenum; param : GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetFramebufferParameteriv = procedure(target : GLenum; pname : GLenum; params : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_internalformat_query2
  TglGetInternalformati64v = procedure(target : GLenum; internalformat : GLenum; pname : GLenum; bufSize : GLsizei; params : PGLint64); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_invalidate_subdata
  TglInvalidateTexSubImage = procedure(texture : GLuint; level : GLint; xoffset : GLint; yoffset : GLint; zoffset : GLint; width : GLsizei; height : GLsizei; depth : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglInvalidateTexImage = procedure(texture : GLuint; level : GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglInvalidateBufferSubData = procedure(buffer : GLuint; offset : GLintptr; length : GLsizeiptr); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglInvalidateBufferData = procedure(buffer : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglInvalidateFramebuffer = procedure(target : GLenum; numAttachments : GLsizei; const attachments : PGLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglInvalidateSubFramebuffer = procedure(target : GLenum; numAttachments : GLsizei; const attachments : PGLenum; x : GLint; y : GLint; width : GLsizei; height : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_multi_draw_indirect
  TglMultiDrawArraysIndirect = procedure(mode : GLenum; const indirect : Pointer; drawcount : GLsizei; stride : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMultiDrawElementsIndirect = procedure(mode : GLenum; type_ : GLenum; const indirect : Pointer; drawcount : GLsizei; stride : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_program_interface_query
  TglGetProgramInterfaceiv = procedure(program_ : GLUInt;programInterface : GLenum; pname : GLenum; params : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetProgramResourceIndex = function(program_ : GLUInt;programInterface : GLenum; const name : PGLchar) : GLUInt; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetProgramResourceName = procedure(program_ : GLUInt;programInterface : GLenum; index : GLuint; bufSize : GLsizei; length : PGLsizei; name : PGLchar); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetProgramResourceiv = procedure(program_ : GLUInt;programInterface : GLenum; index : GLuint; propCount : GLsizei; const props : PGLenum; bufSize : GLsizei; length : PGLsizei; params : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetProgramResourceLocation = function(program_ : GLUInt;programInterface : GLenum; const name : PGLchar) : GLInt; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetProgramResourceLocationIndex = function(program_ : GLUInt;programInterface : GLenum; const name : PGLchar) : GLInt; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_robust_buffer_access_behavior

  // GL_ARB_shader_image_size

  // GL_ARB_shader_storage_buffer_object
  TglShaderStorageBlockBinding = procedure(program_ : GLuint; storageBlockIndex : GLuint; storageBlockBinding : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_stencil_texturing

  // GL_ARB_texture_buffer_range
  TglTexBufferRange = procedure(target : GLenum; internalformat : GLenum; buffer : GLuint; offset :GLintptr; size : GLsizeiptr); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_texture_query_levels

  // GL_ARB_texture_storage_multisample
  TglTexStorage2DMultisample = procedure(target : GLenum; samples : GLsizei; internalformat : GLenum; width : GLsizei; height : GLsizei; fixedsamplelocations : GLboolean); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTexStorage3DMultisample = procedure(target : GLenum; samples : GLsizei; internalformat : GLenum; width : GLsizei; height : GLsizei; depth : GLsizei; fixedsamplelocations : GLboolean); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL 4.4
  TglBufferStorage = procedure(target : GLenum; size : GLsizeiptr; const data : pointer; flags : GLbitfield); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglClearTexImage = procedure(texture : GLuint; level : GLint; format : GLenum; _type : GLenum; const data : Pointer); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglClearTexSubImage = procedure(texture : GLuint; level : GLint; xoffset : GLint; yoffset : GLint; zoffset : GLint; width : GLsizei; height : GLsizei; depth : GLsizei; format : GLenum; _type : GLenum; const Data : Pointer); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBindBuffersBase = procedure(target : GLenum; first : GLuint; count : GLsizei; const buffers : PGLUint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBindBuffersRange = procedure(target : GLenum; first : GLuint; count : GLsizei; const buffers : PGLuint; const offsets : GLintptr; const sizes : GLsizeiptr); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBindTextures = procedure(first : GLuint; count : GLsizei; const textures : PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBindSamplers = procedure(first : GLuint; count : GLsizei; const samplers : PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBindImageTextures = procedure(first : GLuint; count : GLsizei; const textures : PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBindVertexBuffers = procedure(first : GLuint; count : GLsizei; const buffers : GLuint; const offsets : GLintptr; const strides : PGLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL 4.5
  TglClipControl = procedure(origin : GLenum; depth : GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCreateTransformFeedbacks = procedure(n : GLsizei; ids : PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTransformFeedbackBufferBase = procedure (xfb : GLuint; index : GLuint; buffer : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTransformFeedbackBufferRange = procedure (xfb : GLuint; index : GLuint; buffer : GLuint; offset : GLintptr; size : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetTransformFeedbackiv = procedure (xfb : GLuint; pname : GLenum; param : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetTransformFeedbacki_v = procedure (xfb : GLuint; pname : GLenum; index : GLuint; param : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetTransformFeedbacki64_v = procedure (xfb : GLuint; pname : GLenum; index : GLuint; param : PGLint64); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCreateBuffers = procedure (n : GLsizei; buffers : PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglNamedBufferStorage = procedure (buffer : GLuint; size : GLsizei; const data : PGLVoid; flags : GLbitfield); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglNamedBufferData = procedure (buffer : GLuint; size : GLsizei; const data : PGLVoid; usage : GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglNamedBufferSubData = procedure (buffer : GLuint; offset : GLintptr; size : GLsizei; data : PGLVoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCopyNamedBufferSubData = procedure (readBuffer : GLuint; writeBuffer : GLuint; readOffset : GLintptr; writeOffset : GLintptr; size : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglClearNamedBufferData = procedure (buffer : GLuint; internalformat : GLenum; format : GLenum; _type : GLenum; data : PGLVoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglClearNamedBufferSubData = procedure (buffer : GLuint; internalformat : GLenum; offset : GLintptr; size : GLsizei; format : GLenum; _type : GLenum; data : PGLVoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMapNamedBuffer = function(buffer : GLuint; access : GLenum) : PGLvoid; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMapNamedBufferRange = function(buffer : GLuint; offset : GLintptr; length : GLsizei; access : GLbitfield) : PGLvoid; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglUnmapNamedBuffer = function(buffer : GLuint) : GLboolean; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglFlushMappedNamedBufferRange = procedure (buffer : GLuint; offset : GLintptr; length : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetNamedBufferParameteriv = procedure (buffer : GLuint; pname : GLenum; param : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetNamedBufferParameteri64v = procedure (buffer : GLuint; pname : GLenum; param : PGLint64); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetNamedBufferPointerv = procedure (buffer : GLuint; pname : GLenum; params : PGLVoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetNamedBufferSubData = procedure (buffer : GLuint; offset : GLintptr; size : GLsizei; data : PGLVoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCreateFramebuffers = procedure (n : GLsizei; framebuffers : PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglNamedFramebufferRenderbuffer = procedure (framebuffer : GLuint; attachment : GLenum ; renderbuffertarget : GLEnum; renderbuffer : GLUInt); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglNamedFramebufferParameteri = procedure (framebuffer : GLuint; pname : GLenum; param : GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglNamedFramebufferTexture = procedure (framebuffer : GLuint; attachment : GLenum; texture : GLuint; level : GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglNamedFramebufferTextureLayer = procedure (framebuffer : GLuint; attachment : GLenum; texture : GLuint; level : GLint; layer : GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglNamedFramebufferDrawBuffer = procedure (framebuffer : GLuint; buf : GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglNamedFramebufferDrawBuffers = procedure (framebuffer : GLuint; n : GLsizei; bufs : PGLEnum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglNamedFramebufferReadBuffer = procedure (framebuffer : GLuint; src : GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglInvalidateNamedFramebufferData = procedure (framebuffer : GLuint; numAttachments : GLSizei; attachments : PGLEnum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglInvalidateNamedFramebufferSubData = procedure (framebuffer : GLuint; numAttachments : GLSizei; attachments : PGLEnum; x : GLint; y : GLint; width : GLsizei; height : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglClearNamedFramebufferiv = procedure (framebuffer : GLuint; buffer : GLenum; drawbuffer : GLint; value : PGLInt); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglClearNamedFramebufferuiv = procedure (framebuffer : GLuint; buffer : GLenum; drawbuffer : GLint; value : PGLInt); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglClearNamedFramebufferfv = procedure (framebuffer : GLuint; buffer : GLenum; drawbuffer : GLint; value : PGLFloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglClearNamedFramebufferfi = procedure (framebuffer : GLuint; buffer : GLenum; const depth : GLfloat; stencil : GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBlitNamedFramebuffer = procedure (readFramebuffer : GLuint; drawFramebuffer : GLuint; srcX0 : GLint; srcY0 : GLint; srcX1 : GLint; srcY1 : GLint; dstX0 : GLint; dstY0 : GLint; dstX1 : GLint; dstY1 : GLint ; mask : GLbitfield; filter : GLenum); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCheckNamedFramebufferStatus = function(framebuffer : GLuint; target : GLenum) : GLenum; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetNamedFramebufferParameteriv = procedure (framebuffer : GLuint; pname : GLenum; param : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetNamedFramebufferAttachmentParameteriv = procedure (framebuffer : GLuint; attachment : GLenum; pname : GLenum; params : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCreateRenderbuffers = procedure (n : GLsizei; renderbuffers : PGLUInt); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglNamedRenderbufferStorage = procedure (renderbuffer : GLUInt; internalformat : GLenum ; width : GLsizei; height : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglNamedRenderbufferStorageMultisample = procedure (renderbuffer : GLUInt; samples : GLSizei; internalformat : GLenum ; width : GLSizei; height : GLSizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetNamedRenderbufferParameteriv = procedure (renderbuffer : GLUInt; pname : GLenum; param : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCreateTextures = procedure (target : GLenum ; n : GLsizei; textures : PGLUInt); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTextureBuffer = procedure (texture : GLuint; internalformat : GLenum; buffer : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTextureBufferRange = procedure (texture : GLuint; internalformat : GLenum; buffer : GLuint; offset : GLintptr; size : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTextureStorage1D = procedure (texture : GLuint; levels : GLsizei; internalformat : GLenum; width : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTextureStorage2D = procedure (texture : GLuint; levels : GLsizei; internalformat : GLenum; width : GLsizei; height : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTextureStorage3D = procedure (texture : GLuint; levels : GLsizei; internalformat : GLenum; width : GLsizei; height : GLsizei; depth : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTextureStorage2DMultisample = procedure (texture : GLuint; samples : GLsizei; internalformat : GLenum; width : GLsizei; height : GLsizei; fixedsamplelocations : GLboolean); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTextureStorage3DMultisample = procedure (texture : GLuint; samples : GLsizei; internalformat : GLenum; width : GLsizei; height : GLsizei; depth : GLsizei; fixedsamplelocations : GLboolean); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTextureSubImage1D = procedure (texture : GLuint; level : GLint; xoffset : GLint; width : GLsizei; format : GLenum; _type : GLenum; pixels : PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTextureSubImage2D = procedure (texture : GLuint; level : GLint; xoffset : GLint; yoffset : GLint; width : GLsizei; height : GLsizei; format : GLenum; _type : GLenum; pixels : PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTextureSubImage3D = procedure (texture : GLuint; level : GLint; xoffset : GLint; yoffset : GLint; zoffset : GLint; width : GLsizei; height : GLsizei; depth : GLsizei; format : GLenum; _type : GLenum; pixels : PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCompressedTextureSubImage1D = procedure (texture : GLuint; level : GLint; xoffset : GLint; width : GLsizei; format : GLenum; imageSize : GLsizei; data : PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCompressedTextureSubImage2D = procedure (texture : GLuint; level : GLint; xoffset : GLint; yoffset : GLint; width : GLsizei; height : GLsizei; format : GLenum; mageSize : GLsizei; data : PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCompressedTextureSubImage3D = procedure (texture : GLuint; level : GLint; xoffset : GLint; yoffset : GLint; zoffset : GLint; width : GLsizei; height : GLsizei; depth : GLsizei; format : GLenum; imageSize : GLsizei; data : PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCopyTextureSubImage1D = procedure (texture : GLuint; level : GLint ; xoffset : GLint; x : GLint; y : GLint; width : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCopyTextureSubImage2D = procedure (texture : GLuint; level : GLint ; xoffset : GLint; yoffset : GLint; x : GLint; y : GLint; width : GLsizei; height : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCopyTextureSubImage3D = procedure (texture : GLuint; level : GLint ; xoffset : GLint; yoffset : GLint; zoffset : GLint; x : GLint; y : GLint; width : GLsizei; height : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTextureParameterf = procedure (texture : GLuint; pname : GLenum; param : GLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTextureParameterfv = procedure (texture : GLuint; pname : GLenum; const param : PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTextureParameteri = procedure (texture : GLuint; pname : GLenum; param : GLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTextureParameterIiv = procedure (texture : GLuint; pname : GLenum; const params : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTextureParameterIuiv = procedure (texture : GLuint; pname : GLenum; const params : PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTextureParameteriv = procedure (texture : GLuint; pname : GLenum; const param : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGenerateTextureMipmap = procedure(texture : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglBindTextureUnit = procedure (_unit : GLuint; texture : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetTextureImage = procedure (texture : GLuint; level : GLint ; format : GLenum; _type : GLenum; bufSize : GLsizei; pixels : PGLVoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetCompressedTextureImage = procedure (texture : GLuint; level : GLint; bufSize : GLSizei; pixels : PGLVoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetTextureLevelParameterfv = procedure (texture : GLuint; level : GLint; pname : GLenum; params : PGLFloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetTextureLevelParameteriv = procedure (texture : GLuint; level : GLint; pname : GLenum; param : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetTextureParameterfv = procedure (texture : GLuint; pname : GLenum; params : PGLFloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetTextureParameterIiv = procedure (texture : GLuint; pname : GLenum; params : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetTextureParameterIuiv = procedure (texture : GLuint; pname : GLenum; params : PGLInt); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetTextureParameteriv = procedure (texture : GLuint; pname : GLenum; params : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCreateVertexArrays = procedure (n : GLsizei; arrays : PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglDisableVertexArrayAttrib = procedure (vaobj : GLuint; index : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglEnableVertexArrayAttrib = procedure (vaobj : GLuint; index : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexArrayElementBuffer = procedure (vaobj : GLuint; buffer : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexArrayVertexBuffer = procedure (vaobj : GLuint; bindingindex : GLuint; buffer : GLuint; offset : GLintptr; stride : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexArrayVertexBuffers = procedure (vaobj : GLuint; first : GLuint; count : GLsizei; const buffers : PGLuint; const offsets : PGLintptr; const strides : PGLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexArrayAttribBinding = procedure (vaobj : GLuint; attribindex : GLuint; bindingindex : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexArrayAttribFormat = procedure(vaobj : GLuint; attribindex : GLuint; size : GLint; _type : GLenum; normalized : GLboolean; relativeoffset : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexArrayAttribIFormat = procedure (vaobj : GLuint; attribindex : GLuint; size : GLint; _type : GLenum; relativeoffset : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexArrayAttribLFormat = procedure (vaobj : GLuint; attribindex : GLuint; size : GLint; _type : GLenum; relativeoffset : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexArrayBindingDivisor = procedure (vaobj : GLuint; bindingindex : GLuint; divisor : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetVertexArrayiv = procedure (vaobj : GLuint; pname : GLenum; param : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetVertexArrayIndexediv = procedure (vaobj : GLuint; index : GLuint; pname : GLenum; param : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetVertexArrayIndexed64iv = procedure (vaobj : GLuint; index : GLuint; pname : GLenum; param : PGLint64); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCreateSamplers = procedure (n : GLsizei; samplers : PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCreateProgramPipelines = procedure (n : GLsizei; pipelines : PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglCreateQueries = procedure (target : GLenum; n : GLsizei; ids : PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglMemoryBarrierByRegion = procedure (barriers : GLbitfield); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetTextureSubImage = procedure (texture : GLuint; level : GLint ; xoffset : GLint; yoffset : GLint; zoffset : GLint; width : GLsizei; height : GLsizei; depth : GLsizei; format : GLenum; _type : GLenum; bufSize : GLsizei; pixels : PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetCompressedTextureSubImage = procedure (texture : GLuint; level : GLint ; xoffset : GLint; yoffset : GLint; zoffset : GLint; width : GLsizei; height : GLsizei; depth : GLsizei; bufSize : GLsizei; pixels : PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetGraphicsResetStatus = function : GLEnum; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetnCompressedTexImage = procedure (target : GLenum; lod : GLint; bufSize : GLsizei; pixels : PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetnTexImage = procedure (target : GLenum; level : GLint; format : GLenum; _type : GLenum; bufSize : GLSizei; pixels : PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetnUniformdv = procedure (_program : GLuint; location : GLint; bufSize : GLsizei; params : PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetnUniformfv = procedure (_program : GLuint; location : GLint; bufSize : GLsizei; params : PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetnUniformiv = procedure (_program : GLuint; location : GLint; bufSize : GLsizei; params : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetnUniformuiv = procedure (_program : GLuint; location : GLint; bufSize : GLsizei; params : PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglReadnPixels = procedure (x : GLint; y : GLint; width : GLsizei; height : GLsizei; format : GLenum; _type : GLenum; bufSize : GLsizei; data : PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetnMapdv = procedure (target : GLenum; query : GLenum; bufSize : GLsizei; v : PGLdouble); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetnMapfv = procedure (target : GLenum; query : GLenum; bufSize : GLsizei; v : PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetnMapiv = procedure (target : GLenum; query : GLenum; bufSize : GLsizei; v : PGLint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetnPixelMapfv = procedure (map : GLenum; bufSize : GLsizei; values : PGLfloat); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetnPixelMapuiv = procedure (map : GLenum; bufSize : GLsizei; values : PGLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetnPixelMapusv = procedure (map : GLenum; bufSize : GLsizei; values : PGLushort); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetnPolygonStipple = procedure (bufSize : GLsizei; pattern : PGLubyte); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetnColorTable = procedure (target : GLenum; format : GLenum; _type : GLenum; bufSize : GLsizei; table : PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetnConvolutionFilter = procedure (target : GLenum; format : GLenum; _type : GLenum; bufSize : GLsizei; image : PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetnSeparableFilter = procedure (target : GLenum; format : GLenum; _type : GLenum; rowBufSize : GLsizei; row : PGLvoid; columnBufSize : GLsizei; column : PGLvoid; span : PGLVoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetnHistogram = procedure (target : GLenum; reset : GLboolean; format : GLenum; _type : GLenum; bufSize : GLsizei; values : PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglGetnMinmax = procedure (target : GLenum; reset : GLboolean; format : GLenum; _type : GLenum; bufSize : GLsizei; values : PGLvoid); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglTextureBarrier = procedure; {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_texture_view
  TglTextureView = procedure(texture : GLuint; target : GLenum; origtexture : GLuint; internalformat : GLenum; minlevel : GLuint; numlevels : GLuint; minlayer : GLuint; numlayers : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

  // GL_ARB_vertex_attrib_binding
  TglBindVertexBuffer = procedure(bindingindex : GLuint; buffer : GLuint; offset : GLintptr; stride : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribFormat = procedure(attribindex : GLuint; size : GLInt; type_ : GLEnum; normalized : GLboolean; relativeoffset : GLUint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribIFormat = procedure(attribindex : GLuint; size : GLInt; type_ : GLEnum; relativeoffset : GLUint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribLFormat = procedure(attribindex : GLuint; size : GLInt; type_ : GLEnum; relativeoffset : GLUint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexAttribBinding = procedure(attribindex : GLuint; bindingindex : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexBindingDivisor = procedure(bindingindex : GLuint; divisor : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexArrayBindVertexBufferEXT = procedure(vaobj : GLuint; bindingindex : GLuint; buffer : GLuint; offset : GLintptr; stride : GLsizei); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexArrayVertexAttribFormatEXT = procedure(vaobj : GLuint; attribindex : GLuint; size : GLInt; type_ : GLEnum; normalized : GLboolean; relativeoffset : GLUint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexArrayVertexAttribIFormatEXT = procedure(vaobj : GLuint; attribindex : GLuint; size : GLInt; type_ : GLEnum; relativeoffset : GLUint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexArrayVertexAttribLFormatEXT = procedure(vaobj : GLuint; attribindex : GLuint; size : GLInt; type_ : GLEnum; relativeoffset : GLUint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexArrayVertexAttribBindingEXT = procedure(vaobj : GLuint; attribindex : GLuint; bindingindex : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}
  TglVertexArrayVertexBindingDivisorEXT = procedure(vaobj : GLuint; bindingindex : GLuint; divisor : GLuint); {$IFDEF DGL_WIN}stdcall; {$ELSE}cdecl; {$ENDIF}

var
  // GL_VERSION_1_2
  glBlendColor: TglBlendColor;
  glBlendEquation: TglBlendEquation;
  glDrawRangeElements: TglDrawRangeElements;
  glTexImage3D: TglTexImage3D;
  glTexSubImage3D: TglTexSubImage3D;
  glCopyTexSubImage3D: TglCopyTexSubImage3D;
  glColorTable: TglColorTable;
  glColorTableParameterfv: TglColorTableParameterfv;
  glColorTableParameteriv: TglColorTableParameteriv;
  glCopyColorTable: TglCopyColorTable;
  glGetColorTable: TglGetColorTable;
  glGetColorTableParameterfv: TglGetColorTableParameterfv;
  glGetColorTableParameteriv: TglGetColorTableParameteriv;
  glColorSubTable: TglColorSubTable;
  glCopyColorSubTable: TglCopyColorSubTable;
  glConvolutionFilter1D: TglConvolutionFilter1D;
  glConvolutionFilter2D: TglConvolutionFilter2D;
  glConvolutionParameterf: TglConvolutionParameterf;
  glConvolutionParameterfv: TglConvolutionParameterfv;
  glConvolutionParameteri: TglConvolutionParameteri;
  glConvolutionParameteriv: TglConvolutionParameteriv;
  glCopyConvolutionFilter1D: TglCopyConvolutionFilter1D;
  glCopyConvolutionFilter2D: TglCopyConvolutionFilter2D;
  glGetConvolutionFilter: TglGetConvolutionFilter;
  glGetConvolutionParameterfv: TglGetConvolutionParameterfv;
  glGetConvolutionParameteriv: TglGetConvolutionParameteriv;
  glGetSeparableFilter: TglGetSeparableFilter;
  glSeparableFilter2D: TglSeparableFilter2D;
  glGetHistogram: TglGetHistogram;
  glGetHistogramParameterfv: TglGetHistogramParameterfv;
  glGetHistogramParameteriv: TglGetHistogramParameteriv;
  glGetMinmax: TglGetMinmax;
  glGetMinmaxParameterfv: TglGetMinmaxParameterfv;
  glGetMinmaxParameteriv: TglGetMinmaxParameteriv;
  glHistogram: TglHistogram;
  glMinmax: TglMinmax;
  glResetHistogram: TglResetHistogram;
  glResetMinmax: TglResetMinmax;
  // GL_VERSION_1_3
  glActiveTexture: TglActiveTexture;
  glSampleCoverage: TglSampleCoverage;
  glCompressedTexImage3D: TglCompressedTexImage3D;
  glCompressedTexImage2D: TglCompressedTexImage2D;
  glCompressedTexImage1D: TglCompressedTexImage1D;
  glCompressedTexSubImage3D: TglCompressedTexSubImage3D;
  glCompressedTexSubImage2D: TglCompressedTexSubImage2D;
  glCompressedTexSubImage1D: TglCompressedTexSubImage1D;
  glGetCompressedTexImage: TglGetCompressedTexImage;
  glClientActiveTexture: TglClientActiveTexture;
  glMultiTexCoord1d: TglMultiTexCoord1d;
  glMultiTexCoord1dv: TglMultiTexCoord1dv;
  glMultiTexCoord1f: TglMultiTexCoord1f;
  glMultiTexCoord1fv: TglMultiTexCoord1fv;
  glMultiTexCoord1i: TglMultiTexCoord1i;
  glMultiTexCoord1iv: TglMultiTexCoord1iv;
  glMultiTexCoord1s: TglMultiTexCoord1s;
  glMultiTexCoord1sv: TglMultiTexCoord1sv;
  glMultiTexCoord2d: TglMultiTexCoord2d;
  glMultiTexCoord2dv: TglMultiTexCoord2dv;
  glMultiTexCoord2f: TglMultiTexCoord2f;
  glMultiTexCoord2fv: TglMultiTexCoord2fv;
  glMultiTexCoord2i: TglMultiTexCoord2i;
  glMultiTexCoord2iv: TglMultiTexCoord2iv;
  glMultiTexCoord2s: TglMultiTexCoord2s;
  glMultiTexCoord2sv: TglMultiTexCoord2sv;
  glMultiTexCoord3d: TglMultiTexCoord3d;
  glMultiTexCoord3dv: TglMultiTexCoord3dv;
  glMultiTexCoord3f: TglMultiTexCoord3f;
  glMultiTexCoord3fv: TglMultiTexCoord3fv;
  glMultiTexCoord3i: TglMultiTexCoord3i;
  glMultiTexCoord3iv: TglMultiTexCoord3iv;
  glMultiTexCoord3s: TglMultiTexCoord3s;
  glMultiTexCoord3sv: TglMultiTexCoord3sv;
  glMultiTexCoord4d: TglMultiTexCoord4d;
  glMultiTexCoord4dv: TglMultiTexCoord4dv;
  glMultiTexCoord4f: TglMultiTexCoord4f;
  glMultiTexCoord4fv: TglMultiTexCoord4fv;
  glMultiTexCoord4i: TglMultiTexCoord4i;
  glMultiTexCoord4iv: TglMultiTexCoord4iv;
  glMultiTexCoord4s: TglMultiTexCoord4s;
  glMultiTexCoord4sv: TglMultiTexCoord4sv;
  glLoadTransposeMatrixf: TglLoadTransposeMatrixf;
  glLoadTransposeMatrixd: TglLoadTransposeMatrixd;
  glMultTransposeMatrixf: TglMultTransposeMatrixf;
  glMultTransposeMatrixd: TglMultTransposeMatrixd;
  // GL_VERSION_1_4
  glBlendFuncSeparate: TglBlendFuncSeparate;
  glMultiDrawArrays: TglMultiDrawArrays;
  glMultiDrawElements: TglMultiDrawElements;
  glPointParameterf: TglPointParameterf;
  glPointParameterfv: TglPointParameterfv;
  glPointParameteri: TglPointParameteri;
  glPointParameteriv: TglPointParameteriv;
  glFogCoordf: TglFogCoordf;
  glFogCoordfv: TglFogCoordfv;
  glFogCoordd: TglFogCoordd;
  glFogCoorddv: TglFogCoorddv;
  glFogCoordPointer: TglFogCoordPointer;
  glSecondaryColor3b: TglSecondaryColor3b;
  glSecondaryColor3bv: TglSecondaryColor3bv;
  glSecondaryColor3d: TglSecondaryColor3d;
  glSecondaryColor3dv: TglSecondaryColor3dv;
  glSecondaryColor3f: TglSecondaryColor3f;
  glSecondaryColor3fv: TglSecondaryColor3fv;
  glSecondaryColor3i: TglSecondaryColor3i;
  glSecondaryColor3iv: TglSecondaryColor3iv;
  glSecondaryColor3s: TglSecondaryColor3s;
  glSecondaryColor3sv: TglSecondaryColor3sv;
  glSecondaryColor3ub: TglSecondaryColor3ub;
  glSecondaryColor3ubv: TglSecondaryColor3ubv;
  glSecondaryColor3ui: TglSecondaryColor3ui;
  glSecondaryColor3uiv: TglSecondaryColor3uiv;
  glSecondaryColor3us: TglSecondaryColor3us;
  glSecondaryColor3usv: TglSecondaryColor3usv;
  glSecondaryColorPointer: TglSecondaryColorPointer;
  glWindowPos2d: TglWindowPos2d;
  glWindowPos2dv: TglWindowPos2dv;
  glWindowPos2f: TglWindowPos2f;
  glWindowPos2fv: TglWindowPos2fv;
  glWindowPos2i: TglWindowPos2i;
  glWindowPos2iv: TglWindowPos2iv;
  glWindowPos2s: TglWindowPos2s;
  glWindowPos2sv: TglWindowPos2sv;
  glWindowPos3d: TglWindowPos3d;
  glWindowPos3dv: TglWindowPos3dv;
  glWindowPos3f: TglWindowPos3f;
  glWindowPos3fv: TglWindowPos3fv;
  glWindowPos3i: TglWindowPos3i;
  glWindowPos3iv: TglWindowPos3iv;
  glWindowPos3s: TglWindowPos3s;
  glWindowPos3sv: TglWindowPos3sv;
  // GL_VERSION_1_5
  glGenQueries: TglGenQueries;
  glDeleteQueries: TglDeleteQueries;
  glIsQuery: TglIsQuery;
  glBeginQuery: TglBeginQuery;
  glEndQuery: TglEndQuery;
  glGetQueryiv: TglGetQueryiv;
  glGetQueryObjectiv: TglGetQueryObjectiv;
  glGetQueryObjectuiv: TglGetQueryObjectuiv;
  glBindBuffer: TglBindBuffer;
  glDeleteBuffers: TglDeleteBuffers;
  glGenBuffers: TglGenBuffers;
  glIsBuffer: TglIsBuffer;
  glBufferData: TglBufferData;
  glBufferSubData: TglBufferSubData;
  glGetBufferSubData: TglGetBufferSubData;
  glMapBuffer: TglMapBuffer;
  glUnmapBuffer: TglUnmapBuffer;
  glGetBufferParameteriv: TglGetBufferParameteriv;
  glGetBufferPointerv: TglGetBufferPointerv;
  // GL_VERSION_2_0
  glBlendEquationSeparate: TglBlendEquationSeparate;
  glDrawBuffers: TglDrawBuffers;
  glStencilOpSeparate: TglStencilOpSeparate;
  glStencilFuncSeparate: TglStencilFuncSeparate;
  glStencilMaskSeparate: TglStencilMaskSeparate;
  glAttachShader: TglAttachShader;
  glBindAttribLocation: TglBindAttribLocation;
  glCompileShader: TglCompileShader;
  glCreateProgram: TglCreateProgram;
  glCreateShader: TglCreateShader;
  glDeleteProgram: TglDeleteProgram;
  glDeleteShader: TglDeleteShader;
  glDetachShader: TglDetachShader;
  glDisableVertexAttribArray: TglDisableVertexAttribArray;
  glEnableVertexAttribArray: TglEnableVertexAttribArray;
  glGetActiveAttrib: TglGetActiveAttrib;
  glGetActiveUniform: TglGetActiveUniform;
  glGetAttachedShaders: TglGetAttachedShaders;
  glGetAttribLocation: TglGetAttribLocation;
  glGetProgramiv: TglGetProgramiv;
  glGetProgramInfoLog: TglGetProgramInfoLog;
  glGetShaderiv: TglGetShaderiv;
  glGetShaderInfoLog: TglGetShaderInfoLog;
  glGetShaderSource: TglGetShaderSource;
  glGetUniformLocation: TglGetUniformLocation;
  glGetUniformfv: TglGetUniformfv;
  glGetUniformiv: TglGetUniformiv;
  glGetVertexAttribfv: TglGetVertexAttribfv;
  glGetVertexAttribiv: TglGetVertexAttribiv;
  glGetVertexAttribPointerv: TglGetVertexAttribPointerv;
  glIsProgram: TglIsProgram;
  glIsShader: TglIsShader;
  glLinkProgram: TglLinkProgram;
  glShaderSource: TglShaderSource;
  glUseProgram: TglUseProgram;
  glUniform1f: TglUniform1f;
  glUniform2f: TglUniform2f;
  glUniform3f: TglUniform3f;
  glUniform4f: TglUniform4f;
  glUniform1i: TglUniform1i;
  glUniform2i: TglUniform2i;
  glUniform3i: TglUniform3i;
  glUniform4i: TglUniform4i;
  glUniform1fv: TglUniform1fv;
  glUniform2fv: TglUniform2fv;
  glUniform3fv: TglUniform3fv;
  glUniform4fv: TglUniform4fv;
  glUniform1iv: TglUniform1iv;
  glUniform2iv: TglUniform2iv;
  glUniform3iv: TglUniform3iv;
  glUniform4iv: TglUniform4iv;
  glUniformMatrix2fv: TglUniformMatrix2fv;
  glUniformMatrix3fv: TglUniformMatrix3fv;
  glUniformMatrix4fv: TglUniformMatrix4fv;
  glValidateProgram: TglValidateProgram;
  glVertexAttrib1d: TglVertexAttrib1d;
  glVertexAttrib1dv: TglVertexAttrib1dv;
  glVertexAttrib1f: TglVertexAttrib1f;
  glVertexAttrib1fv: TglVertexAttrib1fv;
  glVertexAttrib1s: TglVertexAttrib1s;
  glVertexAttrib1sv: TglVertexAttrib1sv;
  glVertexAttrib2d: TglVertexAttrib2d;
  glVertexAttrib2dv: TglVertexAttrib2dv;
  glVertexAttrib2f: TglVertexAttrib2f;
  glVertexAttrib2fv: TglVertexAttrib2fv;
  glVertexAttrib2s: TglVertexAttrib2s;
  glVertexAttrib2sv: TglVertexAttrib2sv;
  glVertexAttrib3d: TglVertexAttrib3d;
  glVertexAttrib3dv: TglVertexAttrib3dv;
  glVertexAttrib3f: TglVertexAttrib3f;
  glVertexAttrib3fv: TglVertexAttrib3fv;
  glVertexAttrib3s: TglVertexAttrib3s;
  glVertexAttrib3sv: TglVertexAttrib3sv;
  glVertexAttrib4Nbv: TglVertexAttrib4Nbv;
  glVertexAttrib4Niv: TglVertexAttrib4Niv;
  glVertexAttrib4Nsv: TglVertexAttrib4Nsv;
  glVertexAttrib4Nub: TglVertexAttrib4Nub;
  glVertexAttrib4Nubv: TglVertexAttrib4Nubv;
  glVertexAttrib4Nuiv: TglVertexAttrib4Nuiv;
  glVertexAttrib4Nusv: TglVertexAttrib4Nusv;
  glVertexAttrib4bv: TglVertexAttrib4bv;
  glVertexAttrib4d: TglVertexAttrib4d;
  glVertexAttrib4dv: TglVertexAttrib4dv;
  glVertexAttrib4f: TglVertexAttrib4f;
  glVertexAttrib4fv: TglVertexAttrib4fv;
  glVertexAttrib4iv: TglVertexAttrib4iv;
  glVertexAttrib4s: TglVertexAttrib4s;
  glVertexAttrib4sv: TglVertexAttrib4sv;
  glVertexAttrib4ubv: TglVertexAttrib4ubv;
  glVertexAttrib4uiv: TglVertexAttrib4uiv;
  glVertexAttrib4usv: TglVertexAttrib4usv;
  glVertexAttribPointer: TglVertexAttribPointer;

  // GL_VERSION_2_1
  glUniformMatrix2x3fv: TglUniformMatrix2x3fv;
  glUniformMatrix3x2fv: TglUniformMatrix3x2fv;
  glUniformMatrix2x4fv: TglUniformMatrix2x4fv;
  glUniformMatrix4x2fv: TglUniformMatrix4x2fv;
  glUniformMatrix3x4fv: TglUniformMatrix3x4fv;
  glUniformMatrix4x3fv: TglUniformMatrix4x3fv;

  // GL_VERSION_3_0
  glColorMaski: TglColorMaski;
  glGetBooleani_v: TglGetBooleani_v;
  glGetIntegeri_v: TglGetIntegeri_v;
  glEnablei: TglEnablei;
  glDisablei: TglDisablei;
  glIsEnabledi: TglIsEnabledi;
  glBeginTransformFeedback: TglBeginTransformFeedback;
  glEndTransformFeedback: TglEndTransformFeedback;
  glBindBufferRange: TglBindBufferRange;
  glBindBufferBase: TglBindBufferBase;
  glTransformFeedbackVaryings: TglTransformFeedbackVaryings;
  glGetTransformFeedbackVarying: TglGetTransformFeedbackVarying;
  glClampColor: TglClampColor;
  glBeginConditionalRender: TglBeginConditionalRender;
  glEndConditionalRender: TglEndConditionalRender;
  glVertexAttribI1i: TglVertexAttribI1i;
  glVertexAttribI2i: TglVertexAttribI2i;
  glVertexAttribI3i: TglVertexAttribI3i;
  glVertexAttribI4i: TglVertexAttribI4i;
  glVertexAttribI1ui: TglVertexAttribI1ui;
  glVertexAttribI2ui: TglVertexAttribI2ui;
  glVertexAttribI3ui: TglVertexAttribI3ui;
  glVertexAttribI4ui: TglVertexAttribI4ui;
  glVertexAttribI1iv: TglVertexAttribI1iv;
  glVertexAttribI2iv: TglVertexAttribI2iv;
  glVertexAttribI3iv: TglVertexAttribI3iv;
  glVertexAttribI4iv: TglVertexAttribI4iv;
  glVertexAttribI1uiv: TglVertexAttribI1uiv;
  glVertexAttribI2uiv: TglVertexAttribI2uiv;
  glVertexAttribI3uiv: TglVertexAttribI3uiv;
  glVertexAttribI4uiv: TglVertexAttribI4uiv;
  glVertexAttribI4bv: TglVertexAttribI4bv;
  glVertexAttribI4sv: TglVertexAttribI4sv;
  glVertexAttribI4ubv: TglVertexAttribI4ubv;
  glVertexAttribI4usv: TglVertexAttribI4usv;
  glVertexAttribIPointer: TglVertexAttribIPointer;
  glGetVertexAttribIiv: TglGetVertexAttribIiv;
  glGetVertexAttribIuiv: TglGetVertexAttribIuiv;
  glGetUniformuiv: TglGetUniformuiv;
  glBindFragDataLocation: TglBindFragDataLocation;
  glGetFragDataLocation: TglGetFragDataLocation;
  glUniform1ui: TglUniform1ui;
  glUniform2ui: TglUniform2ui;
  glUniform3ui: TglUniform3ui;
  glUniform4ui: TglUniform4ui;
  glUniform1uiv: TglUniform1uiv;
  glUniform2uiv: TglUniform2uiv;
  glUniform3uiv: TglUniform3uiv;
  glUniform4uiv: TglUniform4uiv;
  glTexParameterIiv: TglTexParameterIiv;
  glTexParameterIuiv: TglTexParameterIuiv;
  glGetTexParameterIiv: TglGetTexParameterIiv;
  glGetTexParameterIuiv: TglGetTexParameterIuiv;
  glClearBufferiv: TglClearBufferiv;
  glClearBufferuiv: TglClearBufferuiv;
  glClearBufferfv: TglClearBufferfv;
  glClearBufferfi: TglClearBufferfi;
  glGetStringi: TglGetStringi;

  // GL_VERSION_2_1
  glEnableVertexArrayEXT : TglEnableVertexArrayEXT;
  glEnableVertexArrayAttribEXT : TglEnableVertexArrayAttribEXT;
  glVertexArrayVertexAttribOffsetEXT : TglVertexArrayVertexAttribOffsetEXT;

  // GL_VERSION_3_1
  glDrawArraysInstanced: TglDrawArraysInstanced;
  glDrawElementsInstanced: TglDrawElementsInstanced;
  glTexBuffer: TglTexBuffer;
  glPrimitiveRestartIndex: TglPrimitiveRestartIndex;

  // GL_VERSION_3_2
  glGetInteger64i_v: TglGetInteger64i_v;
  glGetBufferParameteri64v: TglGetBufferParameteri64v;
  glFramebufferTexture: TglFramebufferTexture;

  // GL_VERSION_3_3
  glVertexAttribDivisor: TglVertexAttribDivisor;

  // GL_VERSION_4_0
  { OpenGL 4.0 also reuses entry points from these extensions: }
  { ARB_texture_query_lod (no entry points) }
  { ARB_draw_indirect }
  { ARB_gpu_shader5 (no entry points) }
  { ARB_gpu_shader_fp64 }
  { ARB_shader_subroutine }
  { ARB_tessellation_shader }
  { ARB_texture_buffer_object_rgb32 (no entry points) }
  { ARB_texture_cube_map_array (no entry points) }
  { ARB_texture_gather (no entry points) }
  { ARB_transform_feedback2 }
  { ARB_transform_feedback3 }
  glMinSampleShading: TglMinSampleShading;
  glBlendEquationi: TglBlendEquationi;
  glBlendEquationSeparatei: TglBlendEquationSeparatei;
  glBlendFunci: TglBlendFunci;
  glBlendFuncSeparatei: TglBlendFuncSeparatei;

  // GL_ARB_framebuffer_object
  glIsRenderbuffer: TglIsRenderbuffer;
  glBindRenderbuffer: TglBindRenderbuffer;
  glDeleteRenderbuffers: TglDeleteRenderbuffers;
  glGenRenderbuffers: TglGenRenderbuffers;
  glRenderbufferStorage: TglRenderbufferStorage;
  glGetRenderbufferParameteriv: TglGetRenderbufferParameteriv;
  glIsFramebuffer: TglIsFramebuffer;
  glBindFramebuffer: TglBindFramebuffer;
  glDeleteFramebuffers: TglDeleteFramebuffers;
  glGenFramebuffers: TglGenFramebuffers;
  glCheckFramebufferStatus: TglCheckFramebufferStatus;
  glFramebufferTexture1D: TglFramebufferTexture1D;
  glFramebufferTexture2D: TglFramebufferTexture2D;
  glFramebufferTexture3D: TglFramebufferTexture3D;
  glFramebufferRenderbuffer: TglFramebufferRenderbuffer;
  glGetFramebufferAttachmentParameteriv: TglGetFramebufferAttachmentParameteriv;
  glGenerateMipmap: TglGenerateMipmap;
  glBlitFramebuffer: TglBlitFramebuffer;
  glRenderbufferStorageMultisample: TglRenderbufferStorageMultisample;
  glFramebufferTextureLayer: TglFramebufferTextureLayer;

  // GL_ARB_map_buffer_range
  glMapBufferRange: TglMapBufferRange;
  glFlushMappedBufferRange: TglFlushMappedBufferRange;

  // GL_ARB_vertex_array_object
  glBindVertexArray: TglBindVertexArray;
  glDeleteVertexArrays: TglDeleteVertexArrays;
  glGenVertexArrays: TglGenVertexArrays;
  glIsVertexArray: TglIsVertexArray;

  // GL_ARB_uniform_buffer_object
  glGetUniformIndices: TglGetUniformIndices;
  glGetActiveUniformsiv: TglGetActiveUniformsiv;
  glGetActiveUniformName: TglGetActiveUniformName;
  glGetUniformBlockIndex: TglGetUniformBlockIndex;
  glGetActiveUniformBlockiv: TglGetActiveUniformBlockiv;
  glGetActiveUniformBlockName: TglGetActiveUniformBlockName;
  glUniformBlockBinding: TglUniformBlockBinding;

  // GL_ARB_copy_buffer
  glCopyBufferSubData: TglCopyBufferSubData;

  // GL_ARB_draw_elements_base_vertex
  glDrawElementsBaseVertex: TglDrawElementsBaseVertex;
  glDrawRangeElementsBaseVertex: TglDrawRangeElementsBaseVertex;
  glDrawElementsInstancedBaseVertex: TglDrawElementsInstancedBaseVertex;
  glMultiDrawElementsBaseVertex: TglMultiDrawElementsBaseVertex;

  // GL_ARB_provoking_vertex
  glProvokingVertex: TglProvokingVertex;

  // GL_ARB_sync
  glFenceSync: TglFenceSync;
  glIsSync: TglIsSync;
  glDeleteSync: TglDeleteSync;
  glClientWaitSync: TglClientWaitSync;
  glWaitSync: TglWaitSync;
  glGetInteger64v: TglGetInteger64v;
  glGetSynciv: TglGetSynciv;

  // GL_ARB_texture_multisample
  glTexImage2DMultisample: TglTexImage2DMultisample;
  glTexImage3DMultisample: TglTexImage3DMultisample;
  glGetMultisamplefv: TglGetMultisamplefv;
  glSampleMaski: TglSampleMaski;

  // GL_ARB_blend_func_extended
  glBindFragDataLocationIndexed: TglBindFragDataLocationIndexed;
  glGetFragDataIndex: TglGetFragDataIndex;

  // GL_ARB_sampler_objects
  glGenSamplers: TglGenSamplers;
  glDeleteSamplers: TglDeleteSamplers;
  glIsSampler: TglIsSampler;
  glBindSampler: TglBindSampler;
  glSamplerParameteri: TglSamplerParameteri;
  glSamplerParameteriv: TglSamplerParameteriv;
  glSamplerParameterf: TglSamplerParameterf;
  glSamplerParameterfv: TglSamplerParameterfv;
  glSamplerParameterIiv: TglSamplerParameterIiv;
  glSamplerParameterIuiv: TglSamplerParameterIuiv;
  glGetSamplerParameteriv: TglGetSamplerParameteriv;
  glGetSamplerParameterIiv: TglGetSamplerParameterIiv;
  glGetSamplerParameterfv: TglGetSamplerParameterfv;
  glGetSamplerParameterIuiv: TglGetSamplerParameterIuiv;

  // GL_ARB_timer_query
  glQueryCounter: TglQueryCounter;
  glGetQueryObjecti64v: TglGetQueryObjecti64v;
  glGetQueryObjectui64v: TglGetQueryObjectui64v;

  // GL_ARB_vertex_type_2_10_10_10_rev
  glVertexP2ui: TglVertexP2ui;
  glVertexP2uiv: TglVertexP2uiv;
  glVertexP3ui: TglVertexP3ui;
  glVertexP3uiv: TglVertexP3uiv;
  glVertexP4ui: TglVertexP4ui;
  glVertexP4uiv: TglVertexP4uiv;
  glTexCoordP1ui: TglTexCoordP1ui;
  glTexCoordP1uiv: TglTexCoordP1uiv;
  glTexCoordP2ui: TglTexCoordP2ui;
  glTexCoordP2uiv: TglTexCoordP2uiv;
  glTexCoordP3ui: TglTexCoordP3ui;
  glTexCoordP3uiv: TglTexCoordP3uiv;
  glTexCoordP4ui: TglTexCoordP4ui;
  glTexCoordP4uiv: TglTexCoordP4uiv;
  glMultiTexCoordP1ui: TglMultiTexCoordP1ui;
  glMultiTexCoordP1uiv: TglMultiTexCoordP1uiv;
  glMultiTexCoordP2ui: TglMultiTexCoordP2ui;
  glMultiTexCoordP2uiv: TglMultiTexCoordP2uiv;
  glMultiTexCoordP3ui: TglMultiTexCoordP3ui;
  glMultiTexCoordP3uiv: TglMultiTexCoordP3uiv;
  glMultiTexCoordP4ui: TglMultiTexCoordP4ui;
  glMultiTexCoordP4uiv: TglMultiTexCoordP4uiv;
  glNormalP3ui: TglNormalP3ui;
  glNormalP3uiv: TglNormalP3uiv;
  glColorP3ui: TglColorP3ui;
  glColorP3uiv: TglColorP3uiv;
  glColorP4ui: TglColorP4ui;
  glColorP4uiv: TglColorP4uiv;
  glSecondaryColorP3ui: TglSecondaryColorP3ui;
  glSecondaryColorP3uiv: TglSecondaryColorP3uiv;
  glVertexAttribP1ui: TglVertexAttribP1ui;
  glVertexAttribP1uiv: TglVertexAttribP1uiv;
  glVertexAttribP2ui: TglVertexAttribP2ui;
  glVertexAttribP2uiv: TglVertexAttribP2uiv;
  glVertexAttribP3ui: TglVertexAttribP3ui;
  glVertexAttribP3uiv: TglVertexAttribP3uiv;
  glVertexAttribP4ui: TglVertexAttribP4ui;
  glVertexAttribP4uiv: TglVertexAttribP4uiv;

  // GL_ARB_draw_indirect
  glDrawArraysIndirect: TglDrawArraysIndirect;
  glDrawElementsIndirect: TglDrawElementsIndirect;

  // GL_ARB_gpu_shader_fp64
  glUniform1d: TglUniform1d;
  glUniform2d: TglUniform2d;
  glUniform3d: TglUniform3d;
  glUniform4d: TglUniform4d;
  glUniform1dv: TglUniform1dv;
  glUniform2dv: TglUniform2dv;
  glUniform3dv: TglUniform3dv;
  glUniform4dv: TglUniform4dv;
  glUniformMatrix2dv: TglUniformMatrix2dv;
  glUniformMatrix3dv: TglUniformMatrix3dv;
  glUniformMatrix4dv: TglUniformMatrix4dv;
  glUniformMatrix2x3dv: TglUniformMatrix2x3dv;
  glUniformMatrix2x4dv: TglUniformMatrix2x4dv;
  glUniformMatrix3x2dv: TglUniformMatrix3x2dv;
  glUniformMatrix3x4dv: TglUniformMatrix3x4dv;
  glUniformMatrix4x2dv: TglUniformMatrix4x2dv;
  glUniformMatrix4x3dv: TglUniformMatrix4x3dv;
  glGetUniformdv: TglGetUniformdv;

  // GL_ARB_shader_subroutine
  glGetSubroutineUniformLocation: TglGetSubroutineUniformLocation;
  glGetSubroutineIndex: TglGetSubroutineIndex;
  glGetActiveSubroutineUniformiv: TglGetActiveSubroutineUniformiv;
  glGetActiveSubroutineUniformName: TglGetActiveSubroutineUniformName;
  glGetActiveSubroutineName: TglGetActiveSubroutineName;
  glUniformSubroutinesuiv: TglUniformSubroutinesuiv;
  glGetUniformSubroutineuiv: TglGetUniformSubroutineuiv;
  glGetProgramStageiv: TglGetProgramStageiv;

  // GL_ARB_tessellation_shader
  glPatchParameteri: TglPatchParameteri;
  glPatchParameterfv: TglPatchParameterfv;

  // GL_ARB_transform_feedback2
  glBindTransformFeedback: TglBindTransformFeedback;
  glDeleteTransformFeedbacks: TglDeleteTransformFeedbacks;
  glGenTransformFeedbacks: TglGenTransformFeedbacks;
  glIsTransformFeedback: TglIsTransformFeedback;
  glPauseTransformFeedback: TglPauseTransformFeedback;
  glResumeTransformFeedback: TglResumeTransformFeedback;
  glDrawTransformFeedback: TglDrawTransformFeedback;

  // GL_ARB_transform_feedback3
  glDrawTransformFeedbackStream: TglDrawTransformFeedbackStream;
  glBeginQueryIndexed: TglBeginQueryIndexed;
  glEndQueryIndexed: TglEndQueryIndexed;
  glGetQueryIndexediv: TglGetQueryIndexediv;

  // GL_ARB_ES2_compatibility
  glReleaseShaderCompiler: TglReleaseShaderCompiler;
  glShaderBinary: TglShaderBinary;
  glGetShaderPrecisionFormat: TglGetShaderPrecisionFormat;
  glDepthRangef: TglDepthRangef;
  glClearDepthf: TglClearDepthf;

  // GL_ARB_get_program_binary
  glGetProgramBinary: TglGetProgramBinary;
  glProgramBinary: TglProgramBinary;
  glProgramParameteri: TglProgramParameteri;

  // GL_ARB_separate_shader_objects
  glUseProgramStages: TglUseProgramStages;
  glActiveShaderProgram: TglActiveShaderProgram;
  glCreateShaderProgramv: TglCreateShaderProgramv;
  glBindProgramPipeline: TglBindProgramPipeline;
  glDeleteProgramPipelines: TglDeleteProgramPipelines;
  glGenProgramPipelines: TglGenProgramPipelines;
  glIsProgramPipeline: TglIsProgramPipeline;
  glGetProgramPipelineiv: TglGetProgramPipelineiv;
  glProgramUniform1i: TglProgramUniform1i;
  glProgramUniform1iv: TglProgramUniform1iv;
  glProgramUniform1f: TglProgramUniform1f;
  glProgramUniform1fv: TglProgramUniform1fv;
  glProgramUniform1d: TglProgramUniform1d;
  glProgramUniform1dv: TglProgramUniform1dv;
  glProgramUniform1ui: TglProgramUniform1ui;
  glProgramUniform1uiv: TglProgramUniform1uiv;
  glProgramUniform2i: TglProgramUniform2i;
  glProgramUniform2iv: TglProgramUniform2iv;
  glProgramUniform2f: TglProgramUniform2f;
  glProgramUniform2fv: TglProgramUniform2fv;
  glProgramUniform2d: TglProgramUniform2d;
  glProgramUniform2dv: TglProgramUniform2dv;
  glProgramUniform2ui: TglProgramUniform2ui;
  glProgramUniform2uiv: TglProgramUniform2uiv;
  glProgramUniform3i: TglProgramUniform3i;
  glProgramUniform3iv: TglProgramUniform3iv;
  glProgramUniform3f: TglProgramUniform3f;
  glProgramUniform3fv: TglProgramUniform3fv;
  glProgramUniform3d: TglProgramUniform3d;
  glProgramUniform3dv: TglProgramUniform3dv;
  glProgramUniform3ui: TglProgramUniform3ui;
  glProgramUniform3uiv: TglProgramUniform3uiv;
  glProgramUniform4i: TglProgramUniform4i;
  glProgramUniform4iv: TglProgramUniform4iv;
  glProgramUniform4f: TglProgramUniform4f;
  glProgramUniform4fv: TglProgramUniform4fv;
  glProgramUniform4d: TglProgramUniform4d;
  glProgramUniform4dv: TglProgramUniform4dv;
  glProgramUniform4ui: TglProgramUniform4ui;
  glProgramUniform4uiv: TglProgramUniform4uiv;
  glProgramUniformMatrix2fv: TglProgramUniformMatrix2fv;
  glProgramUniformMatrix3fv: TglProgramUniformMatrix3fv;
  glProgramUniformMatrix4fv: TglProgramUniformMatrix4fv;
  glProgramUniformMatrix2dv: TglProgramUniformMatrix2dv;
  glProgramUniformMatrix3dv: TglProgramUniformMatrix3dv;
  glProgramUniformMatrix4dv: TglProgramUniformMatrix4dv;
  glProgramUniformMatrix2x3fv: TglProgramUniformMatrix2x3fv;
  glProgramUniformMatrix3x2fv: TglProgramUniformMatrix3x2fv;
  glProgramUniformMatrix2x4fv: TglProgramUniformMatrix2x4fv;
  glProgramUniformMatrix4x2fv: TglProgramUniformMatrix4x2fv;
  glProgramUniformMatrix3x4fv: TglProgramUniformMatrix3x4fv;
  glProgramUniformMatrix4x3fv: TglProgramUniformMatrix4x3fv;
  glProgramUniformMatrix2x3dv: TglProgramUniformMatrix2x3dv;
  glProgramUniformMatrix3x2dv: TglProgramUniformMatrix3x2dv;
  glProgramUniformMatrix2x4dv: TglProgramUniformMatrix2x4dv;
  glProgramUniformMatrix4x2dv: TglProgramUniformMatrix4x2dv;
  glProgramUniformMatrix3x4dv: TglProgramUniformMatrix3x4dv;
  glProgramUniformMatrix4x3dv: TglProgramUniformMatrix4x3dv;
  glValidateProgramPipeline: TglValidateProgramPipeline;
  glGetProgramPipelineInfoLog: TglGetProgramPipelineInfoLog;

  // GL_ARB_vertex_attrib_64bit
  glVertexAttribL1d: TglVertexAttribL1d;
  glVertexAttribL2d: TglVertexAttribL2d;
  glVertexAttribL3d: TglVertexAttribL3d;
  glVertexAttribL4d: TglVertexAttribL4d;
  glVertexAttribL1dv: TglVertexAttribL1dv;
  glVertexAttribL2dv: TglVertexAttribL2dv;
  glVertexAttribL3dv: TglVertexAttribL3dv;
  glVertexAttribL4dv: TglVertexAttribL4dv;
  glVertexAttribLPointer: TglVertexAttribLPointer;
  glGetVertexAttribLdv: TglGetVertexAttribLdv;

  // GL_ARB_viewport_array
  glViewportArrayv: TglViewportArrayv;
  glViewportIndexedf: TglViewportIndexedf;
  glViewportIndexedfv: TglViewportIndexedfv;
  glScissorArrayv: TglScissorArrayv;
  glScissorIndexed: TglScissorIndexed;
  glScissorIndexedv: TglScissorIndexedv;
  glDepthRangeArrayv: TglDepthRangeArrayv;
  glDepthRangeIndexed: TglDepthRangeIndexed;
  glGetFloati_v: TglGetFloati_v;
  glGetDoublei_v: TglGetDoublei_v;

  // GL 4.2

  // GL_ARB_base_instance
  glDrawArraysInstancedBaseInstance : TglDrawArraysInstancedBaseInstance;
  glDrawElementsInstancedBaseInstance : TglDrawElementsInstancedBaseInstance;
  glDrawElementsInstancedBaseVertexBaseInstance : TglDrawElementsInstancedBaseVertexBaseInstance;

  // GL_ARB_transform_feedback_instanced
  glDrawTransformFeedbackInstanced : TglDrawTransformFeedbackInstanced;
  glDrawTransformFeedbackStreamInstanced : TglDrawTransformFeedbackStreamInstanced;

  // GL_ARB_internalformat_query
  glGetInternalformativ : TglGetInternalformativ;

  // GL_ARB_shader_atomic_counters
  glGetActiveAtomicCounterBufferiv : TglGetActiveAtomicCounterBufferiv;

  /// GL_ARB_shader_image_load_store
  glBindImageTexture : TglBindImageTexture;
  glMemoryBarrier : TglMemoryBarrier;

  // GL_ARB_texture_storage
  glTexStorage1D : TglTexStorage1D;
  glTexStorage2D : TglTexStorage2D;
  glTexStorage3D : TglTexStorage3D;

  // GL 4.3
    // GL_ARB_clear_buffer_object
    glClearBufferData : TglClearBufferData;
    glClearBufferSubData : TglClearBufferSubData;
    // GL_ARB_compute_shader
    glDispatchCompute : TglDispatchCompute;
    glDispatchComputeIndirect : TglDispatchComputeIndirect;
    // GL_ARB_copy_image
    glCopyImageSubData : TglCopyImageSubData;
    // GL_ARB_framebuffer_no_attachments
    glFramebufferParameteri : TglFramebufferParameteri;
    glGetFramebufferParameteriv : TglGetFramebufferParameteriv;
    // GL_ARB_internalformat_query2
    glGetInternalformati64v : TglGetInternalformati64v;
    // GL_ARB_invalidate_subdata
    glInvalidateTexSubImage : TglInvalidateTexSubImage;
    glInvalidateTexImage : TglInvalidateTexImage;
    glInvalidateBufferSubData : TglInvalidateBufferSubData;
    glInvalidateBufferData : TglInvalidateBufferData;
    glInvalidateFramebuffer : TglInvalidateFramebuffer;
    glInvalidateSubFramebuffer : TglInvalidateSubFramebuffer;
    // GL_ARB_multi_draw_indirect
    glMultiDrawArraysIndirect : TglMultiDrawArraysIndirect;
    glMultiDrawElementsIndirect : TglMultiDrawElementsIndirect;
    // GL_ARB_program_interface_query
    glGetProgramInterfaceiv : TglGetProgramInterfaceiv;
    glGetProgramResourceIndex : TglGetProgramResourceIndex;
    glGetProgramResourceName : TglGetProgramResourceName;
    glGetProgramResourceiv : TglGetProgramResourceiv;
    glGetProgramResourceLocation : TglGetProgramResourceLocation;
    glGetProgramResourceLocationIndex : TglGetProgramResourceLocationIndex;
    // GL_ARB_shader_storage_buffer_object
    glShaderStorageBlockBinding : TglShaderStorageBlockBinding;
    // GL_ARB_texture_buffer_range
    glTexBufferRange : TglTexBufferRange;
    // GL_ARB_texture_storage_multisample
    glTexStorage2DMultisample : TglTexStorage2DMultisample;
    glTexStorage3DMultisample : TglTexStorage3DMultisample;
    // GL_ARB_texture_view
    glTextureView : TglTextureView;
    // GL_ARB_vertex_attrib_binding
    glBindVertexBuffer : TglBindVertexBuffer;
    glVertexAttribFormat : TglVertexAttribFormat;
    glVertexAttribIFormat : TglVertexAttribIFormat;
    glVertexAttribLFormat : TglVertexAttribLFormat;
    glVertexAttribBinding : TglVertexAttribBinding;
    glVertexBindingDivisor : TglVertexBindingDivisor;
  // END GL 4.3

  // GL 4.4
    glBufferStorage : TglBufferStorage;
    glClearTexImage : TglClearTexImage;
    glClearTexSubImage : TglClearTexSubImage;
    glBindBuffersBase : TglBindBuffersBase;
    glBindBuffersRange : TglBindBuffersRange;
    glBindTextures : TglBindTextures;
    glBindSamplers : TglBindSamplers;
    glBindImageTextures : TglBindImageTextures;
    glBindVertexBuffers : TglBindVertexBuffers;

  // GL 4.5
  glClipControl : TglClipControl;
  glCreateTransformFeedbacks : TglCreateTransformFeedbacks;
  glTransformFeedbackBufferBase : TglTransformFeedbackBufferBase;
  glTransformFeedbackBufferRange : TglTransformFeedbackBufferRange;
  glGetTransformFeedbackiv : TglGetTransformFeedbackiv;
  glGetTransformFeedbacki_v : TglGetTransformFeedbacki_v;
  glGetTransformFeedbacki64_v : TglGetTransformFeedbacki64_v;
  glCreateBuffers : TglCreateBuffers;
  glNamedBufferStorage : TglNamedBufferStorage;
  glNamedBufferData : TglNamedBufferData;
  glNamedBufferSubData : TglNamedBufferSubData;
  glCopyNamedBufferSubData : TglCopyNamedBufferSubData;
  glClearNamedBufferData : TglClearNamedBufferData;
  glClearNamedBufferSubData : TglClearNamedBufferSubData;
  glMapNamedBuffer : TglMapNamedBuffer;
  glMapNamedBufferRange : TglMapNamedBufferRange;
  glUnmapNamedBuffer : TglUnmapNamedBuffer;
  glFlushMappedNamedBufferRange : TglFlushMappedNamedBufferRange;
  glGetNamedBufferParameteriv : TglGetNamedBufferParameteriv;
  glGetNamedBufferParameteri64v : TglGetNamedBufferParameteri64v;
  glGetNamedBufferPointerv : TglGetNamedBufferPointerv;
  glGetNamedBufferSubData : TglGetNamedBufferSubData;
  glCreateFramebuffers : TglCreateFramebuffers;
  glNamedFramebufferRenderbuffer : TglNamedFramebufferRenderbuffer;
  glNamedFramebufferParameteri : TglNamedFramebufferParameteri;
  glNamedFramebufferTexture : TglNamedFramebufferTexture;
  glNamedFramebufferTextureLayer : TglNamedFramebufferTextureLayer;
  glNamedFramebufferDrawBuffer : TglNamedFramebufferDrawBuffer;
  glNamedFramebufferDrawBuffers : TglNamedFramebufferDrawBuffers;
  glNamedFramebufferReadBuffer : TglNamedFramebufferReadBuffer;
  glInvalidateNamedFramebufferData : TglInvalidateNamedFramebufferData;
  glInvalidateNamedFramebufferSubData : TglInvalidateNamedFramebufferSubData;
  glClearNamedFramebufferiv : TglClearNamedFramebufferiv;
  glClearNamedFramebufferuiv : TglClearNamedFramebufferuiv;
  glClearNamedFramebufferfv : TglClearNamedFramebufferfv;
  glClearNamedFramebufferfi : TglClearNamedFramebufferfi;
  glBlitNamedFramebuffer : TglBlitNamedFramebuffer;
  glCheckNamedFramebufferStatus : TglCheckNamedFramebufferStatus;
  glGetNamedFramebufferParameteriv : TglGetNamedFramebufferParameteriv;
  glGetNamedFramebufferAttachmentParameteriv : TglGetNamedFramebufferAttachmentParameteriv;
  glCreateRenderbuffers : TglCreateRenderbuffers;
  glNamedRenderbufferStorage : TglNamedRenderbufferStorage;
  glNamedRenderbufferStorageMultisample : TglNamedRenderbufferStorageMultisample;
  glGetNamedRenderbufferParameteriv : TglGetNamedRenderbufferParameteriv;
  glCreateTextures : TglCreateTextures;
  glTextureBuffer : TglTextureBuffer;
  glTextureBufferRange : TglTextureBufferRange;
  glTextureStorage1D : TglTextureStorage1D;
  glTextureStorage2D : TglTextureStorage2D;
  glTextureStorage3D : TglTextureStorage3D;
  glTextureStorage2DMultisample : TglTextureStorage2DMultisample;
  glTextureStorage3DMultisample : TglTextureStorage3DMultisample;
  glTextureSubImage1D : TglTextureSubImage1D;
  glTextureSubImage2D : TglTextureSubImage2D;
  glTextureSubImage3D : TglTextureSubImage3D;
  glCompressedTextureSubImage1D : TglCompressedTextureSubImage1D;
  glCompressedTextureSubImage2D : TglCompressedTextureSubImage2D;
  glCompressedTextureSubImage3D : TglCompressedTextureSubImage3D;
  glCopyTextureSubImage1D : TglCopyTextureSubImage1D;
  glCopyTextureSubImage2D : TglCopyTextureSubImage2D;
  glCopyTextureSubImage3D : TglCopyTextureSubImage3D;
  glTextureParameterf : TglTextureParameterf;
  glTextureParameterfv : TglTextureParameterfv;
  glTextureParameteri : TglTextureParameteri;
  glTextureParameterIiv : TglTextureParameterIiv;
  glTextureParameterIuiv : TglTextureParameterIuiv;
  glTextureParameteriv : TglTextureParameteriv;
  glGenerateTextureMipmap : TglGenerateTextureMipmap;
  glBindTextureUnit : TglBindTextureUnit;
  glGetTextureImage : TglGetTextureImage;
  glGetCompressedTextureImage : TglGetCompressedTextureImage;
  glGetTextureLevelParameterfv : TglGetTextureLevelParameterfv;
  glGetTextureLevelParameteriv : TglGetTextureLevelParameteriv;
  glGetTextureParameterfv : TglGetTextureParameterfv;
  glGetTextureParameterIiv : TglGetTextureParameterIiv;
  glGetTextureParameterIuiv : TglGetTextureParameterIuiv;
  glGetTextureParameteriv : TglGetTextureParameteriv;
  glCreateVertexArrays : TglCreateVertexArrays;
  glDisableVertexArrayAttrib : TglDisableVertexArrayAttrib;
  glEnableVertexArrayAttrib : TglEnableVertexArrayAttrib;
  glVertexArrayElementBuffer : TglVertexArrayElementBuffer;
  glVertexArrayVertexBuffer : TglVertexArrayVertexBuffer;
  glVertexArrayVertexBuffers : TglVertexArrayVertexBuffers;
  glVertexArrayAttribBinding : TglVertexArrayAttribBinding;
  glVertexArrayAttribFormat : TglVertexArrayAttribFormat;
  glVertexArrayAttribIFormat : TglVertexArrayAttribIFormat;
  glVertexArrayAttribLFormat : TglVertexArrayAttribLFormat;
  glVertexArrayBindingDivisor : TglVertexArrayBindingDivisor;
  glGetVertexArrayiv : TglGetVertexArrayiv;
  glGetVertexArrayIndexediv : TglGetVertexArrayIndexediv;
  glGetVertexArrayIndexed64iv : TglGetVertexArrayIndexed64iv;
  glCreateSamplers : TglCreateSamplers;
  glCreateProgramPipelines : TglCreateProgramPipelines;
  glCreateQueries : TglCreateQueries;
  glMemoryBarrierByRegion : TglMemoryBarrierByRegion;
  glGetTextureSubImage : TglGetTextureSubImage;
  glGetCompressedTextureSubImage : TglGetCompressedTextureSubImage;
  glGetGraphicsResetStatus : TglGetGraphicsResetStatus;
  glGetnCompressedTexImage : TglGetnCompressedTexImage;
  glGetnTexImage : TglGetnTexImage;
  glGetnUniformdv : TglGetnUniformdv;
  glGetnUniformfv : TglGetnUniformfv;
  glGetnUniformiv : TglGetnUniformiv;
  glGetnUniformuiv : TglGetnUniformuiv;
  glReadnPixels : TglReadnPixels;
  glGetnMapdv : TglGetnMapdv;
  glGetnMapfv : TglGetnMapfv;
  glGetnMapiv : TglGetnMapiv;
  glGetnPixelMapfv : TglGetnPixelMapfv;
  glGetnPixelMapuiv : TglGetnPixelMapuiv;
  glGetnPixelMapusv : TglGetnPixelMapusv;
  glGetnPolygonStipple : TglGetnPolygonStipple;
  glGetnColorTable : TglGetnColorTable;
  glGetnConvolutionFilter : TglGetnConvolutionFilter;
  glGetnSeparableFilter : TglGetnSeparableFilter;
  glGetnHistogram : TglGetnHistogram;
  glGetnMinmax : TglGetnMinmax;
  glTextureBarrier : TglTextureBarrier;

type
  TRCOptions = set of (opDoubleBuffered, opGDI, opStereo);

var
  GL_LibHandle: Pointer = nil;
  LastPixelFormat: Integer;
  ExtensionsRead: Boolean;
  ImplementationRead: Boolean;

implementation

end.
