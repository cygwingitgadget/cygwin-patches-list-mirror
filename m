Return-Path: <SRS0=Pspn=2F=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.117])
	by sourceware.org (Postfix) with ESMTPS id 207D83858D1E
	for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 02:17:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 207D83858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 207D83858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.117
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753323458; cv=none;
	b=M3x2QsD28HA1d46iz0B+vSoasQCkgpEn8GY3vc83N+IaQI6LpH0hzeajprEgbo9lqnL+Ri8mDqYHKL/5AB+aVwHMv32/R8I8/Wb2JcUzyLtV0fI3m7fAy9wN7jCG3VjNm7E+XLBrPXBhpMgi3CYESlx06YpdEqmW5FasQ2wbvdY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753323458; c=relaxed/simple;
	bh=36H+7Id/z3Qtfnr0FvzyL/jE9dph904etdwPHJkPxro=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=XOtBB/+jlQdqzw4JN+YmwvjYsgI8uHc3WUErBt0a/dnwYAsBxrLv3exERJkT8NFslipMdHuQTMHnjok/Vupa2twiFKksnpCPQGGAQXEI7EOL1ROb9qk9mQ0QnE4UocDbWPa3UgueHKvkQbsDA86euWhLP3TDlTIVIHCCAxjktcg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 207D83858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=do4NNtv1
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20250724021734774.JCQV.36235.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 11:17:34 +0900
Date: Thu, 24 Jul 2025 11:17:33 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: process_fd: Fix handling of archetype fhandler
Message-Id: <20250724111733.90d0b036a2113af56199dcf9@nifty.ne.jp>
In-Reply-To: <20250724091016.f04b1709e164619f58b21032@nifty.ne.jp>
References: <20250722123240.349-1-takashi.yano@nifty.ne.jp>
	<aIClgpTaJ_6khEmq@calimero.vinschen.de>
	<20250723195536.5783866c1683727f0ca49fb1@nifty.ne.jp>
	<aIDbTUeOEM6kSDUh@calimero.vinschen.de>
	<20250724091016.f04b1709e164619f58b21032@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753323454;
 bh=KG3kbvNrjS1gA6G58jUr/I9mz8TZvUZ9Mf+S9SmC0RQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=do4NNtv1MGL/p3tNgIghbvEavCnoNG9t6cxJY2Mup5Ud0M9hAJk0elrWKNOGwttoh5xgA5o+
 lB8xdH41m0xIRsyVB/pnnSbGWMMigq9sCNNuh7MU9qHl8lTLtDGIaWpqXTdnXti0zvZN1sKx2y
 sp0kzZ5Ba5PZmwbeyJHXo0iEYwLj9e9jDFdz1VHeb/R2qaQNVaJWH0n00NoqZoNLHMEBmxKGtg
 0duoJdRAVQRw/e0wUPkTKlYyNQVbon9ibRhBhJa3QeBreWeeSMCgpk4U5deHMv3oC47gXdNZU7
 jly2FCxaa3buLxA0ay8kinQijnBN1Ahf6bweW93kklFhR4DQ==
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 24 Jul 2025 09:10:16 +0900
Takashi Yano wrote:
> On Wed, 23 Jul 2025 14:53:33 +0200
> Corinna Vinschen wrote:
> > On Jul 23 19:55, Takashi Yano wrote:
> > > On Wed, 23 Jul 2025 11:04:02 +0200
> > > Corinna Vinschen wrote:
> > > > On Jul 22 21:32, Takashi Yano wrote:
> > > > > Previously, process_fd did not handle fhandler using archetype
> > > > > correctly. Due to lack of PC_OPEN flag for path_conv, build_fh_pc()
> > > > > could not initialize archetype. Because of this bug, accessing pty
> > > > > or console via process_fd fails.
> > > > > 
> > > > > With this patch, use build_fh_name() with PC_OPEN flag instead of
> > > > > build_fh_pc() to set PC_OPEN flag to path_conv.
> > > > 
> > > > Your patch fixes the issue, ok, but I don't understand why this occurs.
> > > > 
> > > > If the process opens /proc/PID/fd/N with PID != MYPID, it uses the
> > > > PICOM_FILE_PATHCONV commune request.  It copies the path_conv member
> > > > of the fd from the target process and this pc is used in the
> > > > build_fh_pc() call.
> > > > 
> > > > And here's what I don't get: If the pc has been fetched from a valid,
> > > > open file descriptor in the target process, why is the PATH_OPEN
> > > > flag not set?
> > > 
> > > Thanks for reviewing.
> > > 
> > > I looked into open process, and noticed that this is because fh_alloc()
> > > called from build_fh_name() does not copy argument pc.path_flags to
> > > fh->pc.path_flags.
> > 
> > No, wait.  build_fh_name() creates a path_conv instance and that in turn
> > is used to call build_fh_pc().  build_fh_pc() calls fh_alloc() and then
> > calls fh->set_name (pc) in allmost all scenarios.  This in turn should
> > copy pc.path_flags, because the underlying path_conv::<< operator is
> > basically a memcpy().
> 
> In the case use_archetype() is true, fh->set_name(pc) does not seem
> to be called.
> https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/cygwin/dtable.cc;h=f1832a1693d45d5fd1e27acb830d5a12a6a34238;hb=HEAD#l683
https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/cygwin/dtable.cc;h=f1832a1693d45d5fd1e27acb830d5a12a6a34238;hb=HEAD#l676

So, the following patch also fixes the issue.

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index f1832a169..3b25e9160 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -674,6 +674,7 @@ build_fh_pc (path_conv& pc)
 		    fh->archetype->get_handle ());
       if (!fh->get_name ())
 	fh->set_name (fh->archetype->dev ().name ());
+      fh->pc.set_isopen ();
     }
   else if (cygwin_finished_initializing && !pc.isopen ())
     fh->set_name (pc);
@@ -681,6 +682,7 @@ build_fh_pc (path_conv& pc)
     {
       if (!fh->get_name ())
 	fh->set_name (fh->dev ().native ());
+      fh->pc.set_isopen ();
       fh->archetype = fh->clone ();
       debug_printf ("created an archetype (%p) for %s(%d/%d)", fh->archetype, fh->get_name (), fh->dev ().get_major (), fh->dev ().get_minor ());
       fh->archetype->archetype = NULL;
diff --git a/winsup/cygwin/local_includes/path.h b/winsup/cygwin/local_includes/path.h
index 1fd542c96..9f62fd993 100644
--- a/winsup/cygwin/local_includes/path.h
+++ b/winsup/cygwin/local_includes/path.h
@@ -258,6 +258,10 @@ class path_conv
     else
       mount_flags &= ~MOUNT_CYGWIN_EXEC;
   }
+  void set_isopen ()
+  {
+    path_flags |= PATH_OPEN;
+  }
   bool isro () const {return !!(mount_flags & MOUNT_RO);}
   bool exists () const {return fileattr != INVALID_FILE_ATTRIBUTES;}
   bool has_attribute (DWORD x) const {return exists () && (fileattr & x);}

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
