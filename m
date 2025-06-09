Return-Path: <SRS0=6Xew=YY=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	by sourceware.org (Postfix) with ESMTPS id 75B3B3858D38
	for <cygwin-patches@cygwin.com>; Mon,  9 Jun 2025 21:40:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 75B3B3858D38
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 75B3B3858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749505214; cv=none;
	b=qkzDrcNhLCJYY7NWL/yQnY7x7+DZWuPnoV94s4+6mpTazO1g6pwiTWUqFbhV9OVReFM/PSEKLb7YjEsBf2SZaZBWAvCYoE3s4QqEgOn88VlEFZB3jcXzTb1dawh7/lxOIkIJlblBYFXiJjIzDwuN6xFvaRCeHjJB7D/UWJ4+5Vg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749505214; c=relaxed/simple;
	bh=sWOlhezppsxsatVyzi1NE/baAF+xCpt77d+6yLfv+U4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=Z9jhPik3YYd1OUKCynFBEJZB4JExO6zjAIWHiOKMxzqqhFYc7YXqGp9ijg+4jCETPDlvRfmpGe7ALh29O4VYqFON8oRM2H9njf0P1a5P9H/UmyXSk0+IM8lU2gpQUDSN3ds/9F2jLUc1tuPnwHi2S0OetNBMpmqviyPS7T8K2gg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 75B3B3858D38
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=YIHiudfH
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 1BC7C1D0F26
	for <cygwin-patches@cygwin.com>; Mon,  9 Jun 2025 21:40:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf03.hostedemail.com (Postfix) with ESMTPA id A5E906000F
	for <cygwin-patches@cygwin.com>; Mon,  9 Jun 2025 21:40:12 +0000 (UTC)
Message-ID: <1ef68eee-d80a-4dde-af43-c4fdea1e4c40@SystematicSW.ab.ca>
Date: Mon, 9 Jun 2025 15:40:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix compatibility with MinGW v13 headers
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <DB9PR83MB09238924363B70583AA08BA5926BA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <7178d417-9d6b-14b2-95cb-b5c4fb53b463@jdrake.com>
Organization: Systematic Software
In-Reply-To: <7178d417-9d6b-14b2-95cb-b5c4fb53b463@jdrake.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: xz916tfb8we5s3a3io5rkhnz5eht73u7
X-Rspamd-Server: rspamout02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: A5E906000F
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19G39myUZXzkYDAeOVgaxjvSGfZoD2HfP8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=7/SBqYvqeIoAgufBJZZsCUXc7w+p2tviXpBDT3TpzYw=; b=YIHiudfH2joJVst3vgcxclCV4IzZ5NxVdjawdQdK6QSTqaUWnAQD1osjysusdxAE53HtpZOyguwu7ZJe3LBEjeiRtYJ9iPsGnyWRQzUXWdWdzYj4MvORhedr94YW8bovxi1MizHF1cijVnBtHrHsVqntGTygE0iqO1i6Tg3ILlV/sXcL1BYsATVaqmbXrKMyD0e5bMDAjpwVRqgYCAK92yiZH9BIibDCFYVW8ZWIY9ritnw8zml2aNRdt6/5xgI0eSrLMxFcvG9/aAurXHEhXREz7vdCx+0FxnaUfhkEDs3wSvF0jVae/rsP741ZfXYuwzU79QoJNqHRBHgoKAzp0g==
X-HE-Tag: 1749505212-633380
X-HE-Meta: U2FsdGVkX1+W+0mKaWlQsGKFvUdPD9VOMz08v/YrvCRg3/chNmGeK9KDMGpY/Gw84BOxqkUvtEQofntNRzjdg4nz9p7FTf9ofPKbljPfsZGnxUcokgZdeLjzF/KC3u4VNJvOAYIB3FHYYOPjflfH7smhNDcd+yJizmdZiMbNcVl0JIs52oARQamum75EDbC/TtAw/KjsMISgmF22DF6PzTulawEjXf0fPbLtast1ojXXrjGFD/Lwt00O1jUKn3rEjFWHzu4HXa1LFzSvylgMVBZQ+fVwPABuc1OIEiA6M3AAU14eUiUfP8XKWTgVGKbI4LkXqnn9lrmM7RKtMjeBjY9sTBFO9ftLvUYgCvkz3JU/7nwwMFzdMJI2B1SNm8bwWv/5deam4GE=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-06-09 12:54, Jeremy Drake via Cygwin-patches wrote:
> On Mon, 9 Jun 2025, Radek Barton via Cygwin-patches wrote:
>> Since today, https://github.com/cygwin/cygwin/actions/runs/15537033468 workflow started to fail as it seems that `cygwin/cygwin-install-action@master` action started to use newer MinGW headers.
>>
>> The attached patch fixes compatibility with v13 MinGW headers while preserving compatibility with v12.

Perhaps in the case of this build, but not necessarily anywhere else in Cygwin 
using BSD sockets.

> The change to cygwin/socket.h concerns me, that is a public header, and
> you can't assume they are including MinGW headers, and if they are how
> they are configuring them (ie, _WIN32_WINNT define) or which ones they
> are including.  It looks like the mingw-w64 header #defines cmsghdr, maybe
> an #ifndef cmsghdr with a comment about this situation?  Or how do other
> Cygwin headers handle potential conflicts with Windows headers?
I appear to be missing where Mingw headers other than ntstatus.h are included in 
these Cygwin headers so how would Mingw version be defined here?

It looks like the changes need to be made elsewhere across the code hierarchy.

What are the actual Mingw header definition changes causing conflicts, and do 
any Cygwin headers, setup or other network apps code need to be adjusted to take 
the Mingw header changes into account?

Such details would be required to explain why the patch would be needed and how 
it fixes the issue while taking compatibility with and any impacts on Cygwin 
network apps into account.

This should perhaps be referred back to the w32api-headers maintainer to see if 
he did any testing before deployment?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
