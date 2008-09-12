Return-Path: <cygwin-patches-return-6350-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15546 invoked by alias); 12 Sep 2008 21:06:07 -0000
Received: (qmail 15532 invoked by uid 22791); 12 Sep 2008 21:06:06 -0000
X-Spam-Check-By: sourceware.org
Received: from yw-out-1718.google.com (HELO yw-out-1718.google.com) (74.125.46.152)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 12 Sep 2008 21:05:07 +0000
Received: by yw-out-1718.google.com with SMTP id 9so379783ywk.38         for <cygwin-patches@cygwin.com>; Fri, 12 Sep 2008 14:05:04 -0700 (PDT)
Received: by 10.151.146.18 with SMTP id y18mr6718931ybn.174.1221253504106;         Fri, 12 Sep 2008 14:05:04 -0700 (PDT)
Received: from ?192.168.0.101? ( [24.76.249.6])         by mx.google.com with ESMTPS id s31sm14564903qbs.11.2008.09.12.14.04.59         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Fri, 12 Sep 2008 14:05:01 -0700 (PDT)
Message-ID: <48CAD97A.9010909@users.sourceforge.net>
Date: Fri, 12 Sep 2008 21:06:00 -0000
From: "Yaakov (Cygwin Ports)" <yselkowitz@users.sourceforge.net>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: undefined reference to '_cfmakeraw'
References: <6FB68266-8839-44EC-B803-66A9DE2E2830@vanderbilt.edu> <48CAD487.5030406@users.sourceforge.net>
In-Reply-To: <48CAD487.5030406@users.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q3/txt/msg00013.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Yaakov (Cygwin Ports) wrote:
> cfmakeraw, while available on Linux glibc, is not available on Cygwin.
> But the glibc manual tells us exactly what it does:
> 
> http://www.gnu.org/software/libc/manual/html_node/Noncanonical-Input.html
> 
> So just substitute the cfmakeraw call for the code shown there.

Since this function is specified in its entirety in documentation
(rather than just in code), as above and in other places listed below,
would a patch be accepted for Cygwin?

http://refspecs.freestandards.org/LSB_3.2.0/LSB-Core-generic/LSB-Core-generic/baselib-cfmakeraw-3.html
http://linux.die.net/man/3/cfmakeraw


Yaakov
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEAREIAAYFAkjK2XoACgkQpiWmPGlmQSNBPwCgyZUJQd8c52sTSVHMLiiOILbL
UJoAn0h0YR/l0mazV1UFaXjTVbqzNPVm
=wc6c
-----END PGP SIGNATURE-----
