Return-Path: <cygwin-patches-return-7057-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 457 invoked by alias); 8 Aug 2010 08:35:40 -0000
Received: (qmail 427 invoked by uid 22791); 8 Aug 2010 08:35:34 -0000
X-SWARE-Spam-Status: No, hits=-1.3 required=5.0	tests=AWL,BAYES_00,RCVD_IN_RP_RNBL,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from service2.sh.cvut.cz (HELO service2.sh.cvut.cz) (147.32.127.218)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 08 Aug 2010 08:35:14 +0000
Received: from localhost (localhost [127.0.0.1])	by service2.sh.cvut.cz (Postfix) with ESMTP id 1C35C3BE2C;	Sun,  8 Aug 2010 10:35:11 +0200 (CEST)
Received: from service2.sh.cvut.cz ([127.0.0.1])	by localhost (service2.sh.cvut.cz [127.0.0.1]) (amavisd-new, port 10024)	with ESMTP id 16946-06; Sun, 8 Aug 2010 10:35:05 +0200 (CEST)
Received: from [10.0.0.1] (13.101.broadband5.iol.cz [88.100.101.13])	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))	(No client certificate requested)	by service2.sh.cvut.cz (Postfix) with ESMTP id C305C3BE2B;	Sun,  8 Aug 2010 10:35:05 +0200 (CEST)
Message-ID: <4C5E6C39.6000802@sh.cvut.cz>
Date: Sun, 08 Aug 2010 08:35:00 -0000
From: =?UTF-8?B?VsOhY2xhdiBIYWlzbWFu?= <v.haisman@sh.cvut.cz>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] define RTLD_LOCAL
References: <1281246553.1344.24.camel@YAAKOV04>
In-Reply-To: <1281246553.1344.24.camel@YAAKOV04>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00017.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Yaakov (Cygwin/X) wrote, On 8.8.2010 7:49:
> POSIX requires RTLD_LOCAL to be defined in <dlfcn.h>[1].  While our
> dlopen() does nothing with its second argument, portable software can
> rightfully expect the definition to exist alongside the other RTLD_*
> macros.
> 
> So why 0?  POSIX states wrt dlopen()[2]:
> 
>> If neither RTLD_GLOBAL nor RTLD_LOCAL are specified, then the default
>> behavior is unspecified.
> 
> On Linux, RTLD_LOCAL is the default behaviour[3], and hence is defined
> as 0[4], therefore I have done the same here.
> 
> Patch attached.  Since this doesn't actually do anything, I wasn't sure
> if I should bump CYGWIN_VERSION_API_MINOR for this or not; I can
> certainly do so before committing if desired.
Is it not undefined in Cygwin because Windows cannot support the behaviour?
AFAIK once you do LoadLibrary(A.dll) then any subsequent reference to A.dll
and its exports will be satisfied from the already loaded A.dll. IOW, Windows
cannot satisfy "The object's symbols shall not be made available for the
relocation processing of any other object," as specified by [2].

> [1] http://www.opengroup.org/onlinepubs/9699919799/basedefs/dlfcn.h.html
> [2] http://www.opengroup.org/onlinepubs/9699919799/functions/dlopen.html
> [3] http://linux.die.net/man/3/dlopen
> [4] http://sourceware.org/git/?p=glibc.git;a=blob;f=bits/dlfcn.h

- -- 
VH
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iF4EAREIAAYFAkxebDkACgkQeqrf2dJjGj7uMgEAhtmcXzuborabjWbPCGe6VkoL
fo9QyIkvBajGyB9RGp0A/iD+lz/brm33xFvDJ1mZ3SIYorSNGXr3ZXbFPHjTma1Q
=Ap0W
-----END PGP SIGNATURE-----
