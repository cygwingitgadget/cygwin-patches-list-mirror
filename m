From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Cc: Mumit Khan <khan@xraylith.wisc.EDU>
Subject: YA w32api change
Date: Mon, 10 Apr 2000 20:00:00 -0000
Message-id: <20000410230023.A13748@cygnus.com>
X-SW-Source: 2000-q2/msg00007.html

I found these while working with Ron's installer.

Ok to check in?

cgf

Mon Apr 10 22:58:25 2000  Christopher Faylor <cgf@cygnus.com>

        * include/winbase.h: Change first argument of ENUMRES* types to 
        coincide with Microsoft usage.

Index: include/winbase.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/winbase.h,v
retrieving revision 1.3
diff -u -p -r1.3 winbase.h
--- winbase.h	2000/03/30 06:10:11	1.3
+++ winbase.h	2000/04/11 02:58:30
@@ -921,9 +921,9 @@ typedef struct _WIN_CERTIFICATE {
 
 typedef DWORD(WINAPI *LPPROGRESS_ROUTINE)(LARGE_INTEGER,LARGE_INTEGER,LARGE_INTEGER,LARGE_INTEGER,DWORD,DWORD,HANDLE,HANDLE,LPVOID);
 typedef void(WINAPI *LPFIBER_START_ROUTINE)(PVOID);
-typedef BOOL(CALLBACK *ENUMRESLANGPROC)(HANDLE,LPCTSTR,LPCTSTR,WORD,LONG);
-typedef BOOL(CALLBACK *ENUMRESNAMEPROC)(HANDLE,LPCTSTR,LPTSTR,LONG);
-typedef BOOL(CALLBACK *ENUMRESTYPEPROC)(HANDLE,LPTSTR,LONG);
+typedef BOOL(CALLBACK *ENUMRESLANGPROC)(HMODULE,LPCTSTR,LPCTSTR,WORD,LONG);
+typedef BOOL(CALLBACK *ENUMRESNAMEPROC)(HMODULE,LPCTSTR,LPTSTR,LONG);
+typedef BOOL(CALLBACK *ENUMRESTYPEPROC)(HMODULE,LPTSTR,LONG);
 typedef void(CALLBACK *LPOVERLAPPED_COMPLETION_ROUTINE)(DWORD,DWORD,LPOVERLAPPED);
 typedef LONG(CALLBACK *PTOP_LEVEL_EXCEPTION_FILTER)(LPEXCEPTION_POINTERS);
 typedef PTOP_LEVEL_EXCEPTION_FILTER LPTOP_LEVEL_EXCEPTION_FILTER;
