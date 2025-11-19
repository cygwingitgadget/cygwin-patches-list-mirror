Return-Path: <SRS0=EBeo=53=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 66065385275F
	for <cygwin-patches@cygwin.com>; Wed, 19 Nov 2025 11:27:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 66065385275F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 66065385275F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1763551626; cv=none;
	b=AUqWIpMiOg44L1LZsoPRLdIFZCrsvEI8gf7F9EAm/G/FQcTohy6XXKpwrmMDBLVUvZTEdDRpgVtKLVfRDIVHFgebHO3ofZ/cDZYBMhqQxMndpcfjaokOrccfZEIQda8pI23jX/speHypNITV3NJcirqdCAJcQgGswVKRNpGJBmA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1763551626; c=relaxed/simple;
	bh=PWGqR1rw0avXBHpmbe6L7Qbwjd5XaVS/xlw69sLrJqk=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=iHatwi82RZ/cU5r1mcQ22X0AQ8GD5gnkeRS+EqdAL03I8z6Zwr9arCEsZEIjf2qC5Imx+8H/ejzzG4dm3+58eH0zfmyEYcfIhSg2/kjr6XINT7PxU92q5C72Za1E5K1ZbiJN/JyVgtcuzNoM628rO+ECl3P7Vb0dxQpdahbo/Y0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 66065385275F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kaaPj8dS
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20251119112703127.PFAN.98325.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 19 Nov 2025 20:27:03 +0900
Date: Wed, 19 Nov 2025 20:27:01 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 1/2] Cygwin: dll_init: Always call __cxa_finalize()
 for DLL_LOAD
Message-Id: <20251119202701.2699ae6e37c254576fe31698@nifty.ne.jp>
In-Reply-To: <aR2J0rv3QLiMzFpC@calimero.vinschen.de>
References: <20251118234535.194356-1-takashi.yano@nifty.ne.jp>
	<20251118234535.194356-2-takashi.yano@nifty.ne.jp>
	<aR2J0rv3QLiMzFpC@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1763551623;
 bh=wi5c1yEbMiHFZQ15/ZcHlOks9g5yqPUAlcrhcDfj1cM=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=kaaPj8dSTTvKmpAxR1G7qHq2hzorBYqvzh+mFJ0v9rRwSFXOiIPggxLA6ncnT9tVxARWs4uC
 o+e6CXhlEUYsyN5xcFy1BlM947wixHf7sqKvULgOW9Umq9tWY7IsBAmY8yjF4ufmDbO5TOBwPc
 Kpb4gEHrhFrw5YnCpfC/fKuXVzlEpOLIYXQbzFM5YEBZRgVWYeSQCPxgdhNMy3RmClti9B/w5Y
 f/M+Ta3+0gjCx/AEMreXw62/zL8N+wJF7Q+NI0+yl+/asKXdUn9s2t6pX6RJ2VD2HdSbY38Knf
 zRODrIfRG1CFfZ7u2ntpIGfXVcFTVdRpP+pPYg2WcaYmxH5A==
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 19 Nov 2025 10:11:46 +0100
Corinna Vinschen wrote:
> On Nov 19 08:45, Takashi Yano wrote:
> > For dlopen()'ed DLL, __cxa_finalize() should always be called at dll
> > detach time. The reason is as follows. In the case that dlopen()'ed
> > DLL A is dlclose()'ed in the destructor of DLL B, and the destructor
> > of DLL B is called in exit_state, DLL A will be unloaded by dlclose().
> > If __cxa_finalize() for DLL A is not called here, the destructor of
> > DLL A will be called in exit() even though DLL A is already unloaded.
> > This causes crash at exit(). In this case, __cxa_finalize() should be
> > called before unloading DLL A even in exit_state.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2025-October/258877.html
> > Fixes: c019a66c32f8 ("* dll_init.cc (dll_list::detach) ... Don't call __cxa_finalize in exiting case.")
> > Reported-by: Thomas Huth <th.huth@posteo.eu>
> > Reviewed-by: Mark Geisert <mark@maxrnd.com>, Jon Turney <jon.turney@dronecode.org.uk>, Corinna Vinschen <corinna-cygwin@cygwin.com>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/dll_init.cc | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
> > index 1369165c9..d2ed74bed 100644
> > --- a/winsup/cygwin/dll_init.cc
> > +++ b/winsup/cygwin/dll_init.cc
> > @@ -584,7 +584,16 @@ dll_list::detach (void *retaddr)
> >  	  /* Ensure our exception handler is enabled for destructors */
> >  	  exception protect;
> >  	  /* Call finalize function if we are not already exiting */
> > -	  if (!exit_state)
> > +	  /* For dlopen()'ed DLL, __cxa_finalize() should always be called
> > +	     at dll detach time. The reason is as follows. In the case that
> > +	     dlopen()'ed DLL A is dlclose()'ed in the destructor of DLL B,
> > +	     and the destructor of DLL B is called in exit_state, DLL A will
> > +	     be unloaded by dlclose(). If __cxa_finalize() for DLL A is not
> > +	     called here, the destructor of DLL A will be called in exit()
> > +	     even though DLL A is already unloaded. This causes crash at
> > +	     exit(). In this case, __cxa_finalize() should be called before
> > +	     unloading DLL A even in exit_state. */
> > +	  if (!exit_state || d->type == DLL_LOAD)
> >  	    __cxa_finalize (d->handle);
> >  	  d->run_dtors ();
> >  	}
> > -- 
> > 2.51.0
> 
> Sounds good to me, now, thanks!

Thanks! Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
