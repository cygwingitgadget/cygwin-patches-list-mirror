Return-Path: <cygwin-patches-return-7128-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11291 invoked by alias); 31 Oct 2010 03:47:05 -0000
Received: (qmail 11247 invoked by uid 22791); 31 Oct 2010 03:46:54 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-56-137.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.56.137)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sun, 31 Oct 2010 03:46:50 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 9AB4413C061	for <cygwin-patches@cygwin.com>; Sat, 30 Oct 2010 23:46:47 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 583A82B352; Sat, 30 Oct 2010 23:46:47 -0400 (EDT)
Resent-From: Christopher Faylor <me@cgf.cx>
Resent-Date: Sat, 30 Oct 2010 23:46:47 -0400
Resent-Message-ID: <20101031034647.GA15222@ednor.casa.cgf.cx>
Resent-To: cygwin-patches@cygwin.com
Date: Sun, 31 Oct 2010 03:47:00 -0000
From: Christopher Faylor <cygwin-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: "regtool -m set" writes 2 extra bytes at the end
Message-ID: <20101031014235.GA13538@ednor.casa.cgf.cx>
References: <20101031003731.GA30070@dpotapov.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101031003731.GA30070@dpotapov.dyndns.org>
Reply-To: cygwin-patches@cygwin.com
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
X-SW-Source: 2010-q4/txt/msg00007.txt.bz2

[Apologies for previously sending this as private email.  Don't know how
that happened]
On Sun, Oct 31, 2010 at 03:37:31AM +0300, Dmitry Potapov wrote:
>Hi,
>
>The easiest way to demonstrate the problem is to run the following shell
>script:
>
>---- >8 ---
>regtool -m set /HKEY_LOCAL_MACHINE/SOFTWARE/Test 1234
>expected="31 00 32 00 33 00 34 00 00 00 00 00"
>actual="`regtool get -b /HKEY_LOCAL_MACHINE/SOFTWARE/Test`"
>
>if [ "$actual" != "$expected" ]; then
>	echo FAILED
>else
>	echo OK
>fi
>---- >8 ---

I've checked this in but isn't there one too many trailing "00 00"s in
the above, i.e., shouldn't it be "n" rather than "n + 1"?

>The patch is below.

Thanks for the patch.

cgf

>
>--- >8 ---
>Index: regtool.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/utils/regtool.cc,v
>retrieving revision 1.30
>diff -u -r1.30 regtool.cc
>--- regtool.cc	28 Aug 2010 11:22:37 -0000	1.30
>+++ regtool.cc	30 Oct 2010 22:56:47 -0000
>@@ -711,7 +711,7 @@
> 	n += mbstowcs ((wchar_t *) data + n, argv[i], max_n - n) + 1;
>       ((wchar_t *)data)[n] = L'\0';
>       rv = RegSetValueExW (key, value, 0, REG_MULTI_SZ, (const BYTE *) data,
>-			   (max_n + 1) * sizeof (wchar_t));
>+			   (n + 1) * sizeof (wchar_t));
>       break;
>     case REG_AUTO:
>       rv = ERROR_SUCCESS;
>--- >8 ---
>
>
>Dmitry
>
