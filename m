Return-Path: <cygwin-patches-return-3534-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5006 invoked by alias); 6 Feb 2003 19:48:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4982 invoked from network); 6 Feb 2003 19:48:26 -0000
Date: Thu, 06 Feb 2003 19:48:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] w32api [jld@ecoscentric.com: PathRelativePathTo() declarations]
Message-ID: <20030206194917.GB26036@redhat.com>
Mail-Followup-To: cygwin-patches@cygwin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00183.txt.bz2

Danny,
I don't know if you read the cygwin mailing list but just in case...

cgf

----- Forwarded message from John Dallaway <jld@ecoscentric.com> -----

From: John Dallaway <jld@ecoscentric.com>
To: cygwin@cygwin.com
Subject: PathRelativePathTo() declarations
Date: Tue, 4 Feb 2003 09:32:39 +0000
Mail-Followup-To: cygwin@cygwin.com
Organization: eCosCentric Limited

I have discovered a trivial error in the shlwapi.h Win32 API header
file. I'm not a Cygwin developer but have appended a patch to the
installed file.

John Dallaway
eCosCentric Limited

--cut here--

--- shlwapi.h.old       2002-11-25 20:21:02.000000000 +0000
+++ shlwapi.h   2003-02-03 12:44:08.000000000 +0000
@@ -262,12 +262,12 @@
 WINSHLWAPI BOOL WINAPI PathMatchSpecW(LPCWSTR,LPCWSTR);
 WINSHLWAPI int WINAPI PathParseIconLocationA(LPSTR);
 WINSHLWAPI int WINAPI PathParseIconLocationW(LPWSTR);
 WINSHLWAPI void WINAPI PathQuoteSpacesA(LPSTR);
 WINSHLWAPI void WINAPI PathQuoteSpacesW(LPWSTR);
-WINSHLWAPI BOOL WINAPI PathRelativePathToA(LPSTR,LPCSTR,DWORD,LPCWSTR,DWORD);
-WINSHLWAPI BOOL WINAPI PathRelativePathToW(LPWSTR,LPCWSTR,DWORD,LPCSTR,DWORD);
+WINSHLWAPI BOOL WINAPI PathRelativePathToA(LPSTR,LPCSTR,DWORD,LPCSTR,DWORD);
+WINSHLWAPI BOOL WINAPI PathRelativePathToW(LPWSTR,LPCWSTR,DWORD,LPCWSTR,DWORD);
 WINSHLWAPI void WINAPI PathRemoveArgsA(LPSTR);
 WINSHLWAPI void WINAPI PathRemoveArgsW(LPWSTR);
 WINSHLWAPI LPSTR WINAPI PathRemoveBackslashA(LPSTR);
 WINSHLWAPI LPWSTR WINAPI PathRemoveBackslashW(LPWSTR);
 WINSHLWAPI void WINAPI PathRemoveBlanksA(LPSTR);


--
Unsubscribe info:      http://cygwin.com/ml/#unsubscribe-simple
Bug reporting:         http://cygwin.com/bugs.html
Documentation:         http://cygwin.com/docs.html
FAQ:                   http://cygwin.com/faq/

----- End forwarded message -----
