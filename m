Return-Path: <cygwin-patches-return-6631-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16202 invoked by alias); 23 Sep 2009 13:37:40 -0000
Received: (qmail 16179 invoked by uid 22791); 23 Sep 2009 13:37:39 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta06.emeryville.ca.mail.comcast.net (HELO QMTA06.emeryville.ca.mail.comcast.net) (76.96.30.56)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 23 Sep 2009 13:37:34 +0000
Received: from OMTA14.emeryville.ca.mail.comcast.net ([76.96.30.60]) 	by QMTA06.emeryville.ca.mail.comcast.net with comcast 	id kCoJ1c0041HpZEsA6DdZp8; Wed, 23 Sep 2009 13:37:33 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA14.emeryville.ca.mail.comcast.net with comcast 	id kDdY1c0040Lg2Gw8aDdZdS; Wed, 23 Sep 2009 13:37:33 +0000
Message-ID: <4ABA248E.70303@byu.net>
Date: Wed, 23 Sep 2009 13:37:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] rename/renameat error
References: <4AA52B5E.8060509@byu.net> <20090907192046.GA12492@calimero.vinschen.de> <loom.20090909T005422-847@post.gmane.org> <loom.20090909T183010-83@post.gmane.org> <loom.20090922T225033-801@post.gmane.org> <4ABA1B92.9080406@byu.net> <20090923133015.GA16976@calimero.vinschen.de>
In-Reply-To: <20090923133015.GA16976@calimero.vinschen.de>
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
X-SW-Source: 2009-q3/txt/msg00085.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Corinna Vinschen on 9/23/2009 7:30 AM:
> Urgh.  I stumbled over the need_directory flag only two days ago.  while
> debugging the symlink errno problem you reported on the list.  CGF is my
> witness.  It's the reason I made the trailing slash change in symlink
> rather than in path_conv::check.  It's quite tricky to keep all possible
> cases working.  Have you tested this change with the entire coreutils
> testsuite?  It seems to be quite thorough.

Still running that, so I'll postpone any commits until further testing
completes.

> This part of the patch looks good to me.  I'm just sweating some
> blood over the need_directory change in path_conv::check due to my
> own experience.  Does it really not break something in the path
> handling?

For the last component, I haven't encountered anything it broke, but
several things (like link("file","missing/")) that were fixed.  But I'm
not completely positive how symlinks to multi-level directories will
behave, so I'm testing it further, and may need yet another tweak.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkq6JI4ACgkQ84KuGfSFAYClyQCeLVjN1DEZKzq2L/+bIU1uj9v1
ZmUAoImr72LAHtcZdNdGjwekBxlhgNlh
=NcT8
-----END PGP SIGNATURE-----
