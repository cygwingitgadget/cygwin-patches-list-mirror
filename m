Return-Path: <SRS0=MQXb=FD=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 73E094BA2E09
	for <cygwin-patches@cygwin.com>; Thu,  9 Jul 2026 12:25:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 73E094BA2E09
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 73E094BA2E09
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783599919; cv=none;
	b=IWHcnjlqiNYN7iOwgqqcnc1eygjaKdrDUnJ5+2YnMoQ2OUf6niExhdvOuKyf38AHI7FEZ+LeTHK5COwBCrY9gFbQeZKbjmd/Ypr/4a7O12XAtwyGVynh6qzxhRF3WuYTnmAoQKNm7mKy7xg3EgKgkI67+u6oonhpWc7iNEDavvQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783599919; c=relaxed/simple;
	bh=JD9g7o5Sf5puwVEuxDoTqQX52qd++PfJvICkaMx4+Us=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Z6ZdyDEKG7zraqYozp5zR6QugMPgIr40bWKghHYLWMKbmHJFhVQKxy6srCQNgHAGxYV3mmE2fmdLiY5c814e80BbhsosYRzXCfmaNRjIpJENw+bquRaoHIjPQrpGOPlTNu1g2OBXxfIq9VLykd5pKWLR3IMntdNIBrpRNdQ5oQc=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=KIntvVDr
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 73E094BA2E09
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=KIntvVDr
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260709122515924.SOPN.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 9 Jul 2026 21:25:15 +0900
Date: Thu, 9 Jul 2026 21:25:14 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Fix nat_pipe_owner_pid when gdb runs
 non-cygwin app
Message-Id: <20260709212514.05f9409ec97112887fbedeb7@nifty.ne.jp>
In-Reply-To: <843d06c0-22a2-1937-6b6a-92adb4d09342@gmx.de>
References: <20260708143017.1073-1-takashi.yano@nifty.ne.jp>
	<843d06c0-22a2-1937-6b6a-92adb4d09342@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1783599915;
 bh=cNbU4NK6MZqF4E0kJPShxGh02Z0h1Wi3jbu1dddFKrw=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=KIntvVDrEaiCvT2MWfJVHurBjjle5qisUV8jAUEX306jvG9lh9zv7IglUftbwtv/c+tnWxGf
 viPS1yBCMP55c2wiyhc0fAmaqpklycMV7WszweigCmy3mNlozDmPYReDxZsGpNtEh3ecWhKOj0
 bOh1BrWZGoDmzhqCsO2VowRNGhPf6T0X4U6QHYEt4qrm3J/nY6FgA3jiQ+0Wb+6l/267dUPZR5
 GrxmV5Yv1yyEPAGKjhlvMcxiBcaKNPiVilSq/TOhUfncJ9HiTN+Qbu4rtN7qcu3Ctb0XQSEjU+
 1f5fM+3xeNhwgmOeEAKVZ5EflyADUY51CUP0wqtqK4YB7XHQ==
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Thu, 9 Jul 2026 10:13:26 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Wed, 8 Jul 2026, Takashi Yano wrote:
> 
> > Previously, nat_pipe_owner_pid was incorrectly set to 0 when the
> > inferior of gdb was a non-cygwin app. Due to this bug, repeatedly
> > running a non-cygwin app under gdb could lead to an unexpected crash.
> > 
> > This occurred because the previous code in setup_for_non_cygwin_app()
> > set nat_pipe_owner_pid to exec_dwProcessId, which is correct when the
> > caller is the stub process of the non-cygwin app. However, when the
> > caller is gdb, the owner should be gdb itself, so nat_pipe_owner_pid
> > must be set to myself->dwProcessId.
> > 
> > With this fix, attach_console_temporarily() can be called with target
> > pid equal to the process's own pid, in which case the attach operation
> > is skipped.
> > 
> > Fixes: 1e6c51d74136 ("Cygwin: pty: Reorganize the code path of setting up and closing pcon.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> > v2: Skip attaching operation when attaching to myself is requested.
> 
> From what I can see, the fix is correct. Three non-blocking notes:
> 
> The new source comment (and the commit message) has exec_dwProcessId and
> dwProcessId the wrong way round, I think. exec_dwProcessId holds the
> stub's own pid, saved before the overlay; dwProcessId is what gets
> repointed to the native child. The code still does the right thing because
> `exec_dwProcessId ?: dwProcessId` reduces to "our own pid" on every path
> that reaches it, which is exactly what the owner-self check already
> assumes. But the commentary as written will mislead the next reader.

Ah, right. I revised the comment and the commit message.

> The sibling assignment in `setup_pseudoconsole()` still writes
> exec_dwProcessId directly, without the fallback. Harmless today because
> its sole caller sets the owner first, but leaving the two spots
> inconsistent invites a future regression. Worth applying the same `?:`
> there.

Indeed. I also apply the fix here.

> Also: I believe that the bug is not really gdb-specific: _any_ Cygwin
> process that spawns a non-cygwin app through the CreateProcess hook
> without _P_OVERLAY hits it. If that is so, the subject and log undersell
> the scope.

Noted to the commit message.

> In any case, I happily provide my:
> 
>   Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Thanks! I'll push the patch to master and cygwin-3_6-branch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
