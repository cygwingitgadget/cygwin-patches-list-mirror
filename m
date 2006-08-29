Return-Path: <cygwin-patches-return-5965-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12798 invoked by alias); 29 Aug 2006 14:59:42 -0000
Received: (qmail 12785 invoked by uid 22791); 29 Aug 2006 14:59:41 -0000
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (66.187.233.31)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 29 Aug 2006 14:59:38 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254]) 	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k7TExaX5022187; 	Tue, 29 Aug 2006 10:59:36 -0400
Received: from post-office.corp.redhat.com (post-office.corp.redhat.com [172.16.52.227]) 	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k7TExapu001540; 	Tue, 29 Aug 2006 10:59:36 -0400
Received: from greed.delorie.com (dj.cipe.redhat.com [10.0.0.222]) 	by post-office.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k7TExXl12168; 	Tue, 29 Aug 2006 10:59:33 -0400
Received: from greed.delorie.com (greed.delorie.com [127.0.0.1]) 	by greed.delorie.com (8.13.1/8.13.1) with ESMTP id k7TExWYa026515; 	Tue, 29 Aug 2006 10:59:32 -0400
Received: (from dj@localhost) 	by greed.delorie.com (8.13.1/8.13.1/Submit) id k7TExRDT026512; 	Tue, 29 Aug 2006 10:59:27 -0400
Date: Tue, 29 Aug 2006 14:59:00 -0000
Message-Id: <200608291459.k7TExRDT026512@greed.delorie.com>
From: DJ Delorie <dj@redhat.com>
To: drow@false.org
CC: gcc-patches@gcc.gnu.org, gdb-patches@sourceware.org,         binutils@sourceware.org, mingw-patches@lists.sourceforge.net,         cygwin-patches@cygwin.com
In-reply-to: <20060829124525.GA13245@nevyn.them.org> (message from Daniel 	Jacobowitz on Tue, 29 Aug 2006 08:45:25 -0400)
Subject: Re: [RFC] Simplify MinGW canadian crosses
References: <20060829114107.GA17951@calimero.vinschen.de> <20060829124525.GA13245@nevyn.them.org>
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00060.txt.bz2


> If you want to build some code that runs on mingw, I don't think
> that having mingw tools installed is an unreasonable requirement.

This is how you *get* mingw tools installed.  The same logic that
gives you a canadian (worst case) also gives you host-x-host.
