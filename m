Return-Path: <cygwin-patches-return-6436-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14749 invoked by alias); 12 Mar 2009 22:21:08 -0000
Received: (qmail 14739 invoked by uid 22791); 12 Mar 2009 22:21:06 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from ey-out-1920.google.com (HELO ey-out-1920.google.com) (74.125.78.147)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 12 Mar 2009 22:21:00 +0000
Received: by ey-out-1920.google.com with SMTP id 26so502283eyw.20         for <cygwin-patches@cygwin.com>; Thu, 12 Mar 2009 15:20:57 -0700 (PDT)
Received: by 10.216.73.85 with SMTP id u63mr260229wed.37.1236896457261;         Thu, 12 Mar 2009 15:20:57 -0700 (PDT)
Received: from ?192.168.0.101? (S0106001346f94b85.wp.shawcable.net [24.76.249.6])         by mx.google.com with ESMTPS id t12sm2275159gvd.20.2009.03.12.15.20.54         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Thu, 12 Mar 2009 15:20:56 -0700 (PDT)
Message-ID: <49B98AC4.1040202@users.sourceforge.net>
Date: Thu, 12 Mar 2009 22:21:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: errno.h: ESTRPIPE
References: <49B8A1F8.1030306@users.sourceforge.net> <20090312085748.GE14431@calimero.vinschen.de>
In-Reply-To: <20090312085748.GE14431@calimero.vinschen.de>
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
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q1/txt/msg00034.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Corinna Vinschen wrote:
> What exactly is this patch fixing?  Ok, we get a new error code, but
> what for?  It's not generated from within Cygwin, so...?

I came across a few packages that used it.  This gets us just a little
more compatible with Linux's errno.

Eric Blake wrote:
> And it's not standardized, which means portable code shouldn't use it.

That may be true, but I didn't write this code, and as I am sure you
already know, not everyone thinks about writing portable code.


Yaakov
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEAREIAAYFAkm5isQACgkQpiWmPGlmQSP76gCgoZW9aAXA6NEstR7EjFfH/ZQl
yeIAoKX+E66iUrkYBHPbgyzf+47CEmSI
=05er
-----END PGP SIGNATURE-----
