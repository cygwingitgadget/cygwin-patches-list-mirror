Return-Path: <cygwin-patches-return-5476-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23865 invoked by alias); 19 May 2005 12:24:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22477 invoked from network); 19 May 2005 12:23:38 -0000
Received: from unknown (HELO rwcrmhc14.comcast.net) (216.148.227.89)
  by sourceware.org with SMTP; 19 May 2005 12:23:38 -0000
Received: from [192.168.0.100] (c-24-10-254-137.hsd1.ut.comcast.net[24.10.254.137])
          by comcast.net (rwcrmhc14) with ESMTP
          id <2005051912233701400c6pe7e>; Thu, 19 May 2005 12:23:37 +0000
Message-ID: <428C8547.1070504@byu.net>
Date: Thu, 19 May 2005 12:24:00 -0000
From: Eric Blake <ebb9@byu.net>
Reply-To:  cygwin@cygwin.com
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
MIME-Version: 1.0
To: Vance Turner <vance.turner@sbcglobal.net>
CC:  cygwin@cygwin.com,  cygwin-patches@cygwin.com
Subject: Re: [Patch]: mkdir -p and network drives
References: <200505190506.j4J56RqA011354@stennis.byu.edu>
In-Reply-To: <200505190506.j4J56RqA011354@stennis.byu.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q2/txt/msg00072.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Wrong list.  Redirecting.

According to Vance Turner on 5/18/2005 11:06 PM:
> I usually don't write you guys, I follow the thread to see how development
> is going.
> 
> Just a note. The ls command is't quite right.
> 
>  Ls -lRC wil not recursively list the files and directories in verbose mode.
> The l flag seems to be ignored.

Per POSIX,
http://www.opengroup.org/onlinepubs/009695399/utilities/ls.html, -C and -l
are mutually exclusive, and the last one specified wins.  You are right
that the -l flag is ignored in your example, but it is not a bug.

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCjIVH84KuGfSFAYARAs53AJ9yVbtYsTOixPy09xEmMoJnA4InDQCg2XqZ
UVT2dXJWEg5kLgrnZ22cqm4=
=b5ty
-----END PGP SIGNATURE-----
