Return-Path: <cygwin-patches-return-5829-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1070 invoked by alias); 20 Apr 2006 01:55:59 -0000
Received: (qmail 1043 invoked by uid 22791); 20 Apr 2006 01:55:58 -0000
X-Spam-Check-By: sourceware.org
Received: from mtiwmhc11.worldnet.att.net (HELO mtiwmhc11.worldnet.att.net) (204.127.131.115)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 20 Apr 2006 01:55:57 +0000
Received: from dfw5rb41 (h-66-167-81-67.chcgilgm.dynamic.covad.net[66.167.81.67])           by worldnet.att.net (mtiwmhc11) with SMTP           id <20060420015555111004vsbue>; Thu, 20 Apr 2006 01:55:55 +0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@cygwin.com>
Cc: <cygwin@cygwin.com>
Subject: [NON-WHINE] RE: mkstemp vs. text mode
Date: Thu, 20 Apr 2006 01:55:00 -0000
Message-ID: <001701c6641d$8e1e2fd0$020aa8c0@DFW5RB41>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <001701c66280$bf5cbe20$020aa8c0@DFW5RB41>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00017.txt.bz2

> From: Gary R. Van Sickle
> 
> > From: Gary R. Van Sickle
> > 
> > > From: Christopher Faylor
> > [snip]
> > > Yes, I think it makes sense to open temp files in binary
> > but I'll bet
> > > that someone is relying on textmode behavior.
> > 
> > I'll see that bet and raise you; I'll bet this results in massive 
> > problems.
> > 

Welp, looks like I (probably) lose that hand (happily).  Using:

CYGWIN_NT-5.1 DFW5RB41 1.5.20s(0.155/4/2) 20060418 12:31:05 i686 Cygwin

with a /tmp mounted as text mode works fine for a configure, build, and
install of wxWindows.  The configure does most of the temp file
machinations, with about 2000 add, modify, and remove events in the /tmp
directory, as reported by a program I have for monitoring such things.

-- 
Gary R. Van Sickle
