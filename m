Return-Path: <cygwin-patches-return-4631-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32058 invoked by alias); 26 Mar 2004 20:03:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32023 invoked from network); 26 Mar 2004 20:03:27 -0000
Date: Fri, 26 Mar 2004 20:03:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFA]: Thread safe stdio again
Message-ID: <20040326200326.GA1864@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4054B242.9080606@gmx.net> <20040326065008.GA18127@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040326065008.GA18127@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00121.txt.bz2

On Fri, Mar 26, 2004 at 01:50:08AM -0500, Christopher Faylor wrote:
>On Sun, Mar 14, 2004 at 08:28:02PM +0100, Thomas Pfaff wrote:
>>This time i am using the non portable mutex initializers, therefore
>>moving __sinit is no longer needed. And i added calls to newlibs
>>__fp_lock_all and __fp_unlock_all at fork.
>>
>>2004-03-14 Thomas Pfaff <tpfaff@gmx.net>
>>
>>	* include/cygwin/_types.h: New file.
>>	* include/sys/lock.h: Ditto.
>>	* include/sys/stdio.h: Ditto.
>>	* thread.cc: Include sys/lock.h
>>	(__cygwin_lock_init): New function.
>>	(__cygwin_lock_init_recursive): Ditto.
>>	(__cygwin_lock_fini): Ditto.
>>	(__cygwin_lock_lock): Ditto.
>>	(__cygwin_lock_trylock): Ditto.
>>	(__cygwin_lock_unlock): Ditto.
>>	(pthread::atforkprepare): Lock file pointer before fork.
>>	(pthread::atforkparent): Unlock file pointer after fork.
>>	(pthread::atforkchild): Ditto.
>
>This is ok to check in.  If you hurry, it will show up in 1.5.10.

I've taken the liberty of checking this patch in myself.

FYI,
cgf
