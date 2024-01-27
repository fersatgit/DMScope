program DMScope;
{$R 1.res}

//Exclude unnecessary code/data from output exe
{$IMAGEBASE $400000} //Base address (used in LoadIconW)
{$G-}                //Imported data
{$R-}                //Range checking
{$M-}                //Run-Time Type Information
{$Y-}                //Symbol declaration and cross-reference information
{$D-}                //debug information
{$C-}                //Asserts
{$L-}                //Local Symbols
{$Q-}                //Overflow checking
{$O+}                //Optimization

uses
  Windows,Messages,MFAPI,WinSock,OpenGL,GDIPlus,ShellAPI,ShlObj,CommCtrl;

function SetWindowThemeAttribute(hwnd,eAttribute: THandle;const pvAttribute;cbAttribute: Cardinal): LongInt;stdcall;external 'UxTheme.dll';
function DwmGetWindowAttribute(hwnd: THandle;dwAttribute: Cardinal;out pvAttribute;cbAttribute: Cardinal):LongInt;stdcall;external 'dwmapi.dll';
function wsprintfW(Output: PWideChar; Format: PWideChar): Cardinal;varargs;cdecl;external user32;
function WndProc(wnd,msg,wParam,lParam: THandle): LongInt;stdcall;forward;
function ToolBarProc(wnd,msg,wParam,lParam: THandle): LongInt;stdcall;forward;

type
  TITLEBARINFOEX=packed record
                 cbSize:     Cardinal;
                 rcTitleBar: TRect;
                 rgstate:    array[0..CCHILDREN_TITLEBAR] of Cardinal;
                 rgrect:     array[0..CCHILDREN_TITLEBAR] of TRect;
                 end;
  TMediaBuffer=class(TInterfacedObject,IMFMediaBuffer)
               BackBuf,FrontBuf: PAnsiChar;
               fBufSize:         Cardinal;
               constructor Create(Back,Front: pointer);
               function Lock(ppbBuffer: ppointer;pcbMaxLength,pcbCurrentLength: PCardinal): LongInt;stdcall;
               function Unlock: LongInt;stdcall;
               function GetCurrentLength(pcbCurrentLength: PCardinal): LongInt;stdcall;
               function SetCurrentLength(cbCurrentLength: Cardinal): LongInt;stdcall;
               function GetMaxLength(pcbMaxLength: PCardinal): LongInt;stdcall;
               end;

const
  Width                      =1280;
  Height                     =720;
  MaxBufSize                 =Width*Height*4;
  FrameSize                  =int64(Width) shl 32+height;
  FPS                        =int64(24) shl 32+1;
  SampleDuration             =10000000 div 24;
  UPDATETEXTURE              =WM_USER+1;
  BTN_ROTATE                 =0;
  BTN_SNAPSHOT               =1;
  BTN_RECORD                 =2;
  BTN_BROWSE                 =3;
  DMBTN_SNAPSHOT             =256;
  DMBTN_MINUS                =1280;
  DMBTN_PLUS                 =1024;
  WM_GETTITLEBARINFOEX       =$33F;
  DWMWA_CAPTION_BUTTON_BOUNDS=5;
  WTNCA_NODRAWICON           =2;
  //Pixel shader performs YUV2RGB conversion
  FragmentShader:   PAnsiChar='#version 430'#13#10+
                              'out vec4 Color;'+
                              'layout(location=0) uniform mat3 RotationMatrix;'+
                              'const mat4 yuv2rgb=mat4(1.164383,        0, 1.596027,-0.870787438,'+
                                                      '1.164383,-0.391762,-0.812968, 0.529591063,'+
                                                      '1.164383, 2.017232,        0,-1.081389938,'+
                                                      '       0,        0,        0, 1);'+
                              'layout(binding=0) uniform sampler2D Y;'+
                              'layout(binding=1) uniform sampler2D UV;'+
                              'void main(){'+
                              'vec2 texCoord=(vec3(gl_FragCoord.xy,1)*RotationMatrix).xy;'+
                              'Color=vec4(texture2D(Y,texCoord).r,texture2D(UV,texCoord).ga,1)*yuv2rgb;};'#0;
  NoDrawIcon:       int64=int64(WTNCA_NODRAWICON) shl 32+WTNCA_NODRAWICON;
  GdipStartupInput: GdiplusStartupInput=(GdiplusVersion: 1);
  //Curve coordinates fof GdipCreatePath2I (Toolbar icons)
  ButtonPoints:     array[0..33] of integer=(205,0,819,0,932,0,1024,92,1024,205,1024,819,1024,932,932,1024,819,1024,205,1024,92,1024,0,932,0,819,0,205,0,92,92,0,205,0);
  ButtonPTypes:     array[0..16] of byte=(0,1,3,3,3,1,3,3,3,1,3,3,3,1,3,3,3);
  RotatePoints:     array[0..95] of integer=(166,457,276,269,477,281,586,346,586,351,565,396,561,404,532,464,610,453,642,445,829,400,876,383,856,349,838,318,744,149,730,125,705,111,683,135,674,144,658,187,651,203,466,110,204,209,166,457,858,567,748,755,547,743,438,678,438,673,459,628,463,620,492,560,414,571,382,579,195,624,148,641,168,675,186,706,280,875,294,899,319,913,341,889,350,880,366,837,373,821,558,914,820,815,858,567);
  RotatePTypes:     array[0..47] of byte=(0,3,3,3,3,3,3,3,3,3,1,3,3,3,1,3,3,3,3,3,3,3,3,3,0,3,3,3,3,3,3,3,3,3,1,3,3,3,1,3,3,3,3,3,3,3,3,3);
  SnapshotPoints:   array[0..139]of integer=(512,458,576,458,627,509,627,573,627,637,576,689,512,689,448,689,397,637,397,573,397,509,448,458,512,458,512,379,619,379,706,466,706,573,706,680,619,767,512,767,405,767,318,680,318,573,318,466,405,379,512,379,799,391,816,391,829,405,829,422,829,438,816,452,799,452,782,452,768,438,768,422,768,405,782,391,799,391,194,327,279,327,320,327,329,282,341,251,351,228,362,205,388,205,636,205,662,205,673,228,683,251,695,282,704,327,745,327,830,327,865,327,893,356,893,391,893,756,893,791,865,819,830,819,194,819,159,819,131,791,131,756,131,391,131,356,159,327,194,327);
  SnapshotPTypes:   array[0..69] of byte=(0,3,3,3,3,3,3,3,3,3,3,3,3,0,3,3,3,3,3,3,3,3,3,3,3,3,0,3,3,3,3,3,3,3,3,3,3,3,3,0,1,3,3,3,3,3,3,1,3,3,3,3,3,3,1,3,3,3,1,3,3,3,1,3,3,3,1,3,3,3);
  RecordPoints:     array[0..25] of integer=(512,277,642,277,747,382,747,512,747,642,642,747,512,747,382,747,277,642,277,512,277,382,382,277,512,277);
  RecordPTypes:     array[0..12] of byte=(0,3,3,3,3,3,3,3,3,3,3,3,3);
  BrowsePoints:     array[0..127]of integer=(148,788,148,802,158,814,173,814,770,814,781,814,791,806,794,795,875,462,879,447,867,432,851,432,282,432,271,432,262,438,258,448,148,788,148,235,148,687,229,439,237,416,258,401,282,401,788,401,788,316,788,303,777,291,764,291,417,291,343,291,381,210,338,210,173,210,159,210,148,221,148,235,118,788,118,235,118,204,143,180,173,180,338,180,411,180,374,261,417,261,764,261,794,261,819,286,819,316,819,401,849,401,874,397,894,422,905,436,909,453,905,469,823,802,817,827,795,844,770,844,173,844,141,844,117,818,118,788);
  BrowsePTypes:     array[0..63] of byte=(0,3,3,3,1,3,3,3,1,3,3,3,1,3,3,3,1,0,1,1,3,3,3,1,1,3,3,3,1,3,3,3,1,3,3,3,0,1,3,3,3,1,3,3,3,1,3,3,3,1,3,3,3,3,3,3,1,3,3,3,1,3,3,3);
  //Parameters for Media Foundation intput - MJPEG, output - YUY2
  inputFilter:      MFT_REGISTER_TYPE_INFO=(guidMajorType:'{73646976-0000-0010-8000-00AA00389B71}';guidSubtype:'{47504A4D-0000-0010-8000-00aa00389b71}');
  outputFilter:     MFT_REGISTER_TYPE_INFO=(guidMajorType:'{73646976-0000-0010-8000-00AA00389B71}';guidSubtype:'{32595559-0000-0010-8000-00aa00389b71}');
  BlendFunc:        BLENDFUNCTION=(SourceConstantAlpha: 255;AlphaFormat: AC_SRC_ALPHA);
  AspectRatios:     array[0..3] of single=(Width/Height,Height/Width,Width/Height,Height/Width);
  pfd:              TPixelFormatDescriptor=(nSize:        sizeof(pfd);
                                            nVersion:     1;
                                            dwFlags:      PFD_DRAW_TO_WINDOW+PFD_SUPPORT_OPENGL+PFD_DOUBLEBUFFER;
                                            iPixelType:   PFD_TYPE_RGBA;
                                            cColorBits:   32;
                                            cStencilBits: 1);
var
  command:                             packed record                          //microscope command structure
                                       signature: array[0..4] of AnsiChar;
                                       cmd:       word;
                                       unknown:   dword;
                                       end=(signature:'JHCMD');
  icmp_request:                        packed record
                                       _type:   byte;
                                       code:    byte;
                                       cksum:   word;
                                       id:      word;
                                       seq_num: word;
                                       end=(_type: 8); //ICMPV4_ECHO_REQUEST_TYPE
  RotationMatrix:                      array[0..3,0..8] of single;
  Buttons:                             array[0..3] of record
                                                      ToolTipText: PWideChar;
                                                      IconPath:    THandle;  //GDI+ path-handle for drawing icon
                                                      Checkable:   boolean;  //Is button work as a checkbox or press button
                                                      State:       byte;     //State of checkbox-style button
                                                      end=((ToolTipText:'Rotate'#0),(ToolTipText:'Take a snapshot'#0),(ToolTipText:'Record video'#0;Checkable:true),(ToolTipText:'Choosing output directory'));
  StopCMD:                             array[0..6] of AnsiChar='JHCMD'#208#02; //Microscope stop streaming command.
  MJPGData1,MJPGData2,YUY2Data:        array[0..MaxBufSize-1] of byte;
  MFTBuffer:                           MFT_OUTPUT_DATA_BUFFER;
  MJPGBuffer,YUY2Buffer:               TMediaBuffer;
  MFActivate:                          array of IMFActivate;
  MFTransForm:                         IMFTransform;
  MFSample:                            IMFSample;
  MFSinkWriter:                        IMFSinkWriter;
  MFMediaTypeH264,
  MFMediaTypeYUY2,
  MFMediaTypeMJPG:                     IMFMediaType;
  ToolBarBuffer:                       pointer;       //pointer to the toolbar bitmap
  msg:                                 tagMSG;  
  WSData:                              WSAData;
  sock_addr:                           sockaddr_in=(sin_family:AF_INET);
  i,StartRecTime,CurrentTime,
  Rotation,HighLightedButton,
  AllButtonsWidth:                     Cardinal;
  MainWnd,DC,RC,YUY2toRGB,TempDC,gdip,
  Graphics,ButtonPath,TransformMatrix,
  ToolBar,font,family,format,ToolTip,
  CMDSock,DataSock:                    THandle;
  TitleBarInfo:                        TITLEBARINFOEX=(cbSize: SIZEOF(TITLEBARINFOEX));
  ToolTipInfo:                         TOOLINFOW=(cbSize:sizeof(TOOLINFOW));
  ButtonBrushes,IconBrushes:           array[0..1] of THandle;
  textures:                            array[0..1] of Cardinal;
  Scale,GdipScale:                     single;
  Rect,ClientRect:                     TRECT;
  BorderSize:                          TSize;
  Color:                               RGBQUAD;
  dwColor:                             Cardinal absolute Color; //Color as dword
  OutputDir:                           array[0..4095] of WideChar;
  BrowseInfo:                          TBrowseInfoW=(ulFlags:BIF_RETURNONLYFSDIRS);
  Events:                              packed record
                                       MJPEGDataReceived,
                                       TextureLoaded,
                                       SnapshotComplete,
                                       VideoSampleComplete: THandle;
                                       end;
  bmi:                                 BITMAPINFO=(bmiHeader:(biSize:     sizeof(BITMAPINFOHEADER);
                                                              biPlanes:   1;
                                                              biBitCount: 32));

//Custom IMFMediaBuffer realization to access video data
  constructor TMediaBuffer.Create(Back,Front: pointer);
  begin
    inherited Create;
    BackBuf :=Back;
    FrontBuf:=Front;
  end;
  function TMediaBuffer.Lock(ppbBuffer: ppointer;pcbMaxLength,pcbCurrentLength: PCardinal): LongInt;stdcall;//Just return pointer. Thread safety provided through events
  begin
    if pcbMaxLength<>nil then
      pcbMaxLength^:=MaxBufSize;
    if pcbCurrentLength<>nil then
      pcbCurrentLength^:=fBufSize;
    ppbBuffer^:=FrontBuf;
    Result:=S_OK;
  end;
  function TMediaBuffer.Unlock: LongInt;stdcall;
  begin
    Result:=S_OK;
  end;
  function TMediaBuffer.GetCurrentLength(pcbCurrentLength: PCardinal): LongInt;stdcall;
  begin
    pcbCurrentLength^:=fBufSize;
    Result:=S_OK;
  end;
  function TMediaBuffer.SetCurrentLength(cbCurrentLength: Cardinal): LongInt;stdcall;
  begin
    fBufSize:=cbCurrentLength;
    Result:=S_OK;
  end;
  function TMediaBuffer.GetMaxLength(pcbMaxLength: PCardinal): LongInt;stdcall;
  begin
    pcbMaxLength^:=MaxBufSize;
    Result:=S_OK;
  end;

//This thread is for decode received MJPG-data and also for encode output mp4-file
procedure TranscoderThread(lParam: Cardinal);stdcall;
var
  status: Cardinal;
begin
  repeat
    WaitForSingleObject(Events.MJPEGDataReceived,INFINITE);
    MFTransform.ProcessInput(0,MFSample,0);
    MFTransform.ProcessOutput(0,1,MFTBuffer,status);
    PostMessageW(MainWnd,UPDATETEXTURE,0,0);
    if Buttons[BTN_RECORD].State>0 then
    begin
      ResetEvent(Events.VideoSampleComplete);
      MFTBuffer.pSample.SetSampleTime((CurrentTime-StartRecTime)*10000);
      MFSinkWriter.WriteSample(0,MFTBuffer.pSample);
      SetEvent(Events.VideoSampleComplete);
    end;
  until false;
end;

//This thread reads and handles the microscope buttons
procedure DMReadCommandsThread(lParam: Cardinal);stdcall;
const
  ScaleFactor: array[0..1] of single=(0.5,2);
var
  buf: array[0..31] of byte;
  i:   Cardinal;
begin
  repeat
    if recv(CMDSock,buf,sizeof(buf),0)=7 then
      case pword(@buf[5])^ of
      DMBTN_SNAPSHOT:begin
                     i:=HighLightedButton;
                     HighLightedButton:=BTN_SNAPSHOT;
                     ToolbarProc(ToolBar,WM_LBUTTONUP,0,0);
                     HighLightedButton:=i;
                     ToolbarProc(ToolBar,WM_PAINT,0,0);
                     end;
         DMBTN_PLUS,
         DMBTN_MINUS:begin
                     Scale:=Scale*ScaleFactor[buf[6] and 1];
                     PostMessageW(MainWnd,WM_SIZE,0,0); //OpenGL interaction must be done in same thread. So I use PostMessageW instead of direct call WndProc
                     end;
      end;
  until false;
end;

procedure DMReadDataThread(lpParam: Cardinal);stdcall;
label
  start;
var
  i,len:                          integer;
  crc,LastHeartBeatTime:          Cardinal;
  ICMPSock,hDMReadCommandsThread: THandle;
  buf:                            array[0..1449] of byte;
  tmp:                            pointer;
begin
  WSAStartup($0202,WSData);
  ICMPSock:=0;
  icmp_request.id:=GetCurrentProcessId;
  goto start;
  with MJPGBuffer do
  repeat
    len:=recv(DataSock,Buf,1450,0);
    //Just reinitialize the sockets if some kind of socket error has been occurred.
    //Then after successfully ping reinitialize the connection.
    if (len=SOCKET_ERROR)or(len=0) then
    begin
      Terminatethread(hDMReadCommandsThread,0);
      CloseSocket(DataSock);
      CloseSocket(CMDSock);
      sock_addr.sin_port:=0;
      start:
      repeat
        CloseSocket(ICMPSock);
        ICMPSock:=socket(AF_INET,SOCK_RAW,IPPROTO_ICMP);
        bind(ICMPSock,sock_addr,sizeof(sock_addr));
        i:=100;
        setsockopt(ICMPSock,SOL_SOCKET,SO_RCVTIMEO,@i,4);
        sock_addr.sin_addr.S_addr:=$011DA8C0;//192.168.29.1
        icmp_request.seq_num:=GetTickCount;
        crc:=Cardinal(icmp_request.id)+icmp_request.seq_num+8;
        crc:=hiword(crc)+loword(crc);
        icmp_request.cksum:=not(hiword(crc)+loword(crc));
        sendto(ICMPSock,icmp_request,sizeof(icmp_request),0,sock_addr,sizeof(sock_addr));
      until recv(ICMPSock,Buf,sizeof(Buf),0)>0;
      sock_addr.sin_addr.S_addr:=0;
      DataSock:=socket(AF_INET,SOCK_DGRAM,IPPROTO_UDP);
      sock_addr.sin_port  :=swap(10900);
      bind(DataSock,sock_addr,sizeof(sock_addr));
      i:=100;
      setsockopt(DataSock,SOL_SOCKET,SO_RCVTIMEO,@i,4);
      CMDSock :=socket(AF_INET,SOCK_DGRAM,IPPROTO_UDP);
      sock_addr.sin_port  :=swap(20000);
      bind(CMDSock,sock_addr,sizeof(sock_addr));
      sock_addr.sin_addr.S_addr:=$011DA8C0;//192.168.29.1
      hDMReadCommandsThread:=CreateThread(nil,0,@DMReadCommandsThread,nil,0,PCardinal(0)^);      
      SendTo(CMDSock,StopCMD,sizeof(StopCMD),0,sock_addr,sizeof(sock_addr));
      command.cmd:=$10;
      SendTo(CMDSock,command,7,0,sock_addr,sizeof(sock_addr));
      command.cmd:=$20;
      SendTo(CMDSock,command,11,0,sock_addr,sizeof(sock_addr));
      command.cmd:=$01D0;
      SendTo(CMDSock,command,7,0,sock_addr,sizeof(sock_addr));
      SendTo(CMDSock,command,7,0,sock_addr,sizeof(sock_addr));
      SendTo(CMDSock,command,7,0,sock_addr,sizeof(sock_addr));
      SendTo(CMDSock,command,7,0,sock_addr,sizeof(sock_addr));
      i:=0;
      LastHeartBeatTime:=icmp_request.seq_num;
    end
    else if len>8 then
    begin
      if buf[3]=0 then
        i:=0;
      move(buf[8],BackBuf[dword(buf[3])*1442],len-8);
      inc(i,len-8);
    end
    else
      MessageBoxW(MainWnd,'Incorrect udp-packet',nil,MB_OK);

    CurrentTime:=GetTickCount;
    if CurrentTime-LastHeartBeatTime>2000 then   //Send heartbeat cmd every 2 seconds
    begin
      command.cmd:=$01D0;
      SendTo(CMDSock,command,7,0,sock_addr,sizeof(sock_addr));
      LastHeartBeatTime:=CurrentTime;
    end;

    if (pword(@BackBuf[0])^=$D8FF)and(pword(@BackBuf[i-2])^=$D9FF) then //Check SOI and EOI JPEG markers to ensure corect data received
    begin
      if WaitForMultipleObjects(3,@Events.TextureLoaded,true,0)=0 then //texture loaded and snapshot complete and video sample encoding complete
      begin
        fBufSize:=i;
        tmp:=BackBuf;
        BackBuf:=FrontBuf;
        FrontBuf:=tmp;
        SetEvent(Events.MJPEGDataReceived);
      end;
    end;
  until false;
end;

function ToolBarProc(wnd,msg,wParam,lParam: THandle): LongInt;stdcall;
var
  i,len:    Cardinal;
  f:        THandle;
  p:        pointer;
  layout:   TRectF;
  sysTime:  SYSTEMTIME;
begin
  result:=0;
  case msg of
     WM_MOUSEMOVE:begin
                  HighLightedButton:=loword(lParam) div (bmi.bmiHeader.biHeight+2);
                  if HighLightedButton<length(Buttons) then
                  begin
                    ToolTipInfo.lpszText:=Buttons[HighLightedButton].ToolTipText;
                    SendMessageW(ToolTip,TTM_ACTIVATE,1,0);
                  end
                  else
                    SendMessageW(ToolTip,TTM_ACTIVATE,0,0);
                  SendMessageW(ToolTip,TTM_UPDATETIPTEXTW,0,LongInt(@ToolTipInfo));
                  ToolBarProc(wnd,WM_PAINT,wParam and MK_LBUTTON,0);
                  end;
    WM_ERASEBKGND:;
         WM_PAINT:begin
                  FillChar(ToolBarBuffer^,bmi.bmiHeader.biSizeImage,0);
                  GdipSetWorldTransform(graphics,TransformMatrix);
                  for i:=0 to length(Buttons)-1 do
                    With Buttons[i] do
                    begin
                      if (HighLightedButton=i)or(State>0) then
                        GdipFillPath(graphics,ButtonBrushes[(State or wParam) xor 1],ButtonPath);
                      GdipFillPath(graphics,IconBrushes[State],IconPath);
                      GdipTranslateWorldTransform(graphics,bmi.bmiHeader.biHeight+2,0,MatrixOrderAppend);
                    end;
                  bmi.bmiHeader.biWidth:=Rect.Right-Rect.Left;
                  layout.x:=0;
                  layout.y:=0;
                  layout.Width:=(bmi.bmiHeader.biWidth-AllButtonsWidth)/GdipScale;
                  layout.Height:=bmi.bmiHeader.biHeight/GdipScale;
                  GdipDrawString(graphics,OutputDir,-1,font,layout,format,IconBrushes[0]);
                  GdipSetWorldTransform(graphics,TransformMatrix);
                  SetWindowPos(ToolBar,GetWindow(MainWnd,GW_HWNDPREV),Rect.Left,Rect.Top,0,0,SWP_NOACTIVATE+SWP_NOSIZE+SWP_NOREDRAW);
                  UpdateLayeredWindow(ToolBar,0,@Rect,@bmi.bmiHeader.biWidth,TempDC,@ClientRect,0,@BlendFunc,ULW_ALPHA);
                  ValidateRect(wnd,nil);
                  end;
      WM_NCHITTEST:result:=HTCLIENT;
      WM_LBUTTONUP:begin
                   case HighLightedButton of
                     BTN_ROTATE:begin
                                Rotation:=(Rotation+1) and 3;
                                WndProc(MainWnd,WM_SIZE,0,0);
                                end;
                   BTN_SNAPSHOT:begin
                                ResetEvent(Events.SnapshotComplete);
                                GetLocalTime(sysTime);
                                len:=lstrlenW(OutputDir);
                                with sysTime do
                                  OutputDir[len+wsprintfW(@OutputDir[len],'%i-%i-%i_%i-%i-%i-%i.jpg',wYear,wMonth,wDay,wHour,wMinute,wSecond,wMilliseconds)]:=#0;
                                f:=CreateFileW(OutputDir,GENERIC_WRITE,0,nil,CREATE_ALWAYS,0,0);
                                OutputDir[len]:=#0;
                                if f<>INVALID_HANDLE_VALUE then
                                begin
                                  WriteFile(f,MJPGBuffer.FrontBuf^,MJPGBuffer.fBufSize,i,nil);
                                  CloseHandle(f);
                                end
                                else
                                  MessageBoxW(MainWnd,'Can'#39' create jpeg-file.',nil,MB_OK);
                                SetEvent(Events.SnapshotComplete);
                                end;
                     BTN_RECORD:if Buttons[BTN_RECORD].State=0 then
                                begin
                                  GetLocalTime(sysTime);
                                  len:=lstrlenW(OutputDir);
                                  with sysTime do
                                    OutputDir[len+wsprintfW(@OutputDir[len],'%i-%i-%i_%i-%i-%i-%i.mp4',wYear,wMonth,wDay,wHour,wMinute,wSecond,wMilliseconds)]:=#0;
                                  if MFCreateSinkWriterFromURL(OutputDir,nil,nil,MFSinkWriter)=0 then
                                  begin
                                    Buttons[2].State:=1;
                                    StartRecTime:=CurrentTime;
                                    MFTBuffer.pSample.SetSampleDuration(SampleDuration);
                                    MFSinkWriter.AddStream(MFMediaTypeH264,i);
                                    MFSinkWriter.SetInputMediaType(0,MFMediaTypeYUY2,nil);
                                    MFTransform.ProcessMessage(MFT_MESSAGE_COMMAND_FLUSH,nil);
                                    MFTransform.ProcessMessage(MFT_MESSAGE_NOTIFY_BEGIN_STREAMING,nil);
                                    MFTransform.ProcessMessage(MFT_MESSAGE_NOTIFY_START_OF_STREAM,nil);
                                    MFSinkWriter.BeginWriting;
                                  end
                                  else
                                    MessageBoxW(MainWnd,'H264 encoder is not available. Can'#39't record video.',nil,MB_OK);
                                  OutputDir[len]:=#0;
                                end
                                else
                                begin
                                  WaitForSingleObject(Events.VideoSampleComplete,INFINITE);
                                  Buttons[2].State:=0;
                                  MFTransform.ProcessMessage(MFT_MESSAGE_NOTIFY_END_OF_STREAM,nil);
                                  MFTransform.ProcessMessage(MFT_MESSAGE_COMMAND_DRAIN,nil);
                                  MFSinkWriter.Finalize;
                                  MFSinkWriter._Release;
                                  pointer(MFSinkWriter):=nil;
                                end;
                     BTN_BROWSE:begin
                                p:=SHBrowseForFolderW(BrowseInfo);
                                if p<>nil then
                                begin
                                  SHGetPathFromIDListW(p,OutputDir);
                                  i:=lstrlenW(OutputDir);
                                  if OutputDir[i-1]<>'\' then
                                    OutputDir[i]:='\';
                                  OutputDir[i+1]:=#0;
                                end;
                                end;
                   else
                     defWindowProcW(wnd,WM_NCLBUTTONDOWN,wParam,lParam);
                   end;
                   ToolBarProc(wnd,WM_PAINT,0,0);
                   DefWindowProcW(wnd,msg,wParam,lParam);
                   end;
    WM_LBUTTONDOWN:ToolBarProc(wnd,WM_PAINT,1,0);
  else
    result:=DefWindowProcW(wnd,msg,wParam,lParam);
  end;
end;

function WndProc(wnd,msg,wParam,lParam: THandle): LongInt;stdcall;
var
  x:   single;
begin
  result:=0;
  case msg of
        WM_NCPAINT:begin
                   defWindowProcW(wnd,WM_NCPAINT,wParam,0);
                   ToolBarProc(ToolBar,WM_PAINT,0,0);
                   end;
     WM_ERASEBKGND:;
     UPDATETEXTURE:begin
                   glActiveTexture(GL_TEXTURE0);
                   glTexImage2D(GL_TEXTURE_2D,0,GL_RED,Width,Height,0,GL_RG,GL_UNSIGNED_BYTE,YUY2Data);           //Y data
                   glActiveTexture(GL_TEXTURE1);
                   glTexImage2D(GL_TEXTURE_2D,0,GL_RGBA,Width shr 1,Height,0,GL_RGBA,GL_UNSIGNED_BYTE,YUY2Data);  //UV data  (actualy it YUYV)
                   SetEvent(Events.TextureLoaded);
                   WndProc(wnd,WM_PAINT,0,0);
                   end;
          WM_PAINT:begin
                   glBegin(GL_TRIANGLE_STRIP);
                   glVertex2f(-1,1);
                   glVertex2f(1,1);
                   glVertex2f(-1,-1);
                   glVertex2f(1,-1);
                   glEnd;
                   SwapBuffers(DC);
                   ValidateRect(MainWnd,nil);
                   end;
      WM_MOUSEMOVE:begin
                   HighLightedButton:=length(Buttons);
                   ToolBarProc(wnd,WM_PAINT,wParam and MK_LBUTTON,0);
                   end;
           WM_SIZE:begin
                   GetWindowRect(wnd,Rect);
                   GetClientRect(wnd,ClientRect);
                   if ClientRect.Right=0 then  //if window is minimized
                     exit;
                   RotationMatrix[0,0]:=Scale/ClientRect.Right;
                   RotationMatrix[0,4]:=-Scale/ClientRect.Bottom;
                   x:=(ClientRect.Right/ClientRect.Bottom)/AspectRatios[Rotation];
                   if x>1 then
                     RotationMatrix[0,0]:=RotationMatrix[0,0]*x
                   else
                     RotationMatrix[0,4]:=RotationMatrix[0,4]/x;
                   RotationMatrix[3,3]:=RotationMatrix[0,0];
                   RotationMatrix[1,3]:=-RotationMatrix[0,0];
                   RotationMatrix[2,0]:=RotationMatrix[1,3];
                   RotationMatrix[1,1]:=RotationMatrix[0,4];
                   RotationMatrix[2,4]:=-RotationMatrix[0,4];
                   RotationMatrix[3,1]:=RotationMatrix[2,4];
                   RotationMatrix[0,2]:=(1-ClientRect.Right *RotationMatrix[0,0])*0.5;
                   RotationMatrix[3,5]:=RotationMatrix[0,2];
                   RotationMatrix[1,5]:=1-RotationMatrix[0,2];
                   RotationMatrix[2,2]:=RotationMatrix[1,5];
                   RotationMatrix[0,5]:=(1-ClientRect.Bottom*RotationMatrix[0,4])*0.5;
                   RotationMatrix[1,2]:=RotationMatrix[0,5];
                   RotationMatrix[2,5]:=1-RotationMatrix[0,5];
                   RotationMatrix[3,2]:=RotationMatrix[2,5];
                   glViewPort(0,0,ClientRect.Right,ClientRect.Bottom);
                   glUniformMatrix3fv(0,1,false,@RotationMatrix[Rotation]);
                   ToolBarProc(ToolBar,WM_PAINT,0,0);
                   end;
  WM_GETMINMAXINFO:PMINMAXINFO(lParam)^.ptMinTrackSize.X:=AllButtonsWidth+1;
           WM_MOVE:begin
                   GetWindowRect(wnd,Rect);
                   ToolBarProc(ToolBar,WM_PAINT,0,0);
                   end;
          WM_CLOSE:begin
                   if Buttons[BTN_RECORD].State>0 then
                   begin
                     HighLightedButton:=BTN_RECORD;
                     ToolbarProc(ToolBar,WM_LBUTTONUP,0,0);
                   end;
                   SendTo(CMDSock,StopCMD,sizeof(StopCMD),0,sock_addr,sizeof(sock_addr));
                   ExitProcess(0);
                   end;
  WM_NCLBUTTONDOWN,
     WM_NCACTIVATE:begin
                   PostMessageW(ToolBar,WM_PAINT,0,0);
                   result:=DefWindowProcW(wnd,msg,wParam,lParam);
                   end;
    else
    result:=DefWindowProcW(wnd,msg,wParam,lParam);
  end;
end;

function _wglGetProcAddress(name: PAnsiChar): pointer;
begin
  result:=wglGetProcAddress(name);
  if result=nil then
  begin
    MessageBoxW(0,'Video card is not supported.',nil,MB_OK);
    ExitProcess(0);
  end;
end;

begin
  GetTempPathW(length(OutputDir),OutputDir);

  //Create MainWindow
  MainWnd:=CreateWindowExW(WS_EX_DLGMODALFRAME,'STATIC',nil,WS_VISIBLE+WS_OVERLAPPEDWINDOW,0,0,Width,Height,0,0,0,nil);
  SetWindowThemeAttribute(MainWnd,1,NoDrawIcon,sizeof(NoDrawIcon));

  //Create caption-toolbar window
  BorderSize.Width:=GetSystemMetrics(SM_CXSIZEFRAME);
  if DwmGetWindowAttribute(MainWnd,DWMWA_CAPTION_BUTTON_BOUNDS,Rect,sizeof(Rect))=0 then //Check a condition for compatibility with Classic Windows theme
  begin
    SendMessageW(MainWnd,WM_SETICON,0,LoadIconW($400000,PWideChar(1)));
    i:=Rect.Right-Rect.Left;
  end
  else
  begin
    BorderSize.Height:=GetSystemMetrics(SM_CYSIZEFRAME);
    SendMessage(MainWnd,WM_GETTITLEBARINFOEX,0,LongInt(@TitleBarInfo));
    Rect:=TitleBarInfo.rcTitleBar;
    i:=TitleBarInfo.rcTitleBar.Right-TitleBarInfo.rcTitleBar.Left-TitleBarInfo.rgrect[2].Left;
  end;
  bmi.bmiHeader.biHeight   :=Rect.Bottom-Rect.Top;
  bmi.bmiHeader.biWidth    :=4096;
  bmi.bmiHeader.biSizeImage:=bmi.bmiHeader.biWidth*bmi.bmiHeader.biHeight shl 2;
  AllButtonsWidth:=i+(bmi.bmiHeader.biHeight+2)*length(Buttons)+BorderSize.Width;
  ToolBar:=CreateWindowExW(WS_EX_LAYERED+WS_EX_NOACTIVATE,'STATIC',nil,WS_VISIBLE+WS_POPUP,0,0,bmi.bmiHeader.biWidth,bmi.bmiHeader.biHeight,0,0,0,nil);
  BrowseInfo.hwndOwner:=ToolBar;
  DC:=GetWindowDC(ToolBar);
  TempDC:=CreateCompatibleDC(DC);
  SelectObject(TempDC,CreateDIBSection(0,bmi,0,ToolBarBuffer,0,0));
  ReleaseDC(ToolBar,DC);

  //GDI+ initialization
  DC:=GetWindowDC(MainWnd);
  SetActiveWindow(MainWnd);
  dwColor:=GetPixel(DC,10,10);                                               //Get caption color
  dwColor:=not -(((Color.rgbRed+Color.rgbGreen+Color.rgbBlue) div 3) shr 7); //Calculate contrast color for caption (black or white)
  ReleaseDC(MainWnd,DC);
  DC:=GetDC(MainWnd);
  GdiplusStartup(gdip,GdipStartupInput,nil);
  GdipCreateFromHDC(TempDC,Graphics);
  GdipCreateMatrix(TransformMatrix);
  GdipScale:=(bmi.bmiHeader.biHeight-BorderSize.Height)/1024;
  GdipSetMatrixElements(TransformMatrix,GdipScale,0,0,GdipScale,BorderSize.Width,BorderSize.Height);
  GdipSetSmoothingMode(graphics,SmoothingModeHighQuality);
  GdipCreateStringFormat(StringFormatFlagsNoWrap,LANG_NEUTRAL,format);
  GdipSetStringFormatLineAlign(format,StringAlignmentCenter);
  GdipSetTextRenderingHint(graphics,TextRenderingHintAntiAliasGridFit);
  GdipCreateFontFamilyFromName('Calibri',0,family);
  GdipCreateFont(family,round(bmi.bmiHeader.biHeight*0.6)/GdipScale,0,UnitPixel,font);
  Scale:=1;
  GdipCreatePath2I(ButtonPoints,ButtonPTypes,length(ButtonPTypes),FillModeAlternate,ButtonPath);
  GdipCreatePath2I(RotatePoints,RotatePTypes,length(RotatePTypes),FillModeAlternate,Buttons[0].IconPath);
  GdipCreatePath2I(SnapshotPoints,SnapshotPTypes,length(SnapshotPTypes),FillModeAlternate,Buttons[1].IconPath);
  GdipCreatePath2I(RecordPoints,RecordPTypes,length(RecordPTypes),FillModeAlternate,Buttons[2].IconPath);
  GdipCreatePath2I(BrowsePoints,BrowsePTypes,length(BrowsePTypes),FillModeAlternate,Buttons[3].IconPath);
  i:=Color.rgbBlue and 1; //Alpha values for pressed and released button colors in dark and light themes are oposite
  Color.rgbReserved:=$90;
  GdipCreateSolidFill(dwColor,ButtonBrushes[i]);
  Color.rgbReserved:=$70;
  GdipCreateSolidFill(dwColor,ButtonBrushes[i xor 1]);
  Color.rgbReserved:=$FF;
  GdipCreateSolidFill(dwColor,IconBrushes[0]);
  GdipCreateSolidFill($FFFF0000,IconBrushes[1]);

  //OpenGL initialization
  SetPixelFormat(DC,ChoosePixelFormat(DC,@pfd),@pfd);
  RC:=wglCreateContext(DC);
  wglMakeCurrent(DC,RC);
  glActiveTexture   :=_wglGetProcAddress('glActiveTexture');
  glUniformMatrix3fv:=_wglGetProcAddress('glUniformMatrix3fv');
  glLinkProgram     :=_wglGetProcAddress('glLinkProgram');
  glShaderSource    :=_wglGetProcAddress('glShaderSource');
  glUseProgram      :=_wglGetProcAddress('glUseProgram');
  glAttachShader    :=_wglGetProcAddress('glAttachShader');
  glCompileShader   :=_wglGetProcAddress('glCompileShader');
  glCreateProgram   :=_wglGetProcAddress('glCreateProgram');
  glCreateShader    :=_wglGetProcAddress('glCreateShader');
  glDeleteShader    :=_wglGetProcAddress('glDeleteShader');
  YUY2toRGB:=glCreateProgram;
  i:=glCreateShader(GL_FRAGMENT_SHADER);
  glShaderSource(i,1,@FragmentShader,nil);
  glCompileShader(i);
  glAttachShader(YUY2toRGB,i);
  glDeleteShader(i);
  glLinkProgram(YUY2toRGB);
  glUseProgram(YUY2toRGB);
  glEnable(GL_TEXTURE_2D);
  glGenTextures(2,textures);
  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_2D,textures[0]);
  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_CLAMP_TO_BORDER);
  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_CLAMP_TO_BORDER);
  glActiveTexture(GL_TEXTURE1);
  glBindTexture(GL_TEXTURE_2D,textures[1]);
  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_CLAMP_TO_BORDER);
  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_CLAMP_TO_BORDER); 

  //Initialize Media Foundation MJPEG to YUY2 decoder
  CoInitializeEx(nil,COINIT_APARTMENTTHREADED+COINIT_DISABLE_OLE1DDE);
  MFStartup(MF_VERSION,MFSTARTUP_FULL);
  MFTEnumEx(MFT_CATEGORY_VIDEO_DECODER,MFT_ENUM_FLAG_SYNCMFT+MFT_ENUM_FLAG_LOCALMFT+MFT_ENUM_FLAG_SORTANDFILTER,inputFilter,outputFilter,MFActivate,i);
  if i=0 then
  begin
    MessageBoxW(0,'MJPEG decoder is not available.',nil,MB_OK);
    ExitProcess(0);
  end;
  MFCreateMediaType(MFMediaTypeH264);
  MFMediaTypeH264.SetGUID(MF_MT_MAJOR_TYPE,MFMediaType_Video);
  MFMediaTypeH264.SetGUID(MF_MT_SUBTYPE,MFVideoFormat_H264);
  MFMediaTypeH264.SetUINT64(MF_MT_FRAME_RATE,FPS);
  MFMediaTypeH264.SetUINT64(MF_MT_FRAME_SIZE,FrameSize);
  MFMediaTypeH264.SetUINT32(MF_MT_INTERLACE_MODE,MFVideoInterlace_Progressive);
  MFMediaTypeH264.SetUINT32(MF_MT_AVG_BITRATE,4*1024*1024);
  MFCreateMediaType(MFMediaTypeYUY2);
  MFMediaTypeYUY2.SetGUID(MF_MT_MAJOR_TYPE,MFMediaType_Video);
  MFMediaTypeYUY2.SetGUID(MF_MT_SUBTYPE,MFVideoFormat_YUY2);
  MFMediaTypeYUY2.SetUINT64(MF_MT_FRAME_SIZE,FrameSize);
  MFCreateMediaType(MFMediaTypeMJPG);
  MFMediaTypeMJPG.SetGUID(MF_MT_MAJOR_TYPE,MFMediaType_Video);
  MFMediaTypeMJPG.SetGUID(MF_MT_SUBTYPE,MFVideoFormat_MJPG);
  MFMediaTypeMJPG.SetUINT64(MF_MT_FRAME_SIZE,FrameSize);
  MFActivate[0].ActivateObject(IMFTransform,@MFTransform);
  MFActivate[0]._Release;
  MFTransform.SetInputType(0,MFMediaTypeMJPG,0);
  MFTransform.SetOutputType(0,MFMediaTypeYUY2,0);
  MFCreateSample(MFSample);
  MJPGBuffer:=TMediaBuffer.Create(@MJPGData1,@MJPGData2);
  MFSample.AddBuffer(MJPGBuffer);
  YUY2Buffer:=TMediaBuffer.Create(@YUY2Data,@YUY2Data);
  MFCreateSample(MFTBuffer.pSample);
  MFTBuffer.pSample.AddBuffer(YUY2Buffer);

  //Events for threads synchronization
  Events.MJPEGDataReceived  :=CreateEvent(nil,false,false,nil);
  Events.TextureLoaded      :=CreateEvent(nil,false,true,nil);
  Events.SnapshotComplete   :=CreateEvent(nil,true,true,nil);
  Events.VideoSampleComplete:=CreateEvent(nil,true,true,nil);
  CreateThread(nil,0,@DMReadDataThread,nil,0,PCardinal(0)^);
  CreateThread(nil,0,@TranscoderThread,nil,0,PCardinal(0)^);

  SetWindowLongW(MainWnd,GWL_WNDPROC,LongInt(@WndProc));
  SetWindowLongW(ToolBar,GWL_WNDPROC,LongInt(@ToolBarProc));

  //Place window in the center of the screen and adjust window size to fit the video
  GetWindowRect(MainWnd,Rect);
  GetClientRect(MainWnd,ClientRect);
  dec(Rect.Right,ClientRect.Right-Width);
  dec(Rect.Bottom,ClientRect.Bottom-Height);
  Rect.Left:=(GetSystemMetrics(SM_CXSCREEN)-Rect.Right) shr 1;
  Rect.Top :=(GetSystemMetrics(SM_CYSCREEN)-Rect.Bottom) shr 1;
  MoveWindow(MainWnd,Rect.Left,Rect.Top,Rect.Right,Rect.Bottom,true);

  //Tooltips for toolbar
  ToolTip:=CreateWindowExW(WS_EX_TOPMOST,TOOLTIPS_CLASS,nil,WS_POPUP+TTS_NOPREFIX+TTS_ALWAYSTIP,0,0,0,0,ToolBar,0,0,nil);
  ToolTipInfo.hwnd:=ToolBar;
  ToolTipInfo.rect:=ClientRect;
  SendMessageW(ToolTip,TTM_ADDTOOLW,0,LongInt(@ToolTipInfo));

  repeat
    GetMessageW(msg,0,0,0);
    TranslateMessage(msg);
    DispatchMessageW(msg);
    if msg.hwnd=ToolBar then
      SendMessageW(Tooltip,TTM_RELAYEVENT,0,LongInt(@msg));
  until false;
end.
