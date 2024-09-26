Return-Path: <SRS0=DNoc=QY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id 4A4F63858D28
	for <cygwin-patches@cygwin.com>; Thu, 26 Sep 2024 12:09:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4A4F63858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4A4F63858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1727352568; cv=none;
	b=THJ2zRHLprWpExNQI3yijR0Fb6nKbpbetfhPBxq+2mrvx6oACBfOt8cRXgSV/4kZep0Vv4R1mbwH3zfV71l8rePMpO/2isC1+kN6uFGJgryzS0a4qytcMrNDUSmohEMM+ZKg/9MqCWVcLFeCMGh+w6srFWijrjlVEBy7AFsDf4o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1727352568; c=relaxed/simple;
	bh=WIU+aNnH+tOR8php/7GwXl8+SSvJ83952HWnt1kIEkA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=XKg3bNTLyjSHMNGAn357GIBAtdNQoZtHrhBZXBS39Z2f2f22TdYWqzwUzSNSq5ASEh1z4zhKtsEjLtggb+YxnQpbFIVy0o93nLmXeT/HC4jtGX3mMiFzwQc3h9p5i5XZ146Ap0fP9FpI7v9MIoJjKVNNYliZCC1n44g3qusiCfo=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-w03.mail.nifty.com with ESMTP
          id <20240926120924447.KZIC.115271.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 26 Sep 2024 21:09:24 +0900
Date: Thu, 26 Sep 2024 21:09:23 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
Message-Id: <20240926210923.e754c56dc508baeab53f7bd2@nifty.ne.jp>
In-Reply-To: <0e6831d3-9c46-4467-af45-4f72555ea4ff@cornell.edu>
References: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
	<0e6831d3-9c46-4467-af45-4f72555ea4ff@cornell.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1727352564;
 bh=wNDTgZ1M6LTX7MRbTTKt/eTu3ZxWP9rjOm5/I6br85I=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=mz/JUNxg1PvrJ4T+CxoBamcMDCb/UJG0kwddQaXDTkkX6Yvh4Y9miVwqOIQu6X4v7S1ljktM
 /FCBLzB868rNHFoxu85a5ss+yLMPynDRcIWqYtq1bM+gXeX6ASryMt92rlWEzSG5d48LCx9cUN
 unORF5h/e46/YIH0OKWWOqEXMHeDhTwXbPl15yPjI84Fhz4FyxKFAcPRMgQivuRlJ3bd9jc6q+
 +66UHb0by/s6HOJxeiLvhB1G2CtU7GAFY3/Chiia3yo75bLVwslbMsRnPBCpbSHwssiaLpLCS6
 5cIWj1hP4+sdDUc2YV2zEqMLwhQ+SA8sLEIbyOIMR0TR1G2w==
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 25 Sep 2024 16:11:12 -0400
Ken Brown wrote:
> On 9/21/2024 5:15 PM, Takashi Yano wrote:
> > Previously, cygwin read pipe used non-blocking mode although non-
> > cygwin app uses blocking-mode by default. Despite this requirement,
> > if a cygwin app is executed from a non-cygwin app and the cygwin
> > app exits, read pipe remains on non-blocking mode because of the
> > commit fc691d0246b9. Due to this behaviour, the non-cygwin app
> > cannot read the pipe correctly after that. Similarly, if a non-
> > cygwin app is executed from a cygwin app and the non-cygwin app
> > exits, the read pipe mode remains on blocking mode although cygwin
> > read pipe should be non-blocking mode.
> > 
> > These bugs were provoked by pipe mode toggling between cygwin and
> > non-cygwin apps. To make management of pipe mode simpler, this
> > patch has re-designed the pipe implementation. In this new
> > implementation, both read and write pipe basically use only blocking
> > mode and the behaviour corresponding to the pipe mode is simulated
> > in raw_read() and raw_write(). Only when NtQueryInformationFile
> > (FilePipeLocalInformation) fails for some reasons, the raw_read()/
> > raw_write() cannot simulate non-blocking access. Therefore, the pipe
> > mode is temporarily changed to non-blocking mode.
> > 
> > Moreover, because the fact that NtSetInformationFile() in
> > set_pipe_non_blocking(true) fails with STATUS_PIPE_BUSY if the pipe
> > is not empty has been found, query handle is not necessary anymore.
> > This allows the implementation much simpler than before.
> > 
> > Addresses: https://github.com/git-for-windows/git/issues/5115
> > Fixes: fc691d0246b9 ("Cygwin: pipe: Make sure to set read pipe non-blocking for cygwin apps.");
> > Reported-by: isaacag, Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>, Ken Brown <kbrown@cornell.edu>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >   winsup/cygwin/dtable.cc                 |   5 +-
> >   winsup/cygwin/fhandler/pipe.cc          | 657 ++++++++----------------
> >   winsup/cygwin/local_includes/fhandler.h |  44 +-
> >   winsup/cygwin/local_includes/sigproc.h  |   1 -
> >   winsup/cygwin/select.cc                 |  46 +-
> >   winsup/cygwin/sigproc.cc                |  10 -
> >   winsup/cygwin/spawn.cc                  |   4 -
> >   7 files changed, 252 insertions(+), 515 deletions(-)
> LGTM, but it's complicated enough that I could have missed something. 
> It will clearly need lots of testing.
> 
> One trivial suggestion: For clarity, you should probably add the 
> initialization of pipe_mtx to the fhandler_pipe_fifo constructor, 
> although I think it's initialized to NULL by default.  Also, it wouldn't 
> hurt to add a comment in fhandler.h that pipe_mtx is only used in the 
> pipe case, i.e., it remains NULL for fifos.

Thank you for reviewing and advice.
Do you mean testing enough before push? Or testing in the 3.6 branch
before release?

Anyway, I'd like to wait corinna before push.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
