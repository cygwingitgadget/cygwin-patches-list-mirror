Return-Path: <cygwin-patches-return-3896-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18515 invoked by alias); 25 May 2003 20:11:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18479 invoked from network); 25 May 2003 20:11:00 -0000
Message-ID: <00d501c322f9$ad228e70$6400a8c0@FoxtrotTech0001>
From: "Bill C. Riemers" <cygwin@docbill.net>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
References: <053f01c3216e$947cc570$6400a8c0@FoxtrotTech0001> <20030524175530.GB5604@redhat.com> <20030524202421.GE19367@cygbert.vinschen.de>
Subject: Re: Proposed change for Win9x file permissions...
Date: Sun, 25 May 2003 20:11:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-SW-Source: 2003-q2/txt/msg00123.txt.bz2


> I like the idea as well but wouldn't that eventually cause problems if
> the umask disables the user bits?  I'm a bit concerned about the new
> arriving questions on the cygwin ML due to applications checking these
> bits in combination with clueless users.  It would be better, IMHO, if
> the umask couldn't mask the user bits at all, just the group and other
> bits.

I seriously doubt it would result in serious problem, since the patch only
changes the file permissions that are visible via a "stat()" command, not
the actual permissions that Windows will use.  Case and point:  /cygdrive/c
shows up with perms 000 under cygwin, but there are not any serious
consequences of that bug, other than user confusion.

                                                Bill


