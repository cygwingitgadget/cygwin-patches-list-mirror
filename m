Return-Path: <SRS0=Pspn=2F=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.121])
	by sourceware.org (Postfix) with ESMTPS id 0EA4E385840B
	for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 11:45:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0EA4E385840B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0EA4E385840B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.121
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753357562; cv=none;
	b=l3K48c+rdZcHErHXe2kauo8UQ4KRJGSAoDxuxc11dZpC9yOzlS/R2OkXaW20NfWABSVkSAmwDxQg3bAiLxMunIbJcURSsKc2iPoCMlvHwpJu9lKixBczVDtKLQB71WsOyZfwFlzyjtbGHl1NBEKnrTqmvsgE9CjHcmlkZydi3U4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753357562; c=relaxed/simple;
	bh=9Rt1cvjU4OtZn1DEiE48qzCqCORHneQs2ymYa/yX/n4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=an4+n/6S8EaybpqlxK85DfuI4CfzHTUCaTjF4KEPimHIVbv98iB7ZhfiASqKjkSGZ3w7VLcMN3vOP0nLr/zxR2giUpQVKIM3QKKa2LQs4aYGm09NwlYZVLqszqKoKv3ZPfLp6DjA5nQSoWCP25ydh0qBTzQeN1Gdj/V2Xb7tE4Q=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0EA4E385840B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=IuzQ+6hS
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20250724114554020.GJWY.84842.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 20:45:54 +0900
Date: Thu, 24 Jul 2025 20:45:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: dtable: Fix handling of archetype fhandler in
 process_fd
Message-Id: <20250724204553.f7969cb5bd736abc52615e99@nifty.ne.jp>
In-Reply-To: <20250724175509.d89485624f8d8a09a3a47e2c@nifty.ne.jp>
References: <20250724083616.1084-1-takashi.yano@nifty.ne.jp>
	<20250724175509.d89485624f8d8a09a3a47e2c@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753357554;
 bh=l5BKfI8EfynyGkHmGuZLchfiWVoLI4+hJxjoraZeHeg=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=IuzQ+6hSua0H7jV0bjKnjgY1NMXclsbbem5iDMlUZ/LGsilEuSxZavaxbpSQX4dhd2gUZP7w
 S4tCBlORrfQ21DnNn3WtGcMdMtE1VR6qLgoceAvYJtkxkCNZORc3cM4JCfz/ztFrcshQuiq8H2
 rVakS7igLgstNspA0yO7iDel6M3j7bRYJCivA0ooEvHkSNUjhj46dEfJzeGo0Vaz1FWMb1SXD3
 LObDDOM/t2LRF0rukFZQYcl4f0kj4Q3OQztdrirMv6ovQ0Vl0dRwSBAGkmMrHaFhpQd7oqiqRz
 8jJZKMMptTZOggbqOXo3yCtNsDrCeuCfOYCIjAKSLCq5PD4g==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 24 Jul 2025 17:55:09 +0900
Takashi Yano wrote:

> On Thu, 24 Jul 2025 17:36:07 +0900
> Takashi Yano wrote:
> > Previously, process_fd failed to correctly handle fhandlers using an
> > archetype. This was due to the missing PATH_OPEN flag in path_conv,
> > which caused build_fh_pc() to skip archetype initialization. The
> > root cause was a bug where open() did not set the PATH_OPEN flag
> > for fhandlers using an archetype.
> > 
> > This patch introduces a new method, path_conv::set_isopen(), to
> > explicitly set the PATH_OPEN flag in path_flags when opening a
> > fhandler that uses an archetype.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2025-May/258167.html
> > Fixes: 92ddb7429065 ("(build_pc_pc): Use fh_alloc to create. Set name from fh->dev if appropriate. Generate an archetype or point to one here.")
> > Reported-by: Christian Franke <Christian.Franke@t-online.de>
> > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/dtable.cc             | 4 ++++
> >  winsup/cygwin/local_includes/path.h | 1 +
> >  winsup/cygwin/release/3.6.5         | 3 +++
> >  3 files changed, 8 insertions(+)
> > 
> > diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> > index f1832a169..6a99c99f9 100644
> > --- a/winsup/cygwin/dtable.cc
> > +++ b/winsup/cygwin/dtable.cc
> > @@ -674,6 +674,8 @@ build_fh_pc (path_conv& pc)
> >  		    fh->archetype->get_handle ());
> >        if (!fh->get_name ())
> >  	fh->set_name (fh->archetype->dev ().name ());
> > +      if (pc.isopen ())
> > +	fh->pc.set_isopen ();
> >      }
> >    else if (cygwin_finished_initializing && !pc.isopen ())
> >      fh->set_name (pc);
> > @@ -681,6 +683,8 @@ build_fh_pc (path_conv& pc)
> >      {
> >        if (!fh->get_name ())
> >  	fh->set_name (fh->dev ().native ());
> > +      if (pc.isopen ())
> > +	fh->pc.set_isopen ();
> >        fh->archetype = fh->clone ();
> >        debug_printf ("created an archetype (%p) for %s(%d/%d)", fh->archetype, fh->get_name (), fh->dev ().get_major (), fh->dev ().get_minor ());
> >        fh->archetype->archetype = NULL;
> > diff --git a/winsup/cygwin/local_includes/path.h b/winsup/cygwin/local_includes/path.h
> > index 1fd542c96..a9ce2c7e4 100644
> > --- a/winsup/cygwin/local_includes/path.h
> > +++ b/winsup/cygwin/local_includes/path.h
> > @@ -244,6 +244,7 @@ class path_conv
> >    int isopen () const {return path_flags & PATH_OPEN;}
> >    int isctty_capable () const {return path_flags & PATH_CTTY;}
> >    int follow_fd_symlink () const {return path_flags & PATH_RESOLVE_PROCFD;}
> > +  void set_isopen () {path_flags |= PATH_OPEN;}
> >    void set_cygexec (bool isset)
> >    {
> >      if (isset)
> 
> Wait. This does not fix console case.

When bash is executed from command prompt, no one calls open().
What should we do for this case?

open() is not called but open_with_arch() is called.
  init_std_file_from_handle() -> init() -> open_with_arch()

What about set PATH_OPEN flag in open_with_arch() as follows?

diff --git a/winsup/cygwin/fhandler/base.cc b/winsup/cygwin/fhandler/base.cc
index 64a5f6aea..beebd710c 100644
--- a/winsup/cygwin/fhandler/base.cc
+++ b/winsup/cygwin/fhandler/base.cc
@@ -474,6 +474,9 @@ fhandler_base::open_with_arch (int flags, mode_t mode)
       if (!open_setup (flags))
 	api_fatal ("open_setup failed, %E");
     }
+  /* For pty and console, PATH_OPEN flag has not been set in open().
+     So set it here unconditionally. */
+  pc.set_isopen ();
 
   close_on_exec (flags & O_CLOEXEC);
   /* A unique ID is necessary to recognize fhandler entries which are
diff --git a/winsup/cygwin/local_includes/path.h b/winsup/cygwin/local_includes/path.h
index 1fd542c96..a9ce2c7e4 100644
--- a/winsup/cygwin/local_includes/path.h
+++ b/winsup/cygwin/local_includes/path.h
@@ -244,6 +244,7 @@ class path_conv
   int isopen () const {return path_flags & PATH_OPEN;}
   int isctty_capable () const {return path_flags & PATH_CTTY;}
   int follow_fd_symlink () const {return path_flags & PATH_RESOLVE_PROCFD;}
+  void set_isopen () {path_flags |= PATH_OPEN;}
   void set_cygexec (bool isset)
   {
     if (isset)

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
