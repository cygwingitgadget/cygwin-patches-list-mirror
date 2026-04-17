Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 6459E4BA2E0A; Fri, 17 Apr 2026 17:44:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6459E4BA2E0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1776447860;
	bh=nF7k/Rm40riEi7aTAz7nQxYWl/RGVbyqCebK5Wy2T9w=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=U0b2GDSw/V9TN9DgSlrxRsYUcBhE4jPRpVCHENZLZyyrpbNIAhbeXghiEmb0Xsx/z
	 o+zg9YySvGxsNrOxeF3Be6RKqx6X25EGeGUx0U+lW0eaBuRrSlls0S/Sv8ak3fk7KO
	 e7t0hkLTZYgZ4+SmgPsbNwn1Xgo4VpS6SRu3gsm8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2C388A80C19; Fri, 17 Apr 2026 19:44:17 +0200 (CEST)
Date: Fri, 17 Apr 2026 19:44:17 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5] Cygwin: pty: Make Ctrl-C work for non-cygwin app in
 GDB
Message-ID: <aeJxcbslixrH-kiq@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260417104847.10575-1-takashi.yano@nifty.ne.jp>
 <aeIhYHuCfXlCwSom@calimero.vinschen.de>
 <20260418022737.578e70457e1ef08af1ce47c0@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260418022737.578e70457e1ef08af1ce47c0@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Apr 18 02:27, Takashi Yano wrote:
> On Fri, 17 Apr 2026 14:02:40 +0200 Corinna Vinschen wrote:
> > Btw., for v2, v3, etc it would be helpful for reviewers to see
> > a short note what has changed in the comment section following the 
> > three dashes.  E.g.
> > 
> >   v1: add foo
> >   [...]
> >   v4: replace foo with bar
> 
> Thanks for the advice. Like this?
> ---
>  winsup/cygwin/exceptions.cc          |  4 +--
>  winsup/cygwin/fhandler/pty.cc        |  7 ++--
>  winsup/cygwin/fhandler/termios.cc    | 54 +++++++++++-----------------
>  winsup/cygwin/local_includes/pinfo.h | 42 ++++++++++++++++++++--
>  winsup/cygwin/tty.cc                 |  7 ++--
>  5 files changed, 69 insertions(+), 45 deletions(-)
> 
> v2: Introduce inline functions such as is_foreground_special_process ()
>     to clarify the code intent.
> v3: Move the inline functions into pinfo.h. In addition, drop the
>     marker: _pinfo::dwProcessId == _pinfo::exec_dwProcessId that
>     means the process is a non-cygwin debuggee, and introduce
>     h_debuggee_maybe which holds process handler of the debuggee
>     instead.
> v4: Use wpid_debuggee_maybe instead of h_debuggee_maybe, because
>     the process handle is valid only in the process that opens it.
> v5: Use pi->dwProcessId instead of GetProcessId (h_gdb_inferior).
>     Introduce is_cygwin_inferior_being_debugged (). Refactor the
>     'if' clauses in process_sigs(). In addition, fix the similar
>     issue that the cygwin debuggee under strace cannot be terminated
>     by Ctrl-C (change in exceptions.cc and line_edit()).

Yes, like this. But most of the time, a oneliner is enough, just to tell
the reviewer what to look out for.  And of course, I didn't do this in
the past either, but I found it pretty helpful, so I intend to use this
myself in future.


Corinna
