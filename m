Return-Path: <cygwin-patches-return-2646-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14837 invoked by alias); 14 Jul 2002 16:17:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14823 invoked from network); 14 Jul 2002 16:17:38 -0000
Date: Sun, 14 Jul 2002 09:17:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Protect handle issue-ettes
Message-ID: <20020714161750.GA26964@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <002a01c22b2f$07f9bda0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002a01c22b2f$07f9bda0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00094.txt.bz2

On Sun, Jul 14, 2002 at 01:07:29PM +0100, Conrad Scott wrote:
>I've attached one patch to the protect handle mechanism: a
>forgotten "hl = hl->next" after find_handle() in setclexec().
>This cured a seg. fault I was getting in the cygwin_daemon branch
>when running make.

Thanks.  Applied.

>I'm still not clear why the cygserver code disturbs this mechanism
>so much: I wasn't getting the seg. fault on the HEAD version.
>I've now added calls to ProtectHandle into the cygserver code, so
>this doesn't seem to be anything to do with their (previous)
>omission.
>
>Other than that, I'm still getting quite a bit of noise, all of
>which (that I've bothered to trace through) is due to handles that
>are non-inheritable (i.e. held in a NO_COPY variable and created
>with, e.g., sec_none_nih).  AFAICT, these need to be removed from
>the protected handle list on fork, not just on fork-exec.  I've
>attached a sample of the "noise" to the end of this message.
>
>Such handles include:
>
>exceptions.cc:
>    title_mutex
>
>sigproc.cc:
>    sigcatch_nonmain
>    sigcatch_main
>    sigcomplete_nonmain
>    sigcomplete_main

None of those are marked inheritable.

>I don't see any mechanism to do this in the code at present and
>I've not the time to go into this any further just now, but I hope
>that helps.

Huh?  The code in dll_crt0_1 is supposed to be called on a fork or an
exec.  That's why I renamed it to debug_fixup_after_fork_exec.
As far as I can tell it *is* called on a fork.  strace confirms
that.

cgf
