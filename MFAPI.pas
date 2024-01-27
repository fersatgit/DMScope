unit MFAPI;

{$W-}
interface

uses Windows;

const
  mfdll ='MF.DLL';
  mfplat='MFPLAT.DLL';
  mfreadwrite='MFREADWRITE.DLL';
  ole32 ='OLE32.DLL';

  E_NOTIMPL = $80004001;
  S_OK      = 0;

  COINIT_MULTITHREADED      = 0;      // OLE calls objects on any thread.
  COINIT_APARTMENTTHREADED  = 2;      // Apartment model
  COINIT_DISABLE_OLE1DDE    = 4;      // Dont use DDE for Ole1 support.
  COINIT_SPEED_OVER_MEMORY  = 8;      // Trade memory for speed.

  MF_VERSION = $10070;

  MFSTARTUP_NOSOCKET =1;
  MFSTARTUP_LITE     =MFSTARTUP_NOSOCKET;
  MFSTARTUP_FULL     =0;

  MF_E_ATTRIBUTENOTFOUND    =$C00D36E6;

  MF_TRANSCODE_ADJUST_PROFILE_DEFAULT	              =0;
  MF_TRANSCODE_ADJUST_PROFILE_USE_SOURCE_ATTRIBUTES	=1;

  MF_RESOLUTION_MEDIASOURCE	                                          = $1;
  MF_RESOLUTION_BYTESTREAM                                         	  = $2;
  MF_RESOLUTION_CONTENT_DOES_NOT_HAVE_TO_MATCH_EXTENSION_OR_MIME_TYPE	= $10;
  MF_RESOLUTION_KEEP_BYTE_STREAM_ALIVE_ON_FAIL	                      = $20;
  MF_RESOLUTION_DISABLE_LOCAL_PLUGINS	                                = $40;
  MF_RESOLUTION_PLUGIN_CONTROL_POLICY_APPROVED_ONLY                   = $80;
  MF_RESOLUTION_PLUGIN_CONTROL_POLICY_WEB_ONLY	                      = $100;
  MF_RESOLUTION_PLUGIN_CONTROL_POLICY_WEB_ONLY_EDGEMODE	              = $200;
  MF_RESOLUTION_ENABLE_STORE_PLUGINS	                                = $400;
  MF_RESOLUTION_READ                                                  = $10000;
  MF_RESOLUTION_WRITE                                                 = $20000;

  MFBYTESTREAM_IS_READABLE                 = $00000001;
  MFBYTESTREAM_IS_WRITABLE                 = $00000002;
  MFBYTESTREAM_IS_SEEKABLE                 = $00000004;
  MFBYTESTREAM_IS_REMOTE                   = $00000008;
  MFBYTESTREAM_IS_DIRECTORY                = $00000080;
  MFBYTESTREAM_HAS_SLOW_SEEK               = $00000100;
  MFBYTESTREAM_IS_PARTIALLY_DOWNLOADED     = $00000200;
  MFBYTESTREAM_SHARE_WRITE                 = $00000400;
  MFBYTESTREAM_DOES_NOT_USE_NETWORK        = $00000800;
  MFBYTESTREAM_SEEK_FLAG_CANCEL_PENDING_IO = $00000001;

  msoBegin   = 0;
  msoCurrent = 1;

  STREAM_SEEK_SET  = 0;
  STREAM_SEEK_CUR  = 1;
  STREAM_SEEK_END  = 2;

  STATFLAG_DEFAULT = 0;
  STATFLAG_NONAME  = 1;
  STATFLAG_NOOPEN  = 2;

  STGTY_STORAGE    = 1;
  STGTY_STREAM     = 2;
  STGTY_LOCKBYTES  = 3;
  STGTY_PROPERTY   = 4;

  LOCK_WRITE       = 1;
  LOCK_EXCLUSIVE   = 2;
  LOCK_ONLYONCE    = 4;

  MFVideoInterlace_Unknown                     = 0;
  MFVideoInterlace_Progressive                 = 2;
  MFVideoInterlace_FieldInterleavedUpperFirst  = 3;
  MFVideoInterlace_FieldInterleavedLowerFirst  = 4;
  MFVideoInterlace_FieldSingleUpper            = 5;
  MFVideoInterlace_FieldSingleLower            = 6;
  MFVideoInterlace_MixedInterlaceOrProgressive = 7;
  MFVideoInterlace_Last                        = (MFVideoInterlace_MixedInterlaceOrProgressive+1);
  MFVideoInterlace_ForceDWORD                  = $7fffffff;

  MFT_ENUM_FLAG_SYNCMFT                        = $00000001;
  MFT_ENUM_FLAG_ASYNCMFT                       = $00000002;
  MFT_ENUM_FLAG_HARDWARE                       = $00000004;
  MFT_ENUM_FLAG_FIELDOFUSE                     = $00000008;
  MFT_ENUM_FLAG_LOCALMFT                       = $00000010;
  MFT_ENUM_FLAG_TRANSCODE_ONLY                 = $00000020;
  MFT_ENUM_FLAG_SORTANDFILTER                  = $00000040;
  MFT_ENUM_FLAG_SORTANDFILTER_APPROVED_ONLY    = $000000C0;
  MFT_ENUM_FLAG_SORTANDFILTER_WEB_ONLY         = $00000140;
  MFT_ENUM_FLAG_SORTANDFILTER_WEB_ONLY_EDGEMODE= $00000240;
  MFT_ENUM_FLAG_UNTRUSTED_STOREMFT             = $00000400;
  MFT_ENUM_FLAG_ALL                            = $0000003F;

  MFT_MESSAGE_COMMAND_FLUSH                    = $0;
  MFT_MESSAGE_COMMAND_DRAIN                    = $1;
  MFT_MESSAGE_SET_D3D_MANAGER                  = $2;
  MFT_MESSAGE_DROP_SAMPLES                     = $3;
  MFT_MESSAGE_COMMAND_TICK                     = $4;
  MFT_MESSAGE_NOTIFY_BEGIN_STREAMING           = $10000000;
  MFT_MESSAGE_NOTIFY_END_STREAMING             = $10000001;
  MFT_MESSAGE_NOTIFY_END_OF_STREAM             = $10000002;
  MFT_MESSAGE_NOTIFY_START_OF_STREAM           = $10000003;
  MFT_MESSAGE_NOTIFY_RELEASE_RESOURCES         = $10000004;
  MFT_MESSAGE_NOTIFY_REACQUIRE_RESOURCES       = $10000005;
  MFT_MESSAGE_NOTIFY_EVENT                     = $10000006;
  MFT_MESSAGE_COMMAND_SET_OUTPUT_STREAM_STATE  = $10000007;
  MFT_MESSAGE_COMMAND_FLUSH_OUTPUT_STREAM      = $10000008;
  MFT_MESSAGE_COMMAND_MARKER                   = $20000000;
  
  MEUnknown	                                  = 0;
  MEError                                   	= 1;
  MEExtendedType                            	= 2;
  MENonFatalError                           	= 3;
  MEGenericV1Anchor	                          = MENonFatalError;
  MESessionUnknown                          	= 100;
  MESessionTopologySet                       	= 101;
  MESessionTopologiesCleared                 	= 102;
  MESessionStarted                           	= 103;
  MESessionPaused	                            = 104;
  MESessionStopped                           	= 105;
  MESessionClosed                            	= 106;
  MESessionEnded	                            = 107;
  MESessionRateChanged                       	= 108;
  MESessionScrubSampleComplete	              = 109;
  MESessionCapabilitiesChanged               	= 110;
  MESessionTopologyStatus	                    = 111;
  MESessionNotifyPresentationTime            	= 112;
  MENewPresentation                           = 113;
  MELicenseAcquisitionStart                  	= 114;
  MELicenseAcquisitionCompleted               = 115;
  MEIndividualizationStart                   	= 116;
  MEIndividualizationCompleted	              = 117;
  MEEnablerProgress	                          = 118;
  MEEnablerCompleted                        	= 119;
  MEPolicyError	                              = 120;
  MEPolicyReport                       	      = 121;
  MEBufferingStarted                        	= 122;
  MEBufferingStopped                        	= 123;
  MEConnectStart	                            = 124;
  MEConnectEnd                       	        = 125;
  MEReconnectStart	                          = 126;
  MEReconnectEnd	                            = 127;
  MERendererEvent	                            = 128;
  MESessionStreamSinkFormatChanged           	= 129;
  MESessionV1Anchor                         	= MESessionStreamSinkFormatChanged;
  MESourceUnknown	                            = 200;
  MESourceStarted	                            = 201;
  MEStreamStarted	                            = 202;
  MESourceSeeked	                            = 203;
  MEStreamSeeked	                            = 204;
  MENewStream                               	= 205;
  MEUpdatedStream	                            = 206;
  MESourceStopped                           	= 207;
  MEStreamStopped                      	      = 208;
  MESourcePaused	                            = 209;
  MEStreamPaused                             	= 210;
  MEEndOfPresentation                        	= 211;
  MEEndOfStream	                              = 212;
  MEMediaSample                      	        = 213;
  MEStreamTick                              	= 214;
  MEStreamThinMode                            = 215;
  MEStreamFormatChanged                      	= 216;
  MESourceRateChanged                      	  = 217;
  MEEndOfPresentationSegment                  = 218;
  MESourceCharacteristicsChanged             	= 219;
  MESourceRateChangeRequested                	= 220;
  MESourceMetadataChanged                    	= 221;
  MESequencerSourceTopologyUpdated            = 222;
  MESourceV1Anchor	                          = MESequencerSourceTopologyUpdated;
  MESinkUnknown                              	= 300;
  MEStreamSinkStarted	                        = 301;
  MEStreamSinkStopped	                        = 302;
  MEStreamSinkPaused                         	= 303;
  MEStreamSinkRateChanged                     = 304;
  MEStreamSinkRequestSample                   = 305;
  MEStreamSinkMarker	                        = 306;
  MEStreamSinkPrerolled	                      = 307;
  MEStreamSinkScrubSampleComplete	            = 308;
  MEStreamSinkFormatChanged                 	= 309;
  MEStreamSinkDeviceChanged                  	= 310;
  MEQualityNotify	                            = 311;
  MESinkInvalidated	                          = 312;
  MEAudioSessionNameChanged	                  = 313;
  MEAudioSessionVolumeChanged  	              = 314;
  MEAudioSessionDeviceRemoved	                = 315;
  MEAudioSessionServerShutdown	              = 316;
  MEAudioSessionGroupingParamChanged	        = 317;
  MEAudioSessionIconChanged	                  = 318;
  MEAudioSessionFormatChanged	                = 319;
  MEAudioSessionDisconnected                	= 320;
  MEAudioSessionExclusiveModeOverride	        = 321;
  MESinkV1Anchor	                            = MEAudioSessionExclusiveModeOverride;
  MECaptureAudioSessionVolumeChanged        	= 322;
  MECaptureAudioSessionDeviceRemoved	        = 323;
  MECaptureAudioSessionFormatChanged	        = 324;
  MECaptureAudioSessionDisconnected	          = 325;
  MECaptureAudioSessionExclusiveModeOverride	= 326;
  MECaptureAudioSessionServerShutdown       	= 327;
  MESinkV2Anchor	                            = MECaptureAudioSessionServerShutdown;
  METrustUnknown	                            = 400;
  MEPolicyChanged	                            = 401;
  MEContentProtectionMessage	                = 402;
  MEPolicySet	                                = 403;
  METrustV1Anchor	                            = MEPolicySet;
  MEWMDRMLicenseBackupCompleted	              = 500;
  MEWMDRMLicenseBackupProgress                = 501;
  MEWMDRMLicenseRestoreCompleted	            = 502;
  MEWMDRMLicenseRestoreProgress	              = 503;
  MEWMDRMLicenseAcquisitionCompleted        	= 506;
  MEWMDRMIndividualizationCompleted	          = 508;
  MEWMDRMIndividualizationProgress	          = 513;
  MEWMDRMProximityCompleted	                  = 514;
  MEWMDRMLicenseStoreCleaned	                = 515;
  MEWMDRMRevocationDownloadCompleted        	= 516;
  MEWMDRMV1Anchor	                            = MEWMDRMRevocationDownloadCompleted;
  METransformUnknown                        	= 600;
  METransformNeedInput	                      = METransformUnknown;
  METransformHaveOutput	                      = METransformNeedInput;
  METransformDrainComplete                  	= METransformHaveOutput;
  METransformMarker	                          = METransformDrainComplete;
  METransformInputStreamStateChanged	        = METransformMarker+1;
  MEByteStreamCharacteristicsChanged          = 700;
  MEVideoCaptureDeviceRemoved	                = 800;
  MEVideoCaptureDevicePreempted	              = 801;
  MEStreamSinkFormatInvalidatd	              = 802;
  MEEncodingParameters	                      = 803;
  MEContentProtectionMetadata                 = 900;
  MEDeviceThermalStateChanged	                = 950;
  MEReservedMax	                              = 10000;

  GUID_NULL:                        TGUID='{00000000-0000-0000-0000-000000000000}';
  MF_MT_MAJOR_TYPE:                 TGUID='{48eba18e-f8c9-4687-bf11-0a74c9f96a8f}';
  MFMediaType_Image:                TGUID='{72178C23-E45B-11D5-BC2A-00B0D0F3F4AB}';
  MFMediaType_Video:                TGUID='{73646976-0000-0010-8000-00AA00389B71}';
  MF_MT_SUBTYPE:                    TGUID='{f7e34c9a-42e8-4714-b74b-cb29d72c35e5}';
  MFImageFormat_JPEG:               TGUID='{19e4a5aa-5662-4fc5-a0c0-1758028e1057}';
  MFImageFormat_RGB32:              TGUID='{00000016-0000-0010-8000-00aa00389b71}';
  MFVideoFormat_RGB24:              TGUID='{00000014-0000-0010-8000-00aa00389b71}';  
  MFVideoFormat_RGB32:              TGUID='{00000016-0000-0010-8000-00aa00389b71}';
  MFVideoFormat_H264:               TGUID='{34363248-0000-0010-8000-00aa00389b71}';
  MFVideoFormat_WMV3:               TGUID='{33564D57-0000-0010-8000-00aa00389b71}';
  MFVideoFormat_MJPG:               TGUID='{47504A4D-0000-0010-8000-00aa00389b71}';
  MFVideoFormat_AYUV:               TGUID='{56555941-0000-0010-8000-00aa00389b71}';
  MFVideoFormat_NV12:               TGUID='{3231564E-0000-0010-8000-00aa00389b71}';
  MFVideoFormat_YUY2:               TGUID='{32595559-0000-0010-8000-00aa00389b71}';
  MFVideoFormat_IMC1:               TGUID='{31434D49-0000-0010-8000-00aa00389b71}';
  MFVideoFormat_IMC2:               TGUID='{32434D49-0000-0010-8000-00aa00389b71}';
  MFVideoFormat_IMC3:               TGUID='{33434D49-0000-0010-8000-00aa00389b71}';
  MFVideoFormat_IMC4:               TGUID='{34434D49-0000-0010-8000-00aa00389b71}';
  MF_TRANSCODE_CONTAINERTYPE:       TGUID='{150ff23f-4abc-478b-ac4f-e1916fba1cca}';
  MFTranscodeContainerType_MPEG4:   TGUID='{dc6cd05d-b9d0-40ef-bd35-fa622c1ab28a}';
  MFTranscodeContainerType_ASF:     TGUID='{430f6f6e-b6bf-4fc1-a0bd-9ee46eee2afb}';
  MF_MT_INTERLACE_MODE:             TGUID='{e2724bb8-e676-4806-b4b2-a8d6efb44ccd}';    
  MF_TRANSCODE_ADJUST_PROFILE:      TGUID='{9c37c21b-060f-487c-a690-80d7f50d1c72}';
  MF_MT_MPEG2_PROFILE:              TGUID='{ad76a80b-2d5c-4e0b-b375-64e520137036}';
  MF_MT_FRAME_SIZE:                 TGUID='{1652c33d-d6b2-4012-b834-72030849a37d}';
  MF_MT_FRAME_RATE:                 TGUID='{c459a2e8-3d2c-4e44-b132-fee5156c7bb0}';
  MF_MT_PIXEL_ASPECT_RATIO:         TGUID='{c6376a1e-8d0a-4027-be45-6d9a0ad39bb6}';
  MF_MT_AVG_BITRATE:                TGUID='{20332624-fb0d-4d9e-bd0d-cbf6786c102e}';
  MF_BYTESTREAM_ORIGIN_NAME:        TGUID='{fc358288-3cb6-460c-a424-b6681260375a}';
  MF_BYTESTREAM_CONTENT_TYPE:       TGUID='{fc358289-3cb6-460c-a424-b6681260375a}';
  MF_BYTESTREAM_DURATION:           TGUID='{fc35828a-3cb6-460c-a424-b6681260375a}';
  MF_BYTESTREAM_LAST_MODIFIED_TIME: TGUID='{fc35828b-3cb6-460c-a424-b6681260375a}';
  MF_BYTESTREAM_IFO_FILE_URI:       TGUID='{fc35828c-3cb6-460c-a424-b6681260375a}';
  MF_BYTESTREAM_DLNA_PROFILE_ID:    TGUID='{fc35828d-3cb6-460c-a424-b6681260375a}';
  MF_BYTESTREAM_EFFECTIVE_URL:      TGUID='{9afa0209-89d1-42af-8456-1de6b562d691}';
  MF_BYTESTREAM_TRANSCODED:         TGUID='{b6c5c282-4dc9-4db9-ab48-cf3b6d8bc5e0}';
  MFT_CATEGORY_VIDEO_DECODER:       TGUID='{d6c02d4b-6833-45b4-971a-05a4b04bab91}';
  MFT_CATEGORY_VIDEO_ENCODER:       TGUID='{f79eac7d-e545-4387-bdee-d647d7bde42a}';

  eAVEncH264VProfile_unknown                   = 0;
  eAVEncH264VProfile_Simple                    = 66;
  eAVEncH264VProfile_Base                      = 66;
  eAVEncH264VProfile_Main                      = 77;
  eAVEncH264VProfile_High                      = 100;
  eAVEncH264VProfile_422                       = 122;
  eAVEncH264VProfile_High10                    = 110;
  eAVEncH264VProfile_444                       = 244;
  eAVEncH264VProfile_Extended                  = 88;
  eAVEncH264VProfile_ScalableBase              = 83;
  eAVEncH264VProfile_ScalableHigh              = 86;
  eAVEncH264VProfile_MultiviewHigh             = 118;
  eAVEncH264VProfile_StereoHigh                = 128;
  eAVEncH264VProfile_ConstrainedBase           = 256;
  eAVEncH264VProfile_UCConstrainedHigh         = 257;
  eAVEncH264VProfile_UCScalableConstrainedBase = 258;
  eAVEncH264VProfile_UCScalableConstrainedHigh = 259;

	AVIF_HASINDEX            =$00000010;
	AVIF_MUSTUSEINDEX        =$00000020;
	AVIF_ISINTERLEAVED       =$00000100;
	AVIF_TRUSTCKTYPE         =$00000800;
	AVIF_WASCAPTUREFILE      =$00010000;
	AVIF_COPYRIGHTED         =$00020000;
	AVI_MAX_RIFF_SIZE        =$40000000;
	AVI_MAX_STREAM_COUNT     =100;
	AVIIF_INDEX              =$00000010;
	AVIIF_NO_TIME            =$00000100;
  AVISF_DISABLED           =$00000001;
 	AVISF_VIDEO_PALCHANGES   =$00010000;

  VT_EMPTY           = 0;   { [V]   [P]  nothing                     }
  VT_NULL            = 1;   { [V]        SQL style Null              }
  VT_I2              = 2;   { [V][T][P]  2 byte signed int           }
  VT_I4              = 3;   { [V][T][P]  4 byte signed int           }
  VT_R4              = 4;   { [V][T][P]  4 byte real                 }
  VT_R8              = 5;   { [V][T][P]  8 byte real                 }
  VT_CY              = 6;   { [V][T][P]  currency                    }
  VT_DATE            = 7;   { [V][T][P]  date                        }
  VT_BSTR            = 8;   { [V][T][P]  binary string               }
  VT_DISPATCH        = 9;   { [V][T]     IDispatch FAR*              }
  VT_ERROR           = 10;  { [V][T]     SCODE                       }
  VT_BOOL            = 11;  { [V][T][P]  True=-1, False=0            }
  VT_VARIANT         = 12;  { [V][T][P]  VARIANT FAR*                }
  VT_UNKNOWN         = 13;  { [V][T]     IUnknown FAR*               }
  VT_DECIMAL         = 14;  { [V][T]   [S]  16 byte fixed point      }
  VT_I1              = 16;  {    [T]     signed char                 }
  VT_UI1             = 17;  {    [T]     unsigned char               }
  VT_UI2             = 18;  {    [T]     unsigned short              }
  VT_UI4             = 19;  {    [T]     unsigned long               }
  VT_I8              = 20;  {    [T][P]  signed 64-bit int           }
  VT_UI8             = 21;  {    [T]     unsigned 64-bit int         }
  VT_INT             = 22;  {    [T]     signed machine int          }
  VT_UINT            = 23;  {    [T]     unsigned machine int        }
  VT_VOID            = 24;  {    [T]     C style void                }
  VT_HRESULT         = 25;  {    [T]                                 }
  VT_PTR             = 26;  {    [T]     pointer type                }
  VT_SAFEARRAY       = 27;  {    [T]     (use VT_ARRAY in VARIANT)   }
  VT_CARRAY          = 28;  {    [T]     C style array               }
  VT_USERDEFINED     = 29;  {    [T]     user defined type          }
  VT_LPSTR           = 30;  {    [T][P]  null terminated string      }
  VT_LPWSTR          = 31;  {    [T][P]  wide null terminated string }
  VT_FILETIME        = 64;  {       [P]  FILETIME                    }
  VT_BLOB            = 65;  {       [P]  Length prefixed bytes       }
  VT_STREAM          = 66;  {       [P]  Name of the stream follows  }
  VT_STORAGE         = 67;  {       [P]  Name of the storage follows }
  VT_STREAMED_OBJECT = 68;  {       [P]  Stream contains an object   }
  VT_STORED_OBJECT   = 69;  {       [P]  Storage contains an object  }
  VT_BLOB_OBJECT     = 70;  {       [P]  Blob contains an object     }
  VT_CF              = 71;  {       [P]  Clipboard format            }
  VT_CLSID           = 72;  {       [P]  A Class ID                  }
  VT_VECTOR          = $1000; {       [P]  simple counted array        }
  VT_ARRAY           = $2000; { [V]        SAFEARRAY*                  }
  VT_BYREF           = $4000; { [V]                                    }
  VT_RESERVED        = $8000;
  VT_ILLEGAL         = $ffff;
  VT_ILLEGALMASKED   = $0fff;
  VT_TYPEMASK        = $0fff;

type
    PDecimal = ^tagDEC;
    tagDEC = packed record
             wReserved: Word;
             case Integer of
             0: (scale, sign: Byte; Hi32: Longint;
               case Integer of
               0: (Lo32, Mid32: Longint);
               1: (Lo64: LONGLONG));
             1: (signscale: Word);
             end;

    tagSAFEARRAYBOUND = record
                        cElements: Longint;
                        lLbound:   Longint;
                        end;

    PSafeArray = ^tagSAFEARRAY;
    tagSAFEARRAY =record
                  cDims:      Word;
                  fFeatures:  Word;
                  cbElements: Longint;
                  cLocks:     Longint;
                  pvData:     Pointer;
                  rgsabound:  array[0..0] of tagSAFEARRAYBOUND;
                  end;

    tagVARIANT   =record
                  vt:         TVarType;
                  wReserved1: Word;
                  wReserved2: Word;
                  wReserved3: Word;
                  case Integer of
                  VT_UI1:                  (bVal:     Byte);
                  VT_I2:                   (iVal:     Smallint);
                  VT_I4:                   (lVal:     Longint);
                  VT_R4:                   (fltVal:   Single);
                  VT_R8:                   (dblVal:   Double);
                  VT_BOOL:                 (vbool:    WordBool);
                  VT_ERROR:                (scode:    LongInt);
                  VT_CY:                   (cyVal:    Currency);
                  VT_DATE:                 (date:     Double);
                  VT_BSTR:                 (bstrVal:  PWideChar{WideString});
                  VT_UNKNOWN:              (unkVal:   Pointer{IUnknown});
                  VT_DISPATCH:             (dispVal:  Pointer{IDispatch});
                  VT_ARRAY:                (parray:   PSafeArray);
                  VT_BYREF or VT_UI1:      (pbVal:    ^Byte);
                  VT_BYREF or VT_I2:       (piVal:    ^Smallint);
                  VT_BYREF or VT_I4:       (plVal:    ^Longint);
                  VT_BYREF or VT_R4:       (pfltVal:  ^Single);
                  VT_BYREF or VT_R8:       (pdblVal:  ^Double);
                  VT_BYREF or VT_BOOL:     (pbool:    ^WordBool);
                  VT_BYREF or VT_ERROR:    (pscode:   ^LongInt);
                  VT_BYREF or VT_CY:       (pcyVal:   ^Currency);
                  VT_BYREF or VT_DATE:     (pdate:    ^Double);
                  VT_BYREF or VT_BSTR:     (pbstrVal: ^WideString);
                  VT_BYREF or VT_UNKNOWN:  (punkVal:  ^IUnknown);
                  VT_BYREF or VT_DISPATCH: (pdispVal: ^IDispatch);
                  VT_BYREF or VT_ARRAY:    (pparray:  ^PSafeArray);
                  VT_BYREF or VT_VARIANT:  (pvarVal:   PVariant);
                  VT_BYREF:                (byRef:     Pointer);
                  VT_I1:                   (cVal:      AnsiChar);
                  VT_UI2:                  (uiVal:     Word);
                  VT_UI4:                  (ulVal:     LongWord);
                  VT_INT:                  (intVal:    Integer);
                  VT_UINT:                 (uintVal:   LongWord);
                  VT_BYREF or VT_DECIMAL:  (pdecVal:   PDecimal);
                  VT_BYREF or VT_I1:       (pcVal:     PAnsiChar);
                  VT_BYREF or VT_UI2:      (puiVal:    PWord);
                  VT_BYREF or VT_UI4:      (pulVal:    PInteger);
                  VT_BYREF or VT_INT:      (pintVal:   PInteger);
                  VT_BYREF or VT_UINT:     (puintVal:  PLongWord);
                  end;

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

  RECT16         =packed record
                  x1: word;
                  y1: word;
                  x2: word;
                  y2: word;
                  end;

  AVIMAINHEADER  =packed record
                  dwMicroSecPerFrame:    Cardinal; // frame display rate (or 0)
                  dwMaxBytesPerSec:      Cardinal; // max. transfer rate
                  dwPaddingGranularity:  Cardinal; // pad to multiples of this size;
                  dwFlags:               Cardinal; // the ever-present flags
                  dwTotalFrames:         Cardinal; // # frames in file
                  dwInitialFrames:       Cardinal;
                  dwStreams:             Cardinal;
                  dwSuggestedBufferSize: Cardinal;
                  dwWidth:               Cardinal;
                  dwHeight:              Cardinal;
                  dwReserved:            array[0..3] of Cardinal;
                  end;

  AVIStreamHeader=packed record
                  fccType:               array[0..3] of AnsiChar;
                  fccHandler:            array[0..3] of AnsiChar;
                  dwFlags:               Cardinal;
                  wPriority:             word;
                  wLanguage:             word;
                  dwInitialFrames:       Cardinal;
                  dwScale:               Cardinal;
                  dwRate:                Cardinal;
                  dwStart:               Cardinal;
                  dwLength:              Cardinal;
                  dwSuggestedBufferSize: Cardinal;
                  dwQuality:             Cardinal;
                  dwSampleSize:          Cardinal;
                  rcFrame:               RECT16;
                  end;

  PROPERTYKEY    =packed record
                  fmtid: TGUID;
                  pid:   Cardinal;
                  end;
  PPROPERTYKEY=^PROPERTYKEY;

  MFint64       =packed record
                 case byte of
                 0:(lo,hi:  Cardinal);
                 1:(int_64: int64);
                 end;

  AACProfileInfo=packed record
                 samplesPerSec: Cardinal;
                 numChannels:   Cardinal;
                 bitsPerSample: Cardinal;
                 bytesPerSec:   Cardinal;
                 aacProfile:    Cardinal;
                 end;

  MFRatio       =packed record
                 Numerator:   Cardinal;
                 Denominator: Cardinal;
                 end;

  H264ProfileInfo=packed record
                  profile:    Cardinal;
                  fps:        MFint64;
                  frame_size: MFint64;
                  bitrate:    Cardinal;
                  end;

  MFT_REGISTER_TYPE_INFO=packed record
                         guidMajorType: TGUID;
                         guidSubtype:   TGUID;
                         end;
  PMFT_REGISTER_TYPE_INFO=^MFT_REGISTER_TYPE_INFO;

  MFT_OUTPUT_STREAM_INFO=packed record
                         dwFlags:     Cardinal;
                         cbSize:      Cardinal;
                         cbAlignment: Cardinal;
                         end;
  PMFT_OUTPUT_STREAM_INFO=^MFT_OUTPUT_STREAM_INFO;

  MF_SINK_WRITER_STATISTICS =packed record
                             cb:                                 Cardinal;
                             llLastTimestampReceived:            int64;
                             llLastTimestampEncoded:             int64;
                             llLastTimestampProcessed:           int64;
                             llLastStreamTickReceived:           int64;
                             llLastSinkSampleRequest:            int64;
                             qwNumSamplesReceived:               int64;
                             qwNumSamplesEncoded:                int64;
                             qwNumSamplesProcessed:              int64;
                             qwNumStreamTicksReceived:           int64;
                             dwByteCountQueued:                  int64;
                             qwByteCountProcessed:               int64;
                             dwNumOutstandingSinkSampleRequests: Cardinal;
                             dwAverageSampleRateReceived:        Cardinal;
                             dwAverageSampleRateEncoded:         Cardinal;
                             dwAverageSampleRateProcessed:       Cardinal;
                             end;
  PMF_SINK_WRITER_STATISTICS=^MF_SINK_WRITER_STATISTICS;

  MFCLOCK_PROPERTIES=packed record
                     qwCorrelationRate: int64;
                     guidClockId:       PGUID;
                     dwClockFlags:      Cardinal;
                     qwClockFrequency:  int64;
                     dwClockTolerance:  Cardinal;
                     dwClockJitter:     Cardinal;
                     end;
  PMFCLOCK_PROPERTIES=^MFCLOCK_PROPERTIES;                   

  IMFAttributes=interface(IUnknown)
  ['{2cd2d921-c447-44a7-a13c-4adabfc247e3}']
  function GetItem(const guidKey: TGUID;pValue: PVARIANT): LongInt;stdcall;
  function GetItemType(const guidKey: TGUID;pType: PCardinal): LongInt;stdcall;
  function CompareItem(const guidKey: TGUID;Value: PVARIANT;pbResult: pboolean): LongInt;stdcall;
  function Compare(const pTheirs: IMFAttributes;MatchType: Cardinal;pbResult: pboolean): LongInt;stdcall;
  function GetUINT32(const guidKey: TGUID;punValue: PCardinal): LongInt;stdcall;
  function GetUINT64(const guidKey: TGUID;punValue: pint64): LongInt;stdcall;
  function GetDouble(const guidKey: TGUID;pfValue: pdouble): LongInt;stdcall;
  function GetGUID(const guidKey,PGUIDValue: TGUID): LongInt;stdcall;
  function GetStringLength(const guidKey: TGUID;pcchLength: PCardinal): LongInt;stdcall;
  function GetString(const guidKey: TGUID;pwszValue: PWideChar;cchBufSize: Cardinal;pcchLength: PCardinal): LongInt;stdcall;
  function GetAllocatedString(const guidKey: TGUID;ppwszValue: ppointer;pcchLength: PCardinal): LongInt;stdcall;
  function GetBlobSize(const guidKey: TGUID;pcbBlobSize: PCardinal): LongInt;stdcall;
  function GetBlob(const guidKey: TGUID;pBuf: pointer;cbBufSize: Cardinal;pcbBlobSize: PCardinal): LongInt;stdcall;
  function GetAllocatedBlob(const guidKey: TGUID;ppBuf: ppointer;pcbSize: pCardinal): LongInt;stdcall;
  function GetUnknown(const guidKey,riid: TGUID;ppv: ppointer): LongInt;stdcall;
  function SetItem(const guidKey: TGUID;Value: PVARIANT): LongInt;stdcall;
  function DeleteItem(const guidKey: TGUID): LongInt;stdcall;
  function DeleteAllItems: LongInt;stdcall;
  function SetUINT32(const guidKey: TGUID;unValue: Cardinal): LongInt;stdcall;
  function SetUINT64(const guidKey: TGUID;const unValue: int64): LongInt;stdcall;
  function SetDouble(const guidKey: TGUID;fValue: double): LongInt;stdcall;
  function SetGUID(const guidKey,guidValue: TGUID): LongInt;stdcall;
  function SetString(const guidKey: TGUID;wszValue: PWideChar): LongInt;stdcall;
  function SetBlob(const guidKey: TGUID;pBuf: pointer;cbBufSize: Cardinal): LongInt;stdcall;
  function SetUnknown(const guidKey: TGUID;const pUnknown: IUnknown): LongInt;stdcall;
  function LockStore: LongInt;stdcall;
  function UnlockStore: LongInt;stdcall;
  function GetCount(pcItems: PCardinal): LongInt;stdcall;
  function GetItemByIndex(unIndex: Cardinal;const PGUIDKey: TGUID;pValue: PVARIANT): LongInt;stdcall;
  function CopyAllItems(const pDest: IMFAttributes): LongInt;stdcall;
  end;
  PMFAttributes=^IMFAttributes;

  IMFMediaEvent=interface(IMFAttributes)
  ['{DF598932-F10C-4E39-BBA2-C308F101DAA3}']
  function GetType(pmet: PCardinal): LongInt;stdcall;
  function GetExtendedType(PGUIDExtendedType: PGUID): LongInt;stdcall;
  function GetStatus(phrStatus: PCardinal): LongInt;stdcall;
  function GetValue(pvValue: PVARIANT): LongInt;stdcall;
  end;
  PMFMediaEvent=^IMFMediaEvent;

  IMFAsyncResult=interface(IUnknown)
  ['{ac6b7889-0740-4d51-8619-905994a55cc6}']
  function GetState(ppunkState: PUnknown): LongInt;stdcall;
  function GetStatus: LongInt;stdcall;
  function SetStatus(hrStatus: Cardinal): LongInt;stdcall;
  function GetObject(ppObject: PUnknown): LongInt;stdcall;
  function GetStateNoAddRef: LongInt;stdcall;
  end;
  PMFAsyncResult=^IMFAsyncResult;

  IMFAsyncCallback=interface(IUnknown)
  ['{a27003cf-2354-4f2a-8d6a-ab7cff15437e}']
  function GetParameters(pdwFlags,pdwQueue: PCardinal): LongInt;stdcall;
  function Invoke(pAsyncResult: IMFAsyncResult): LongInt;stdcall;
  end;
  PMFAsyncCallback=^IMFAsyncCallback;

  IMFMediaEventGenerator=interface(IUnknown)
  ['{2CD0BD52-BCD5-4B89-B62C-EADC0C031E7D}']
  function GetEvent(dwFlags: cardinal;ppEvent: PMFMediaEvent): LongInt;stdcall;
  function BeginGetEvent(pCallback: IMFAsyncCallback;punkState: IUnknown): LongInt;stdcall;
  function EndGetEvent(pResult: IMFAsyncResult;ppEvent: PMFMediaEvent): LongInt;stdcall;
  function QueueEvent(met: Cardinal;guidExtendedType: PGUID;hrStatus: Cardinal;pvValue: PVARIANT): LongInt;stdcall;
  end;
  PMFMediaEventGenerator=^IMFMediaEventGenerator;

  IMFMediaType=interface(IMFAttributes)
  ['{44ae0fa8-ea31-4109-8d2e-4cae4997c555}']
  function GetMajorType(PGUIDMajorType: PGUID): LongInt;stdcall;
  function IsCompressedFormat(pfCompressed: pboolean): LongInt;stdcall;
  function IsEqual(pIMediaType: IMFMediaType;pdwFlags: PCardinal): LongInt;stdcall;
  function GetRepresentation(guidRepresentation: PGUID;ppvRepresentation: pointer): LongInt;stdcall;
  function FreeRepresentation(guidRepresentation: PGUID;pvRepresentation: pointer): LongInt;stdcall;
  end;
  PMFMediaType=^IMFMediaType;

  IMFMediaTypeHandler=interface(IUnknown)
  ['{e93dcf6c-4b07-4e1e-8123-aa16ed6eadf5}']
  function IsMediaTypeSupported(pMediaType,ppMediaType: PMFMediaType): LongInt;stdcall;
  function GetMediaTypeCount(pdwTypeCount: PCardinal): LongInt;stdcall;
  function GetMediaTypeByIndex(dwIndex: Cardinal;ppType: pMFMediaType): LongInt;stdcall;
  function SetCurrentMediaType(pMediaType: IMFMediaType): LongInt;stdcall;
  function GetCurrentMediaType(ppMediaType: PMFMediaType): LongInt;stdcall;
  function GetMajorType(PGUIDMajorType: PGUID): LongInt;stdcall;
  end;
  PMFMediaTypeHandler=^IMFMediaTypeHandler;

  IMFStreamDescriptor=interface(IMFAttributes)
  ['{56c03d9c-9dbb-45f5-ab4b-d80f47c05938}']
  function GetStreamIdentifier(pdwStreamIdentifier: PCardinal): LongInt;stdcall;
  function GetMediaTypeHandler(ppMediaTypeHandler: PMFMediaTypeHandler): LongInt;stdcall;
  end;
  PMFStreamDescriptor=^IMFStreamDescriptor;

  IMFPresentationDescriptor=interface(IMFAttributes)
  ['{03cb2711-24d7-4db6-a17f-f3a7a479a536}']
  function GetStreamDescriptorCount(pdwDescriptorCount: PCardinal): LongInt;stdcall;
  function GetStreamDescriptorByIndex(dwIndex: Cardinal;pfSelected: pboolean;ppDescriptor: PMFStreamDescriptor): LongInt;stdcall;
  function SelectStream(dwDescriptorIndex: Cardinal): LongInt;stdcall;
  function DeselectStream(dwDescriptorIndex: Cardinal): LongInt;stdcall;
  function Clone(out ppPresentationDescriptor: IMFPresentationDescriptor): LongInt;stdcall;
  end;
  PMFPresentationDescriptor=^IMFPresentationDescriptor;

  IMFMediaSource=interface(IMFMediaEventGenerator)
  ['{279a808d-aec7-40c8-9c6b-a6b492c78a66}']
  function GetCharacteristics(pdwCharacteristics: pcardinal): LongInt;stdcall;
  function CreatePresentationDescriptor(ppPresentationDescriptor: PMFPresentationDescriptor): LongInt;stdcall;
  function Start(pPresentationDescriptor: IMFPresentationDescriptor;PGUIDTimeFormat: PGUID;pvarStartPosition: PVARIANT): LongInt;stdcall;
  function Stop: LongInt;stdcall;
  function Pause: LongInt;stdcall;
  function Shutdown: LongInt;stdcall;
  end;
  PMFMediaSource=^IMFMediaSource;

  IMFTranscodeProfile=interface(IUnknown)
  ['{4ADFDBA3-7AB0-4953-A62B-461E7FF3DA1E}']
  function SetAudioAttributes(pAttrs: IMFAttributes): LongInt;stdcall;
  function GetAudioAttributes(ppAttrs: PMFAttributes): LongInt;stdcall;
  function SetVideoAttributes(pAttrs: IMFAttributes): LongInt;stdcall;
  function GetVideoAttributes(ppAttrs: PMFAttributes): LongInt;stdcall;
  function SetContainerAttributes(pAttrs: IMFAttributes): LongInt;stdcall;
  function GetContainerAttributes(ppAttrs: PMFAttributes): LongInt;stdcall;
  end;
  PMFTranscodeProfile=^IMFTranscodeProfile;

  IMFTopologyNode=interface(IMFAttributes)
  ['{83CF873A-F6DA-4bc8-823F-BACFD55DC430}']
  function SetObject(pObject: IUnknown): LongInt;stdcall;
  function GetObject(ppObject: PUnknown): LongInt;stdcall;
  function GetNodeType(pType: PCardinal): LongInt;stdcall;
  function GetTopoNodeID(pID: pint64): LongInt;stdcall;
  function SetTopoNodeID(const ullTopoID: int64): LongInt;stdcall;
  function GetInputCount(pcInputs: PCardinal): LongInt;stdcall;
  function GetOutputCount(pcOutputs: PCardinal): LongInt;stdcall;
  function ConnectOutput(dwOutputIndex: Cardinal;pDownstreamNode: IMFTopologyNode;dwInputIndexOnDownstreamNode: Cardinal): LongInt;stdcall;
  function DisconnectOutput(dwOutputIndex: Cardinal): LongInt;stdcall;
  function GetInput(dwInputIndex: Cardinal;out ppUpstreamNode: IMFTopologyNode;pdwOutputIndexOnUpstreamNode: PCardinal): LongInt;stdcall;
  function GetOutput(dwOutputIndex: Cardinal;out ppDownstreamNode: IMFTopologyNode;pdwInputIndexOnDownstreamNode: PCardinal): LongInt;stdcall;
  function SetOutputPrefType(dwOutputIndex: PCardinal;pType: IMFMediaType): LongInt;stdcall;
  function GetOutputPrefType(dwOutputIndex: Cardinal;ppType: PMFMediaType): LongInt;stdcall;
  function SetInputPrefType(dwInputIndex: Cardinal;pType: IMFMediaType): LongInt;stdcall;
  function GetInputPrefType(dwInputIndex: Cardinal;ppType: PMFMediaType): LongInt;stdcall;
  function CloneFrom(pNode: IMFTopologyNode): LongInt;stdcall;
  end;
  PMFTopologyNode=^IMFTopologyNode;

  IMFCollection=interface(IUnknown)
  ['{5BC8A76B-869A-46a3-9B03-FA218A66AEBE}']
  function GetElementCount(pcElements: PCardinal): LongInt;stdcall;
  function GetElement(dwElementIndex: Cardinal;ppUnkElement: PUnknown): LongInt;stdcall;
  function AddElement(pUnkElement: IUnknown): LongInt;stdcall;
  function RemoveElement(dwElementIndex: Cardinal;ppUnkElement: PUnknown): LongInt;stdcall;
  function InsertElementAt(dwIndex: Cardinal;pUnknown: IUnknown): LongInt;stdcall;
  function RemoveAllElements: LongInt;stdcall;
  end;
  PMFCollection=^IMFCollection;

  IMFTopology=interface(IMFAttributes)
  ['{83CF873A-F6DA-4bc8-823F-BACFD55DC433}']
  function GetTopologyID(pID: pint64): LongInt;stdcall;
  function AddNode(pNode: IMFTopologyNode): LongInt;stdcall;
  function RemoveNode(pNode: IMFTopologyNode): LongInt;stdcall;
  function GetNodeCount(pwNodes: pword): LongInt;stdcall;
  function GetNode(wIndex: word;ppNode: PMFTopologyNode): LongInt;stdcall;
  function Clear: LongInt;stdcall;
  function CloneFrom(pTopology: IMFTopology): LongInt;stdcall;
  function GetNodeByID(const qwTopoNodeID: int64;ppNode: PMFTopologyNode): LongInt;stdcall;
  function GetSourceNodeCollection(ppCollection: PMFCollection): LongInt;stdcall;
  function GetOutputNodeCollection(ppCollection: PMFCollection): LongInt;stdcall;
  end;
  PMFTopology=^IMFTopology;

  IMFClock=interface(IUnknown)
  ['{2eb1e945-18b8-4139-9b1a-d5d584818530}']
  function GetClockCharacteristics(pdwCharacteristics: PCardinal): LongInt;stdcall;
  function GetCorrelatedTime(dwReserved: Cardinal;pllClockTime: pint64;const phnsSystemTime: int64): LongInt;stdcall;
  function GetContinuityKey(pdwContinuityKey: PCardinal): LongInt;stdcall;
  function GetState(dwReserved: Cardinal;peClockState: PCardinal): LongInt;stdcall;
  function GetProperties(pClockProperties: PMFCLOCK_PROPERTIES): LongInt;stdcall;
  end;
  PMFClock=^IMFClock;

  IMFPresentationTimeSource=interface(IMFClock)
  ['{7FF12CCE-F76F-41c2-863B-1666C8E5E139}']
  function GetUnderlyingClock(ppClock: PMFClock): LongInt;stdcall;
  end;
  PMFPresentationTimeSource=^IMFPresentationTimeSource;

  IMFClockStateSink=interface(IUnknown)
  ['{F6696E82-74F7-4f3d-A178-8A5E09C3659F}']
  function OnClockStart(const hnsSystemTime,llClockStartOffset: int64): LongInt;stdcall;
  function OnClockStop(const hnsSystemTime: int64): LongInt;stdcall;
  function OnClockPause(const hnsSystemTime: int64): LongInt;stdcall;
  function OnClockRestart(const hnsSystemTime: int64): LongInt;stdcall;
  function OnClockSetRate(const hnsSystemTime: int64;flRate: single): LongInt;stdcall;
  end;

  IMFPresentationClock=interface(IMFClock)
  ['{868CE85C-8EA9-4f55-AB82-B009A910A805}']
  function SetTimeSource(pTimeSource: IMFPresentationTimeSource): LongInt;stdcall;
  function GetTimeSource(ppTimeSource: PMFPresentationTimeSource): LongInt;stdcall;
  function GetTime(phnsClockTime: pint64): LongInt;stdcall;
  function AddClockStateSink(pStateSink: IMFClockStateSink): LongInt;stdcall;
  function RemoveClockStateSink(pStateSink: IMFClockStateSink): LongInt;stdcall;
  function Start(const llClockStartOffset: int64): LongInt;stdcall;
  function Stop: LongInt;stdcall;
  function Pause: LongInt;stdcall;
  end;
  PMFPresentationClock=^IMFPresentationClock;

  IMFMediaSession=interface(IMFMediaEventGenerator)
  ['{90377834-21D0-4dee-8214-BA2E3E6C1127}']
  function SetTopology(dwSetTopologyFlags: Cardinal;const pTopology: IMFTopology): LongInt;stdcall;
  function ClearTopologies: LongInt;stdcall;
  function Start(pguidTimeFormat: PGUID;pvarStartPosition: PVARIANT): LongInt;stdcall;
  function Pause: LongInt;stdcall;
  function Stop: LongInt;stdcall;
  function Close: LongInt;stdcall;
  function Shutdown: LongInt;stdcall;
  function GetClock(ppClock: PMFClock): LongInt;stdcall;
  function GetSessionCapabilities(pdwCaps: PCardinal): LongInt;stdcall;
  function GetFullTopology(dwGetFullTopologyFlags: Cardinal;const TopoId: int64;ppFullTopology: PMFTopology): LongInt;stdcall;
  end;
  PMFMediaSession=^IMFMediaSession;

  IMFByteStream=interface(IUnknown)
  ['{ad4c1b00-4bf7-422f-9175-756693d9130d}']
  function GetCapabilities(pdwCapabilities: PCardinal): LongInt;stdcall;
  function GetLength(pqwLength: pint64): LongInt;stdcall;
  function SetLength(const qwLength: int64): LongInt;stdcall;
  function GetCurrentPosition(pqwPosition: pint64): LongInt;stdcall;
  function SetCurrentPosition(const qwPosition: int64): LongInt;stdcall;
  function IsEndOfStream(pfEndOfStream: pboolean): LongInt;stdcall;
  function Read(pb: pointer;cb: Cardinal;pcbRead: PCardinal): LongInt;stdcall;
  function BeginRead(pb: pointer;cb: Cardinal;const pCallback: IMFAsyncCallback;const punkState: IUnknown): LongInt;stdcall;
  function EndRead(const pResult: IMFAsyncResult;pcbRead: PCardinal): LongInt;stdcall;
  function Write(pb: pointer;cb: Cardinal;pcbWritten: PCardinal): LongInt;stdcall;
  function BeginWrite(pb: pointer;cb: Cardinal;const pCallback: IMFAsyncCallback;const punkState: IUnknown): LongInt;stdcall;
  function EndWrite(const pResult: IMFAsyncResult;pcbWritten: PCardinal): LongInt;stdcall;
  function Seek(SeekOrigin: Cardinal;const llSeekOffset: int64;dwSeekFlags: Cardinal;pqwCurrentPosition: pint64): LongInt;stdcall;
  function Flush: LongInt;stdcall;
  function Close: LongInt;stdcall;
  end;
  PMFByteStream=^IMFByteStream;

  IPropertyStore=interface(IUnknown)
  ['{886d8eeb-8cf2-4446-8d02-cdba1dbdcf99}']
  function GetCount(cProps: PCardinal): LongInt;stdcall;
  function GetAt(iProp: Cardinal;pkey: PPROPERTYKEY): LongInt;stdcall;
  function GetValue(key: PPROPERTYKEY;pv: PVARIANT): LongInt;stdcall;
  function SetValue(key: PPROPERTYKEY;propvar: PVARIANT): LongInt;stdcall;
  function Commit: LongInt;stdcall;
  end;
  PPropertyStore=^IPropertyStore;

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

  IMFSourceResolver=interface(IUnknown)
  ['{FBE5A32D-A497-4b61-BB85-97B1A848A6E3}']
  function CreateObjectFromURL(pwszURL: PWideChar;dwFlags: Cardinal;pProps: PPropertyStore;pObjectType: PCardinal;ppObject: PUnknown): LongInt;stdcall;
  function CreateObjectFromByteStream(const pByteStream: IMFByteStream;pwszURL: PWideChar;dwFlags: Cardinal;pProps: PPropertyStore;pObjectType: PCardinal;ppObject: PUnknown): LongInt;stdcall;
  function BeginCreateObjectFromURL(pwszURL: PWideChar;dwFlags: Cardinal;const pProps: IPropertyStore;ppIUnknownCancelCookie: PUnknown;const  pCallback: IMFAsyncCallback;const punkState: IUnknown): LongInt;stdcall;
  function EndCreateObjectFromURL(const pResult: IMFAsyncResult;pObjectType: PCardinal;ppObject: PUnknown): LongInt;stdcall;
  function BeginCreateObjectFromByteStream(const pByteStream: IMFByteStream;pwszURL: PWideChar;dwFlags: Cardinal;const pProps: IPropertyStore;ppIUnknownCancelCookie: PUnknown;const pCallback: IMFAsyncCallback;const punkState: IUnknown): LongInt;stdcall;
  function EndCreateObjectFromByteStream(const pResult: IMFAsyncResult;pObjectType: PCardinal;ppObject: PUnknown): LongInt;stdcall;
  function CancelObjectCreation(const pIUnknownCancelCookie: IUnknown): LongInt;stdcall;
  end;
  PMFSourceResolver=^IMFSourceResolver;

  IMFMediaBuffer=interface(IUnknown)
  ['{045FA593-8799-42b8-BC8D-8968C6453507}']
  function Lock(ppbBuffer: ppointer;pcbMaxLength,pcbCurrentLength: PCardinal): LongInt;stdcall;
  function Unlock: LongInt;stdcall;
  function GetCurrentLength(pcbCurrentLength: PCardinal): LongInt;stdcall;
  function SetCurrentLength(cbCurrentLength: Cardinal): LongInt;stdcall;
  function GetMaxLength(pcbMaxLength: PCardinal): LongInt;stdcall;
  end;
  PMFMediaBuffer=^IMFMediaBuffer;

  IMFSample=interface(IMFAttributes)
  ['{c40a00f2-b93a-4d80-ae8c-5a1c634f58e4}']
  function GetSampleFlags(pdwSampleFlags: PCardinal): LongInt;stdcall;
  function SetSampleFlags(dwSampleFlags: Cardinal): LongInt;stdcall;
  function GetSampleTime(phnsSampleTime: pint64): LongInt;stdcall;
  function SetSampleTime(hnsSampleTime: int64): LongInt;stdcall;
  function GetSampleDuration(phnsSampleDuration: pint64): LongInt;stdcall;
  function SetSampleDuration(hnsSampleDuration: int64): LongInt;stdcall;
  function GetBufferCount(pdwBufferCount: PCardinal): LongInt;stdcall;
  function GetBufferByIndex(dwIndex: Cardinal;ppBuffer: PMFMediaBuffer): LongInt;stdcall;
  function ConvertToContiguousBuffer(ppBuffer: PMFMediaBuffer): LongInt;stdcall;
  function AddBuffer(const pBuffer: IMFMediaBuffer): LongInt;stdcall;
  function RemoveBufferByIndex(dwIndex: Cardinal): LongInt;stdcall;
  function RemoveAllBuffers: LongInt;stdcall;
  function GetTotalLength(pcbTotalLength: PCardinal): LongInt;stdcall;
  function CopyToBuffer(const pBuffer: IMFMediaBuffer): LongInt;stdcall;
  end;
  PMFSample=^IMFSample;

  IMFSinkWriter=interface(IUnknown)
  ['{3137f1cd-fe5e-4805-a5d8-fb477448cb3d}']
  function AddStream(const pTargetMediaType: IMFMediaType;out pdwStreamIndex: Cardinal): LongInt;stdcall;
  function SetInputMediaType(dwStreamIndex: Cardinal;const pInputMediaType: IMFMediaType;const pEncodingParameters: IMFAttributes): LongInt;stdcall;
  function BeginWriting: LongInt;stdcall;
  function WriteSample(dwStreamIndex: Cardinal;const pSample: IMFSample): LongInt;stdcall;
  function SendStreamTick(dwStreamIndex: Cardinal;llTimestamp: int64): LongInt;stdcall;
  function PlaceMarker(dwStreamIndex: Cardinal;pvContext: pointer): LongInt;stdcall;
  function NotifyEndOfSegment(dwStreamIndex: Cardinal): LongInt;stdcall;
  function Flush(dwStreamIndex: Cardinal): LongInt;stdcall;
  function Finalize: LongInt;stdcall;
  function GetServiceForStream(dwStreamIndex: Cardinal;guidService,riid: PGUID;ppvObject: pointer): LongInt;stdcall;
  function GetStatistics(dwStreamIndex: Cardinal;pStats: PMF_SINK_WRITER_STATISTICS): LongInt;stdcall;
  end;
  PIMFSinkWriter=^IMFSinkWriter;

  IMFActivate=interface(IMFAttributes)
  ['{7FEE9E9A-4A89-47a6-899C-B6A53A70FB67}']
  function ActivateObject(const riid: TGUID;ppv: ppointer): LongInt;stdcall;
  function ShutdownObject: LongInt;stdcall;
  function DetachObject: LongInt;stdcall;
  end;
  PMFActivate=^IMFActivate;

  MFT_OUTPUT_DATA_BUFFER=packed record
                         dwStreamID: Cardinal;
                         pSample:    IMFSample;
                         dwStatus:   Cardinal;
                         pEvents:    IMFCollection;
                         end;
  PMFT_OUTPUT_DATA_BUFFER=^MFT_OUTPUT_DATA_BUFFER;                       

  IMFTransform=interface(IUnknown)
  ['{bf94c121-5b05-4e6f-8000-ba598961414d}']
  function GetStreamLimits(pdwInputMinimum,pdwInputMaximum,pdwOutputMinimum,pdwOutputMaximum: PCardinal): LongInt;stdcall;
  function GetStreamCount(pcInputStreams,pcOutputStreams: PCardinal): LongInt;stdcall;
  function GetStreamIDs(dwInputIDArraySize: Cardinal;pdwInputIDs: PCardinal;dwOutputIDArraySize: Cardinal;pdwOutputIDs: PCardinal): LongInt;stdcall;
  function GetInputStreamInfo(dwInputStreamID: Cardinal;pStreamInfo: PCardinal): LongInt;stdcall;
  function GetOutputStreamInfo(dwOutputStreamID: Cardinal;pStreamInfo: PMFT_OUTPUT_STREAM_INFO): LongInt;stdcall;
  function GetAttributes(pAttributes: PMFAttributes): LongInt;stdcall;
  function GetInputStreamAttributes(dwInputStreamID: Cardinal;pAttributes: PMFAttributes): LongInt;stdcall;
  function GetOutputStreamAttributes(dwOutputStreamID: Cardinal;pAttributes: PMFAttributes): LongInt;stdcall;
  function DeleteInputStream(dwStreamID: Cardinal): LongInt;stdcall;
  function AddInputStreams(cStreams: Cardinal;adwStreamIDs: PCardinal): LongInt;stdcall;
  function GetInputAvailableType(dwInputStreamID,dwTypeIndex: Cardinal;ppType: PMFMediaType): LongInt;stdcall;
  function GetOutputAvailableType(dwOutputStreamID,dwTypeIndex: Cardinal;ppType: PMFMediaType): LongInt;stdcall;
  function SetInputType(dwInputStreamID: Cardinal;const pType: IMFMediaType;dwFlags: Cardinal): LongInt;stdcall;
  function SetOutputType(dwOutputStreamID: Cardinal;const pType: IMFMediaType;dwFlags: Cardinal): LongInt;stdcall;
  function GetInputCurrentType(dwInputStreamID: Cardinal;ppType: PMFMediaType): LongInt;stdcall;
  function GetOutputCurrentType(dwOutputStreamID: Cardinal;ppType: PMFMediaType): LongInt;stdcall;
  function GetInputStatus(dwInputStreamID: Cardinal;pdwFlags: PCardinal): LongInt;stdcall;
  function GetOutputStatus(pdwFlags: PCardinal): LongInt;stdcall;
  function SetOutputBounds(hnsLowerBound,hnsUpperBound: int64): LongInt;stdcall;
  function ProcessEvent(dwInputStreamID: Cardinal;const pEvent: IMFMediaEvent): LongInt;stdcall;
  function ProcessMessage(eMessage: Cardinal;ulParam: PCardinal): LongInt;stdcall;
  function ProcessInput(dwInputStreamID: Cardinal;const pSample: IMFSample;dwFlags: Cardinal): LongInt;stdcall;
  function ProcessOutput(dwFlags,cOutputBufferCount: Cardinal;var pOutputSamples: MFT_OUTPUT_DATA_BUFFER;out pdwStatus: Cardinal): LongInt;stdcall;
  end;
  PMFTransform=^IMFTransform;

  function  StringFromGUID2(const guid: TGUID; psz: PWideChar; cbMax: Integer): Integer; stdcall;external ole32;
  function  IsEqualGUID(const guid1, guid2: TGUID): Boolean; stdcall;external ole32;
  function  CoInitializeEx(pvReserved: Pointer; coInit: Longint): LongInt; stdcall;external ole32;
  function  CoCreateInstance(const clsid: TGUID; unkOuter: IUnknown; dwClsContext: Longint; const iid: TGUID; out pv): HResult; stdcall;external ole32;
  procedure CoUninitialize; stdcall;external ole32;
  function  CoTaskMemAlloc(cb: Longint): Pointer; stdcall;external ole32;
  function  MFCreateSinkWriterFromURL(pwszOutputURL: PWideChar;const pByteStream: IMFByteStream;const pAttributes: IMFAttributes;out ppSinkWriter: IMFSinkWriter): LongInt;stdcall;external mfreadwrite;
  function  MFGetSupportedMimeTypes(pPropVarMimeTypeArray: PVARIANT): LongInt;stdcall;external mfdll;
  function  MFCreateTranscodeTopology(const pSrc: IMFMediaSource;const pwszOutputFilePath: PWideChar;const pProfile: IMFTranscodeProfile;out ppTranscodeTopo: IMFTopology): LongInt;stdcall;external mfdll;
  function  MFCreateTranscodeProfile(ppTranscodeProfile: PMFTranscodeProfile): LongInt;stdcall;external mfdll;
  function  MFCreateMediaSession(const pConfiguration: IMFAttributes;ppMediaSession: PMFMediaSession): LongInt;stdcall;external mfdll;
  function  MFCreateMFByteStreamOnStream(const pStream: IStream;ppByteStream: PMFByteStream): LongInt;stdcall;external mfplat;  
  function  MFStartup(Version,dwFlags: Cardinal): LongInt;stdcall;external mfplat;
  function  MFShutdown: LongInt;stdcall;external mfplat;
  function  MFTEnumEx(guidCategory: TGUID;Flags: Cardinal;const pInputType,pOutputType: MFT_REGISTER_TYPE_INFO;var pppMFTActivate;out pnumMFTActivate: Cardinal): LongInt;stdcall;external mfplat;
  function  MFCreateMemoryBuffer(cbMaxLength: Cardinal;ppBuffer: PMFMediaBuffer): LongInt;stdcall;external mfplat;
  function  MFCreateMediaType(out ppMFType: IMFMediaType): LongInt;stdcall;external mfplat;
  function  MFCreateSample(out ppIMFSample: IMFSample): LongInt;stdcall;external mfplat;
  function  MFCreateSourceResolver(out ppISourceResolver: IMFSourceResolver): LongInt;stdcall;external mfplat;
  function  MFCreateAttributes(ppMFAttributes: PMFAttributes;cInitialSize: Cardinal): LongInt;stdcall;external mfplat;
  function  MFCreateStreamDescriptor(dwStreamIdentifier,cMediaTypes: Cardinal;apMediaTypes: PMFMediaType;ppDescriptor: PMFStreamDescriptor): LongInt;stdcall;external mfplat;
  function  MFCreatePresentationDescriptor(cStreamDescriptors: Cardinal;apStreamDescriptors: PMFStreamDescriptor;ppPresentationDescriptor: PMFPresentationDescriptor): LongInt;stdcall;external mfplat;

implementation

end.
