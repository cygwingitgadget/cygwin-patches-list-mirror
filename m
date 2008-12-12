Return-Path: <cygwin-patches-return-6388-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16877 invoked by alias); 12 Dec 2008 16:18:36 -0000
Received: (qmail 16865 invoked by uid 22791); 12 Dec 2008 16:18:35 -0000
X-Spam-Check-By: sourceware.org
Received: from qmta05.emeryville.ca.mail.comcast.net (HELO QMTA05.emeryville.ca.mail.comcast.net) (76.96.30.48)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 12 Dec 2008 16:17:34 +0000
Received: from OMTA11.emeryville.ca.mail.comcast.net ([76.96.30.36]) 	by QMTA05.emeryville.ca.mail.comcast.net with comcast 	id qCPw1a0060mlR8UA5GHXrk; Fri, 12 Dec 2008 16:17:31 +0000
Received: from [192.168.0.101] ([67.166.125.73]) 	by OMTA11.emeryville.ca.mail.comcast.net with comcast 	id qGHV1a00F1b8C2B8XGHWY9; Fri, 12 Dec 2008 16:17:30 +0000
Message-ID: <49428EA4.5090402@byu.net>
Date: Fri, 12 Dec 2008 16:18:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.18) Gecko/20081105 Thunderbird/2.0.0.18 Mnenhy/0.7.5.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Avoid duplicate names in /proc/registry (which may 	crash    find)
References: <49384250.7080707@t-online.de> <20081205095742.GP12905@calimero.vinschen.de> <4939A9F7.1000400@t-online.de> <20081207171802.GV12905@calimero.vinschen.de> <493C1DF7.6090905@t-online.de> <20081208114800.GW12905@calimero.vinschen.de> <20081208115433.GX12905@calimero.vinschen.de> <49417625.4030209@t-online.de> <20081212152000.GA32492@calimero.vinschen.de> <494287F4.2080505@byu.net> <20081212161304.GK32197@calimero.vinschen.de>
In-Reply-To: <20081212161304.GK32197@calimero.vinschen.de>
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
X-SW-Source: 2008-q4/txt/msg00032.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Corinna Vinschen on 12/12/2008 9:13 AM:
>> "@" for the named value, and "%.val" for the unnamed default?
> 
> Backward compatibility would ask for sticking to @ for the default
> value.  Actually there could be a key and a value called @ so you
> have three @ items. :-P

If there is no key or value @, then use @ for the default for
compatibility.  If there is either a key or a value named @, then use:

@ - named key
@%val - named value
%val - default value

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAklCjqQACgkQ84KuGfSFAYA9MACgkdlmxZOiNCMfe700l0KdUf+X
DnEAnRGxplpN33GTEzKHqrx4uufIeIhG
=fpmG
-----END PGP SIGNATURE-----
