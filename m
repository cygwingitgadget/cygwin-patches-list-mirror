Return-Path: <cygwin-patches-return-5966-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6487 invoked by alias); 29 Aug 2006 15:23:47 -0000
Received: (qmail 6475 invoked by uid 22791); 29 Aug 2006 15:23:46 -0000
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (66.187.233.31)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 29 Aug 2006 15:23:43 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254]) 	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k7TFNf3w000988; 	Tue, 29 Aug 2006 11:23:41 -0400
Received: from post-office.corp.redhat.com (post-office.corp.redhat.com [172.16.52.227]) 	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k7TFNfZw010518; 	Tue, 29 Aug 2006 11:23:41 -0400
Received: from greed.delorie.com (dj.cipe.redhat.com [10.0.0.222]) 	by post-office.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k7TFNbl16121; 	Tue, 29 Aug 2006 11:23:38 -0400
Received: from greed.delorie.com (greed.delorie.com [127.0.0.1]) 	by greed.delorie.com (8.13.1/8.13.1) with ESMTP id k7TFNZoe027246; 	Tue, 29 Aug 2006 11:23:35 -0400
Received: (from dj@localhost) 	by greed.delorie.com (8.13.1/8.13.1/Submit) id k7TFNUR6027243; 	Tue, 29 Aug 2006 11:23:30 -0400
Date: Tue, 29 Aug 2006 15:23:00 -0000
Message-Id: <200608291523.k7TFNUR6027243@greed.delorie.com>
From: DJ Delorie <dj@redhat.com>
To: drow@false.org
CC: gcc-patches@gcc.gnu.org, gdb-patches@sourceware.org,         binutils@sourceware.org, mingw-patches@lists.sourceforge.net,         cygwin-patches@cygwin.com
In-reply-to: <20060829150948.GA18308@nevyn.them.org> (message from Daniel 	Jacobowitz on Tue, 29 Aug 2006 11:09:48 -0400)
Subject: Re: [RFC] Simplify MinGW canadian crosses
References: <20060829114107.GA17951@calimero.vinschen.de> <20060829124525.GA13245@nevyn.them.org> <200608291459.k7TExRDT026512@greed.delorie.com> <20060829150948.GA18308@nevyn.them.org>
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00061.txt.bz2


> Corinna is trying to generate --host=i686-mingw32 tools, with a
> different --target.  This requires at least a --target=i686-mingw32
> compiler coming from elsewhere.  That compiler can build the
> --host=i686-mingw32 libraries, and usually should.

Yes.  So?  We build that compiler from the same tree (as a simple
cross), so it's still the same problem.  We still have to build those
libraries somehow, we still need to have them in source control, etc.
Our build farm likes to see a monolithic source tree, and we already
support building cygwin out of that tree, building mingw out of it is
a minor change.

(actually, we build four compilers out of that tree:
	linux-linux-linux
	linux-linux-mingw
	linux-linux-arm
	linux-mingw-arm)
