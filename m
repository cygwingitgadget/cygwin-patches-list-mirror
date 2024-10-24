Return-Path: <SRS0=lOez=RU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id C87E73858D21
	for <cygwin-patches@cygwin.com>; Thu, 24 Oct 2024 08:58:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C87E73858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C87E73858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1729760341; cv=none;
	b=cGmI7UU/mpGwgkJpu4s8YRhGpJXgOxG9Ki5rUSgvFyCyvumIH6LYmOacVMsyouAuKCV4+nTd9mhOzals1z78mFHlmD6JUq0bnq6pM9j/6SLT2nPuwuo0CR07KU2OZvQOSgM3oG9zKtGThePM7ovrUb7zw446DkJEacDeUR1FCR8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1729760341; c=relaxed/simple;
	bh=WC9X2a1zgT/y/56I2GZnvWzmio83O8tziChFFuE2N8Q=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=h3r1+Rs2iRywFIxnBsZCm+nRGCV180sl2Fr7EdboK3KqdU6E1GWl72+VG4ys8phuuPVyeDdwh+QVm6rPV2ytePUuA0rdQCq1v/l6Waa7ORrdXRrYclhyCZYP92x8G6LHTSA/9Dtf4gxzNtxIcMcKg0yVXLyi0TzxQTh4nHCG5PU=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e04.mail.nifty.com with ESMTP
          id <20241024085856980.LZOJ.7571.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 24 Oct 2024 17:58:56 +0900
Date: Thu, 24 Oct 2024 17:58:55 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: lockf: Make lockf() return ENOLCK when too
 many locks
Message-Id: <20241024175855.504e05b50902cbd978b217ce@nifty.ne.jp>
In-Reply-To: <ZxfMeOTgFQHZYTCD@calimero.vinschen.de>
References: <20241020092650.835-1-takashi.yano@nifty.ne.jp>
	<20241020092650.835-3-takashi.yano@nifty.ne.jp>
	<ZxfMeOTgFQHZYTCD@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1729760337;
 bh=umGs66yxZtGzUHfQ1vr7GC60f6kmuQv3OGkb7gnfvYc=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=AsQL2QJ+afaMsWcAs2ayLx3SBKb7lA5Nab3a8TGQKOv2CGVHSBpGIeAvWKVCYvYMLm1NJboQ
 2Eu0R0kGCbI+l4fbxduDPoPsCPsRSxEolDm9lXHcQGKCxEuY8W7XHg8hBphDB4ZUPb0AEWvJ7W
 LsOvwftNjGN6uqHeqmGM4loY652NUFJILVnFHZ16G9v8KE9TT+aDOfpc66xz0g72EsbqXTKNL2
 /2vv6Mg7DQbsW/IArYZXDJAUgjNbgYb1fEUiDhIUKwQwHHapc2zhBUtpMMaKlt15Y/daKjezTR
 gRtjpzIPECZsYpiaILzMy2yG78cqdK6mkm+nayBBEo1iW3Ug==
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 22 Oct 2024 18:02:00 +0200
Corinna Vinschen <corinna-cygwin@cygwin.com> wrote:
> > @@ -503,7 +506,8 @@ inode_t::get (dev_t dev, ino_t ino, bool create_if_missing, bool lock)
> >  }
> >  
> >  inode_t::inode_t (dev_t dev, ino_t ino)
> > -: i_lockf (NULL), i_all_lf (NULL), i_dev (dev), i_ino (ino), i_cnt (0L)
> > +: i_lockf (NULL), i_all_lf (NULL), i_dev (dev), i_ino (ino), i_cnt (0L),
> > +  i_lock_cnt (0)
> >  {
> >    HANDLE parent_dir;
> >    WCHAR name[48];
> > @@ -610,17 +614,15 @@ inode_t::get_all_locks_list ()
> >  	  dbi->ObjectName.Buffer[LOCK_OBJ_NAME_LEN] = L'\0';
> >  	  if (!newlock.from_obj_name (this, &i_all_lf, dbi->ObjectName.Buffer))
> >  	    continue;
> > -	  if (lock - i_all_lf >= MAX_LOCKF_CNT)
> > -	    {
> > -	      system_printf ("Warning, can't handle more than %d locks per file.",
> > -			     MAX_LOCKF_CNT);
> > -	      break;
> > -	    }
> > +	  if (lock - i_all_lf > MAX_LOCKF_CNT)
> > +	    api_fatal ("Can't handle more than %d locks per file.",
> > +		       MAX_LOCKF_CNT);
> 
> I don't quite get that. The commit message says to return ENOLCK rather
> than printing a warning, but here you call api_fatal(), which is even
> more extrem?  Did I miss something?

Yeah, this should not happen. So assert() might be better approach.
Please review again for v2 patch. Problems in this patch also has
been fixed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
