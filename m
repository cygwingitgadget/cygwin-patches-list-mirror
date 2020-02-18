Return-Path: <cygwin-patches-return-10086-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30223 invoked by alias); 18 Feb 2020 11:34:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 30213 invoked by uid 89); 18 Feb 2020 11:34:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-04.nifty.com
Received: from conssluserg-04.nifty.com (HELO conssluserg-04.nifty.com) (210.131.2.83) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 18 Feb 2020 11:34:47 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-04.nifty.com with ESMTP id 01IBYhnm023179	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2020 20:34:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 01IBYhnm023179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582025683;	bh=u+b+21zFc+tisoOTffcZZTMfbU72cp4+ga4slGPAyCc=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=eBfsPc3nDKgsYouYfUK7JXm7iau3XnYBrYIEqsUPPITrHL3xIaouZhLZiRcQyl+zw	 U897oyfI+AzaVFl3xHr/L75Ak6F9166etWUulOAu+KxjR4uku06c7yQpu7rJPPf+Dm	 fVUqApTEXfJsU+N+be+fT6132w/lH8ixJtod9UoAIrCUSTpKL+7zRXNF8ImogiQZfS	 JupKUEEWATuJaVky3LYDYjTH28nljiMIV9cdZvVemKUiOzbue8MovQB7eyLa2Din1Q	 8PI5OrmQs1rxBVHAaYSOIQrtFE/CIvrE1ldl2JQ6SROTtPx8WAzoIIaXBWR+cNu3d6	 nlKMX/X6L9QYQ==
Date: Tue, 18 Feb 2020 11:34:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: console: Add guard for set/unset xterm compatible mode.
Message-Id: <20200218203446.d70de4ddc487d246f74c9aed@nifty.ne.jp>
In-Reply-To: <20200218104336.GI4092@calimero.vinschen.de>
References: <20200218091254.415-1-takashi.yano@nifty.ne.jp>	<20200218104336.GI4092@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00192.txt

On Tue, 18 Feb 2020 11:43:36 +0100
Corinna Vinschen wrote:
> On Feb 18 18:12, Takashi Yano wrote:
> > - Setting / unsetting xterm compatible mode may cause race issue
> >   between multiple processes. This patch adds guard for that.
> > ---
> >  winsup/cygwin/fhandler.h          |   6 ++
> >  winsup/cygwin/fhandler_console.cc | 125 +++++++++++++++++++++---------
> >  winsup/cygwin/select.cc           |  22 ++----
> >  winsup/cygwin/spawn.cc            |   8 +-
> >  4 files changed, 103 insertions(+), 58 deletions(-)
> 
> The patch looks good to me, but I'm curious...
> 
> Yesterday you wrote that interlocked counting is not a good
> solution due to the 'bash -> cmd -> bash' scenario.  What has
> changed your mind?

Interlocking in this patch is not used in open/close, but
in read()/select() for input, and in write()/close()/exec()
for output. For input, InterlockedIncrement/Decrement() is
used and InterlockedExchage() is used for output.

As for bash->cmd->bash case, first xterm mode is enabled
for output and input in write() and read() in bash, then
xterm mode for input is disabled when it returns from read().
When cmd.exe is executed, xterm mode for output is disabled
in exec(). As a result, cmd.exe is executed under xterm mode
disabled. Next, when bash is executed, xterm mode is re-
enabled in write()/read().

After that, if second bash is exited, xterm mode for input
is disabled when returned from read(), and for output, it
is disabled in close(). Then, cmd.exe is executed under
xterm mode is disabled. If cmd.exe is exited, xterm mode
is re-enabled in write()/read() in bash.

After all, xterm mode for input is enabled/disabled each
read() and select() call. xterm mode for output is enabled
when write() is called and disabled in close() and exec()
for non-cygwin process.

On Mon, 17 Feb 2020 10:00:15 +0100
Corinna Vinschen wrote:
> In terms of this patch, rather than to change the mode on every
> invocation of read/write/select/close, wouldn't it make more sense to
> count the number of mode switches in a shared per-console variable, i.e.

In other words, it is not as suggested above.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
