Return-Path: <cygwin-patches-return-5435-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5077 invoked by alias); 6 May 2005 22:29:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5065 invoked from network); 6 May 2005 22:29:38 -0000
Received: from unknown (HELO sccrmhc12.comcast.net) (204.127.202.56)
  by sourceware.org with SMTP; 6 May 2005 22:29:38 -0000
Received: from [192.168.0.100] (c-24-10-254-137.hsd1.ut.comcast.net[24.10.254.137])
          by comcast.net (sccrmhc12) with ESMTP
          id <2005050622293801200skgvae>; Fri, 6 May 2005 22:29:38 +0000
Message-ID: <427BEFD2.7080809@byu.net>
Date: Fri, 06 May 2005 22:29:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch]: mkdir -p and network drives
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q2/txt/msg00031.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> I thought that Eric Blake implied that // *had* to be translated to /,
> as per POSIX.  I wonder how many programs out there translate a
> standalone '//' to '/'.

No, POSIX requires that / be untouched, // be implementation-defined (hint
- - define it on cygwin to stay untouched), and /// translate to /.

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCe+/S84KuGfSFAYARAhb2AKCgqcwkbuXxzLrb2lbrfNk7va3ekgCgkl5U
xCilioyN45W4FmvOYEc0Yno=
=D3xl
-----END PGP SIGNATURE-----
