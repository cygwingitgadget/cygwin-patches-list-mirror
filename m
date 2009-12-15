Return-Path: <cygwin-patches-return-6868-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32029 invoked by alias); 15 Dec 2009 13:05:41 -0000
Received: (qmail 32019 invoked by uid 22791); 15 Dec 2009 13:05:40 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta13.emeryville.ca.mail.comcast.net (HELO QMTA13.emeryville.ca.mail.comcast.net) (76.96.27.243)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 15 Dec 2009 13:05:36 +0000
Received: from OMTA17.emeryville.ca.mail.comcast.net ([76.96.30.73]) 	by QMTA13.emeryville.ca.mail.comcast.net with comcast 	id HR311d0021afHeLADR5cMT; Tue, 15 Dec 2009 13:05:36 +0000
Received: from [192.168.0.104] ([24.10.247.15]) 	by OMTA17.emeryville.ca.mail.comcast.net with comcast 	id HR5a1d0090Lg2Gw8dR5bPB; Tue, 15 Dec 2009 13:05:35 +0000
Message-ID: <4B27899E.1030201@byu.net>
Date: Tue, 15 Dec 2009 13:05:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: VCS and changelogs (was: console enhancements: mouse events etc)
References: <4AF73FEC.2050300@towo.net>  <20091119152632.GJ29173@calimero.vinschen.de>  <20091119160054.GB8185@ednor.casa.cgf.cx>  <20091119160948.GA1883@calimero.vinschen.de>  <4B1C04D1.8010707@towo.net>  <20091214114715.GG8059@calimero.vinschen.de>  <4B266528.7090006@towo.net>  <20091214162953.GO8059@calimero.vinschen.de>  <4B266F9B.6070204@towo.net>  <20091214171323.GS8059@calimero.vinschen.de> <20091215130036.GA19394@calimero.vinschen.de>
In-Reply-To: <20091215130036.GA19394@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00199.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Corinna Vinschen on 12/15/2009 6:00 AM:
> Btw., please don't add the ChangeLog entries to the patch, just add
> them as plain text to your mail.  Patches to ChangeLogs almost always
> don't apply cleanly.

Unless we were to move to git, in which case the git-merge-changelog
program from gnulib almost always merges ChangeLog entries exactly how I
was expecting.  Maybe I should go ahead and ITP that as a standalone program.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAksniZ4ACgkQ84KuGfSFAYDy6wCaAw3CTIRjwBOcXT2x6Y/OylI2
nS8AniXX3OGekL81a/4hSMxE1qprWC6q
=Upk6
-----END PGP SIGNATURE-----
