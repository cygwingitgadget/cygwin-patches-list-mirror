Return-Path: <cygwin-patches-return-6468-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29552 invoked by alias); 3 Apr 2009 16:08:26 -0000
Received: (qmail 29540 invoked by uid 22791); 3 Apr 2009 16:08:24 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-qy0-f123.google.com (HELO mail-qy0-f123.google.com) (209.85.221.123)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 03 Apr 2009 16:08:19 +0000
Received: by qyk29 with SMTP id 29so1972452qyk.18         for <cygwin-patches@cygwin.com>; Fri, 03 Apr 2009 09:08:16 -0700 (PDT)
Received: by 10.224.14.195 with SMTP id h3mr316472qaa.10.1238774896367;         Fri, 03 Apr 2009 09:08:16 -0700 (PDT)
Received: from ?192.168.0.101? (S010600112f237275.wp.shawcable.net [24.76.253.194])         by mx.google.com with ESMTPS id 5sm3645607ywl.38.2009.04.03.09.08.15         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Fri, 03 Apr 2009 09:08:15 -0700 (PDT)
Message-ID: <49D63467.2050506@users.sourceforge.net>
Date: Fri, 03 Apr 2009 16:08:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] <asm/byteorder.h> missing prototypes warning
References: <49D57E45.4000409@users.sourceforge.net> <20090403082635.GB27898@calimero.vinschen.de>
In-Reply-To: <20090403082635.GB27898@calimero.vinschen.de>
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
X-SW-Source: 2009-q2/txt/msg00010.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Corinna Vinschen wrote:
> Wouldn't it be better to move newlib's _ELIDABLE_INLINE definition to
> some nicely matchin header like _ansi.h and then use it wherever it
> fits?

As I said, perhaps there is a better way of dealing with this.  The main
reason I didn't go for that solution in the first place is that I didn't
find other newlib/cygwin headers that would require this.  If there are
indeed more, then centralizing this makes perfect sense.


Yaakov
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEAREIAAYFAknWNGcACgkQpiWmPGlmQSNATgCfQyBuNQ4mMjGfpY6/nb6W1V28
vkwAn0Uo0xSKwmAhK5vRcax6UTdTz+Wo
=7UOD
-----END PGP SIGNATURE-----
