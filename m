Return-Path: <SRS0=haOa=BZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id 9308F4BB3BF0
	for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 13:43:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9308F4BB3BF0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9308F4BB3BF0
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774446228; cv=none;
	b=cqqGdZJlSM7+kn7212wrDzJZkdHNpge/ZO1LKZysUpzmJUMFbObehcurfFd63lvyEBON1Weu2rUIr2TxmoHp7ktHGsAbq3xPNNOMBZKzYoZl4xmiCalIb3BpCc6Ofv9h9adR3kl1+nrPNdpRjPPRrVNk4SB7lcIJ+1JALN3nur0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774446228; c=relaxed/simple;
	bh=yJ/YQ2h7BzwsgoVVEuvVc0ES3m/j+U6zwN0uGEujW4M=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=BhXzO6BVCHjoNO6iwIu7RopyYQw/+TPF0iZIGE7lIeBuWSIqNB39/oXuBGpxR5Thq1CJdLF0D+0aX6kPsggljN1OsfFjfR3XWa01bi1WN+ilmUnmaN3uzBPMbb8Z4NM4KyeaPTNE+QN6kHDmhT12fVitIrfmvJAtUiioi4/cZ7g=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9308F4BB3BF0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=jvyWXuLc
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260325134345806.DFWO.14880.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 22:43:45 +0900
Date: Wed, 25 Mar 2026 22:43:43 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Status of pty and console pathces
Message-Id: <20260325224343.5d92b9ee72ec70e0a09b133a@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774446225;
 bh=9DgHkKQmW8AtvhJQxPbVmAB8IwDvp1LwqMoks3tZBEA=;
 h=Date:From:To:Subject;
 b=jvyWXuLcfUbGbCAsGJpGxvI8RJE42FkqPFLW1p81L3Sl3VTFDWDrmDmek0DPF11ugVh1Fkp2
 S7dR1RZ9KWVfluyKF1K1y4zu7fDSO/v3j+9PZZ5PXNnmmq0E8MMSeWENOva2sOvxmgHcpa31ew
 S7j4mAUc3XDJuMIFWuzYwvKl/GrLKxqTzskvgl8SyYGgGcJXA+iNI7qnsMCzWeg55Mg8oMzniY
 Tg7wAtBJ3p3dBRaZL/S7+FnMyPG9bgsyL9UBNzu8aRlgKhxzM5+hnnj7giFu1E87TUmUxLceq4
 w12ofUD8tR9Ok0236DFSF+egbs+yHK1J/cIzrN6ba4JtnIgQ==
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

I currently am proposing the following patches that is waiting for review.

Many of bugs are uncovered by Johannes's reproducer:
https://cygwin.com/pipermail/cygwin-patches/2026q1/014714.html
I really appreciate for providing such a reproducer.


[New feature]
===== OpenConsole (v6) ====
Cygwin: console: Fix master thread for OpenConsole.exe
Cygwin: pty: Handle CSIc in pcon_start phase (*)
Cygwin: pty: Use OpenConsole.exe if available (*)
===========================


[Bug fixes]
Cygwin: pty: Make pcon_start handling more multi thread durable
Cygwin: pty: Fix write data handling in pcon_start phase

Cygwin: pty: Clear discard_input flag on master write()
Cygwin: console: Release pipe_sw_mutex in pcon_hand_over_proc()

====== out-of-order patch (v7) ====
Cygwin: pty: Drop nat_fg() check from to_be_read_from_nat_pipe()
Cygwin: pty: Guard to_be_read_from_nat_pipe() by pipe_sw_mutex
Cygwin: pty: Guard get_winpid_to_hand_over() with attach_mutex
Cygwin: pty: Apply line_edit() for transferred input to to_cyg
Cygwin: console: Use input_mutex in the parent PTY in master thread
Cygwin: pty: Add workaround for handling of backspace when pcon enabled (*)
Cygwin: console: Fix master thread
===================================

Cygwin: pty: Omit CSI?1004h/l from pseudo console output
Cygwin: pty: Fix input transfer when multiple non-cygwin apps exist

Cygwin: pty: Make Ctrl-C work for non-cygwin app in GDB (*)
Cygwin: pty: Restore nat handles in all PTY-slave instances in GDB


(*) means the patch reviewed once and revised.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
