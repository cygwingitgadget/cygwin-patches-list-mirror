Return-Path: <SRS0=0NVs=7N=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id 0E7E84BA2E04
	for <cygwin-patches@cygwin.com>; Thu,  8 Jan 2026 12:46:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0E7E84BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0E7E84BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767876391; cv=none;
	b=evg9hmlr2cPlgaZ6Mu3IMMBqJmtMeFQJNZnCkA26kpudiw5nCZvAkZcvrt8WNevvaOGwZrEMc7AMqwZu6eyN9b6e2ZQP/OcYnYgR4IEvDr4HuSzMnbv/ygfT0bnWdZ2exLW0EbMYhPMJKPfypW8I6FHYD5V6C2LbS7+CoVS20ss=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767876391; c=relaxed/simple;
	bh=V8L/d5SqhNkqtvOBC+xlgTagIUUxAEuvbwcIEYhuePE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=kxwv6GDKiqb2S5O+3kEfQWAdTNEwAmTzjp3A97TKmeAl1iFgHvwsBuCOVEl4TIxHtTrGh3rYtPkWMGc7VsVsXzBZnHjhao7pToobMQAuAgNBbeLVC4l/Glz0n5bdA0X/eQZCGu6JevY0Uwb80kAAcM/ZqK2mOwNAt1oqmt3/lLA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0E7E84BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=sQLR07OV
Received: from HP-Z230 by mta-snd-w06.mail.nifty.com with ESMTP
          id <20260108124629229.HEV.86286.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 8 Jan 2026 21:46:29 +0900
Date: Thu, 8 Jan 2026 21:46:26 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: flock: Remove the unnecessary fdtab lock
Message-Id: <20260108214626.1487161c6da89f7f2603b05d@nifty.ne.jp>
In-Reply-To: <20260108123502.989-1-takashi.yano@nifty.ne.jp>
References: <20260108123502.989-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1767876389;
 bh=NIGykgh3rxsrlRy1yRuCscv1Z37YACGwPxXhpN8+eKQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=sQLR07OVVKhrq/ccudWu6lLW8aC6JMURh5OuIszSJx1xpLEpinYNrtGoKN4GNYBamT/EufQZ
 XqgfzfMXEHV0IKrQHDd2bmVirauNeGFiy2oas95yGE53Du29vSUH7TALso12v/uTH9nFUDVJvO
 AHIpnTuSubUKbbwen1tTIIcjsfaw+Yu4WFPLIJH78uZGkwsOGci1bDlW6cZ+obvoaONBzUo0lL
 Nvv4T33uNCUZOVi7zz+Wj3CzcZqmilcnwHIhc/jufTJjGRAX2+koMlaraXRobB0vzpkDt782+s
 5iIR9n5L7OlvgZHyxZ7lXDepH6og8YZ3YCQlw8jKG5l+Ucrw==
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu,  8 Jan 2026 21:34:40 +0900
Takashi Yano wrote:
> There were two fdtab locks: one is in inode_t::del_my_locks(), and
> the other is in fixup_lockf_after_exec().  The merely counts the file
> descriptors affected by the corresponding lock, so locking fdtab seems
> unnecessary.  The latter only only during execve(), when no other
                           ~~~~~~~~~
runs only

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
