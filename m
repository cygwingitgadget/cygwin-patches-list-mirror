Return-Path: <cygwin-patches-return-6386-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27119 invoked by alias); 12 Dec 2008 15:50:12 -0000
Received: (qmail 27106 invoked by uid 22791); 12 Dec 2008 15:50:11 -0000
X-Spam-Check-By: sourceware.org
Received: from qmta10.emeryville.ca.mail.comcast.net (HELO QMTA10.emeryville.ca.mail.comcast.net) (76.96.30.17)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 12 Dec 2008 15:49:01 +0000
Received: from OMTA11.emeryville.ca.mail.comcast.net ([76.96.30.36]) 	by QMTA10.emeryville.ca.mail.comcast.net with comcast 	id qFUz1a00L0mlR8UAAFoz4w; Fri, 12 Dec 2008 15:48:59 +0000
Received: from [192.168.0.101] ([67.166.125.73]) 	by OMTA11.emeryville.ca.mail.comcast.net with comcast 	id qFoy1a0031b8C2B8XFoyFw; Fri, 12 Dec 2008 15:48:59 +0000
Message-ID: <494287F4.2080505@byu.net>
Date: Fri, 12 Dec 2008 15:50:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.18) Gecko/20081105 Thunderbird/2.0.0.18 Mnenhy/0.7.5.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Avoid duplicate names in /proc/registry (which may 	crash   find)
References: <49384250.7080707@t-online.de> <20081205095742.GP12905@calimero.vinschen.de> <4939A9F7.1000400@t-online.de> <20081207171802.GV12905@calimero.vinschen.de> <493C1DF7.6090905@t-online.de> <20081208114800.GW12905@calimero.vinschen.de> <20081208115433.GX12905@calimero.vinschen.de> <49417625.4030209@t-online.de> <20081212152000.GA32492@calimero.vinschen.de>
In-Reply-To: <20081212152000.GA32492@calimero.vinschen.de>
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
X-SW-Source: 2008-q4/txt/msg00030.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Corinna Vinschen on 12/12/2008 8:20 AM:
> 
> Here's a question which occured to me when reading the doc after I had
> applied it.  There's apparently still a problem which is, how do you
> read the default value of a key if a value called '@' exists?  Do you
> have an idea for a simple solution?

"@" for the named value, and "%.val" for the unnamed default?

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAklCh/QACgkQ84KuGfSFAYDg9gCfdlY71wkx9/99qqcJazGrdRTY
n5cAoIvh7tJGy99lOjNecBlT6TkcwXxc
=dJiq
-----END PGP SIGNATURE-----
