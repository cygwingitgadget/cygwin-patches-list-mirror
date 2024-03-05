Return-Path: <SRS0=ZRpm=KL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1007.nifty.com (mta-snd01013.nifty.com [106.153.227.45])
	by sourceware.org (Postfix) with ESMTPS id E08373858C66
	for <cygwin-patches@cygwin.com>; Tue,  5 Mar 2024 00:06:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E08373858C66
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E08373858C66
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.45
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1709597214; cv=none;
	b=oaNdNN2FyfVoQL9BcByOmXfDh9IGdsfJBI472hxXx85NFT6kchv+2gvGbYvBz/Aqv7Z6D6/Qxf9QkKqtBe16cvJ9JjsA8/K9bitIwIs4LbY/0GZniH4o8zwsQh9ZkyxlwnK4bIHsp7NEIEYmf4Q5/6b1mNKI2dUSfEwtMn6SBKI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1709597214; c=relaxed/simple;
	bh=UzSQwBdts/d9Ac5ZM04aYFyip0qKGTPlbb9t6/Fnn5c=;
	h=Date:From:To:Subject:Message-Id:Mime-Version; b=VW6ehqAycAdxBz5+TbpS94tVy79/9u9pveKa71VbR3vq6jShSSQOLjyU9I9Sz96erGO/8aeKEk6QeB9uQf4enehn3jA4j7EMQVPEoH9bGGVWEAbN6MA3DLoYgjfDnDOIW2ivEHRQXxl1/dSswgTfyJGq0m47bGRc1vlUon/uYjw=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by dmta1007.nifty.com with ESMTP
          id <20240305000649533.GKHZ.5813.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 5 Mar 2024 09:06:49 +0900
Date: Tue, 5 Mar 2024 09:06:48 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Give up to use query_hdl for non-cygwin
 apps.
Message-Id: <20240305090648.6342d8f9cb8fd4ca64b47d38@nifty.ne.jp>
In-Reply-To: <ZeYG_11UfRTLzit1@calimero.vinschen.de>
References: <20240303050915.2024-1-takashi.yano@nifty.ne.jp>
	<b0bd6b96-5bd8-7f4e-71ff-4552e5ac1cb5@gmx.de>
	<20240303192109.9fb4a3a4968bb11ca5d9636a@nifty.ne.jp>
	<87a5nfbnv7.fsf@Gerda.invalid>
	<20240303203641.09321b0a0713e8bdb90980b5@nifty.ne.jp>
	<ZeWjmEikjIUushtk@calimero.vinschen.de>
	<87edcqgfwc.fsf@>
	<ZeYG_11UfRTLzit1@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 4 Mar 2024 18:38:07 +0100
Corinna Vinschen wrote:
> On Mar  4 16:45, ASSI wrote:
> > Corinna Vinschen writes:
> > > Right you are.  We always said that independent Cygwin installations
> > > are supposed to *stay* independent.
> > >
> > > Keep in mind that they don't share the same shared objects in the native
> > > NT namespace and they don't know of each other.  It's not only the
> > > process table but also in-use FIFO stuff, pty info, etc.
> > 
> > What I was getting at is that a process not showing up in the process
> > list in one Cygwin installation doesn't automatically mean it's a native
> > Windows process, it could be a process started by an independent Cygwin
> > installation.  So this way of checking for "native" Windows processes
> > may or may not do what was originally intended.
> 
> But that was my point. A "foreign" Cygwin process from another
> installation is not a Cygwin process.  Lots of interoperability
> just won't work, so it's basically a native process.

Actually, I think query_hdl can be retrieved from the process
from another installation of cygwin using NtQueryInformationProcess()
with ProcessHandleInformation. However, I cannot imagne the case
that the pipe is made by one cygwin installation but the reader
process is from another installation of cygwin.

BTW, what about v2 patch itself?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
