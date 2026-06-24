Return-Path: <SRS0=WipY=EU=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 492E34BA2E04
	for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 07:09:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 492E34BA2E04
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 492E34BA2E04
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782284977; cv=none;
	b=M1mRWtX3byibk3fiy91xy4F0NTMHJjJQyzYps8uFnlk/pTfSw+bipWDAamNUBO616UQMXC9wR9qecX1otWSjPZ2V6YnIrn/QW6rxpwQ+lVVcY7bboHkKJTStzwLW5Una9a6vwiP2KWH1m39Kc2jAfjzyk6Ck7a5XFqdf9MO/ZrI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782284977; c=relaxed/simple;
	bh=+CEyphSyM7GtwpbAetqnSp8xVNgdXrfvhycaxorUhZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=n7ir/xHRRyzRBWlpp5zB7SLFEeSQbDG20uxGDFOJgbpJfg4LyyMpBdA4ALeM9hrHEIRM/Hal5HOtFiTEpBgpv3bYTpbfDSRZc6PhujLV3ftDtytQwI3FPOJRvfuKPtdzu3CcgkBtbQgZEKQjL5EAdf2TgF36C3jBJwCO9/3F3sE=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 492E34BA2E04
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 65O7OZR5037568
	for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 00:24:35 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdnYrSpp; Wed Jun 24 00:24:27 2026
Message-ID: <47a930e6-12ec-4512-a566-1bbccffcbaf2@maxrnd.com>
Date: Wed, 24 Jun 2026 00:09:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] Cygwin: pty: Fix race issue between starting and
 exiting non-cygwin apps
To: cygwin-patches@cygwin.com
References: <20260623225137.263-1-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260623225137.263-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

This v7 LGTM.  OK to push.
Thanks,

..mark

On 6/23/2026 3:51 PM, Takashi Yano wrote:
> Without this patch, when a non-cygwin program (A) is about to exit, and
> another non-cygwin program (B) is started, input transferring between
> cyg-pipe and nat-pipe may not work as expected. When the non-cygwin
> program (A) exits, input transferring from nat-pipe to cyg-pipe will be
> performed. However, the the non-cygwin program (B) will performs input
> transferring from cyg-pipe to nat-pipe at the same time. The mechanism
> of the problem is as follows.
>   1) The the non-cygwin program (A) checks current input pipe state,
>      then it is nat-pipe since the this program is a non-cygwin program.
>      The program (A) also checks if any handover target exists, but
>      it is not found since the program (B) is not started yet. So,
>      the program (A) decided to transfer input form nat-pipe to cyg-
>      pipe.
>   2) Before the non-cygwin (A) program performs input transferring,
>      if the non-cygwin program (B) is started and checks the input
>      pipe state, it is nat-pipe state, so the non-cygwin program (B)
>      does not perform input transferring.
>   3) However, just after that, the non-cygwin program (A) performs
>      input transferring from nat-pipe to cyg-pipe, so typeahead input
>      will be stored in cyg-pipe.
>   4) The non-cygwin program (B) cannot read the typeahead input
>      because it is now in the cyg-pipe.
> 
> The following code demonstrates the issue.
>    #include <stdio.h>
>    #include <stdlib.h>
>    #include <unistd.h>
> 
>    int main(int argc, char *argv[])
>    {
>      int n = 1;
>      if (argc > 1)
>        n = atoi(argv[1]);
>      if (fork()) {
>        execlp("cmd.exe", "cmd", NULL);
>        perror("execlp(\"cmd\"): ");
>      }
>      for (int i=0; i<n; i++) {
>        if (fork() == 0) {
>          execlp("./winsleep.exe", "winsleep", "0", NULL);
>          perror("execlp(\"winsleep\"): ");
>        }
>      }
>      return 0;
>    }
> 
> Transferring input itself is guarded by input_mutex, but the pre-
> check is not. With this patch, the guard is enhanced so that the
> state check and transferring input are done in atomic way.
> 
> Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Mark Geisert <mark@maxrnd.com>
> ---
>   winsup/cygwin/fhandler/pty.cc           | 99 +++++++++++++++----------
>   winsup/cygwin/local_includes/fhandler.h |  2 +
>   2 files changed, 60 insertions(+), 41 deletions(-)
[...]
