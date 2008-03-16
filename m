Return-Path: <cygwin-patches-return-6301-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13268 invoked by alias); 16 Mar 2008 15:16:24 -0000
Received: (qmail 13258 invoked by uid 22791); 16 Mar 2008 15:16:23 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Sun, 16 Mar 2008 15:16:00 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id A7ACA6D430A; Sun, 16 Mar 2008 16:15:57 +0100 (CET)
Date: Sun, 16 Mar 2008 15:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] normalize_posix_path and c:/foo/bar
Message-ID: <20080316151557.GC29148@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47DCCAFF.36C14CB@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47DCCAFF.36C14CB@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00075.txt.bz2

On Mar 16 00:23, Brian Dessent wrote:
> There's a small buglet in normalize_posix_path in that it doesn't see
> c:/foo/bar type paths as being win32 and so it treats them as a relative
> path and prepends cwd.

Actually that was intended, but unfortunately the current path handling
deliberately creates DOS paths with slashes (in find_exec) right now,
so that doesn't work ATM.

> that exposed this was insight failing to load because some of the tcl
> parts use win32 paths, but really a reduced testcase is simply
> open("c:/cygwin/bin/ls.exe", O_RDONLY) = ENOENT.

Yeah, I *wished* that c:foo and c:/foo are treated as relative posix
paths, and the above open is just not doing the right thing, but...
see above.  I fixed that already in CVS two days ago:
http://cygwin.com/ml/cygwin-cvs/2008-q1/msg00121.html


Thanks anyway,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
