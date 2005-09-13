Return-Path: <cygwin-patches-return-5648-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19757 invoked by alias); 13 Sep 2005 04:10:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19690 invoked by uid 22791); 13 Sep 2005 04:10:01 -0000
Received: from rwcrmhc11.comcast.net (HELO rwcrmhc11.comcast.net) (216.148.227.117)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 13 Sep 2005 04:10:01 +0000
Received: from [192.168.0.100] (c-67-172-242-110.hsd1.ut.comcast.net[67.172.242.110])
          by comcast.net (rwcrmhc11) with ESMTP
          id <2005091304095301300prc99e>; Tue, 13 Sep 2005 04:09:58 +0000
Message-ID: <43265113.3000207@byu.net>
Date: Tue, 13 Sep 2005 04:10:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: PING: fix ARG_MAX
References: <loom.20050906T172937-420@post.gmane.org> <loom.20050910T164247-175@post.gmane.org> <20050912152245.GB29379@calimero.vinschen.de>
In-Reply-To: <20050912152245.GB29379@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q3/txt/msg00103.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Corinna Vinschen on 9/12/2005 9:22 AM:
>>Even with your recent patches to make cygwin programs receive longer command
>>lines, whether or not they are not mounted cygexec, ARG_MAX should still reflect
>>the worst case limit so that programs (like xargs) that use ARG_MAX will work
>>reliably even when invoking non-cygwin programs that are really bound by the 32k
>>limit.
> 
> 
> I had a short talk with Chris and we both agree that it doesn't make
> overly sense to go down to the lowest limit just to accomodate
> non-Cygwin applications.  Users of those apps can easily use xargs -s
> so why penalize Cygwin apps?

Well, for now, xargs in findutils-4.2.25-2 is already hardcoded to 32k
max; attempting to use -s to get a larger value will fail, because of the
POSIX rules placed on xargs.  If, on the other hand, cygwin added
pathconf(_PC_ARG_MAX) as a legal extension to POSIX, then xargs could use
its preferred 128k default when calling cygwin apps, while using 32k for
windows apps without even requiring users to supply -s; not to mention the
fact that -s could then be used to obtain larger command lines than even
the default 128k for cygwin apps.  With that extension in place,
sysconf(_SC_ARG_MAX) at 32k is not much of a limit for applications that
know about cygwin's extension.

Also, the argument brought up on the findutils mailing list was that
beyond a certain size, the cost of processing each argument starts to
outweigh the benefits of forking fewer tasks, to the point that the
difference between a 32k ARG_MAX vs. a 1M ARG_MAX falls in the noise when
the same amount of data is divided by xargs to as few runs as possible, so
a 32k limit is not really penalizing cygwin apps.

But since I have not provided a patch for pathconf(_PC_ARG_MAX), and I do
not have copyright assignment, I will be understanding if 1.5.19 is
released with _SC_ARG_MAX still broken in the corner cases.  Just be aware
that xargs will remain at its hardcoded 32k limit unless it can find a way
to query cygwin whether a particular executable can be given a larger limit.

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDJlES84KuGfSFAYARAu75AJ4r3Zd2U/eFTMzod39mpNn0M8aQigCgySob
xk7QutMPTnN3wh/zUMnSMHM=
=sw7M
-----END PGP SIGNATURE-----
