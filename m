Return-Path: <cygwin-patches-return-4659-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2942 invoked by alias); 10 Apr 2004 00:53:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2776 invoked from network); 10 Apr 2004 00:53:24 -0000
Date: Sat, 10 Apr 2004 00:53:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] thread self handling revised
Message-ID: <20040410005322.GA3972@coe>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <14630.1080813525@www21.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14630.1080813525@www21.gmx.net>
User-Agent: Mutt/1.4.1i
X-OriginalArrivalTime: 10 Apr 2004 00:52:16.0645 (UTC) FILETIME=[11D70B50:01C41E96]
X-SW-Source: 2004-q2/txt/msg00011.txt.bz2

On Thu, Apr 01, 2004 at 11:58:45AM +0200, Thomas Pfaff wrote:
>Rethinking the changes to pthread::init_mainthread i came to the conclusion
>that this stuff can be made simpler and cleaner.
>The changes to init_maintread are reverted, the thread self pointer for an
>unknown thread is now set in pthread::self.
>
>2004-04-01  Thomas Pfaff  <tpfaff@gmx.net>
>
>	* thread.h (pthread::init_mainthread): Remove parameter forked.
>	(pthread::set_tls_self_pointer): New static function.
>	* thread.cc (MTinterface::fixup_after_fork): Change call to
>	pthread::init_mainthread.
>	(pthread::init_mainthread): Remove parameter forked. Simplify
>	thread self pointer handling.
>	(pthread::self): Set thread self pointer to null_pthread if
>	thread has not been initialized.
>	(pthread::set_tls_self_pointer): New static function.

Applied.  Sorry for the delay.

Thanks,
cgf
