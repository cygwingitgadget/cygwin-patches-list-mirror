Return-Path: <cygwin-patches-return-4571-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9076 invoked by alias); 11 Feb 2004 15:01:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9066 invoked from network); 11 Feb 2004 15:01:04 -0000
Date: Wed, 11 Feb 2004 15:01:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Thread safe stdio
Message-ID: <20040211150103.GA15035@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4029FF39.9080806@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4029FF39.9080806@gmx.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00061.txt.bz2

On Wed, Feb 11, 2004 at 11:08:57AM +0100, Thomas Pfaff wrote:
>The __sinit call must be done after malloc is initialized, otherwise the 
>mutex creation will fail.

I am not comfortable with this part of the patch.  I moved the __sinit
call where I did for a reason.  It needed to be called earlier in the
process.  I'm also somewhat uncomfortable with using malloc for this
purpose in general.  It seems like a heavyweight solution to something
that could be solved with either a muto or a critical section.

>2004-02-11 Thomas Pfaff <tpfaff@gmx.net>
>
>	* include/cygwin/_types.h: New file.
>	* include/sys/lock.h: Ditto.
>	* include/sys/stdio.h: Ditto.
>	* dcrt0.cc (dll_crt0_1): Add __sinit call after malloc
>	initialization.
>	(_dll_crt0): Remove __sinit call.
>	* thread.cc: Include sys/lock.h
>	(__cygwin_lock_init): New function.
>	(__cygwin_lock_init_recursive): Ditto.
>	(__cygwin_lock_fini): Ditto.
>	(__cygwin_lock_lock): Ditto.
>	(__cygwin_lock_unlock): Ditto.
