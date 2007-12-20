Return-Path: <cygwin-patches-return-6200-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17519 invoked by alias); 20 Dec 2007 16:00:38 -0000
Received: (qmail 17509 invoked by uid 22791); 20 Dec 2007 16:00:37 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 20 Dec 2007 16:00:28 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1J5Now-0005Jq-Bv 	for cygwin-patches@cygwin.com; Thu, 20 Dec 2007 16:00:26 +0000
Message-ID: <476A9193.A5F1B905@dessent.net>
Date: Thu, 20 Dec 2007 16:00:00 -0000
From: Brian Dessent <brian@dessent.net>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] un-NT-ify cygcheck (was: cygwin 1.5.25-7: cygcheck does   not   work?)
References: <836045.82708.qm@web33207.mail.mud.yahoo.com> <476A726D.50100@byu.net> <476A78EF.2322FB0A@dessent.net> <476A8729.5C05B169@dessent.net>
Content-Type: text/plain; charset=us-ascii
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
X-SW-Source: 2007-q4/txt/msg00052.txt.bz2

Brian Dessent wrote:

> ... but sadly a similar cleanup is
> still required for cygpath as well if we are to support 9x/ME out of the
> 1.5 branch. In that case I suppose you could just revert cygpath.cc to
> an older revision before the native APIs were added.

Er, nevermind.  I was accidently looking at HEAD, but the native stuff
in cygpath is not on the branch.  So I think only the bloda.cc change is
necessary to restore 9x/ME capability on the branch.

Brian
