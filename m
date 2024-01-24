Return-Path: <SRS0=o9c9=JC=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1012.nifty.com (mta-snd01008.nifty.com [106.153.227.40])
	by sourceware.org (Postfix) with ESMTPS id 676E93858D1E
	for <cygwin-patches@cygwin.com>; Wed, 24 Jan 2024 14:48:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 676E93858D1E
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 676E93858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1706107694; cv=none;
	b=PFvb9otfsfOBllICp5qGVgkB2IbOQIQcMxO0M9wFr8jHGyvZNhM20voOo7eEJoTtxhQATO88dg7vEbvl92P6p8BB1Q8q0ujcZpuVva1ot6fIpWiErjoUzTiBr2iBfvQw0AErqx0dymuooVZQ74kXNFfNoczPM0Ol85RIa+j9i2s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1706107694; c=relaxed/simple;
	bh=RzKmHS2LePXvg5HAZrvdM5dFkfkCNCE4L4v0zOc53bE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version; b=pMfBDkdEW6lw1DoFswvXtjL8sZpz19Jo4lHx4no8/jB9BEVG/cd1G9Y/X+kp4eCQFAT3FpSJZILusTimDpl6PpjTrbUKhNLr4asgiGjExCBD8gPP8yf6nhzuRyINRNv6QNWBCI8JRvLno6ymFGuP/XXOALODcLotav0bUB6ar1E=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by dmta1012.nifty.com with ESMTP
          id <20240124144809036.ZHUP.65725.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 24 Jan 2024 23:48:09 +0900
Date: Wed, 24 Jan 2024 23:48:07 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pthread: Fix handle leak in pthread_once.
Message-Id: <20240124234807.2cb091ad7b315af944bbfe66@nifty.ne.jp>
In-Reply-To: <ZbEhVg3ApRhrWF1Z@calimero.vinschen.de>
References: <20240124134448.39071-1-takashi.yano@nifty.ne.jp>
	<ZbEhVg3ApRhrWF1Z@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 24 Jan 2024 15:40:22 +0100
Corinna Vinschen wrote:
> (You don't have to CC me, btw., I only get the same mail twice then
> and I look into this mailing list constantly anyway)

Perhaps, CC: is added automatically by git send-email if
Reviewed-by: exists. I'll try --no-cc option next time.

Thanks.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
