Return-Path: <SRS0=EoNB=QP=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w08.mail.nifty.com (mta-snd-w08.mail.nifty.com [106.153.227.40])
	by sourceware.org (Postfix) with ESMTPS id 3FEE33858D26
	for <cygwin-patches@cygwin.com>; Tue, 17 Sep 2024 13:06:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3FEE33858D26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3FEE33858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1726578418; cv=none;
	b=EawsCtFv617UK1N7YmB/d3vXFhxtDxkPBY883+wbGpUslaGB+7Ig8Ej/FngnkxI+VtY3wf30cHFgWSJVcDTbxahEhtAI6Bf6xWeKqKmKAQEGsWCvfOLiiI/DAogyYer/6A3+KCbVQialbP4pOrIajLOELBeCDSqkj+FvfAdqt2E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1726578418; c=relaxed/simple;
	bh=OjH+rEkj9c1liTPR5qmf/GvdSAXITj7wmPGWSh7v3hE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=YANUrqIZ89LR06woRuwhri2hOHoEketS6NQ0MioyjIKXoruYs+wLAv4EswcZI+pplUGNklCp1m00exKX+qtpI7ER/P4PYt6T7JUinZDabLkTCFe+CN42UzQZpOVqGngb5T8qWNzCKuX+FxoufHwS3wuzPuOcn7k/R85mG8EZhDo=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-w08.mail.nifty.com with ESMTP
          id <20240917130652913.VGI.4660.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 17 Sep 2024 22:06:52 +0900
Date: Tue, 17 Sep 2024 22:06:51 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pipe: Restore blocking mode of read pipe on
 close()
Message-Id: <20240917220651.ec05e8f932842438f33d3607@nifty.ne.jp>
In-Reply-To: <1748f37a-89d2-4245-a3f7-74d0a627a58e@cornell.edu>
References: <20240906080850.14853-1-takashi.yano@nifty.ne.jp>
	<1748f37a-89d2-4245-a3f7-74d0a627a58e@cornell.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1726578413;
 bh=rRRpL45z4ZpG1Q9bKPp8104olocpVkBeERiCQ8ByLdE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=rjuGGpOb2ZrR/xe7Y9iIrKVkF0EJc3t0wBrJfNCV1s/GkaAUUtT1UlMBJw2/rz6KV2B8BbJT
 xoOyYAIxvfs5ie11aMr9Ed0Z9bk6RpGyErjRv6W0DOi2zecR78+yDajvShGxtgQUZUyiBN/tyC
 U0oMzE+MY1bLoRb8PBdMAYiEuZl42ACaBMRGLdRQjlAE1usQUCDjqq5UvnXOzlmTe0i6khttYB
 eM96LRGSU/yx7TBbiV3rawHLmWBz57L4yRrAcjzu+IYZW8MsJfpm/G4ij4CSf372HMmcuMy8OU
 V8hUl7z9Q4jbgVPAOAN6wxIvlgG299X+bS5CVgkeiFSrn4Sw==
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 12 Sep 2024 17:35:52 -0400
Ken Brown wrote:
> On 9/6/2024 4:08 AM, Takashi Yano wrote:
> > If a cygwin app is executed from a non-cygwin app and the cygwin
> > app exits, the read pipe remains in the non-blocking mode because
> > of the commit fc691d0246b9. Due to this behaviour, the non-cygwin
> > app cannot read the pipe correctly after that. Similarly, if a
> > non-cygwin app is executed from a cygwin app and the non-cygwin
> > app exits, the read pipe remains in the blocking mode. With this
> > patch, the blocking mode of the read pipe is stored into a variable
> > was_blocking_read_pipe on set_pipe_non_blocking() when the cygwin
> > app starts and restored on close(). In addition, the pipe mode is
> > set to non-blocking mode in raw_read() if the mode is blocking
> > mode as well.
> > 
> > Addresses: https://github.com/git-for-windows/git/issues/5115
> > Fixes: fc691d0246b9 ("Cygwin: pipe: Make sure to set read pipe non-blocking for cygwin apps.");
> > Reported-by: isaacag, Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >   winsup/cygwin/fhandler/pipe.cc          | 41 +++++++++++++++++++++++++
> >   winsup/cygwin/local_includes/fhandler.h |  3 ++
> >   winsup/cygwin/sigproc.cc                |  9 +-----
> >   3 files changed, 45 insertions(+), 8 deletions(-)
> 
> LGTM, but I haven't tried to test it (except to make sure that the 
> branch still builds).  I assume you've tested it.  My only question is 
> whether you want to mention the variable is_blocking_read_pipe in the 
> commit message.

Thanks for revewing!

I added the description for is_blocking_read_pipe to the commit message
and pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
