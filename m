Return-Path: <cygwin-patches-return-6789-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30995 invoked by alias); 18 Oct 2009 19:07:42 -0000
Received: (qmail 30984 invoked by uid 22791); 18 Oct 2009 19:07:42 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 18 Oct 2009 19:07:38 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id F25EBACA93 	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2009 15:07:36 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute1.internal (MEProxy); Sun, 18 Oct 2009 15:07:36 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 8BEC64EB29; 	Sun, 18 Oct 2009 15:07:36 -0400 (EDT)
Message-ID: <4ADB6773.3090605@cwilson.fastmail.fm>
Date: Sun, 18 Oct 2009 19:07:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Honor DESTDIR in w32api and mingw
References: <4AD78C5B.2080107@cwilson.fastmail.fm> <4AD7C107.6000803@byu.net> <4AD7D356.8030703@cwilson.fastmail.fm> <4AD8DE16.3030506@cwilson.fastmail.fm> <20091018084824.GA25560@calimero.vinschen.de> <4ADB22B8.5060108@cwilson.fastmail.fm> <4ADB3D80.4050108@gmail.com> <4ADB542B.6020701@cwilson.fastmail.fm> <4ADB5F8A.7080902@gmail.com>
In-Reply-To: <4ADB5F8A.7080902@gmail.com>
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
X-SW-Source: 2009-q4/txt/msg00120.txt.bz2

Dave Korn wrote:
>   Yes, I think everything that lives in the /src repository should consider
> itself obliged to adhere to the common conventions.  If they really find it
> onerous,

Remember, that was just my impression given the current discussion, some
previous ones like the old 2006 argument about Corinna's patches to
"Simplify MinGW canadian crosses", and snarky comments in the repo like
the one I quoted.  Nobody has actually come out and SAID such a thing.

> it occurs to me that they could always move mingw sideways - to a
> different repository still on the sourceware.org cvs server

Meh. There's been continual talk about such reorganization:

http://osdir.com/ml/gnu.mingw.devel/2006-03/msg00013.html
http://www.nabble.com/Putting-GCC-machinery-into-MinGW-CVS-td24187752.html

but little has come of that. Most recently, the mingw website/wiki was
moved to a new provider (not sf), although the lists, CVS (for all but
mingw-runtime and w32api), and file distribution remain at sf -- with
plans to move the file distribution to the new provider eventually, as well.

But AFAIK there are no *current* plans to (a) move the
non-mingwrt/w32api CVS anywhere, or (b) move the lists, or (c) rearrange
the mingwrt/w32api stuff now under src/.

> - and we could
> import a mildly-forked version of their packages into winsup just like we
> would with any other external library.  That ought to be able to accommodate
> everyone's wishes, no?

Well, except for poor Chris Sutcliff. It'd double his workload.

--
Chuck
