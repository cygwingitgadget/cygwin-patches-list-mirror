Return-Path: <cygwin-patches-return-6660-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31977 invoked by alias); 30 Sep 2009 02:10:48 -0000
Received: (qmail 31963 invoked by uid 22791); 30 Sep 2009 02:10:46 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta05.emeryville.ca.mail.comcast.net (HELO QMTA05.emeryville.ca.mail.comcast.net) (76.96.30.48)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 30 Sep 2009 02:10:40 +0000
Received: from OMTA08.emeryville.ca.mail.comcast.net ([76.96.30.12]) 	by QMTA05.emeryville.ca.mail.comcast.net with comcast 	id moL31c0020FhH24A5qAgsZ; Wed, 30 Sep 2009 02:10:40 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA08.emeryville.ca.mail.comcast.net with comcast 	id mqAd1c0020Lg2Gw8UqAfNL; Wed, 30 Sep 2009 02:10:39 +0000
Message-ID: <4AC2BE07.1070501@byu.net>
Date: Wed, 30 Sep 2009 02:10:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] rename/renameat error
References: <4ABA1B92.9080406@byu.net> <20090923133015.GA16976@calimero.vinschen.de> <20090923140905.GA2527@ednor.casa.cgf.cx> <20090923160846.GA18954@calimero.vinschen.de> <20090923164127.GB3172@ednor.casa.cgf.cx> <4ABC39A1.1060702@byu.net> <20090925151114.GA23857@ednor.casa.cgf.cx> <4ABD5A4A.9060603@byu.net> <20090926145748.GA8697@ednor.casa.cgf.cx> <4AC25D6C.4010106@byu.net> <20090929193534.GK7193@calimero.vinschen.de>
In-Reply-To: <20090929193534.GK7193@calimero.vinschen.de>
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
X-SW-Source: 2009-q3/txt/msg00114.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Corinna Vinschen on 9/29/2009 1:35 PM:
> On Sep 29 13:18, Eric Blake wrote:
>> I missed one corner case in my testing; how about this followup?
>>
>> 2009-09-29  Eric Blake  <ebb9@byu.net>
>>
>> 	* syscalls.cc (rename): Fix regression on rename("dir","d/").
> 
> Looks ok to me.  Isn't that partly covered by the next if, though?
> YA piece of code lacking comments it seems.

I added a few comments before committing.  The difference between the two
lines is that only the first one rejects rename("file","file2/"), and only
the second rejects rename("dir","file"); both lines are needed.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkrCvgcACgkQ84KuGfSFAYA1pQCgwfc9ayThRxR2LfXKdkRgAyHE
zH4An1LF/FQwanbMRHuu1uCrv5a2RGIt
=p2ej
-----END PGP SIGNATURE-----
