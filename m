Return-Path: <cygwin-patches-return-6049-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29497 invoked by alias); 23 Mar 2007 12:27:39 -0000
Received: (qmail 29485 invoked by uid 22791); 23 Mar 2007 12:27:38 -0000
X-Spam-Check-By: sourceware.org
Received: from flim.org (HELO flim.org) (65.99.223.158)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 23 Mar 2007 12:27:23 +0000
Received: from brak (222-155-161-114.jetstream.xtra.co.nz [222.155.161.114]) 	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) 	(No client certificate requested) 	by flim.org (Postfix) with ESMTP id 86E4064066 	for <cygwin-patches@cygwin.com>; Fri, 23 Mar 2007 12:27:21 +0000 (UTC)
Received: by brak (Postfix, from userid 1000) 	id CE31964515; Sat, 24 Mar 2007 00:27:17 +1200 (NZST)
Date: Fri, 23 Mar 2007 12:27:00 -0000
From: Matthew Gregan <kinetik@flim.org>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] w32api: Correct Unicode/Ansi defines for GetMappedFileName
Message-ID: <20070323122717.GA2148@flim.org>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20070322210856.GV23239@flim.org> <20070323092157.GA18589@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20070323092157.GA18589@calimero.vinschen.de>
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
X-SW-Source: 2007-q1/txt/msg00030.txt.bz2


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 929

At 2007-03-23T10:21:57+0100, Corinna Vinschen wrote:
> Thanks for the patch.  I've applied it.

Well, not quite.  The changes you've applied still have the incorrect case
for GetMappedFileName (note the capital N).  My original patch was correct.
I've attached a new patch against the latest revision to fix up the
capitalization.

> Btw., the w32api is officially maintained by the MinGW folks, see the
> README.w32api file.  Patches to w32api are better off in the appropriate
> mingw mailing list.

Yes, sorry, I totally missed this.  I got confused because the w32api
directory in the MinGW CVS tree is empty and points you to the Cygwin CVS
tree, but, as you say, the README.w32api in the Cygwin w32api source tree
does tell you to send patches to the MinGW developers.  I'll do that next
time.

Thanks,
-mjg
-- 
Matthew Gregan                     |/
                                  /|                    kinetik@flim.org

--fdj2RfSjLxBAspz7
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="cygwin-w32api-psapi-2.patch"
Content-length: 993

Index: include/psapi.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/psapi.h,v
retrieving revision 1.3
diff -u -p -r1.3 psapi.h
--- include/psapi.h	23 Mar 2007 09:17:26 -0000	1.3
+++ include/psapi.h	23 Mar 2007 12:24:47 -0000
@@ -76,13 +76,13 @@ BOOL WINAPI GetProcessMemoryInfo(HANDLE,
 #ifdef UNICODE
 #define GetModuleBaseName GetModuleBaseNameW
 #define GetModuleFileNameEx GetModuleFileNameExW
-#define GetMappedFilename GetMappedFilenameW
+#define GetMappedFileName GetMappedFileNameW
 #define GetDeviceDriverBaseName GetDeviceDriverBaseNameW
 #define GetDeviceDriverFileName GetDeviceDriverFileNameW
 #else
 #define GetModuleBaseName GetModuleBaseNameA
 #define GetModuleFileNameEx GetModuleFileNameExA
-#define GetMappedFilename GetMappedFilenameA
+#define GetMappedFileName GetMappedFileNameA
 #define GetDeviceDriverBaseName GetDeviceDriverBaseNameA
 #define GetDeviceDriverFileName GetDeviceDriverFileNameA
 #endif

--fdj2RfSjLxBAspz7--
