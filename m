Return-Path: <cygwin-patches-return-6760-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31775 invoked by alias); 13 Oct 2009 02:26:44 -0000
Received: (qmail 31762 invoked by uid 22791); 13 Oct 2009 02:26:44 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta04.emeryville.ca.mail.comcast.net (HELO QMTA04.emeryville.ca.mail.comcast.net) (76.96.30.40)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 13 Oct 2009 02:26:39 +0000
Received: from OMTA15.emeryville.ca.mail.comcast.net ([76.96.30.71]) 	by QMTA04.emeryville.ca.mail.comcast.net with comcast 	id rpFv1c0021Y3wxoA42SfhT; Tue, 13 Oct 2009 02:26:39 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA15.emeryville.ca.mail.comcast.net with comcast 	id s2Sd1c0040Lg2Gw8b2Sems; Tue, 13 Oct 2009 02:26:38 +0000
Message-ID: <4AD3E560.7090408@byu.net>
Date: Tue, 13 Oct 2009 02:26:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: utimensat UTIME_NOW granularity bug
References: <loom.20091008T221131-292@post.gmane.org>  <20091008212425.GB2068@ednor.casa.cgf.cx>  <4ACEACBA.4030904@byu.net>  <20091009045800.GA17335@ednor.casa.cgf.cx>  <4ACF307F.1040604@byu.net> <20091012150237.GA29109@ednor.casa.cgf.cx>
In-Reply-To: <20091012150237.GA29109@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q4/txt/msg00091.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 10/12/2009 9:02 AM:
> I'm still not convinced that this switch makes anything clearer but, that's ok.
> 
> Please check in.

I decided not to move the gettime block; I left it after the handle open.
 That way, the clock_gettime() is as close to the assignment as possible,
rather than appearing to be early by the amount of time spent opening the
handle.  But with that change backed out, the patch is now in.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkrT5WAACgkQ84KuGfSFAYDpLQCfXZopvpYbyTFJrNqjMZg8cS3Y
ZZIAoLTRoJk0dE/EHrrQrTT7jwB0OgT2
=lNpx
-----END PGP SIGNATURE-----
