Return-Path: <SRS0=15Wh=6Z=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 103284BA2E04
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 13:53:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 103284BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 103284BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766152398; cv=none;
	b=igWJiEPcuvSIvPNhqdQAlkuNPaS/gIP3Id37itnKhJFgFwctuczjQlZvlcJ3lG3nCYvr8mKy+alNWIT9Usdg8RZ7WYFL0Ca+x61IfAHsy01OPVpZQkG1ObQYHtKPsJViaYvrZkSpzNVReG1qpFwwszreYCVleJ8m/Sm3pJY0soA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766152398; c=relaxed/simple;
	bh=BHXZqsym/ZJVVcnkrQveA9nHaHz0VR2QTJ5GO0saQow=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=EEkmC8p2EuqnihUDaPMSEhE1rPlDxhIuQ68uF3W33E0OE3Xwo66chE9fR7fU60b9794mlpxhlC+xfOFCmwulKGCYK3lPgN3WtSAT+hm4MKSJHrvNLpzcABi/kmenQ4UtoQlDokg+pIGp0/d95Qx6ChBgZj7k7i+McwiJnxSr/20=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 103284BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FBhK7GR2
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20251219135315322.QUBZ.61558.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 22:53:15 +0900
Date: Fri, 19 Dec 2025 22:53:13 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/3] Cygwin: newgrp(1): fix POSIX compatibility
Message-Id: <20251219225313.c96ee56ee33537d51fdd3ce0@nifty.ne.jp>
In-Reply-To: <20251210173201.193740-1-corinna-cygwin@cygwin.com>
References: <20251210173201.193740-1-corinna-cygwin@cygwin.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766152395;
 bh=DFZe8l23Pazsn6JbXQSsyJb77Z8xKTNc4S/IebYEtCM=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=FBhK7GR2Qv9OsVzpVUdt0hd3sAhOU4z95Vd2BTzT5yUmNlIfOcEo6kgfXF6kiEWkpURhe3lQ
 eefXbUbmMdAkjbOhdrL7B1zgNuY5fCjvrgk0w320Fuu3H8OnmZhw5G/BKxIxI3qjIn8prkrbSB
 Ua4UVbyi/fb7TwEjYI/tXKIJh/9YS/Xebue2NfFCQEWz/uJ+rQZ3rpoAYYJa2G8dUzCGzsR32Y
 Uh5NIQoVRGUeY0P9VbprgxUPGq3gdxvl7g7h1ev24+dbUynlHT6BrwKdNNpeKJQ++eN1jVUKqQ
 c2hS15Dg4m9oKZVP95beMUyotH9dREJR81sUiTzidPePE3AQ==
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Wed, 10 Dec 2025 18:31:58 +0100
Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> As outlined in the thread starting at
> https://cygwin.com/pipermail/cygwin/2025-December/259055.html,
> newgrp(1) didn't allow numerical group IDs.  While this is in line with
> the shadow-utils version of newgrp(1), it's not what POSIX allows.
> Fix up the code and the documentation to be more in line with POSIX.
> 
> Corinna Vinschen (3):
>   Cygwin: newgrp(1): improve POSIX compatibility
>   Cygwin: doc: utils.xml: improve newgrp(1) documentation
>   Cygwin: add release note for newgrp(1) fixes
> 
>  winsup/cygwin/release/3.6.6 |  3 +++
>  winsup/doc/utils.xml        | 27 ++++++++++++++++-----------
>  winsup/utils/newgrp.c       | 30 ++++++++++++++++++++----------
>  3 files changed, 39 insertions(+), 21 deletions(-)
> 
> -- 
> 2.52.0
> 

Shouldn't this patch series apply for cygwin-3_6-branch as well?
I'm asking because these paches are not cherry picked in to
cygwin-3_6-branch, but documented in release/3.6.6.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
