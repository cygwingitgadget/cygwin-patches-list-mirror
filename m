Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 by sourceware.org (Postfix) with ESMTPS id 5A7DC385701F
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 13:52:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5A7DC385701F
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=takashi.yano@nifty.ne.jp
Received: from Express5800-S70 (ae236159.dynamic.ppp.asahi-net.or.jp
 [14.3.236.159]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id 12NDpesp003723
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 22:51:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 12NDpesp003723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1616507500;
 bh=t81dnbBaLImg3xgDxc/YszgpTqNCS/QZxssxJvg4fbU=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=qeEUhTHZFB4HYeTpGjJHi1BLg5HfLnxmUarf+NnZQ0c6RTbqlu3HAlMPLW3gIffdo
 q7/7HWn8HVam0IN8i0gRWRdC6aGMHrFXS/NnhRGY1r+G5Eutys365ewpG2tfuxxLy6
 10AGOSHqH7xnfMdHdiljSOCalLC2weSRlLWl2QdMfJofj7TbJacIVs3zfKB5QnGZ0V
 YEJ1pxLXCZjOlzKRQbWu7zWuw++o2ZFHa7XIppu71vgbGZaZ0Izp5tJmNZC7iniPS1
 xQbZh0DjZbVn5YW+cMdlbioLG3+K1wSt1sRU3WuoGVRNMQlQK18tSWaEt4geEPeR5l
 QxnUsYwySeN1Q==
X-Nifty-SrcIP: [14.3.236.159]
Date: Tue, 23 Mar 2021 22:51:42 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
Message-Id: <20210323225142.3ddc21334ca645ab838ddf49@nifty.ne.jp>
In-Reply-To: <YFnt95aAHnuu7NCC@calimero.vinschen.de>
References: <20210321174427.cf79e39deeea896583caa48c@nifty.ne.jp>
 <20210322080738.6841d7f2a1e09290a929ad90@nifty.ne.jp>
 <YFiC6FXrnGeW8v1M@calimero.vinschen.de>
 <58c7be6c-42db-cc09-9f89-461ac7c87747@cornell.edu>
 <YFm+fEONY3wLq3Sp@calimero.vinschen.de>
 <20210323205717.bf5c3a41695871ec70bf1229@nifty.ne.jp>
 <YFncTItWHhMlNH5Y@calimero.vinschen.de>
 <20210323213212.d2c5a9e7db7a508260693998@nifty.ne.jp>
 <20210323214206.ebb5b1cb80a8b71ead4e8cda@nifty.ne.jp>
 <20210323215227.eda395caff35c4d5aa9b9007@nifty.ne.jp>
 <YFnt95aAHnuu7NCC@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Tue, 23 Mar 2021 13:52:03 -0000

On Tue, 23 Mar 2021 14:32:39 +0100
Corinna Vinschen wrote:
> On Mar 23 21:52, Takashi Yano via Cygwin-patches wrote:
> > On Tue, 23 Mar 2021 21:42:06 +0900
> > Takashi Yano wrote:
> > > On Tue, 23 Mar 2021 21:32:12 +0900
> > > Takashi Yano wrote:
> > > > I try to check run.exe behaviour and noticed that
> > > > run cmd.exe
> > > > and
> > > > run cat.exe
> > > > does not work with cygwin 3.0.7 and 3.2.0 (TEST) while these
> > > > work in 3.1.7.
> > > 
> > > In obove cases, cmd.exe and cat.exe is running in *hidden* console,
> > > therefore nothing is shown. Right?
> > 
> > In what situation are
> >   psi->cb = sizeof (STARTUPINFO);
> >   psi->hStdInput  = GetStdHandle (STD_INPUT_HANDLE);
> >   psi->hStdOutput = GetStdHandle (STD_OUTPUT_HANDLE);
> >   psi->hStdError  = GetStdHandle (STD_ERROR_HANDLE);
> > these handles used?
> 
> Hmm, trying to make sense from the code, I'd say, these handles are used
> by default, unless run.exe is already attached to a console.  In  the
> latter case, it calls CreateFile( "CONIN$") etc. to attach the new
> process to that console.

"if (!bForceUsingPipes && bHaveConsole)"
then handles are replaced by CreateFile("CONIN$", ...) etc.
else replaced by pipe handle. If so, handles returned by
GetStdHandle() are never used.

Do I overlook something?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
