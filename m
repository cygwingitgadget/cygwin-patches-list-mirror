Return-Path: <cygwin-patches-return-1667-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10930 invoked by alias); 10 Jan 2002 22:38:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10910 invoked from network); 10 Jan 2002 22:38:10 -0000
From: "Ralf Habacker" <Ralf.Habacker@freenet.de>
To: "Cygwin-Patches" <cygwin-patches@sourceware.cygnus.com>
Subject: Problem with winsup/cinstall compilation
Date: Thu, 10 Jan 2002 14:38:00 -0000
Message-ID: <008101c19a27$1f847120$651c440a@BRAMSCHE>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0082_01C19A2F.8148D920"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
X-SW-Source: 2002-q1/txt/msg00024.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0082_01C19A2F.8148D920
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 774

Hi,

I've tried to compile a recent setup.exe from the cvs and got an error while compiling
mklink2.c about "function declaration isn't a prototype"
I've found that in cinstall/Makefile.in the -Werror option is set, so warnings causes
compiling failures.

What about this ? As I see there are two solutions for this.

1. remove the -Werror in Makefile.in
CFLAGS		:= @CFLAGS@ -Werror -Winline -Wall -Wpointer-arith -Wcast-align\
                              ^^^^^^^^
	-Wwrite-strings -Wstrict-prototypes -Wmissing-prototypes \
	-Wmissing-declarations -Wcomments

2. fix the bad header.
   This seems to me the better solution, so a patch for the w32api header is appended.

Charles Wilson told me, to send this patch to cygwin-patches, so I'm doing this :-)

Regards
Ralf



------=_NextPart_000_0082_01C19A2F.8148D920
Content-Type: application/octet-stream;
	name="w32api_20010110.dif"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="w32api_20010110.dif"
Content-length: 10586

Index: ntsecapi.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/ntsecapi.h,v=0A=
retrieving revision 1.6=0A=
diff -u -b -B -p -r1.6 ntsecapi.h=0A=
--- ntsecapi.h	2001/05/17 15:16:37	1.6=0A=
+++ ntsecapi.h	2002/01/10 22:28:07=0A=
@@ -595,7 +595,7 @@ NTSTATUS NTAPI LsaStorePrivateData(LSA_H=0A=
                             PLSA_UNICODE_STRING);=0A=
 typedef NTSTATUS (*PSAM_PASSWORD_NOTIFICATION_ROUTINE)(PUNICODE_STRING,=0A=
                             ULONG,PUNICODE_STRING);=0A=
-typedef BOOLEAN (*PSAM_INIT_NOTIFICATION_ROUTINE)();=0A=
+typedef BOOLEAN (*PSAM_INIT_NOTIFICATION_ROUTINE)(void);=0A=
 typedef BOOLEAN (*PSAM_PASSWORD_FILTER_ROUTINE)(PUNICODE_STRING,PUNICODE_S=
TRING,=0A=
                             PUNICODE_STRING,BOOLEAN);=0A=
 #ifdef __cplusplus=0A=
Index: objbase.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/objbase.h,v=0A=
retrieving revision 1.3=0A=
diff -u -b -B -p -r1.3 objbase.h=0A=
--- objbase.h	2001/11/01 19:42:56	1.3=0A=
+++ objbase.h	2002/01/10 22:28:08=0A=
@@ -162,8 +162,8 @@ WINOLEAPI CoQueryProxyBlanket(IUnknown*,=0A=
 WINOLEAPI CoSetProxyBlanket(IUnknown*,DWORD,DWORD,OLECHAR*,DWORD,DWORD,RPC=
_AUTH_IDENTITY_HANDLE, DWORD);=0A=
 WINOLEAPI CoCopyProxy(IUnknown*,IUnknown**);=0A=
 WINOLEAPI CoQueryClientBlanket(DWORD*,DWORD*,OLECHAR**, DWORD*,DWORD*,RPC_=
AUTHZ_HANDLE*,DWORD*);=0A=
-WINOLEAPI CoImpersonateClient();=0A=
-WINOLEAPI CoRevertToSelf();=0A=
+WINOLEAPI CoImpersonateClient(void);=0A=
+WINOLEAPI CoRevertToSelf(void);=0A=
 WINOLEAPI CoQueryAuthenticationServices(DWORD*, SOLE_AUTHENTICATION_SERVIC=
E**);=0A=
 WINOLEAPI CoSwitchCallContext(IUnknown*,IUnknown**);=0A=
 WINOLEAPI CoGetInstanceFromFile(COSERVERINFO*, CLSID*,IUnknown*,DWORD,DWOR=
D,OLECHAR*,DWORD,MULTI_QI*);=0A=
Index: rapi.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/rapi.h,v=0A=
retrieving revision 1.2=0A=
diff -u -b -B -p -r1.2 rapi.h=0A=
--- rapi.h	2000/02/24 18:04:23	1.2=0A=
+++ rapi.h	2002/01/10 22:28:08=0A=
@@ -35,11 +35,11 @@ typedef struct _RAPIINIT=0A=
   HRESULT hrRapiInit;=0A=
 } RAPIINIT;=0A=
=20=0A=
-STDAPI CeRapiInit ();=0A=
+STDAPI CeRapiInit (void);=0A=
 STDAPI CeRapiInitEx (RAPIINIT*);=0A=
 STDAPI_(BOOL) CeCreateProcess (LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES, LP=
SECURITY_ATTRIBUTES,=0A=
 			       BOOL, DWORD, LPVOID, LPWSTR, LPSTARTUPINFO, LPPROCESS_INFORMATIO=
N);=0A=
-STDAPI CeRapiUninit ();=0A=
+STDAPI CeRapiUninit (void);=0A=
=20=0A=
 STDAPI_(BOOL) CeWriteFile (HANDLE, LPCVOID, DWORD, LPDWORD, LPOVERLAPPED);=
=0A=
 STDAPI_(HANDLE) CeCreateFile (LPCWSTR, DWORD, DWORD, LPSECURITY_ATTRIBUTES=
, DWORD, DWORD, HANDLE);=20=0A=
Index: rpc.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/rpc.h,v=0A=
retrieving revision 1.1.1.1=0A=
diff -u -b -B -p -r1.1.1.1 rpc.h=0A=
--- rpc.h	2000/02/17 19:38:31	1.1.1.1=0A=
+++ rpc.h	2002/01/10 22:28:09=0A=
@@ -46,7 +46,7 @@ typedef long RPC_STATUS;=0A=
 #endif /* 0 */=0A=
=20=0A=
 RPC_STATUS RPC_ENTRY RpcImpersonateClient(RPC_BINDING_HANDLE);=0A=
-RPC_STATUS RPC_ENTRY RpcRevertToSelf();=0A=
+RPC_STATUS RPC_ENTRY RpcRevertToSelf(void);=0A=
 long RPC_ENTRY I_RpcMapWin32Status(RPC_STATUS);=0A=
 #ifdef __cplusplus=0A=
 }=0A=
Index: rpcdce.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/rpcdce.h,v=0A=
retrieving revision 1.3=0A=
diff -u -b -B -p -r1.3 rpcdce.h=0A=
--- rpcdce.h	2001/01/26 21:05:20	1.3=0A=
+++ rpcdce.h	2002/01/10 22:28:13=0A=
@@ -360,7 +360,7 @@ RPC_STATUS RPC_ENTRY RpcIfIdVectorFree(R=0A=
 RPC_STATUS RPC_ENTRY RpcEpResolveBinding(RPC_BINDING_HANDLE,RPC_IF_HANDLE)=
;=0A=
 RPC_STATUS RPC_ENTRY RpcBindingServerFromClient(RPC_BINDING_HANDLE,RPC_BIN=
DING_HANDLE*);=0A=
 DECLSPEC_NORETURN void  RPC_ENTRY RpcRaiseException(RPC_STATUS);=0A=
-RPC_STATUS RPC_ENTRY RpcTestCancel();=0A=
+RPC_STATUS RPC_ENTRY RpcTestCancel(void);=0A=
 RPC_STATUS RPC_ENTRY RpcCancelThread(void*);=0A=
 RPC_STATUS RPC_ENTRY UuidCreate(UUID*);=0A=
 signed int RPC_ENTRY UuidCompare(UUID*,UUID*, RPC_STATUS*);=0A=
Index: rpcdcep.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/rpcdcep.h,v=0A=
retrieving revision 1.3=0A=
diff -u -b -B -p -r1.3 rpcdcep.h=0A=
--- rpcdcep.h	2001/12/03 19:59:34	1.3=0A=
+++ rpcdcep.h	2002/01/10 22:28:19=0A=
@@ -109,8 +109,8 @@ long __stdcall I_RpcConnectionSetSockBuf=0A=
 long __stdcall I_RpcBindingSetAsync(HANDLE,RPC_BLOCKING_FUNCTION);=0A=
 long __stdcall I_RpcAsyncSendReceive(RPC_MESSAGE*,void*);=0A=
 long __stdcall I_RpcGetThreadWindowHandle(void**);=0A=
-long __stdcall I_RpcServerThreadPauseListening();=0A=
-long __stdcall I_RpcServerThreadContinueListening();=0A=
+long __stdcall I_RpcServerThreadPauseListening(void);=0A=
+long __stdcall I_RpcServerThreadContinueListening(void);=0A=
 long __stdcall I_RpcServerUnregisterEndpointA(unsigned char*,unsigned char=
*);=0A=
 long __stdcall I_RpcServerUnregisterEndpointW(unsigned short*,unsigned sho=
rt*);=0A=
 #ifdef UNICODE=0A=
Index: rpcndr.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/rpcndr.h,v=0A=
retrieving revision 1.3=0A=
diff -u -b -B -p -r1.3 rpcndr.h=0A=
--- rpcndr.h	2000/11/01 00:37:23	1.3=0A=
+++ rpcndr.h	2002/01/10 22:28:19=0A=
@@ -249,7 +249,7 @@ typedef struct _MIDL_FORMAT_STRING {=0A=
 	unsigned char Format[1];=0A=
 } MIDL_FORMAT_STRING;=0A=
 typedef void(__RPC_API *STUB_THUNK)(PMIDL_STUB_MESSAGE);=0A=
-typedef long(__RPC_API *SERVER_ROUTINE)();=0A=
+typedef long(__RPC_API *SERVER_ROUTINE)(void);=0A=
 typedef struct _MIDL_SERVER_INFO_ {=0A=
 	PMIDL_STUB_DESC pStubDesc;=0A=
 	const SERVER_ROUTINE *DispatchTable;=0A=
Index: rpcnsip.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/rpcnsip.h,v=0A=
retrieving revision 1.1.1.1=0A=
diff -u -b -B -p -r1.1.1.1 rpcnsip.h=0A=
--- rpcnsip.h	2000/02/17 19:38:31	1.1.1.1=0A=
+++ rpcnsip.h	2002/01/10 22:28:19=0A=
@@ -12,9 +12,9 @@ RPC_STATUS RPC_ENTRY I_RpcNsGetBuffer(IN=0A=
 RPC_STATUS RPC_ENTRY I_RpcNsSendReceive(IN PRPC_MESSAGE,OUT RPC_BINDING_HA=
NDLE*);=0A=
 void RPC_ENTRY I_RpcNsRaiseException(IN PRPC_MESSAGE,IN RPC_STATUS);=0A=
 RPC_STATUS RPC_ENTRY I_RpcReBindBuffer(IN PRPC_MESSAGE);=0A=
-RPC_STATUS RPC_ENTRY I_NsServerBindSearch();=0A=
-RPC_STATUS RPC_ENTRY I_NsClientBindSearch();=0A=
-void RPC_ENTRY I_NsClientBindDone();=0A=
+RPC_STATUS RPC_ENTRY I_NsServerBindSearch(void);=0A=
+RPC_STATUS RPC_ENTRY I_NsClientBindSearch(void);=0A=
+void RPC_ENTRY I_NsClientBindDone(void);=0A=
 #ifdef __cplusplus=0A=
 }=0A=
 #endif=0A=
Index: rpcproxy.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/rpcproxy.h,v=0A=
retrieving revision 1.2=0A=
diff -u -b -B -p -r1.2 rpcproxy.h=0A=
--- rpcproxy.h	2001/12/03 19:59:34	1.2=0A=
+++ rpcproxy.h	2002/01/10 22:28:19=0A=
@@ -32,11 +32,11 @@ BOOL WINAPI DllMain(HINSTANCE hinstDLL,D=0A=
 if(fdwReason =3D=3D DLL_PROCESS_ATTACH) hProxyDll =3D hinstDLL; \=0A=
 return TRUE; \=0A=
 } \=0A=
-HRESULT STDAPICALLTYPE DllRegisterServer() \=0A=
+HRESULT STDAPICALLTYPE DllRegisterServer(void) \=0A=
 {\=0A=
 return NdrDllRegisterProxy(hProxyDll, pProxyFileList, pClsID); \=0A=
 }\=0A=
-HRESULT STDAPICALLTYPE DllUnregisterServer()\=0A=
+HRESULT STDAPICALLTYPE DllUnregisterServer(void)\=0A=
 {\=0A=
 return NdrDllUnregisterProxy(hProxyDll, pProxyFileList, pClsID);\=0A=
 }=0A=
@@ -64,7 +64,7 @@ void RPC_ENTRY GetProxyDllInfo( const Pr=0A=
 { *pInfo =3D pPFList; *pId =3D pClsid; };=0A=
 #define DLLGETCLASSOBJECTROUTINE(pPFlist, pClsid,pFactory) HRESULT STDAPIC=
ALLTYPE DllGetClassObject(REFCLSID rclsid,REFIID riid,void **ppv) \=0A=
 { return NdrDllGetClassObject(rclsid,riid,ppv,pPFlist,pClsid,pFactory ); }=
=0A=
-#define DLLCANUNLOADNOW(pFactory) HRESULT STDAPICALLTYPE DllCanUnloadNow()=
 \=0A=
+#define DLLCANUNLOADNOW(pFactory) HRESULT STDAPICALLTYPE DllCanUnloadNow(v=
oid) \=0A=
 { return NdrDllCanUnloadNow( pFactory ); }=0A=
 #define DLLDUMMYPURECALL void __cdecl _purecall(void) { }=0A=
 #define CSTDSTUBBUFFERRELEASE(pFactory) ULONG STDMETHODCALLTYPE CStdStubBu=
ffer_Release(IRpcStubBuffer *This) \=0A=
Index: windef.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/windef.h,v=0A=
retrieving revision 1.6=0A=
diff -u -b -B -p -r1.6 windef.h=0A=
--- windef.h	2001/12/03 19:59:34	1.6=0A=
+++ windef.h	2002/01/10 22:28:20=0A=
@@ -200,9 +200,9 @@ DECLARE_HANDLE(HKL);=0A=
 typedef int HFILE;=0A=
 typedef HICON HCURSOR;=0A=
 typedef DWORD COLORREF;=0A=
-typedef int (WINAPI *FARPROC)();=0A=
-typedef int (WINAPI *NEARPROC)();=0A=
-typedef int (WINAPI *PROC)();=0A=
+typedef int (WINAPI *FARPROC)(void);=0A=
+typedef int (WINAPI *NEARPROC)(void);=0A=
+typedef int (WINAPI *PROC)(void);=0A=
 typedef struct tagRECT {=0A=
 	LONG left;=0A=
 	LONG top;=0A=

------=_NextPart_000_0082_01C19A2F.8148D920
Content-Type: application/octet-stream;
	name="ChangeLog.w32api_20010110"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.w32api_20010110"
Content-length: 364

2002-01-12 Ralf Habacker  <Ralf.Habacker@freenet.de>

	* include/ntsecapi.h:  fixed missing void parameter type in some prototyps 
	* include/objbase.h: dito
	* include/rapi.h: dito
	* include/rpc.h: dito
	* include/rpcdce.h: dito
	* include/rpcdcep.h: dito
	* include/rpcndr.h: dito
	* include/rpcnsip.h: dito
	* include/rpcproxy.h: dito
	* include/windef.h: dito
------=_NextPart_000_0082_01C19A2F.8148D920--
