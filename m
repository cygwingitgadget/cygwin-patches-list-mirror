Return-Path: <cygwin-patches-return-6645-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2835 invoked by alias); 25 Sep 2009 13:45:22 -0000
Received: (qmail 2814 invoked by uid 22791); 25 Sep 2009 13:45:21 -0000
X-SWARE-Spam-Status: No, hits=-1.5 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_52,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta12.emeryville.ca.mail.comcast.net (HELO QMTA12.emeryville.ca.mail.comcast.net) (76.96.27.227)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 25 Sep 2009 13:45:16 +0000
Received: from OMTA03.emeryville.ca.mail.comcast.net ([76.96.30.27]) 	by QMTA12.emeryville.ca.mail.comcast.net with comcast 	id kzz41c0020b6N64AC1lGPc; Fri, 25 Sep 2009 13:45:16 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA03.emeryville.ca.mail.comcast.net with comcast 	id l1lE1c0030Lg2Gw8P1lF5p; Fri, 25 Sep 2009 13:45:16 +0000
Message-ID: <4ABCC962.6040803@byu.net>
Date: Fri, 25 Sep 2009 13:45:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] bugs in faccessat
References: <loom.20090903T175736-252@post.gmane.org> <4ABC3A64.1030609@byu.net> <20090925081109.GA26348@calimero.vinschen.de>
In-Reply-To: <20090925081109.GA26348@calimero.vinschen.de>
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
X-SW-Source: 2009-q3/txt/msg00099.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Corinna Vinschen on 9/25/2009 2:11 AM:
>> +int __stdcall check_file_access (path_conv &, int, bool effective = true);
>> +int __stdcall check_registry_access (HANDLE, int, bool effective = true);
> 
> Can you please drop the default values for the effective flag here
> and add the value explicitely where necessary?  AFAICS, that only
> affects two calls in spawn.cc which should rather get an explicit
> "true".

Confirmed that those were the only two other clients, and done.  I ran out
of time for now, so it will be later today before I can polish and commit
the remaining patches (hopefully by then cgf chimes in on the
link/mkdir/rename enhancements).  I also plan on mentioning the fixed
semantics of access() as part of documenting the new euidaccess()
interface in new-features.sgml.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkq8yWIACgkQ84KuGfSFAYC0PQCbB9D8fRZli1z/JLzY2VWrwLCs
Ag0AnjSmaEXxVmAFeNElArLYXUw97U5m
=GKVl
-----END PGP SIGNATURE-----
