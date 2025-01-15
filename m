Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7EBAF3851A89; Wed, 15 Jan 2025 16:59:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7EBAF3851A89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736960380;
	bh=g7AZSlRivmmz473MgtQ510JyQBvda1XrZFnT7Nt38VA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ZKMtssf9i4UoDJeEwKJ2hpeEXIZqhIfUj/jWj/gay2xmqkdWdpHW2bxaQkBXLwMfJ
	 CXq4ZWrCh3oUZqoEZrwxdCVjJCc0TyKyvLf8zDmDTAg4j5Bpm+2VZsOpyPJ6BCzlUT
	 NxrgMfH4t11a/+3XP88H8xcUxnG0CxsXDDeSAFgs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CF0F9A80D2F; Wed, 15 Jan 2025 17:59:37 +0100 (CET)
Date: Wed, 15 Jan 2025 17:59:37 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: mmap: use 64K pages for bookkeeping
Message-ID: <Z4fpeXlmjOVu-u1A@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <92eb753b-055a-4171-a1d0-56bc8572d174@cornell.edu>
 <Z4TzRLHGdvcxfT_y@calimero.vinschen.de>
 <20250115221730.4b1ce8becbd1060ffb0373da@nifty.ne.jp>
 <8f026ac1-d628-4723-983f-953275ea4329@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f026ac1-d628-4723-983f-953275ea4329@cornell.edu>
List-Id: <cygwin-patches.cygwin.com>

On Jan 15 11:36, Ken Brown wrote:
> On 1/15/2025 8:17 AM, Takashi Yano wrote:
> > With this patch, gdb no longer works in my environment:
> > 
> > $ gdb
> > Pre-boot error; key: system-error, args: ("load-thunk-from-memory" "~A" ("Invalid argument") (22))
> > 
> > Fatal signal: Aborted
> > ----- Backtrace -----
> > ---------------------
> > A fatal error internal to GDB has been detected, further
> > debugging is not possible.  GDB will now terminate.
> > 
> > This is a bug, please report it.  For instructions, see:
> > <https://www.gnu.org/software/gdb/bugs/>.
> > 
> > Abort
> > $
> > 
> > Any idea?
> 
> I ran gdb under strace and saw the following:
> 
> 
>   125 6200747 [main] gdb 25844 mprotect: mprotect (addr: 0x6FFFFFA50000, len
> 7584, prot 0x3)
>   122 6200869 [main] gdb 25844 seterrno_from_win_error:
> ../../../../winsup/cygwin/mm/mmap.cc:1290 windows error 487
>   141 6201010 [main] gdb 25844 geterrno_from_win_error: windows error 487 ==
> errno 22
>   133 6201143 [main] gdb 25844 mprotect: -1 = mprotect (), errno 22
> [...]
>    65 6237537 [main] gdb 25844 mmap_record::unmap_pages: VirtualProtect in
> unmap_pages () failed, Win32 error 487
> 
> Windows error 487 is ERROR_INVALID_ADDRESS.
> 
> I'll try to figure out what's going on.  In the meantime, I've reverted the
> commit.

Ouch.  It looks like we can't go to 64K bookkeeping.  Windows files are
not length-aligned to 64K allocation granularity, but to 4K pagesize.
Thus, if we align the length to 64K in mprotect or
mmap_record::unmap_pages, it tries to access the unallocatd area from
the EOF page to the last page in the 64K area, which, obviously fails.

D'oh.

Sorry, I could have thought about this earlier :(


Corinna
