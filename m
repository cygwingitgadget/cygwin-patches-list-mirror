Return-Path: <cygwin-patches-return-6124-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29399 invoked by alias); 27 Jun 2007 12:52:40 -0000
Received: (qmail 29389 invoked by uid 22791); 27 Jun 2007 12:52:39 -0000
X-Spam-Check-By: sourceware.org
Received: from rwcrmhc14.comcast.net (HELO rwcrmhc14.comcast.net) (204.127.192.84)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 27 Jun 2007 12:52:36 +0000
Received: from [192.168.0.103] (c-24-10-242-83.hsd1.co.comcast.net[24.10.242.83])           by comcast.net (rwcrmhc14) with ESMTP           id <20070627125235m1400ngfrle>; Wed, 27 Jun 2007 12:52:35 +0000
Message-ID: <46825E07.6070301@byu.net>
Date: Wed, 27 Jun 2007 12:52:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070509 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: C99 assert
References: <loom.20070626T181404-544@post.gmane.org> <46816D73.8050202@redhat.com> <loom.20070626T220222-433@post.gmane.org> <4681B668.3010201@byu.net> <20070627073510.GC15182@calimero.vinschen.de>
In-Reply-To: <20070627073510.GC15182@calimero.vinschen.de>
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
X-SW-Source: 2007-q2/txt/msg00070.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Corinna Vinschen on 6/27/2007 1:35 AM:
>> 2007-06-26  Eric Blake
>>
>> 	* assert.cc (__assert_func): New function, to match newlib header
>> 	change.
>> 	* cygwin.din: Export __assert_func.
>> 	* include/cygwin/version.h: Bump API minor number.
> 
> Yeees, barely.  This is on the verge of being non-trivial, however.

Applied.

> Any chance you can sign the copyright assignment?  Please?

I'll try talking to my management at work today, once again, about the
prospects of signing it.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGgl4H84KuGfSFAYARAkQuAKC1tPJ30XsDik9kPng84SqWHqgUrACfY+SV
mU7KDEHOzXlzrxfNDvzJ4+w=
=4SGM
-----END PGP SIGNATURE-----
