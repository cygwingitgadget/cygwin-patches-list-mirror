Return-Path: <cygwin-patches-return-5968-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21794 invoked by alias); 29 Aug 2006 15:38:33 -0000
Received: (qmail 21747 invoked by uid 22791); 29 Aug 2006 15:38:32 -0000
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (66.187.233.31)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 29 Aug 2006 15:38:28 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254]) 	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k7TFcRZI009186; 	Tue, 29 Aug 2006 11:38:27 -0400
Received: from post-office.corp.redhat.com (post-office.corp.redhat.com [172.16.52.227]) 	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k7TFcRiA016379; 	Tue, 29 Aug 2006 11:38:27 -0400
Received: from greed.delorie.com (dj.cipe.redhat.com [10.0.0.222]) 	by post-office.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k7TFcNl18631; 	Tue, 29 Aug 2006 11:38:23 -0400
Received: from greed.delorie.com (greed.delorie.com [127.0.0.1]) 	by greed.delorie.com (8.13.1/8.13.1) with ESMTP id k7TFcKOb027473; 	Tue, 29 Aug 2006 11:38:20 -0400
Received: (from dj@localhost) 	by greed.delorie.com (8.13.1/8.13.1/Submit) id k7TFcFXh027470; 	Tue, 29 Aug 2006 11:38:15 -0400
Date: Tue, 29 Aug 2006 15:38:00 -0000
Message-Id: <200608291538.k7TFcFXh027470@greed.delorie.com>
From: DJ Delorie <dj@redhat.com>
To: drow@false.org
CC: gcc-patches@gcc.gnu.org, gdb-patches@sourceware.org,         binutils@sourceware.org, mingw-patches@lists.sourceforge.net,         cygwin-patches@cygwin.com
In-reply-to: <20060829153206.GA19040@nevyn.them.org> (message from Daniel 	Jacobowitz on Tue, 29 Aug 2006 11:32:06 -0400)
Subject: Re: [RFC] Simplify MinGW canadian crosses
References: <20060829114107.GA17951@calimero.vinschen.de> <20060829124525.GA13245@nevyn.them.org> <200608291459.k7TExRDT026512@greed.delorie.com> <20060829150948.GA18308@nevyn.them.org> <200608291523.k7TFNUR6027243@greed.delorie.com> <20060829153206.GA19040@nevyn.them.org>
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00063.txt.bz2


I'll let Corinna answer herself, but I don't think we're trying to do
anything differently than what we already do for Cygwin.
