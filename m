Return-Path: <cygwin-patches-return-6802-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7531 invoked by alias); 25 Oct 2009 21:16:00 -0000
Received: (qmail 7519 invoked by uid 22791); 25 Oct 2009 21:15:58 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-42-77.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.42.77)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 25 Oct 2009 21:15:51 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id B7F933B0002 	for <cygwin-patches@cygwin.com>; Sun, 25 Oct 2009 17:15:40 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 6A5822B352; Sun, 25 Oct 2009 17:15:40 -0400 (EDT)
Date: Sun, 25 Oct 2009 21:16:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Sync pseudo-reloc.c, round #2
Message-ID: <20091025211540.GA1658@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AE4A701.3050206@cwilson.fastmail.fm>  <4AE4B419.1060502@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AE4B419.1060502@cwilson.fastmail.fm>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00133.txt.bz2

On Sun, Oct 25, 2009 at 04:24:57PM -0400, Charles Wilson wrote:
>Charles Wilson wrote:
>
>> Tested on mingw32 and cygwin.
>
>It occurred to me that I hadn't explicitly tested the error path with
>this new version, and sure enough, there's a slight problem.  Here's the
>fix (relative to the previous patch):
>
>--- pseudo-reloc.c.save	2009-10-25 15:45:43.595012200 -0400
>+++ pseudo-reloc.c	2009-10-25 16:10:08.236212200 -0400
>@@ -94,7 +94,7 @@
>   wchar_t module[MAX_PATH];
>   char * posix_module = NULL;
>   static const char * UNKNOWN_MODULE = "<unknown module>: ";
>-  static const char * CYGWIN_FAILURE_MSG = "Cygwin runtime failure: ";
>+  static const char   CYGWIN_FAILURE_MSG[] = "Cygwin runtime failure: ";
>   static const size_t CYGWIN_FAILURE_MSG_LEN = sizeof
>(CYGWIN_FAILURE_MSG) - 1;
>   DWORD len;
>   DWORD done;
>@@ -133,6 +133,8 @@
>                  sizeof(UNKNOWN_MODULE), &done, NULL);
>       WriteFile (errh, (PCVOID)buf, len, &done, NULL);
>     }
>+  WriteFile (errh, (PCVOID)"\n", 1, &done, NULL);
>+
>   cygwin_internal (CW_EXIT_PROCESS,
>                    STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION,
>                    1);

I didn't go through this + previous patch in exhaustive detail but if
you've tested it then I think it's fine to check in.

cgf
