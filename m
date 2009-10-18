Return-Path: <cygwin-patches-return-6786-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2223 invoked by alias); 18 Oct 2009 17:45:28 -0000
Received: (qmail 2213 invoked by uid 22791); 18 Oct 2009 17:45:27 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 18 Oct 2009 17:45:21 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 89C6EB2B1D 	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2009 13:45:19 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute2.internal (MEProxy); Sun, 18 Oct 2009 13:45:19 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 1FC209F72; 	Sun, 18 Oct 2009 13:45:19 -0400 (EDT)
Message-ID: <4ADB542B.6020701@cwilson.fastmail.fm>
Date: Sun, 18 Oct 2009 17:45:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Honor DESTDIR in w32api and mingw
References: <4AD78C5B.2080107@cwilson.fastmail.fm> <4AD7C107.6000803@byu.net> <4AD7D356.8030703@cwilson.fastmail.fm> <4AD8DE16.3030506@cwilson.fastmail.fm> <20091018084824.GA25560@calimero.vinschen.de> <4ADB22B8.5060108@cwilson.fastmail.fm> <4ADB3D80.4050108@gmail.com>
In-Reply-To: <4ADB3D80.4050108@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00117.txt.bz2

Dave Korn wrote:
>   Well, I can think of a possible counter-proposal: how about a patch that
> adds DESTDIR in the normal manner, but only on platforms that support DESTDIR
> correctly?  This could be done by testing the --host setting in the Makefile

Don't you mean the --build setting?  If I'm using a cross-compiler (such
as, say, gcc3 -mno-cygwin on cygwin, or i686-pc-mingw32-gcc anywhere),
then so long as my 'make' and 'sh' use posixy paths, I should be ok with
DESTDIR, right?

Unless I've set --prefix to "C:/foo".  Which, in a cross environment,
PROBABLY means that 'make install' won't work anyway even without
DESTDIR, absent significant help from wine.

So, maybe you DO mean --host, as that's the only case where you might
use an X: path in $(prefix).

> and either warning, erroring, or just silently overriding the definition of
> DESTDIR to empty on platforms that don't can't or won't honour it.  There
> shouldn't be anything particularly controversial about the concept of using a
> feature on some platforms where it's implemented and not on others where it isn't.

The main problem is that the mingw developers seem to be, from my
admittedly limited and personal perspective, rather dissatisfied with
the location of mingw-runtime and w32api within the src/ build tree.

This positioning means that odd things happen to $CC and $CC_FOR_TARGET
during the build, when -- in a different world -- you COULD just
consider "mingw-runtime" to be a standalone project like, say, zlib,
where no such shenanigans are necessary.

This leads to attitudes such as "so what if /src/*/ supports DESTDIR. We
don't and here's why."  Never mind that this refusal /breaks/ DESTDIR
support for the entire combined tree, if you're so audacious as to TRY
to use DESTDIR from a super-directory of src/winsup/mingw/.

Also (from mingw/Makefile):
CC := gcc -L/usr/src/devel/kernel/src-build/i686-pc-cygwin/winsup
-L/usr/src/devel/kernel/src-build/i686-pc-cygwin/winsup/cygwin
-L/usr/src/devel/kernel/src-build/i686-pc-cygwin/winsup/w32api/lib
-isystem /usr/src/devel/kernel/src/winsup/include -isystem
/usr/src/devel/kernel/src/winsup/cygwin/include -isystem
/usr/src/devel/kernel/src/winsup/w32api/include
-B/usr/src/devel/kernel/src-build/i686-pc-cygwin/newlib/ -isystem
/usr/src/devel/kernel/src-build/i686-pc-cygwin/newlib/targ-include
-isystem /usr/src/devel/kernel/src/newlib/libc/include

[[[ this wierdness is /NECESSARY/ to build cygwin from scratch -- that
is, the other bits of winsup/*/.  Without it, winsup/cygwin won't build.
 And, since CC is automatically passed down via MAKEFLAGS, it gets
handed down to the subconfigures like winsup/mingw/. However, to build
the mingw bits, you don't want the cygwin -isystem headers...so:

ifneq (,$(findstring cygwin,$(target_alias)))
override CC := ${filter-out -L% -B%,${shell echo $(CC) | sed -e
's%\(-isystem\|-iwithprefixbefore\)  *[^ ]*\( \|$$\)% %g'}}
endif

[[[ but I cheated. Somebody in the mingw project added this editorial to
Makefile.in: ]]]

#
# FIXME: What is the purpose of this hideous kludge?
#
# Again, we have a dubious use of `target_alias'.  Worse, `CC'
# should have been appropriately set by the configure script; to
# mess with it, in this fashion, should neither be necessary,
# nor accepted.
#

To me, this shows that the mingw developers -- and I even consider
myself a member of that team, tho in only a limited capacity -- have
/issues/ with any accommodations necessary to enable building "their"
bits as part of the combined winsup/ (or even src/) tree.

DESTDIR is just the latest example.

--
Chuck



