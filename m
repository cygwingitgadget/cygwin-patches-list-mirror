Return-Path: <cygwin-patches-return-6278-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15726 invoked by alias); 10 Mar 2008 00:30:42 -0000
Received: (qmail 15697 invoked by uid 22791); 10 Mar 2008 00:30:29 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 10 Mar 2008 00:30:12 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JYVu6-0006Yv-SL 	for cygwin-patches@cygwin.com; Mon, 10 Mar 2008 00:30:11 +0000
Message-ID: <47D48113.814F024C@dessent.net>
Date: Mon, 10 Mar 2008 00:30:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de> <20080309143819.GB8192@ednor.casa.cgf.cx> <20080309151440.GB18407@calimero.vinschen.de> <20080309162800.GB13754@ednor.casa.cgf.cx> <47D4266A.CE301EDE@dessent.net> <20080309195509.GD18407@calimero.vinschen.de>
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
X-SW-Source: 2008-q1/txt/msg00052.txt.bz2

Corinna Vinschen wrote:

> The problem is that the cwd is stored as UNICODE_STRING with a
> statically allocated buffer in the user parameter block.  The
> MaximumLength is set to 520.  SetCurrentDirectory refuses to take paths
> longer than that.  In theory it would be possible to define a longer cwd
> by defining a new buffer in the cwd's UNICODE_STRING.  But I never tried
> that.  I don't really know if that's possible and what happens if you
> call CreateProcess or, FWIW, any Win32 file access function after doing
> that.  Nobody keeps us from trying, but I have this gut feeling that
> different NT versions will show different behaviour...

How does this fit in with the practice of maintaining our own Cygwin CWD
state separate from the Win32 CWD so that unlink(".") and the like can
succeed?  Or is that precisely how we are able to support a CWD >= 260? 
If it is the case that we can only support a CWD >= 260 by faking it,
i.e. not trying to sync the Win32 CWD to the actual long CWD, then it
seems we are limited to two choices for how to deal with a long CWD in a
non-Cygwin process: a) not supported, b) supported only through some
special hook (such as cgf's idea of handle inheritance of the Cygwin CWD
handle) or through relying on the shell to set PWD.

Brian
