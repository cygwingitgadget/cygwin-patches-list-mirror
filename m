Return-Path: <cygwin-patches-return-7821-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21699 invoked by alias); 21 Feb 2013 01:15:22 -0000
Received: (qmail 21687 invoked by uid 22791); 21 Feb 2013 01:15:22 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-04-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.74)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 21 Feb 2013 01:15:17 +0000
Received: from pool-173-76-49-193.bstnma.fios.verizon.net ([173.76.49.193] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1U8Kkm-000LpN-T4	for cygwin-patches@cygwin.com; Thu, 21 Feb 2013 01:15:16 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id B8C2D8804BF	for <cygwin-patches@cygwin.com>; Wed, 20 Feb 2013 20:15:16 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX186XnXbVWzZKaFWsvf+eJfs
Date: Thu, 21 Feb 2013 01:15:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] utils: force static linkage
Message-ID: <20130221011516.GB2786@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130220153103.48a3a6d5@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130220153103.48a3a6d5@YAAKOV04>
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
X-SW-Source: 2013-q1/txt/msg00032.txt.bz2

On Wed, Feb 20, 2013 at 03:31:03PM -0600, Yaakov wrote:
>Last time I checked, we were linking all utils statically, so this
>caught me by surprise:
>
>$ /bin/ldd dumper.exe 
>	ntdll.dll => /cygdrive/c/Windows/SysWOW64/ntdll.dll (0x77d70000)
>	kernel32.dll => /cygdrive/c/Windows/syswow64/kernel32.dll (0x75a50000)
>	KERNELBASE.dll => /cygdrive/c/Windows/syswow64/KERNELBASE.dll (0x76ef0000)
>	cygwin1.dll => /usr/bin/cygwin1.dll (0x61000000)
>	cygintl-8.dll => /usr/bin/cygintl-8.dll (0x49bd0000)
>	cygiconv-2.dll => /usr/bin/cygiconv-2.dll (0x6bfb0000)
>	??? => ??? (0x550000)
>
>The -static flag implies -static-libgcc (see gcc -dumpspecs) and affects
>all other libraries (including libstdc++).  Patch for HEAD attached.
>
>
>Yaakov

>2013-02-20  Yaakov Selkowitz  <yselkowitz@...>
>
>	* Makefile.in (CYGWIN_LDFLAGS): Replace -static-lib* with -static.
>	(MINGW_LDFLAGS): Ditto.
>	(ZLIB): Simplify accordingly.

Please check in.

cgf
