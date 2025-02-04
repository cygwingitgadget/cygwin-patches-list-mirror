Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 527793858D20; Tue,  4 Feb 2025 09:01:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 527793858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1738659719;
	bh=235uXL/0LOHgqUJNGBXH4roaAFRlJZwhoYS1yijY7xI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=o9id7vzG/CYNlEYgOuE3VeF7Qks7wPfJdGjdhHYjeBxkMr8xf0Ku56qiaEZn2Qtan
	 ROeDyuQRgN/CDw4ef8OmNgn17VnjjCB7s0/JCx0Fog6w4mcBh8COT6bKjjRtqjbGYP
	 oNVitnZSvdbxv8mbCdSU7xczrkewrBJAH7uX+AUk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B8BA1A809BC; Tue,  4 Feb 2025 10:01:57 +0100 (CET)
Date: Tue, 4 Feb 2025 10:01:57 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: factor out code to resolve a symlink target.
Message-ID: <Z6HXhfgbVzQN-xWo@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <fd3e4a7d-6d5d-a938-79b5-65e2a5a8942f@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd3e4a7d-6d5d-a938-79b5-65e2a5a8942f@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

On Feb  3 11:38, Jeremy Drake via Cygwin-patches wrote:
> This code was duplicated between the lnk symlink type and the native
> symlink type.
> 
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>  winsup/cygwin/path.cc | 62 +++++++++++++++++++------------------------
>  1 file changed, 28 insertions(+), 34 deletions(-)

Pushed.


Thanks,
Corinna
