Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A9159385841C; Wed,  5 Feb 2025 10:25:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A9159385841C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1738751116;
	bh=j85x1JGPIP/I0E6t6jN/PdD3xbbEqDk7hWbhA2kM25c=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=xW1gW95HMkHl7a99WVFERbwUZCpDPZyn3GKT1lrdzMrfvUNKvA6Fxo0eW9axWmGBT
	 YVDCfcxPM1F4DEyxQB7fc8c2OjywLqLxlbqLQzlzdWCZgkh/5JYse6n2iYGaLIkC6v
	 oExvdkjZOaBA2+nHbPPbsPBkG3+BloOSG8SXd1ro=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0F2C8A80CAE; Wed,  5 Feb 2025 11:25:15 +0100 (CET)
Date: Wed, 5 Feb 2025 11:25:15 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: /proc/<PID>/mount*: escape strings.
Message-ID: <Z6M8iyIsgLaE9_G7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <d7c79b40-237b-2f76-fc4d-3b7c3376199d@jdrake.com>
 <f3707f39-5858-15b0-e136-a07b2d8d7e76@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3707f39-5858-15b0-e136-a07b2d8d7e76@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

On Feb  4 13:47, Jeremy Drake via Cygwin-patches wrote:
> I sent this patch in June
> (https://cygwin.com/pipermail/cygwin-patches/2024q2/012712.html), and I
> recently remembered I hadn't heard anything about it.

Sorry for missing this patch!  Looks good.  Pushed.


Thanks,
Corinna
