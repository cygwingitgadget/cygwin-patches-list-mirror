Return-Path: <cygwin-patches-return-2884-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10578 invoked by alias); 30 Aug 2002 12:20:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10551 invoked from network); 30 Aug 2002 12:20:45 -0000
Date: Fri, 30 Aug 2002 05:20:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Added Kazuhiro's new wchar functions to cygwin.din
Message-ID: <20020830142028.F5475@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00332.txt.bz2

Hi,

did I miss one?

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.59
diff -u -p -r1.59 cygwin.din
--- cygwin.din	28 Aug 2002 10:50:26 -0000	1.59
+++ cygwin.din	30 Aug 2002 11:32:53 -0000
@@ -1031,6 +1031,42 @@ wcscmp
 _wcscmp = wcscmp
 wcslen
 _wcslen = wcslen
+wcscat
+_wcscat = wcscat
+wcschr
+_wcschr = wcschr
+wcscpy
+_wcscpy = wcscpy
+wcscspn
+_wcscspn = wcscspn
+wcslcat
+_wcslcat = wcslcat
+wcslcpy
+_wcslcpy = wcslcpy
+wcsncat
+_wcsncat = wcsncat
+wcsncmp
+_wcsncmp = wcsncmp
+wcsncpy
+_wcsncpy = wcsncpy
+wcspbrk
+_wcspbrk = wcspbrk
+wcsrchr
+_wcsrchr = wcsrchr
+wcsspn
+_wcsspn = wcsspn
+wcsstr
+_wcsstr = wcsstr
+wmemchr
+_wmemchr = wmemchr
+wmemcmp
+_wmemcmp = wmemcmp
+wmemcpy
+_wmemcpy = wmemcpy
+wmemmove
+_wmemmove = wmemmove
+wmemset
+_wmemset = wmemset
 wprintf
 _wprintf = wprintf
 memccpy


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
