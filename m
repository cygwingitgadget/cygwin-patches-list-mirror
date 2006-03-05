Return-Path: <cygwin-patches-return-5800-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12232 invoked by alias); 5 Mar 2006 01:15:42 -0000
Received: (qmail 12222 invoked by uid 22791); 5 Mar 2006 01:15:41 -0000
X-Spam-Check-By: sourceware.org
Received: from sccrmhc14.comcast.net (HELO sccrmhc14.comcast.net) (204.127.200.84)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 05 Mar 2006 01:15:38 +0000
Received: from [192.168.0.100] (c-24-10-241-225.hsd1.ut.comcast.net[24.10.241.225])           by comcast.net (sccrmhc14) with ESMTP           id <2006030501153501400e5k7be>; Sun, 5 Mar 2006 01:15:35 +0000
Message-ID: <440A3B91.9000702@byu.net>
Date: Sun, 05 Mar 2006 01:15:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Yitzchak Scott-Thoennes <sthoenna@efn.org>
CC: Dave Korn <dave.korn@artimi.com>,  cygwin-patches@cygwin.com
Subject: Re: [Patch] regtool: Add load/unload commands and --binary option
References: <20060303094621.GP3184@calimero.vinschen.de> <03f701c63ec4$0eee53d0$a501a8c0@CAM.ARTIMI.COM> <20060303174157.GA3704@efn.org>
In-Reply-To: <20060303174157.GA3704@efn.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00109.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Yitzchak Scott-Thoennes on 3/3/2006 10:41 AM:
> 
> as another example of non-traditional access to the registry.  How
> about /proc/registry//machinename/... to access the registry of other
> computers on the network?  Or is // not at the beginning a no-no?

// is only special at the beginning.  Anywhere else in a filename, POSIX
requires /proc/registry/foo and /proc/registry//foo to name the same file.

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFECjuR84KuGfSFAYARAo38AJwNlRpqrR339r9FqVc+0ZNLRNHOkwCgz4T0
l02999MPTlIgJCPO/UU6cQg=
=mlnF
-----END PGP SIGNATURE-----
