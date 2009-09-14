Return-Path: <cygwin-patches-return-6622-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26043 invoked by alias); 14 Sep 2009 23:02:14 -0000
Received: (qmail 25885 invoked by uid 22791); 14 Sep 2009 23:02:13 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 14 Sep 2009 23:02:08 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 6C5E46A38A; 	Mon, 14 Sep 2009 19:02:06 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute1.internal (MEProxy); Mon, 14 Sep 2009 19:02:06 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id DA0BD6ADB5; 	Mon, 14 Sep 2009 19:02:05 -0400 (EDT)
Message-ID: <4AAECB58.2030401@cwilson.fastmail.fm>
Date: Mon, 14 Sep 2009 23:02:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: Dave Korn <dave.korn.cygwin@googlemail.com>
CC: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Define _TIMEVAL_DEFINED consistently whenever defining  timeval.
References: <4AADAF9C.2000601@gmail.com>
In-Reply-To: <4AADAF9C.2000601@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00076.txt.bz2

Dave Korn wrote:
> Granted that the whole _TIMEVAL_DEFINED/__USE_W32_SOCKETS thing is basically
> an ugly and undesirable hack, but until we have a plan to fix the whole
> tcl/tk/expect/dejagnu/gdb/insight combo (as well as gnat), I figure we have to
> live with it, and so it should at least be correct consistent and complete.

From this thread:
  http://www.cygwin.com/ml/cygwin/2008-08/msg00089.html
I thought most people either were in favor of, or at least not opposed
to, "fixing" the */tk/*/insight issue by switching to an X-based tk. It
was just waiting on enough cgf-tuits (and, perhaps, the long-delayed gdb
7.0 release and/or Insight 7.0).

FWIW, I recently had to build my own tcl/tk and python (with pytk)
because I needed the Python Imaging Library but I couldn't get it to
work properly with cygwin-standard python and tk.  (That combo used to
work, but it was a very old version of python, and cygwin-1.5. No longer.)

Anway, tcl-8.5.6 and tk-8.5.6 built easily on a bog-standard cygwin-1.7
system using the cygports derived from the Cygwin Ports project. I
couldn't just use the Cygwin Ports binaries because IIRC they depend on
other Cygwin Ports packages not available in the normal cygwin
distro...and I didn't want to pull in more than I needed.

'Course, this broke my insight since I didn't bother to rebuild gdb.
But, if it would help, I can post these cygport files (which may differ
very slightly from the Cygwin Ports-supplied and -dependent ones).

While doing that, I was curious to see what else this change would break
(e.g. what else relies on tcltk):

suite3270/tcl3270
brltty/tcl-brlapi
parrot/parrot-languages
db/db*/tcl-db*
git/gitk
git/git-gui
expect
WordNet
ruby
catgets
gdb (e.g. insight)
python

which, honestly, isn't very much. I'd be concerned about all those
tcl-db${old_version} packages -- but it looks like there are no
in-distro users of them.  That leaves gdb, ruby, python, git, and parrot
-- all of which have active maintainers.  Plus suite3270 and brltty,
which I'm not sure about.

--
Chuck
