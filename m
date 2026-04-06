Return-Path: <SRS0=q3sT=CF=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id D06734BA2E21
	for <cygwin-patches@cygwin.com>; Mon,  6 Apr 2026 12:19:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D06734BA2E21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D06734BA2E21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1775477953; cv=none;
	b=VC48iU7yjxcCe94Oo9F8l3+A3bKTVD0W+fCP0qha5q+CRpTsgJRgr7ELjv/9OyEes3Lezz2SbojpMcK5APw0b2MZyQtHzbYP3dEZdt9aluLtKPLm6sjsLXLfEdvfeKfXKPnpqURbAL6fxJpVnO0h0uKHVegupqhNfXE9rraWllk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775477953; c=relaxed/simple;
	bh=PJnj2G0Alby7bQhXlYIMUCPKUX+xwa3uCkDuuR8qQTM=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=LbTEF6uCPXn8Ti1nc7YqcwUsnMM4DnpmdqKUCE86W7I7EOXidwiwfOSRLyKfdXuRgriy0+AVJrwf4AYPOiBEkKcmLmi+cFTtwCJBq/+km10qRAJCGX+wKkk01QI1Q4eeuTKMh6M1pvWykxJYd/2cXLgXjKiKRU5sQbAqHELMZXo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D06734BA2E21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=oEx7GX68
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260406121908833.LPVY.127398.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 6 Apr 2026 21:19:08 +0900
Date: Mon, 6 Apr 2026 21:19:07 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Restore nat handles in all PTY-slave
 instances in GDB
Message-Id: <20260406211907.c70b72c0d2f249d382ccfc77@nifty.ne.jp>
In-Reply-To: <c21ace27-1678-9399-6eae-c9cc01831d58@gmx.de>
References: <20260309070645.5931-1-takashi.yano@nifty.ne.jp>
	<c21ace27-1678-9399-6eae-c9cc01831d58@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1775477948;
 bh=r9ZoEjBgz2gWG8Dzqz57tA9I1GfNnzJUhPNhdCknWg4=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=oEx7GX68JZd31oCZEm44r717WkymLtFlapu5B3I/nLSRXy3zOwyQBL76wJLX05c+Q0GqiK1u
 w2NNZTAPCwY+mMBM+BLfibSawrLiBXt/zncouwib0KSXZ8IUxuDhJLt51azrvajF6Lsy7bNf+O
 XGt9LX2xHes8N9LXfKLP4knlKaWvYJ/4TUgBxEXQ2VqyWMBfqoSYtsusrOTFAoxNexuaLb0Fdd
 Q2z165ltN1SoQYiMS4gUUWA6aEDsIXAzzt9pppkHUUqi4ZdftyjzfUtd+GamaDMhjeH8q7+qYr
 WGKRDEELT3P3hxhMD6WPpJSNAGEWNrXpiaGAbhK1Hpzeuexw==
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_SHORT,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for the review.

On Mon, 6 Apr 2026 10:14:10 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Mon, 6 Apr 2026, Takashi Yano wrote:
> 
> > If non-cygwin app is started in GDB and terminating it normally,
> > re-running the non-cygwin app might fail in setup_pseudoconsole().
> > 
> > The error is something like:
> > 
> > $ gdb ./winsleep
> > GNU gdb (GDB) (Cygwin 15.2-1) 15.2
> > Copyright (C) 2024 Free Software Foundation, Inc.
> > License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> > This is free software: you are free to change and redistribute it.
> > There is NO WARRANTY, to the extent permitted by law.
> > Type "show copying" and "show warranty" for details.
> > This GDB was configured as "x86_64-pc-cygwin".
> > Type "show configuration" for configuration details.
> > For bug reporting instructions, please see:
> > <https://www.gnu.org/software/gdb/bugs/>.
> > Find the GDB manual and other documentation resources online at:
> >     <http://www.gnu.org/software/gdb/documentation/>.
> > 
> > For help, type "help".
> > Type "apropos word" to search for commands related to "word"...
> > Reading symbols from ./winsleep...
> > (gdb) run
> > Starting program: /home/yano/winsleep
> > [New Thread 49324.0x14178]
> > [Thread 49324.0x14178 exited with code 0]
> > [Inferior 1 (process 49324) exited normally]
> > (gdb) run
> > Starting program: /home/yano/winsleep
> >       0 [] gdb 294 fhandler_pty_slave::setup_pseudoconsole: CreatePseudoConsole() failed. 00000057 80070057
> >                            [New Thread 86480.0xfd4]
> > [Thread 86480.0xfd4 exited with code 0]
> > [Inferior 1 (process 86480) exited normally]
> > (gdb)
> > 
> > The essential problem is lack of restoring nat handles for *ALL* the
> > PTY-slave instances after closing pseudo console in GDB.
> > 
> > Restoring handles from pseudo console handles to simple pipe handles
> > is not necessary in normal non-cygwin apps because pseudo console is
> > setup in the stub process for the non-cygwin app and the stub process
> > exits after the app is terminated.
> > 
> > However, for GDB, pseudo console is setup in GDB process in hooked
> > CreateProcess() because GDB does not use exec() to run an inferior
> > (debuggee). Therefore, after the inferior exits, nat handle must be
> > restored to simple pipe handles.
> > 
> > The current code restores only handles in the PTY-slave instance
> > that has called fhandler_pty_slave::reset_switch_to_nat_pipe(). If
> > this instance is different from the instance that will setup pseudo
> > console, the nat handles are not restored correctly, then call to
> > CreatePseudoConsole() causes error.
> 
> The fix is correct and the commit message is excellent: detailed repro,
> clear root cause analysis, and a good explanation of why GDB is the
> special case (it sets up the pseudo console in its own process rather
> than in a stub that exits). Thank you!
> 
> Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> One tiny typo in the commit message:
> 
> > To solves this issue, restore nat handles in all the PTY-slave
> > instances to simple pipe handles when the inferior exits with this
> > patch.
> 
> "To solves" should be "To solve". Since you apply your own patches, you
> can fix that before pushing.
> 
> > In addition, if ctty is PTY-slave, fixup handles in it as well.
> 
> One optional suggestion for a possible follow-up: after this patch, the
> handle-replacement pattern (iterate the fd table + ctty, compare old
> handles, set new handles, close old handles) is now duplicated nearly
> verbatim between `reset_switch_to_nat_pipe()` and `setup_pseudoconsole()`.
> The only difference between the two blocks is the two new HANDLE values
> passed in.
> 
> This would be a natural candidate for a small helper method, something
> like this:
> 
> 	void
> 	fhandler_pty_slave::replace_nat_handles (HANDLE new_input, HANDLE new_output)
> 	{
> 	  HANDLE orig_input = get_handle_nat ();
> 	  HANDLE orig_output = get_output_handle_nat ();
> 	  cygheap_fdenum cfd (false);
> 	  while (cfd.next () >= 0)
> 	    if (cfd->get_device () == get_device ())
> 	      {
> 		fhandler_pty_slave *ptys = (fhandler_pty_slave *) (fhandler_base *) cfd;
> 		if (ptys->get_handle_nat () == orig_input)
> 		  ptys->set_handle_nat (new_input);
> 		if (ptys->get_output_handle_nat () == orig_output)
> 		  ptys->set_output_handle_nat (new_output);
> 	      }
> 	  if (cygheap->ctty->get_device () == get_device ())
> 	    {
> 	      fhandler_pty_slave *ptys = (fhandler_pty_slave *) cygheap->ctty;
> 	      if (ptys->get_handle_nat () == orig_input)
> 		ptys->set_handle_nat (new_input);
> 	      if (ptys->get_output_handle_nat () == orig_output)
> 		ptys->set_output_handle_nat (new_output);
> 	    }
> 	  CloseHandle (orig_input);
> 	  CloseHandle (orig_output);
> 	}
> 
> Both call sites would then collapse to a single line each. This is not a
> request to respin; the patch is fine as-is. Just something worth
> considering as a follow-up since the duplication is quite substantial
> (~20 lines).

Great idea! I've adopted your suggestion and pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
