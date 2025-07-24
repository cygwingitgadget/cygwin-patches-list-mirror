Return-Path: <SRS0=Pspn=2F=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 2A1173857348
	for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 15:26:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2A1173857348
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2A1173857348
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753370811; cv=none;
	b=rJYTI4KoHYuoirn/Ntl+BBAT2rCV+zxzcj7syH71MUjJV2Hjhv+IeEtJwo6daBvjpy9HVRu/CcjXEj9Ty/CcVA6cJIthkQPd6xAn2cdmwsForyBSN3sGpQKtbgx9mRoo4dE9HZNTpOFc+p0XCqkcGUnrW0pAhPibBawlst1wv1o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753370811; c=relaxed/simple;
	bh=NNZaxXcsfvU9e97QRb5NzF3Rc10fxpuo382J9+/ifPE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=QNQsovJ+ccWLV195+HKkvrQ5pJ1nxb4uguMuJ45yeZphE0FX95xnxnEoOx2pHpyd5DU/JEzMMJCZSuohghlAXU17lk6Bc78xmvueFCC3SDRtY70YX3mQs2tsvDJ2NWnN/DZKz4LRsR5iJE9g8e1KuvjiGntSXGD5h4rD9Rkipi4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2A1173857348
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Isj05zAQ
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20250724152647456.UOWU.14880.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 25 Jul 2025 00:26:47 +0900
Date: Fri, 25 Jul 2025 00:26:46 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Fix handling of archetype fhandler in
 process_fd
Message-Id: <20250725002646.64f8a7b84be3939a9dcf8e14@nifty.ne.jp>
In-Reply-To: <aIIzE9Q3HPTV7_oo@calimero.vinschen.de>
References: <20250724115713.1669-1-takashi.yano@nifty.ne.jp>
	<aIIv1EH-BccejUqa@calimero.vinschen.de>
	<aIIxfYssj6zseSPi@calimero.vinschen.de>
	<aIIzE9Q3HPTV7_oo@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753370807;
 bh=3BpH1thDeVKSBRwLaqsIS2Tixs9GrPtjjuJJ1qGF9jE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Isj05zAQYkCJOxFGudmjW9M8mGhSNymuwHqrppo33OnsPSsLh8lLJD3bQBujGyhRh87NUjiN
 j2BRpU9PBSVdu/k5zuAC2CDOJ2QPtkwoGyySH+SIAOkbe/GKxotP/e32tEZ5B3XggSML/HenXS
 y19N9xIsLRvftOSsxCmJLy0NljxjgO8aldVo+Bs29WN0lHMT9AjevXmDsYhX84MsB52jRpBmIA
 d4fxbR8WtJwXnvHWX2GcLEZ8Np8gSIAtoqWXJN6crrC/xC+SVPxj5cXYn3khaCiCCt4CPUjFDF
 Orwm8Himj3izpgdXrhOYHPWL+qYpFtLCjC8X0tXHYiT+FdVg==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 24 Jul 2025 15:20:19 +0200
Corinna Vinschen wrote:
> On Jul 24 15:13, Corinna Vinschen wrote:
> > On Jul 24 15:06, Corinna Vinschen wrote:
> > > On Jul 24 20:57, Takashi Yano wrote:
> > > > Previously, process_fd failed to correctly handle fhandlers using an
> > > > archetype. This was due to the missing PATH_OPEN flag in path_conv,
> > > > which caused build_fh_pc() to skip archetype initialization. The
> > > > root cause was a bug where open() did not set the PATH_OPEN flag
> > > > for fhandlers using an archetype.
> > > > 
> > > > This patch introduces a new method, path_conv::set_isopen(), to
> > > > explicitly set the PATH_OPEN flag in path_flags in fhandler_base::
> > > > open_with_arch().
> > > 
> > > Wouldn't this patch fix the problem as well?
> > > 
> > > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > > index 887e2ef722bf..2801c806edd5 100644
> > > --- a/winsup/cygwin/fhandler/console.cc
> > > +++ b/winsup/cygwin/fhandler/console.cc
> > > @@ -4311,7 +4311,7 @@ fhandler_console::init (HANDLE h, DWORD a, mode_t bin, int64_t dummy)
> > >  {
> > >    // this->fhandler_termios::init (h, mode, bin);
> > >    /* Ensure both input and output console handles are open */
> > > -  int flags = 0;
> > > +  int flags = PC_OPEN;
> > >  
> > >    a &= GENERIC_READ | GENERIC_WRITE;
> > >    if (a == GENERIC_READ)
> > > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > > index 77a363eb0e3b..10785e240091 100644
> > > --- a/winsup/cygwin/fhandler/pty.cc
> > > +++ b/winsup/cygwin/fhandler/pty.cc
> > > @@ -1015,7 +1015,7 @@ fhandler_pty_slave::close (int flag)
> > >  int
> > >  fhandler_pty_slave::init (HANDLE h, DWORD a, mode_t, int64_t dummy)
> > >  {
> > > -  int flags = 0;
> > > +  int flags = PC_OPEN;
> > >  
> > >    a &= GENERIC_READ | GENERIC_WRITE;
> > >    if (a == GENERIC_READ)
> > > 
> > > 
> > > Corinna
> > 
> > No, it wouldn't.  flags are not or'ed in the followup code.  Sigh.
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> 
> And no, this one wouldn't either. I'm not thinking straight ATM, sorry.

Thanks. The following patch also fixes the issue, however, the intent of
the code is more unclear than v2 patch, I think.
The root cause is the same for pty and console, but fixes are different.

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index f1832a169..5a3d01698 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -681,6 +681,8 @@ build_fh_pc (path_conv& pc)
     {
       if (!fh->get_name ())
 	fh->set_name (fh->dev ().native ());
+      if (pc.isopen ())
+	fh->pc.set_isopen (); // <- fix for pty
       fh->archetype = fh->clone ();
       debug_printf ("created an archetype (%p) for %s(%d/%d)", fh->archetype, fh->get_name (), fh->dev ().get_major (), fh->dev ().get_minor ());
       fh->archetype->archetype = NULL;
diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 887e2ef72..4994e3172 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -4321,6 +4321,7 @@ fhandler_console::init (HANDLE h, DWORD a, mode_t bin, int64_t dummy)
   if (a == (GENERIC_READ | GENERIC_WRITE))
     flags = O_RDWR;
   open_with_arch (flags | O_BINARY | (h ? 0 : O_NOCTTY));
+  pc.set_isopen (); // <- fix for console
 
   return !tcsetattr (0, &get_ttyp ()->ti);
 }
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
