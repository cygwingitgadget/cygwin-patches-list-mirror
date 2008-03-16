Return-Path: <cygwin-patches-return-6306-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30814 invoked by alias); 16 Mar 2008 15:52:07 -0000
Received: (qmail 30800 invoked by uid 22791); 16 Mar 2008 15:52:05 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 16 Mar 2008 15:51:47 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1Jav9G-00014b-50 	for cygwin-patches@cygwin.com; Sun, 16 Mar 2008 15:51:46 +0000
Message-ID: <47DD4212.86606B25@dessent.net>
Date: Sun, 16 Mar 2008 15:52:00 -0000
From: Brian Dessent <brian@dessent.net>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] normalize_posix_path and c:/foo/bar
References: <47DCCAFF.36C14CB@dessent.net> <20080316151557.GC29148@calimero.vinschen.de>
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
X-SW-Source: 2008-q1/txt/msg00080.txt.bz2

Corinna Vinschen wrote:

> Actually that was intended, but unfortunately the current path handling
> deliberately creates DOS paths with slashes (in find_exec) right now,
> so that doesn't work ATM.

I guess what I don't understand is how it's both possible for
open("c:/foo/bar.exe") to succeed and for this code to treat it as a
relative posix path instead of absolute win32.  Or is that the point,
that forward-slash win32 paths are intended not to work?  That I think
is going to be quite a lot of affected code unfortunately... as I said
the only real reason I went looking here is I updated my tree to current
CVS and insight stopped functioning.

Brian
