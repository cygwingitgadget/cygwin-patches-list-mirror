Return-Path: <cygwin-patches-return-6875-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11563 invoked by alias); 17 Dec 2009 14:04:42 -0000
Received: (qmail 11552 invoked by uid 22791); 17 Dec 2009 14:04:41 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta03.emeryville.ca.mail.comcast.net (HELO QMTA03.emeryville.ca.mail.comcast.net) (76.96.30.32)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 17 Dec 2009 14:04:38 +0000
Received: from OMTA17.emeryville.ca.mail.comcast.net ([76.96.30.73]) 	by QMTA03.emeryville.ca.mail.comcast.net with comcast 	id JDzN1d0081afHeLA3E4dcs; Thu, 17 Dec 2009 14:04:37 +0000
Received: from [192.168.0.104] ([24.10.244.244]) 	by OMTA17.emeryville.ca.mail.comcast.net with comcast 	id JE4M1d00B5H651C8dE4XPx; Thu, 17 Dec 2009 14:04:36 +0000
Message-ID: <4B2A3A64.2010005@byu.net>
Date: Thu, 17 Dec 2009 14:04:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: patch: sleep/nanosleep bug
References: <4B045581.4040301@byu.net>  <20091118204709.GA3461@ednor.casa.cgf.cx>  <4B06A48C.5050904@byu.net> <20091216160851.GB31219@ednor.casa.cgf.cx>
In-Reply-To: <20091216160851.GB31219@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q4/txt/msg00206.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 12/16/2009 9:08 AM:
>> How about the following, then?  Same changelog.
> 
> It wonder if your while (!done) loop could be expressed as a for loop but
> it isn't enough of an issue to block inclusion of this patch.
> 
> So, thanks for the patch and please check in.  This will then go into 1.7.2.

Thanks; committed now.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAksqOl4ACgkQ84KuGfSFAYDuKgCfRY1+DlzGW6JsB82wbWpXeL4Z
E3cAoMoYkKSQTG6yafQXMtTPrwLNnZco
=u1VK
-----END PGP SIGNATURE-----
