Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 by sourceware.org (Postfix) with ESMTPS id 39A1F3858424
 for <cygwin-patches@cygwin.com>; Thu,  3 Feb 2022 09:28:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 39A1F3858424
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (v036249.dynamic.ppp.asahi-net.or.jp
 [124.155.36.249]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id 2139SW85012729
 for <cygwin-patches@cygwin.com>; Thu, 3 Feb 2022 18:28:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 2139SW85012729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1643880512;
 bh=mYMc+9jDsIxVlSW/ej1ZdDmEUEgGYQk6qkfwUvgZVYU=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=btpVEcBXZUNE905drg6a2yP29tXkjSl81P1rUhmdTlzvDBAgIvdpvv7kmQ28jKSJ/
 P6fUMfQgVvHAla2wqSLi3UBgOTNgtakYzcV2CAq1UV786HedBZcz5q16hMWBzuBcPn
 YFicbs93g3hc61LRXE4+fqlP5kLL3oHMzWqhGCXJtiqpsLEhV0uIEqvdlXveSXXxvr
 X/0psiepcIc5yQj5ac3U3Nnd25AOJwTwh2BcuGBtsI6ZGUidOxfaIFdpbbw5pwvAJb
 ihn1mNTj8klpsGKTfQdLyk9amBPPZMOWYhjVbCzytlRkHLL84dlbElFFfLxNz/pKga
 3KJ77Xo7K7AKg==
X-Nifty-SrcIP: [124.155.36.249]
Date: Thu, 3 Feb 2022 18:28:32 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: path: Fix UNC path handling for SMB3 mounted to
 a drive.
Message-Id: <20220203182832.3f0613375ce8eadd2cd27b05@nifty.ne.jp>
In-Reply-To: <YfuZK5lTopYPSwwZ@calimero.vinschen.de>
References: <20220203084026.1934-1-takashi.yano@nifty.ne.jp>
 <YfuZK5lTopYPSwwZ@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Thu, 03 Feb 2022 09:28:52 -0000

On Thu, 3 Feb 2022 09:58:19 +0100
Corinna Vinschen wrote:
> On Feb  3 17:40, Takashi Yano wrote:
> > - If an UNC path is mounted to a drive using SMB3.11, accessing to
> >   the drive fails with error "Too many levels of symbolic links."
> >   This patch fixes the issue.
> 
> LGTM, please push.

Thanks for reviewing.

> I'm curious.  I'm using Samba as well and never saw this problem.
> Can you describe how to reproduce?

I used samba under debian stretch last December, and
confirmed current code worked without the problem.

Recently, I have upgraded the server OS from stretch
to bullseye, and noticed this problem.

Perhaps, samba version and its protocol version may be
related.

My samba version is: Version 4.13.13-Debian

This also happens with shared folder under Windows 10
in my environment.

Win10 version is:
Microsoft Windows [Version 10.0.19044.1466]

The reproducible steps are as follows.

$ net use z: '\\server\sharedname'
The command completed successfully.

$ cd /cygdrive/z
/cygdrive/z: Too many levels of symbolic links.
$

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
