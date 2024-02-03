Return-Path: <SRS0=MPDs=JM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1003.nifty.com (mta-snd01007.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id C31E03858403
	for <cygwin-patches@cygwin.com>; Sat,  3 Feb 2024 15:04:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C31E03858403
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C31E03858403
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1706972677; cv=none;
	b=maUvde6iDqMp8kmxwoyvGOPYUdSfx/nHmi/I6FiYt7JutyIsic777U2eyd9UYEYxUdtr1/7IyGERYBQ0vBh9XSTZtrpxm67do+U8i7SSTeeHoTEXxeaS56LSfx17Bhfg3HJSjYPXtn0ID7G7n7i03Mdm9pRlpHKC84XRAPyxxuY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1706972677; c=relaxed/simple;
	bh=7psxn/0uC3yHBKJBMsmIqFIZklf64iCwSedMNFWoWIc=;
	h=Date:From:To:Subject:Message-Id:Mime-Version; b=JroJ8yEajzz6Y6KcEtEn/COaA+gg9zm/jl2PYb0G1CYj6lG7huIRy+H3bbAAgYcXQUat07jv0io3V6Qv4WnBmZjpKeYhuYQD1LsP2nKxVF3Spz9+K+ABd0InJmVLa5TxzeXGNXVSrbnoV40d2dgy1I0vrYRNwLm30eAqLnxNEiY=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by dmta1003.nifty.com with ESMTP
          id <20240203150430861.QBWI.95478.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 4 Feb 2024 00:04:30 +0900
Date: Sun, 4 Feb 2024 00:04:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix exit code for non-cygwin process.
Message-Id: <20240204000430.4e0373736deaec9e72a87a0d@nifty.ne.jp>
In-Reply-To: <9d19f0fe-b547-0ec7-146b-fbaf12baa986@gmx.de>
References: <20240202052923.881-1-takashi.yano@nifty.ne.jp>
	<23727ea4-229b-cf13-057d-e9f0e2790b61@gmx.de>
	<9d19f0fe-b547-0ec7-146b-fbaf12baa986@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 3 Feb 2024 15:27:06 +0100 (CET)
Johannes Schindelin wrote:
> On IRC, you reported that the thread would crash if `cons` was not fixed
> up. The symptom was that that crash would apparently prevent the exit code
> from being read, and it would be left at 0, indicating potentially
> incorrectly that the non-Cygwin process succeeded.
> 
> I wonder: What would it take to change this logic so that the crash would
> be detected (and not be misinterpreted as exit code 0)?

I am not sure, but I think it is necessary to modify:
pinfo::exit()
pinfo::meybe_set_exit_code_from_windows()
pinfo::set_exit_code()

I guess detecting crash of sbub process needs modification of
spawn.cc.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
