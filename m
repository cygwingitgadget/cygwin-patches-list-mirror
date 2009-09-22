Return-Path: <cygwin-patches-return-6628-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1337 invoked by alias); 22 Sep 2009 04:10:09 -0000
Received: (qmail 1324 invoked by uid 22791); 22 Sep 2009 04:10:08 -0000
X-SWARE-Spam-Status: No, hits=0.2 required=5.0 	tests=AWL,BAYES_40,J_CHICKENPOX_52,J_CHICKENPOX_62,J_CHICKENPOX_82,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta08.emeryville.ca.mail.comcast.net (HELO QMTA08.emeryville.ca.mail.comcast.net) (76.96.30.80)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 22 Sep 2009 04:10:03 +0000
Received: from OMTA04.emeryville.ca.mail.comcast.net ([76.96.30.35]) 	by QMTA08.emeryville.ca.mail.comcast.net with comcast 	id jdT31c0020lTkoCA8gA3BQ; Tue, 22 Sep 2009 04:10:03 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA04.emeryville.ca.mail.comcast.net with comcast 	id jgA11c0060Lg2Gw8QgA2t7; Tue, 22 Sep 2009 04:10:02 +0000
Message-ID: <4AB84E17.5050503@byu.net>
Date: Tue, 22 Sep 2009 04:10:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: fcntl bug
References: <4A8F0944.5020004@byu.net>  <4A8F1819.9060209@sipxx.com>  <4A8F19DC.8060104@byu.net>  <20090822001027.GB8375@ednor.casa.cgf.cx>  <loom.20090824T170139-863@post.gmane.org>  <4A9B1A3B.9070600@byu.net>  <20090831005538.GH2068@ednor.casa.cgf.cx>  <4AA013D2.5060702@byu.net> <20090903191717.GA3998@ednor.casa.cgf.cx>
In-Reply-To: <20090903191717.GA3998@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
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
X-SW-Source: 2009-q3/txt/msg00082.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 9/3/2009 1:17 PM:
>> 	* dtable.h (OPEN_MAX_MAX): New macro.
>> 	* resource.cc (getrlimit) [RLIMIT_NOFILE]: Use it.
>> 	* dtable.cc (dtable::extend): Likewise.
>> 	* fcntl.cc (fcntl64): Obey POSIX rules.
>> 	* syscalls.cc (dup2): Likewise.
> 
> Thanks for the patch.  Go ahead and check this in.
> 
> In particular, thanks for turning (100 * NOFILE_INCR) into a #define.

Now applied.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkq4ThcACgkQ84KuGfSFAYDTpACgpTumH8GA1N2jkwFdjaUfbnli
DW8AoIFSRWSH7R1te3aTrBgK5fZy9pnZ
=Naje
-----END PGP SIGNATURE-----
