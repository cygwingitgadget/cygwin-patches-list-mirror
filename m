Return-Path: <cygwin-patches-return-2809-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13879 invoked by alias); 8 Aug 2002 17:35:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13865 invoked from network); 8 Aug 2002 17:35:32 -0000
Message-ID: <3D52ABE4.1010403@hekimian.com>
Date: Thu, 08 Aug 2002 10:35:00 -0000
X-Sybari-Trust: a4df70ad b923d9bf 4738785c 00000109
From: Joe Buehler <jbuehler@hekimian.com>
Reply-To:  joseph.buehler@spirentcom.com
Organization: Spirent Communications
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: patch so strace can be used with C code
Content-Type: multipart/mixed;
 boundary="------------070900010408050904050003"
X-SW-Source: 2002-q3/txt/msg00257.txt.bz2

This is a multi-part message in MIME format.
--------------070900010408050904050003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 371

Attached is a patch to allow the strace printf functionality to be
used inside C code in Cygwin.  It looks like this might have
worked at some point in the past -- the changes were easy.

Christopher had objected that it would be better to convert the
C files to C++, but this is a lot easier until that is done -- there
are several C files still in Cygwin.

Joe Buehler

--------------070900010408050904050003
Content-Type: text/plain;
 name="temp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="temp.patch"
Content-length: 4005

Index: src/winsup/cygwin/strace.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/strace.cc,v
retrieving revision 1.33
diff -u -r1.33 strace.cc
--- src/winsup/cygwin/strace.cc	19 Jun 2002 15:27:25 -0000	1.33
+++ src/winsup/cygwin/strace.cc	8 Aug 2002 16:38:10 -0000
@@ -234,6 +234,12 @@
     }
 }
 
+extern "C" int
+strace_active()
+{
+  return strace.active;
+}
+
 static NO_COPY struct tab
 {
   int v;
Index: src/winsup/cygwin/include/sys/strace.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/strace.h,v
retrieving revision 1.16
diff -u -r1.16 strace.h
--- src/winsup/cygwin/include/sys/strace.h	10 Jun 2002 19:58:21 -0000	1.16
+++ src/winsup/cygwin/include/sys/strace.h	8 Aug 2002 16:38:13 -0000
@@ -78,6 +78,7 @@
 #define _STRACE_MALLOC	 0x20000 // trace malloc calls
 #define _STRACE_THREAD	 0x40000 // thread-locking calls
 #define _STRACE_NOTALL	 0x80000 // don't include if _STRACE_ALL
+
 #if defined (DEBUGGING)
 # define _STRACE_ON strace.active = 1;
 # define _STRACE_OFF strace.active = 0;
@@ -92,29 +93,37 @@
 
 void small_printf (const char *, ...);
 void strace_printf (unsigned, const char *func, const char *, ...);
+int strace_active();
 
 #ifdef __cplusplus
 }
 #endif
 
 #ifdef __cplusplus
-
-#ifdef NOSTRACE
-#define define_strace(c, f)
-#define define_strace1(c, f)
+#define STRACE_PRINTF strace.prntf
+#define STRACE_ACTIVE strace.active
 #else
+#define STRACE_PRINTF strace_printf
+#define STRACE_ACTIVE strace_active()
+#endif /* __cplusplus */
+
 #ifdef NEW_MACRO_VARARGS
 /* Output message to strace log */
 
 #define define_strace0(c,...) \
   do { \
-      if ((c & _STRACE_SYSTEM) || strace.active) \
-	strace.prntf (c, __PRETTY_FUNCTION__, __VA_ARGS__); \
+      if ((c & _STRACE_SYSTEM) || STRACE_ACTIVE) \
+	STRACE_PRINTF (c, __PRETTY_FUNCTION__, __VA_ARGS__); \
     } \
   while (0)
 
+#ifdef NOSTRACE
+#define define_strace(c, f)
+#define define_strace1(c, f)
+#else
 #define define_strace(c, ...) define_strace0 (_STRACE_ ## c, __VA_ARGS__)
 #define define_strace1(c, ...) define_strace0 ((_STRACE_ ## c | _STRACE_NOTALL), __VA_ARGS__)
+#endif
 
 #define debug_printf(...)	define_strace (DEBUG, __VA_ARGS__)
 #define paranoid_printf(...)	define_strace (PARANOID, __VA_ARGS__)
@@ -127,19 +136,26 @@
 #define minimal_printf(...)	define_strace1 (MINIMAL, __VA_ARGS__)
 #define malloc_printf(...)	define_strace1 (MALLOC, __VA_ARGS__)
 #define thread_printf(...)	define_strace1 (THREAD, __VA_ARGS__)
+
+#else /*NEW_MACRO_VARARGS*/
+
+#ifdef NOSTRACE
+#define strace_printf_wrap(what, fmt, args...)
+#define strace_printf_wrap1(what, fmt, args...)
 #else
 #define strace_printf_wrap(what, fmt, args...) \
    ((void) ({\
-	if ((_STRACE_ ## what & _STRACE_SYSTEM) || strace.active) \
-	  strace.prntf(_STRACE_ ## what, __PRETTY_FUNCTION__, fmt, ## args); \
+	if ((_STRACE_ ## what & _STRACE_SYSTEM) || STRACE_ACTIVE) \
+	  STRACE_PRINTF(_STRACE_ ## what, __PRETTY_FUNCTION__, fmt, ## args); \
 	0; \
     }))
 #define strace_printf_wrap1(what, fmt, args...) \
     ((void) ({\
-	if ((_STRACE_ ## what & _STRACE_SYSTEM) || strace.active) \
-	  strace.prntf((_STRACE_ ## what) | _STRACE_NOTALL, __PRETTY_FUNCTION__, fmt, ## args); \
+	if ((_STRACE_ ## what & _STRACE_SYSTEM) || STRACE_ACTIVE) \
+	  STRACE_PRINTF((_STRACE_ ## what) | _STRACE_NOTALL, __PRETTY_FUNCTION__, fmt, ## args); \
 	0; \
     }))
+#endif
 
 #define debug_printf(fmt, args...) strace_printf_wrap(DEBUG, fmt , ## args)
 #define paranoid_printf(fmt, args...) strace_printf_wrap(PARANOID, fmt , ## args)
@@ -152,7 +168,7 @@
 #define minimal_printf(fmt, args...) strace_printf_wrap1(MINIMAL, fmt , ## args)
 #define malloc_printf(fmt, args...) strace_printf_wrap1(MALLOC, fmt , ## args)
 #define thread_printf(fmt, args...) strace_printf_wrap1(THREAD, fmt , ## args)
+
 #endif /*NEW_MACRO_VARARGS*/
-#endif /*NOSTRACE*/
-#endif /* __cplusplus */
+
 #endif /* _SYS_STRACE_H */


--------------070900010408050904050003
Content-Type: text/plain;
 name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ChangeLog.txt"
Content-length: 151

2002-08-08  Joe Buehler  <jbuehler@hekimian.com>

	* strace.cc: added strace_active for use with C code
	* include/sys/strace.h: added support for C



--------------070900010408050904050003--
