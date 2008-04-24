Return-Path: <cygwin-patches-return-6331-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30062 invoked by alias); 24 Apr 2008 05:33:32 -0000
Received: (qmail 30039 invoked by uid 22791); 24 Apr 2008 05:33:31 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.177)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 24 Apr 2008 05:33:06 +0000
Received: by py-out-1112.google.com with SMTP id w53so4624400pyg.25         for <cygwin-patches@cygwin.com>; Wed, 23 Apr 2008 22:33:04 -0700 (PDT)
Received: by 10.65.254.5 with SMTP id g5mr4855255qbs.14.1209015184093;         Wed, 23 Apr 2008 22:33:04 -0700 (PDT)
Received: from ?192.168.0.100? ( [24.76.249.6])         by mx.google.com with ESMTPS id c6sm1324701qbc.11.2008.04.23.22.33.02         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Wed, 23 Apr 2008 22:33:03 -0700 (PDT)
Message-ID: <48101B9B.6010100@users.sourceforge.net>
Date: Thu, 24 Apr 2008 05:33:00 -0000
From: "Yaakov (Cygwin Ports)" <yselkowitz@users.sourceforge.net>
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: wait.h
References: <480F8B7D.5080908@users.sourceforge.net> <481015FE.8010508@sh.cvut.cz>
In-Reply-To: <481015FE.8010508@sh.cvut.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q2/txt/msg00002.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

VÃ¡clav Haisman wrote:
| I strongly think you should fix the packages and send the patches
| upstream instead.

I don't disagree that using <wait.h> isn't very portable, but glibc has
it. The point is that we should be trying to be compatible with glibc
when possible.  This patch is a small price to pay to make building
software on Cygwin that much closer to Linux.


Yaakov
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEAREIAAYFAkgQG5sACgkQpiWmPGlmQSM97QCeMYcn39K5qbwwyC2KZ6e16Kwb
AWYAn3mktGXW4wCyyvNrLZMSTduL+GlK
=UWnF
-----END PGP SIGNATURE-----
