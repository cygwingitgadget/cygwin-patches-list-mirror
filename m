Return-Path: <SRS0=i6Vi=F7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 4AFC04BB5888
	for <cygwin-patches@cygwin.com>; Thu,  6 Aug 2026 16:25:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4AFC04BB5888
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4AFC04BB5888
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1786033562; cv=none;
	b=RYhpP9jrBn/kg17F986Nc5VEH6ziuQOXKoC/5fj4GKIxWI5Ej3HNfewb6qUmguu3/lyZAxsE16prAyifz7VNzEq+QB/KqsHnzNBMuowegAeImyGdO/mfn0XASlBsbkGN4Rp1B4uln2/NEd7Ixw2GvJjHnXaRxCUghjldFTtFMrY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1786033562; c=relaxed/simple;
	bh=B59nnbERau8cOQR4NrkYBYLpccIx/ZCfY1NPuHrWGd0=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=n2EMWDREDCSlQrB9EhphTKwuApHUUmhqGBCucSDsPGcb9868v7kutk1Q7nd4LYZKpPQrH3u3olBvnC1DCH1ugLOVDE9RzpdUYQu70Bsfb4WoVxRq/9FP6YixLz/GLAzoENS5bUiAJsuuHvN/8W0je1BTpqCYifdnHn9gyRu3ClM=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=D5O6tX3N
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4AFC04BB5888
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=D5O6tX3N
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260806162552721.KZIV.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 7 Aug 2026 01:25:52 +0900
Date: Fri, 7 Aug 2026 01:25:51 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix regression in console input
Message-Id: <20260807012551.c176e66e6288f13ad597d9a2@nifty.ne.jp>
In-Reply-To: <9a1a2379-361e-86b4-b310-d162af82a417@gmx.de>
References: <20260803025011.5289-1-takashi.yano@nifty.ne.jp>
	<9a1a2379-361e-86b4-b310-d162af82a417@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1786033552;
 bh=tIP4qTO+ZWEL5t22bgEvt3opLgp91nQ4oE2PwUDXpKY=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=D5O6tX3NE9SxfD8fhp7gqkHsUlXhQwD38T/lmvP+VV0oGIoyVYMQnbNJftG/NbVUXiRaqeog
 vikjEzg4NfvjRTNw01sUs6/Ed8E+JsEEYmZoFl1cjbz85igicspVlL43diGRzNg1lblZ2d8lM+
 +CniyocQHb+L6L25bPPMlwjDFH1LB5WVmAneSttwKBC9An68MWI60mEqmGd9SGb2xIZ5Yab+ur
 dUqXnZBNOANTILxPka3Mf+9w67izZExvY7tZ3KM4iq6LzVj//Xff8VYXAOA8Rqp54pu/Oq//62
 pxVzyfBN3wuy9Al3ZTnmb9wGwy2qrYQdwABlJct0AcA+BvTg==
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for reviewing!

On Thu, 6 Aug 2026 16:21:49 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Mon, 3 Aug 2026, Takashi Yano wrote:
> 
> > The commit fac73911f5a0 ("Cygwin: console: Fix typeahead input for
> > bash") introduced a bug where select() consumes some input chars in
> > canonical mode, preventing read() from reading them. This is due to
> > discarding input events when process_input_message() does not return
> > `input_ok` even if it is called from select().
> > The basic idea of that commit was making process_input_message()
> > not to store processed chars into readahead buffer. This was not
> > correct because the key input events ware processed twice, once by
> > select() and again by read(). Thus even if that commit worked as
> > intended, the side effect such as input echo would be applied twice.
> > 
> > With this patch, process_input_message() handles only the minimum
> > necessary of input events in both cases, those processed by select()
> > and those processed by read(). To achive this behaviour, the function
> > returns without processing when `input_ready` is already satisfied,
> > or after it has processed the specified number of chars.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2026-August/259915.html
> > Reported-by: Steven Doerfler <sgd-cygwinlist@lugaru.com>
> > Fixes: fac73911f5a0 ("Cygwin: console: Fix typeahead input for bash")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Revewed-by:
> 
> This explanation, as well as the diff, look sound to me.
> 
> You may want to fix the typos "Revewed" -> "Reviewed", "ware" -> "were"
> and "achive" -> "achieve", but those are tiny nits.
> 
> You could also fix the pre-existing typo in the comment "recored" ->
> "recorded" while at it, but again, that's just a nit.
> 
> > ---
> >  winsup/cygwin/fhandler/console.cc | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index 0219a37ef..3904fbd57 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -1406,7 +1406,6 @@ fhandler_console::input_states
> >  fhandler_console::process_input_message (size_t len)
> >  {
> >    char tmp[60];
> > -  size_t num_chars = 0;
> >  
> >    if (!shared_console_info[unit])
> >      return input_error;
> > @@ -1429,6 +1428,10 @@ fhandler_console::process_input_message (size_t len)
> >        return input_error;
> >      }
> >  
> > +  /* len == 0 if called from select.cc:peek_console() */
> > +  if (input_ready && (len == 0 || (get_ttyp ()->ti.c_lflag & ICANON)))
> > +    return input_ok;
> 
> It is worth pointing out that while this `input_ready &&` part looks
> superfluous (both callers guard the call behind `!input_ready`), it is a
> concurrency guard: a second thread reading the same console fd can set
> `inpuy_ready` in the window between `read()`'s lock-free `while
> (!input_ready)` check and `acquire_input_mutex`.
> 
> Maybe worth an extra code comment?

I added short comment here. Thanks.

> > +
> >    for (i = 0; i < total_read; i ++)
> >      {
> >        DWORD nread = 1;
> > @@ -1794,7 +1797,6 @@ fhandler_console::process_input_message (size_t len)
> >  	}
> >  
> >        num_input_events_processed = i + 1;
> > -      num_chars += nread;
> >        if (toadd)
> >  	{
> >  	  ssize_t ret;
> > @@ -1813,21 +1815,17 @@ fhandler_console::process_input_message (size_t len)
> >  	    }
> >  	}
> >        /* len == 0 if called from select.cc:peek_console() */
> > -      if (len && num_chars >= len)
> > +      if (input_ready && (len == 0 || con_ra.ralen >= len))
> 
> Something GPT 5.6 Sol stumbled over, before noticing that this is a
> pre-existing issue: the raw multi-pass caller passes full `buflen` (not
> `buflen - copied_chars`). That was already there before this patch (and
> both GPT and Opus think that this is incorrect, I haven't had time to wrap
> my head around it), and the new `ralen`-based check is actually
> neutral-to-better; and `tcflush(TCIFLUSH)` doesn't flush `con_ra`.
> 
> I'm fairly certain that this is out of scope for this here bug fix, if it
> is an issue at all (what do you think? Is this `buflen` issue real? Should
> `tcflush()` also flush `con_ra`?).

Thanks for finding this. I rechecked here and concluded passing `buflen`
for process_input_message() is correct. This is because, the length check
in the process_input_message is:

      if (input_ready && (len == 0 || con_ra.ralen >= len))
        goto out;

After the `while` loop, the chars in readahead data of length `con_ra.ralen`
will be copied into buffer of `buflen`. So the `len` should be total buffer
size here.

As for tcflush(), let me check. Please wait for a while.

> In any case, I'm happy with this patch! Feel free to add my "Reviewed-by".

Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
