Return-Path: <cygwin-patches-return-6046-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3568 invoked by alias); 22 Mar 2007 21:09:08 -0000
Received: (qmail 3556 invoked by uid 22791); 22 Mar 2007 21:09:07 -0000
X-Spam-Check-By: sourceware.org
Received: from flim.org (HELO flim.org) (65.99.223.158)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 22 Mar 2007 21:09:01 +0000
Received: from brak (222-155-161-114.jetstream.xtra.co.nz [222.155.161.114]) 	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) 	(No client certificate requested) 	by flim.org (Postfix) with ESMTP id 00D6564066 	for <cygwin-patches@cygwin.com>; Thu, 22 Mar 2007 21:08:59 +0000 (UTC)
Received: by brak (Postfix, from userid 1000) 	id D907E52D9E; Fri, 23 Mar 2007 09:08:56 +1200 (NZST)
Date: Thu, 22 Mar 2007 21:09:00 -0000
From: Matthew Gregan <kinetik@flim.org>
To: cygwin-patches@cygwin.com
Subject: [PATCH] w32api: Correct Unicode/Ansi defines for GetMappedFileName
Message-ID: <20070322210856.GV23239@flim.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00027.txt.bz2


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 390

Hi,

Attached is a small patch to correct the Unicode and Ansi defines that
expose the appropriate W/A variant of GetMappedFileName.

2007-03-23  Matthew Gregan  <kinetik@flim.org>

       * include/psapi.h (GetMappedFileName): Rename from GetMappedFilenameEx.

Cheers,
-mjg
-- 
Matthew Gregan                     |/
                                  /|                    kinetik@flim.org

--a2FkP9tdjPU2nyhF
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="cygwin-w32api-psapi.patch"
Content-length: 976

Index: psapi.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/psapi.h,v
retrieving revision 1.2
diff -u -p -r1.2 psapi.h
--- psapi.h	9 Mar 2002 09:04:09 -0000	1.2
+++ psapi.h	22 Mar 2007 20:20:03 -0000
@@ -76,13 +76,13 @@ BOOL WINAPI GetProcessMemoryInfo(HANDLE,
 #ifdef UNICODE
 #define GetModuleBaseName GetModuleBaseNameW
 #define GetModuleFileNameEx GetModuleFileNameExW
-#define GetMappedFilenameEx GetMappedFilenameExW
+#define GetMappedFileName GetMappedFileNameW
 #define GetDeviceDriverBaseName GetDeviceDriverBaseNameW
 #define GetDeviceDriverFileName GetDeviceDriverFileNameW
 #else
 #define GetModuleBaseName GetModuleBaseNameA
 #define GetModuleFileNameEx GetModuleFileNameExA
-#define GetMappedFilenameEx GetMappedFilenameExA
+#define GetMappedFileName GetMappedFileNameA
 #define GetDeviceDriverBaseName GetDeviceDriverBaseNameA
 #define GetDeviceDriverFileName GetDeviceDriverFileNameA
 #endif

--a2FkP9tdjPU2nyhF--
