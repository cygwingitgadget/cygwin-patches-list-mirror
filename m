Return-Path: <cygwin-patches-return-6866-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2954 invoked by alias); 14 Dec 2009 22:19:25 -0000
Received: (qmail 2942 invoked by uid 22791); 14 Dec 2009 22:19:24 -0000
X-SWARE-Spam-Status: No, hits=-3.2 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 14 Dec 2009 22:19:21 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id E06BBC749C; 	Mon, 14 Dec 2009 17:19:19 -0500 (EST)
Received: from web6.messagingengine.com ([10.202.2.215])   by compute1.internal (MEProxy); Mon, 14 Dec 2009 17:19:19 -0500
Received: by web6.messagingengine.com (Postfix, from userid 99) 	id 9437ED1EA2; Mon, 14 Dec 2009 17:19:19 -0500 (EST)
Message-Id: <1260829159.28933.1350092439@webmail.messagingengine.com>
From: "Charles Wilson" <cygwin@cwilson.fastmail.fm>
To: "Thomas Wolff" <towo@towo.net>, cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4B266F9B.6070204@towo.net>
References: <4B266F9B.6070204@towo.net>
Subject: Re: console enhancements: mouse events etc
Date: Mon, 14 Dec 2009 22:19:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00197.txt.bz2

On Mon, 14 Dec 2009 18:02 +0100, "Thomas Wolff" wrote:
> Hi, please excuse some basic questions about CVS best practice:
> 
> Corinna Vinschen wrote:
> > ...  Patches are supposed to be against
> > the latest from CVS.  And it's also not cumbersome, it's rather quite
> > simple.  CVS is doing that for you usually anyway.  If you have a
> > patched CVS source tree, just call `cvs up' and the current HEAD is
> > merged with your local changes.  Given that fhandler_console.cc wasn't
> > changed for a while anyway, you should not see any merge conflicts.
> >   
> In this case yes. In general, if there are merging conflicts, I would 
> have to dig around in reject logs, right? (Or do a fresh checkout and 
> repatch.)
> Also, since with this workflow I'd have the patched latest version only, 
> what is the most convenient way to create the patch diff? Do you 
> maintain two checkouts, an unpatched one to base on?

No, CVS does all this for you.  Take a look here:
http://www.network-theory.co.uk/docs/cvsmanual/Conflictsexample.html for
a walkthrough with examples concerning cvs update and merge resolution.

--
Chuck
