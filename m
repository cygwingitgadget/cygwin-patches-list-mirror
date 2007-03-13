Return-Path: <cygwin-patches-return-6040-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25705 invoked by alias); 13 Mar 2007 13:26:47 -0000
Received: (qmail 25693 invoked by uid 22791); 13 Mar 2007 13:26:46 -0000
X-Spam-Check-By: sourceware.org
Received: from alnrmhc11.comcast.net (HELO alnrmhc11.comcast.net) (206.18.177.51)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 13 Mar 2007 13:26:40 +0000
Received: from [192.168.0.103] (failure[67.186.254.72])           by comcast.net (alnrmhc11) with ESMTP           id <20070313132638b1100a3ujse>; Tue, 13 Mar 2007 13:26:39 +0000
Message-ID: <45F6A707.8010209@byu.net>
Date: Tue, 13 Mar 2007 13:26:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.10) Gecko/20070221 Thunderbird/1.5.0.10 Mnenhy/0.7.4.666
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: compile warning in cygwin/stat.h
References: <45F69971.4000604@byu.net> <20070313132213.GE24859@calimero.vinschen.de>
In-Reply-To: <20070313132213.GE24859@calimero.vinschen.de>
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
X-SW-Source: 2007-q1/txt/msg00021.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Corinna Vinschen on 3/13/2007 7:22 AM:
> On Mar 13 06:30, Eric Blake wrote:
>> 	* include/cygwin/stat.h (S_TYPEISSHM, S_TYPEISSEM, S_TYPEISSHM):
>> 	Avoid compiler warnings.
> 
> Thanks, applied.

For all that, and I still got the changelog wrong.  I listed S_TYPEISSHM
twice and missed S_TYPEISMQ.  I'm spending more typing on the patch
procedure than the patch itself :)

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF9qbl84KuGfSFAYARAihTAKCmoqXThbnAbrcp6nDGf+oTejzmJQCfXERJ
ElI9YadGLZOg4wNDvncH9Fg=
=xwql
-----END PGP SIGNATURE-----
