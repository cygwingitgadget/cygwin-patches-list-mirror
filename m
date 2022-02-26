Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id 901293858D1E
 for <cygwin-patches@cygwin.com>; Sat, 26 Feb 2022 13:06:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 901293858D1E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 21QD6S9t003818
 for <cygwin-patches@cygwin.com>; Sat, 26 Feb 2022 22:06:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 21QD6S9t003818
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645880789;
 bh=jxVEsqX5abImqGgtDxDtLM0eLphzivIquR+g9LsSKXc=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=JR5doJZdwDI3AyMEJfpdQUuI2XtN/5w0ehCSad4/buO2KsFT7KOh3KyYIY04NB+DT
 EMcSwW+iJtS0VXCWwMP2TfJvD4ZEqMGfL5PWzMqVoUzyT/jV58ueOMNbd1FRRXwVpz
 BhSNDftXurtPcvckM8biiv491rfjqBs4GXe7mxibHLzFI4NVjth/p5nGei9oL+weUZ
 RxM9wo/A+eaqhyRLrLwxEer5Du+r1NnYXRXRjm5MSEYr8hB+pSgI/ZkezF0lTsyRKm
 2Xq9JmqujO1e/yXjoPdMvT1+RsXteNvICR+lyvX/S54xnzW/Tgd7J6L4j0zsTB4GiR
 9CFSpRH4CogtA==
X-Nifty-SrcIP: [119.150.36.16]
Date: Sat, 26 Feb 2022 22:06:31 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty, console: Refactor the code processing
 special keys.
Message-Id: <20220226220631.23a9a4f27655a2b86f177e1a@nifty.ne.jp>
In-Reply-To: <nycvar.QRO.7.76.6.2202242023050.11118@tvgsbejvaqbjf.bet>
References: <20220220111510.978-1-takashi.yano@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2202242023050.11118@tvgsbejvaqbjf.bet>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 26 Feb 2022 13:06:51 -0000

Hi Johannes,

Thank you for the comment.

On Fri, 25 Feb 2022 14:37:59 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Sun, 20 Feb 2022, Takashi Yano wrote:
> 
> > - This patch commonize the code which processes special keys in pty
> >   and console to improve maintanancibility.
> 
> I very much welcome the direction. Thank you for working on this!
> 
> > As a result, some small bugs have been fixed.
> 
> Whenever I read something like this in commit messages, I wish for more
> details. Could you describe those bugs, and how exactly they were fixed?

The bugs I noticed were as follows.

1. In console, even with NOFLSH flag, type ahead input was flushed
   by Ctrl-C. This has been fixed by adding following code to
   fhandler_console::cons_master_thread().

> +		case not_signalled_but_done:
>  		  processed = true;
> +		  ttyp->output_stopped = false;
> +		  if (ti.c_lflag & NOFLSH)
> +		    goto remove_record;
> +		  goto skip_writeback;

2. If output of non-cygwin app and input of cygwin app are connected
   by a pipe, we needed press Ctrl-C twice to terminate them when the
   cygwin app does not read stdin at the moment. This issue has been
   fixed by the code added to exceptions.cc you asked next.

Other bugs might exist, but did not check old behaviour in detail.
The priority was to make sure that the new code works without problems.
I have checked the behaviour of the current code using more than 200
test cases.

> > diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> > index a914110fe..356d69d6a 100644
> > --- a/winsup/cygwin/exceptions.cc
> > +++ b/winsup/cygwin/exceptions.cc
> > @@ -1147,6 +1147,19 @@ ctrl_c_handler (DWORD type)
> >      return TRUE;
> >
> >    tty_min *t = cygwin_shared->tty.get_cttyp ();
> > +
> > +  /* If process group leader is non-cygwin process or not exist,
> > +     send signal to myself. */
> > +  pinfo pi (t->getpgid ());
> > +  if ((!pi || (pi->process_state & PID_NOTCYGWIN))
> > +      && (!have_execed || have_execed_cygwin)
> > +      && t->getpgid () == myself->pgid
> > +      && type == CTRL_C_EVENT)
> > +    {
> > +      t->output_stopped = false;
> > +      sig_send(myself, SIGINT);
> > +    }
> > +
> 
> From the commit message, I would have expected this patch to be
> essentially a clean and obvious refactoring of the existing code.
> 
> However, I cannot find any removed code in the diff that would explain
> this newly-added code.

Sorry, but this commit was not pure refactoring as a result. Some
small issues, such as the issues above, are fixed at the same time.

On the other hand, other bugs might be introduced accidentally.
As expected, some additional patches have been needed.
https://cygwin.com/pipermail/cygwin-patches/2022q1/011789.html
https://cygwin.com/pipermail/cygwin-patches/2022q1/011790.html

> When I see something like this in patches, I usually take to the commit
> message to explain what is going on. But in this case, I am left even more
> puzzled than before.
> 
> > diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
> > index 4e86ab58a..3e0d7d5a6 100644
> > --- a/winsup/cygwin/fhandler.h
> > +++ b/winsup/cygwin/fhandler.h
> > @@ -1901,6 +1902,13 @@ class fhandler_termios: public fhandler_base
> >    virtual void release_input_mutex_if_necessary (void) {};
> >    virtual void discard_input () {};
> >
> > +  enum process_sig_state {
> > +    signalled,
> > +    not_signalled,
> > +    not_signalled_but_done,
> > +    not_signalled_with_cyg_reader
> > +  };
> > +
> 
> My hope for this refactor is that it will get much easier to understand
> for developers who are unfamiliar with the pseudo console code.
> 
> In this instance, I am wishing for a code comment above the `enum` that
> explains its role, and the meaning of the four values. In particular the
> difference of the last two compared to the second is quite lost on me.
> > @@ -1943,6 +1954,8 @@ class fhandler_termios: public fhandler_base
> >    }
> >    static bool path_iscygexec_a (LPCSTR n, LPSTR c);
> >    static bool path_iscygexec_w (LPCWSTR n, LPWSTR c);
> > +  virtual bool is_pty_master_with_pcon () { return false; }
> 
> It would probably make sense to document the role of a pty master with
> respect to pseudo consoles somewhere. If no better location can be found,
> then it would probably make most sense to add a comment above this new
> line.

I will add some comments to the source files.

> > +  virtual void cleanup_before_exit () {}
> >  };
> >
> >  enum ansi_intensity
> > diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
> > index 50f350c49..475c1acdb 100644
> > --- a/winsup/cygwin/fhandler_console.cc
> > +++ b/winsup/cygwin/fhandler_console.cc
> > @@ -188,13 +188,28 @@ cons_master_thread (VOID *arg)
> >  void
> >  fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
> >  {
> > +  termios &ti = ttyp->ti;
> >    DWORD output_stopped_at = 0;
> >    while (con.owner == myself->pid)
> >      {
> >        DWORD total_read, n, i;
> >        INPUT_RECORD input_rec[INREC_SIZE];
> >
> > -      if (con.disable_master_thread)
> > +      bool nat_fg = false;
> > +      bool nat_child_fg = false;
> > +      winpids pids ((DWORD) 0);
> > +      for (unsigned i = 0; i < pids.npids; i++)
> > +	{
> > +	  _pinfo *pi = pids[i];
> > +	  if (pi && pi->ctty == ttyp->ntty && pi->pgid == ttyp->getpgid ()
> > +	      && (pi->process_state & PID_NOTCYGWIN)
> > +	      && !(pi->process_state & PID_NEW_PG))
> > +	    nat_fg = true;
> > +	  if (pi && pi->ctty == ttyp->ntty && pi->pgid == ttyp->getpgid ()
> > +	      && !(pi->process_state & PID_CYGPARENT))
> > +	    nat_child_fg = true;
> > +	}
> > +      if (nat_fg && !nat_child_fg)
> 
> It is unclear to me whether this code fixes a bug, or refactors other
> code, or both. Not to forget: it is still unclear to be what `nat` should
> mean, which suggests to me that either the name could be improved or a
> code comment would be in order.

Disabling cons_master_thread() is necessary when non-cygwin app
is started because ReadConsoleInputW() call in cons_master_thread()
may conflict with console read in the non-cygwin app. Previously,
this was done by con.disable_master_thread flag. With this patch,
above code tries to determine that without that flag. (However, this
does not make much sense on second thought, so was reverted in the
current git head.)

'nat' is used as shortened word of 'native' (which means non-cygwin,
native windows). It comes from the discussion below.
https://cygwin.com/pipermail/cygwin-patches/2021q1/011271.html

> Since it is already unclear to me what fundamental goal this part has (as
> well as much of the remainder of this quite large patch), I fear that even
> for a motivated reviewer like myself, it is rather difficult to provide
> any useful review.
> 
> Therefore I think I need to stop here, as much as I want to help.
> 
> Maybe this code could be augmented with more comments? And maybe the patch
> could be split up further for clarity? I have a sense that much of it is
> actually refactoring that could be done incrementally, with an explanation
> in the commit message that makes things utterly clear, and other parts are
> bug fixes where the bug in question could be described, and the approach
> taken to fix it (as well as other approaches that were considered and a
> discussion why those approaches were rejected).

I will try to add more descriptive comments to the code.

> Thank you for working on this, I appreciate it a lot,
> Johannes

Thanks for the comment, again.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
