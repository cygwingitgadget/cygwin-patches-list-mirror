From: Brian Keener <bkeener@thesoftwaresource.com>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: updated: Categories and basic dependency handling for setup
Date: Wed, 13 Jun 2001 17:02:00 -0000
Message-id: <VA.0000080d.024962fa@thesoftwaresource.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF7A00@itdomain002.itdomain.net.au> <20010613162448.M1144@cygbert.vinschen.de> <006c01c0f457$59d7f070$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00293.html

Robert Collins wrote:
> I don't know where the version 2.4.PRE-STABLE is coming from, I'll look
> into that.
>
I've run into similar when working on some of my various changes for setup.  
Usually ends up as a bad pointer into the package structure and/or a bad loop 
resulting in the same.

bk

