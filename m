Return-Path: <cygwin-patches-return-5978-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7280 invoked by alias); 13 Sep 2006 12:57:10 -0000
Received: (qmail 7268 invoked by uid 22791); 13 Sep 2006 12:57:09 -0000
X-Spam-Check-By: sourceware.org
Received: from sccrmhc15.comcast.net (HELO sccrmhc15.comcast.net) (63.240.77.85)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 13 Sep 2006 12:57:03 +0000
Received: from [192.168.0.101] (c-24-10-241-225.hsd1.ut.comcast.net[24.10.241.225])           by comcast.net (sccrmhc15) with ESMTP           id <2006091312570101500he2mie>; Wed, 13 Sep 2006 12:57:01 +0000
Message-ID: <4508002B.1010905@byu.net>
Date: Wed, 13 Sep 2006 12:57:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.5) Gecko/20060719 Thunderbird/1.5.0.5 Mnenhy/0.7.4.666
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [ANNOUNCEMENT] Updated [experimental]: bash-3.1-7
References: <091220061205.16953.4506A2720005FBDD0000423922135285730A050E040D0C079D0A@comcast.net> <20060912151512.GA19459@trixie.casa.cgf.cx>
In-Reply-To: <20060912151512.GA19459@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00073.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 9/12/2006 9:15 AM:
>> 2006-09-11  Eric Blake  <ebb9@byu.net>
>>
>> 	* cygcheck.cc (main): Restore POSIXLY_CORRECT before displaying
>> 	user's environment.
> 
> Applied.

Not quite.  The changelog changed, but cygcheck.cc is still pending :)
http://cygwin.com/ml/cygwin-cvs/2006-q3/msg00158.html

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFCAAp84KuGfSFAYARAhuzAJ9l1pgZyV6MLVy7jmPoHvy+E8r7NACgh30t
c8l9IU0n9tPaDQ/j2pNPa9o=
=tL6t
-----END PGP SIGNATURE-----
