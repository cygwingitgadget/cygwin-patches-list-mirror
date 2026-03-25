Return-Path: <SRS0=haOa=BZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id 13D4B4BB58FC
	for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 12:58:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 13D4B4BB58FC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 13D4B4BB58FC
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774443534; cv=none;
	b=V4mBxzpPXKxNJdTmLBI46wxo/mErgogj0Hch6P7g/Q8fd82RccNWMvX06S+4xDJO9ZPpELG05KMmSnOZaCaPdIw3DOp79iHyLiV44X+kkNYoyRl1ftf702BR2SEVtTTz6mo1hdbyI1ZffI6fpdaTBbEREzw3p0yn1b65ErGcCM8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774443534; c=relaxed/simple;
	bh=6TRMHkJFel+xrnAy4NlV+ZGgZYJz6J7ciHaBqlveQoA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=PVvOftpL4znBle4Maql6r5OC7EWBoyEJ+nnwElXYs5CFJ9IOafSragSD+M6MdxOutwNiRdVuPvhwIvr4u+ohzIu0x4F/yxdmB62j2kT2WBE+m1uQIMRfxkfwg5g33X4zqjN+4XCUsS6tEggJx8Og2kp2yiHIfRm+wthstBxujaw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 13D4B4BB58FC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=iIu4ha/f
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260325125852203.SALG.58584.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 21:58:52 +0900
Date: Wed, 25 Mar 2026 21:58:50 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 2/3] Cygwin: pty: Update workaround for rlwrap for
 pseudo console
Message-Id: <20260325215850.b2f34a98e5d592ae7dd3607d@nifty.ne.jp>
In-Reply-To: <8d775de9-2a03-1e0d-67fc-5c62bb05007d@gmx.de>
References: <20260312113923.1528-1-takashi.yano@nifty.ne.jp>
	<20260312113923.1528-3-takashi.yano@nifty.ne.jp>
	<8d775de9-2a03-1e0d-67fc-5c62bb05007d@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774443532;
 bh=aMLBqFZqtSqA1wFCys6i8TkNcywzPpT2zzhPnnJxJkY=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=iIu4ha/ftFKB+lOcHTBwHou/DKIgP4q0NL40Cl3G9fQlV9oYsmCe2IIBewsR5fX22V9BNwbf
 Ltn9nmxJgojO7wSclbdaIrUsPF5VECVAcK+3aUYkNzStOVBbbfcAd9JdqIDztkMIUmab3KOyfr
 kCECD1NO6qx79ZXNRHUKLo033yl4b74QAihXw1wNIEtGregieY5Uz9iM1kdDhouO32UXwm10X1
 Ah0zK18LVCxxPugsRf2BT7SU6qiQ7Kbrgx8yIa5MfplETm0yEEVNe/XLnUI/kSly3nADRbjLen
 OF6c4rmu84/5LoBdgQqOQsvrhAxWJlO6zTTgQy+dT3XhYC0g==
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Mon, 16 Mar 2026 16:40:01 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Thu, 12 Mar 2026, Takashi Yano wrote:
> 
> > In tcgetattr(), the conventional workaround for rlwrap v0.40 or later
> > is not work as expected with OpenConsole.exe for some reason. This
> > patch update the workaround so that it works even with OpenConsole.exe
> > by rebuilding tcgetattr responce reffering the corrent console mode
> > instead of just overriding it depends on pseudo console setting up
> > state. The patch also handle tcsetattr() so that the change is applied
> > to the console mode.
> 
> Calling `attach_console_temporarily()` in every `tcgetattr`/`tcsetattr`
> call might incur a prohibitively large performance penalty: This involves
> `FreeConsole()` + `AttachConsole()` + `FreeConsole()` + `AttachConsole()`.
> That's four kernel calls plus the mutex. `tcgetattr` can be called
> frequently (rlwrap polls it). This is expensive and introduces latency in
> a path that was previously just a memory read.

Hmm, maybe. I mesured the latency of FreeConsole()/ AttachConsole().
The result is 170 micro sec. in my environment. If an application calls
tcsetattr()/tcgetattr() 100 times in a second, it consume 34 msec every
one second. This may not be acceptable.

> 
> > 
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >  winsup/cygwin/fhandler/pty.cc | 148 ++++++++++++++++++++++++++++++----
> >  1 file changed, 131 insertions(+), 17 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index 85d29f1cc..bd5c24625 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -1764,18 +1764,37 @@ fhandler_pty_slave::tcgetattr (struct termios *t)
> >  {
> >    *t = get_ttyp ()->ti;
> >  
> > -  /* Workaround for rlwrap */
> > -  cygheap_fdenum cfd (false);
> > -  while (cfd.next () >= 0)
> > -    if (cfd->get_major () == DEV_PTYM_MAJOR
> > -	&& cfd->get_minor () == get_minor ())
> > -      {
> > -	if (get_ttyp ()->pcon_start)
> > -	  t->c_lflag &= ~(ICANON | ECHO);
> > -	if (get_ttyp ()->pcon_activated)
> > -	  t->c_iflag &= ~ICRNL;
> > -	break;
> > -      }
> 
> Hmm.  The code now no longer checks whether the master fd is open: The old
> code iterated cygheap_fdenum to verify the caller actually has the master
> side open. The new code skips this check entirely. The commit message
> doesn't mention this behavioral change.

Just a result of lazy.

> > +  /* Conventional workaround for rlwrap v0.40 or later is not work
> > +     as expected with OpenConsole.exe for some reason. The following
> 
> I'll never be a fan of reading "for some reason" in a patch that changes
> behavior in a fundamental way. If such changes (which typically come with
> a high risk of unintended side effects) are made, I'd rather want to have
> a really good reason for that. In this instance, I have concerns that the
> underlying problem might not be understood well enough, and hence the
> chosen approach might need to be improved to fully address the bug.
> 
> Could you please describe the full picture here?

I looked into more closely, and found that fixing up tcgetattr()
is also necessary for pcon_start_csi_c case. And it is enough for
rlwrap and full translation between terminal attributes and console
mode is not necessary. New patch series drops this patch.

> > +     workaround is perhaps better solution even for apps other than
> > +     rlwrap under pcon_activated mode. */
> > +  if (get_ttyp ()->pcon_activated
> > +      && (to_be_read_from_nat_pipe ()
> > +	  || get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
> > +    {
> > +      DWORD mode = ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT;
> > +      t->c_lflag &= ~(ICANON | ECHO);
> > +      t->c_iflag &= ~ICRNL;
> 
> Hmm. What if the application specifically set ICRNL? This unconditional
> clearing 

Without this, rlwrap cmd.exe does not accept CR (Enter key).

> > +      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> > +				       get_ttyp ()->nat_pipe_owner_pid);
> 
> This call could fail.
> 
> > +      HANDLE h_pcon_in;
> > +      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> > +		       GetCurrentProcess (), &h_pcon_in,
> > +		       0, FALSE, DUPLICATE_SAME_ACCESS);
> 
> if this `DuplicateHandle()` call fails, `h_pcon_in` is uninitialized, yet
> it is happily used in the `GetConsoleMode()` call below.
> 
> And since this is a near-duplicate of the other `tcgetattr()` method and
> both `tcsetattr()` methods touched by this patch, this problem is
> multiplied by 4.



> > +      DWORD resume_pid =
> > +	attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
> > +      if (!GetConsoleMode (h_pcon_in, &mode)
> > +	  && (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
> > +	mode = 0;
> > +      resume_from_temporarily_attach (resume_pid);
> > +      CloseHandle (h_pcon_in);
> > +      CloseHandle (pcon_owner);
> > +
> > +      if (mode & ENABLE_LINE_INPUT)
> > +	t->c_lflag |= ICANON;
> > +      if (mode & ENABLE_ECHO_INPUT)
> > +	t->c_lflag |= ECHO;
> > +    }
> >    return 0;
> >  }
> >  
> > @@ -1784,6 +1803,40 @@ fhandler_pty_slave::tcsetattr (int, const struct termios *t)
> >  {
> >    acquire_output_mutex (mutex_timeout);
> >    get_ttyp ()->ti = *t;
> > +
> > +  if (get_ttyp ()->pcon_activated
> > +      && (to_be_read_from_nat_pipe ()
> > +	  || get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
> > +    {
> > +      DWORD mode;
> > +      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> > +				       get_ttyp ()->nat_pipe_owner_pid);
> > +      HANDLE h_pcon_in;
> > +      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> > +		       GetCurrentProcess (), &h_pcon_in,
> > +		       0, FALSE, DUPLICATE_SAME_ACCESS);
> > +      DWORD resume_pid =
> > +	attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
> > +      if (!GetConsoleMode (h_pcon_in, &mode)
> > +	  && (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
> > +	mode = 0;
> > +
> > +      mode &= ~(ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT
> > +		| ENABLE_PROCESSED_INPUT);
> > +      if (t->c_lflag & ICANON)
> > +	mode |= ENABLE_LINE_INPUT;
> > +      if (t->c_lflag & ECHO)
> > +	mode |= ENABLE_ECHO_INPUT;
> > +      if (t->c_lflag & ISIG)
> > +	mode |= ENABLE_PROCESSED_INPUT;
> > +      SetConsoleMode (h_pcon_in, mode);
> 
> Wouldn't this potentially wreak havoc with native Win32 apps that are
> attached to this Console? They typically do not handle it well when their
> Console changes under their feet.

This is for rlwrap with non-cygwin app. But, yes, you are right.
Changing console mode by rlwrap does not have meaning for non-cygwin
app such as cmd.exe...

> > +
> > +      resume_from_temporarily_attach (resume_pid);
> > +      CloseHandle (h_pcon_in);
> > +      CloseHandle (pcon_owner);
> > +
> > +      get_ttyp ()->ti.c_iflag |= ICRNL;
> > +    }
> 
> This code seems to be a near duplicate of the master side, same goes for
> the `tcgetattr()` methods. This is not only hard to review, in my
> experience it _will_ lead to maintenance nightmares.
> 
> Couldn't this be refactored to not only be much easier to maintain and
> reduce redundant code dramatically, but at the same time also improve
> readability and the ease of review in a quite meaningful way? I mean, the
> `c_lflag` handling is _already_ duplicated across
> `fhandler_pty_slave::setup_pseudoconsole()` and
> `fhandler_console::set_input_mode()`... I'd rather see this copy/edit
> pattern reduced than increased.

Thanks. Though I'll withdraw this patch, I agree with that your point is
important indeed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
