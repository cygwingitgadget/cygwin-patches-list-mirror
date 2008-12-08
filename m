Return-Path: <cygwin-patches-return-6380-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31160 invoked by alias); 8 Dec 2008 23:54:27 -0000
Received: (qmail 31150 invoked by uid 22791); 8 Dec 2008 23:54:26 -0000
X-Spam-Check-By: sourceware.org
Received: from yx-out-1718.google.com (HELO yx-out-1718.google.com) (74.125.44.154)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 08 Dec 2008 23:52:43 +0000
Received: by yx-out-1718.google.com with SMTP id 4so555994yxp.38         for <cygwin-patches@cygwin.com>; Mon, 08 Dec 2008 15:52:41 -0800 (PST)
Received: by 10.64.183.6 with SMTP id g6mr3337025qbf.17.1228780360371;         Mon, 08 Dec 2008 15:52:40 -0800 (PST)
Received: from ?192.168.0.100? (S0106001346f94b85.wp.shawcable.net [24.76.249.6])         by mx.google.com with ESMTPS id 12sm8663583qbw.29.2008.12.08.15.52.39         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Mon, 08 Dec 2008 15:52:39 -0800 (PST)
Message-ID: <493DB346.2070909@users.sourceforge.net>
Date: Mon, 08 Dec 2008 23:54:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: <resolv.h> requires <netinet/in.h>
References: <493DA370.30006@users.sourceforge.net> <024501c95989$2c07cc70$940410ac@wirelessworld.airvananet.com>
In-Reply-To: <024501c95989$2c07cc70$940410ac@wirelessworld.airvananet.com>
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
X-SW-Source: 2008-q4/txt/msg00024.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Pierre A. Humblet wrote:
> Every version of man resolver that I have ever seen specifies:
> 
> SYNOPSIS 
>      #include <sys/types.h>
>      #include <netinet/in.h>
>      #include <arpa/nameser.h>
>      #include <resolv.h>
> 
> So it's up to the user to include the right files.

Perhaps so, but:

1) <resolv.h> already #includes all of those headers *except* for
<netinet/in.h>.

2) this does not match Linux behaviour:

http://sourceware.org/cgi-bin/cvsweb.cgi/libc/resolv/resolv.h?cvsroot=glibc

As I stated, my STC was based on a configure test which works on other
platforms; I don't see why we shouldn't match that.

> Sure we can make an exception for Cygwin, but the same program can then fail elsewhere.

I agree that for portability, a program should not assume that #include
<resolv.h> automatically #include <netinet/in.h> and use the latter's
functions or typedefs.  But the bottom line here is that <resolv.h>
requires struct sockaddr_in, so it needs that #include.


Yaakov
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEAREIAAYFAkk9s0YACgkQpiWmPGlmQSMO/ACg1fIAqsvbkNC3CF3XnM/hQmBD
emwAn3jFN6zrj55wieyYvNawpI/HOkD4
=uV4z
-----END PGP SIGNATURE-----
