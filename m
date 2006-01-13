Return-Path: <cygwin-patches-return-5713-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23181 invoked by alias); 13 Jan 2006 18:49:32 -0000
Received: (qmail 23169 invoked by uid 22791); 13 Jan 2006 18:49:31 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 13 Jan 2006 18:49:27 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.54) 	id 1ExTzJ-0006oa-RI 	for cygwin-patches@cygwin.com; Fri, 13 Jan 2006 18:49:26 +0000
Message-ID: <43C7F635.9FDD093F@dessent.net>
Date: Fri, 13 Jan 2006 18:49:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [patch] load wininet dynamically in cygcheck
Content-Type: multipart/mixed;  boundary="------------8CD6729D187BE6E8E2CE46A6"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00022.txt.bz2

This is a multi-part message in MIME format.
--------------8CD6729D187BE6E8E2CE46A6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 550


This uses LoadLibrary and GetProcAddress instead of -lwininet so that systems
lacking IE3 can still run cygcheck.  Tested on XP and NT4, and verified that
with WININET.DLL renamed cygcheck can still function.

2006-01-13  Brian Dessent  <brian@dessent.net>

	* Makefile.in (cygcheck.exe): Do not link against libwininet.a.
	* cygcheck.cc (pInternetCloseHandle): Define global function pointer.
	(display_internet_error): Use it.
	(package_grep): Attempt to load wininet.dll at runtime.  Call WinInet
	API through function pointers throughout.

Brian
--------------8CD6729D187BE6E8E2CE46A6
Content-Type: text/plain; charset=us-ascii;
 name="cygcheck-wininet-dynamic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygcheck-wininet-dynamic.patch"
Content-length: 6260

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
retrieving revision 1.58
diff -u -p -r1.58 Makefile.in
--- Makefile.in	22 Nov 2005 17:19:17 -0000	1.58
+++ Makefile.in	13 Jan 2006 18:39:16 -0000
@@ -99,15 +99,15 @@ else
 	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,2,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS)
 endif
 
-cygcheck.exe: cygcheck.o path.o dump_setup.o $(MINGW_DEP_LDLIBS) $(w32api_lib)/libwininet.a
+cygcheck.exe: cygcheck.o path.o dump_setup.o $(MINGW_DEP_LDLIBS)
 ifeq "$(libz)" ""
 	@echo '*** Building cygcheck without package content checking due to missing mingw libz.a.'
 endif
 ifdef VERBOSE
-	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,3,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS) $(libz) $(w32api_lib)/libwininet.a
+	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,3,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS) $(libz)
 else
-	@echo $(CXX) -o $@ ${wordlist 1,3,$^} ${filter-out -B%, $(MINGW_CXXFLAGS) $(MINGW_LDFLAGS)} $(libz) $(w32api_lib)/libwininet.a;\
-	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,3,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS) $(libz) $(w32api_lib)/libwininet.a
+	@echo $(CXX) -o $@ ${wordlist 1,3,$^} ${filter-out -B%, $(MINGW_CXXFLAGS) $(MINGW_LDFLAGS)} $(libz);\
+	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,3,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS) $(libz)
 endif
 
 dumper.o: dumper.cc dumper.h
Index: cygcheck.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
retrieving revision 1.83
diff -u -p -r1.83 cygcheck.cc
--- cygcheck.cc	13 Jan 2006 13:39:05 -0000	1.83
+++ cygcheck.cc	13 Jan 2006 18:39:16 -0000
@@ -37,6 +37,10 @@ int find_package = 0;
 int list_package = 0;
 int grep_packages = 0;
 
+/* This is global because it's used in both internet_display_error as well
+   as package_grep.  */
+BOOL (WINAPI *pInternetCloseHandle) (HINTERNET);
+
 #ifdef __GNUC__
 typedef long long longlong;
 #else
@@ -161,7 +165,7 @@ display_internet_error (const char *mess
 
   va_start (hptr, message);
   while ((h = va_arg (hptr, HINTERNET)) != 0)
-    InternetCloseHandle (h);
+    pInternetCloseHandle (h);
   va_end (hptr);
 
   return 1;
@@ -1588,6 +1592,43 @@ package_grep (char *search)
 {
   char buf[1024];
 
+  /* Attempt to dynamically load the necessary WinInet API functions so that
+     cygcheck can still function on older systems without IE.  */
+  HMODULE hWinInet;
+  if (!(hWinInet = LoadLibrary ("wininet.dll")))
+    {
+      fputs ("Unable to locate WININET.DLL.  This feature requires Microsoft "
+             "Internet Explorer v3 or later to function.\n", stderr);
+      return 1;
+    }
+
+  /* InternetCloseHandle is used outside this function so it is declared
+     global.  The rest of these functions are only used here, so declare them
+     and call GetProcAddress for each of them with the following macro.  */
+
+  pInternetCloseHandle = (BOOL (WINAPI *) (HINTERNET))
+                            GetProcAddress (hWinInet, "InternetCloseHandle");
+#define make_func_pointer(name, ret, args) ret (WINAPI * p##name) args = \
+            (ret (WINAPI *) args) GetProcAddress (hWinInet, #name);
+  make_func_pointer (InternetAttemptConnect, DWORD, (DWORD));
+  make_func_pointer (InternetOpenA, HINTERNET, (LPCSTR, DWORD, LPCSTR, LPCSTR, 
+                                                DWORD));
+  make_func_pointer (InternetOpenUrlA, HINTERNET, (HINTERNET, LPCSTR, LPCSTR, 
+                                                   DWORD, DWORD, DWORD));
+  make_func_pointer (InternetReadFile, BOOL, (HINTERNET, PVOID, DWORD, PDWORD));
+  make_func_pointer (HttpQueryInfoA, BOOL, (HINTERNET, DWORD, PVOID, PDWORD,
+                                            PDWORD));
+#undef make_func_pointer
+
+  if(!pInternetCloseHandle || !pInternetAttemptConnect || !pInternetOpenA
+     || !pInternetOpenUrlA || !pInternetReadFile || !pHttpQueryInfoA)
+    {
+      fputs ("Unable to load one or more functions from WININET.DLL.  This "
+             "feature requires Microsoft Internet Explorer v3 or later to "
+             "function.\n", stderr);
+      return 1;
+    }
+
   /* construct the actual URL by escaping  */
   char *url = (char *) alloca (sizeof (base_url) + strlen (search) * 3);
   strcpy (url, base_url);
@@ -1610,7 +1651,7 @@ package_grep (char *search)
   *dest = 0;
 
   /* Connect to the net and open the URL.  */
-  if (InternetAttemptConnect (0) != ERROR_SUCCESS)
+  if (pInternetAttemptConnect (0) != ERROR_SUCCESS)
     {
       fputs ("An internet connection is required for this function.\n", stderr);
       return 1;
@@ -1618,16 +1659,16 @@ package_grep (char *search)
 
   /* Initialize WinInet and attempt to fetch our URL.  */
   HINTERNET hi = NULL, hurl = NULL;
-  if (!(hi = InternetOpen ("cygcheck", INTERNET_OPEN_TYPE_PRECONFIG, NULL, NULL, 0)))
+  if (!(hi = pInternetOpenA ("cygcheck", INTERNET_OPEN_TYPE_PRECONFIG, NULL, NULL, 0)))
     return display_internet_error ("InternetOpen() failed", NULL);
 
-  if (!(hurl = InternetOpenUrl (hi, url, NULL, 0, 0, 0)))
+  if (!(hurl = pInternetOpenUrlA (hi, url, NULL, 0, 0, 0)))
     return display_internet_error ("unable to contact cygwin.com site, "
                                    "InternetOpenUrl() failed", hi, NULL);
 
   /* Check the HTTP response code.  */
   DWORD rc = 0, rc_s = sizeof (DWORD);
-  if (!HttpQueryInfo (hurl, HTTP_QUERY_STATUS_CODE | HTTP_QUERY_FLAG_NUMBER,
+  if (!pHttpQueryInfoA (hurl, HTTP_QUERY_STATUS_CODE | HTTP_QUERY_FLAG_NUMBER,
                       (void *) &rc, &rc_s, NULL))
     return display_internet_error ("HttpQueryInfo() failed", hurl, hi, NULL);
 
@@ -1642,15 +1683,15 @@ package_grep (char *search)
   DWORD numread;
   do
     {
-      if (!InternetReadFile (hurl, (void *) buf, sizeof (buf), &numread))
+      if (!pInternetReadFile (hurl, (void *) buf, sizeof (buf), &numread))
         return display_internet_error ("InternetReadFile failed", hurl, hi, NULL);
       if (numread)
         fwrite ((void *) buf, (size_t) numread, 1, stdout);
     }
   while (numread);
 
-  InternetCloseHandle (hurl);
-  InternetCloseHandle (hi);
+  pInternetCloseHandle (hurl);
+  pInternetCloseHandle (hi);
   return 0;
 }
 

--------------8CD6729D187BE6E8E2CE46A6--
