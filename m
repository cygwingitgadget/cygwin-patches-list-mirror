Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 5627C3858C98; Mon, 13 Jan 2025 13:26:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5627C3858C98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736774819;
	bh=8rw7vB2N7n8+JjSWGiO68+7kiMCh2AJgKqGp6xZevIw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=KKx6U813vL5lXv/uTNLQMoeS3mw6+cibWK0vfCy6BaEEn5Z1gVVEVt/9N3ijl5ZiG
	 UT78C+QbLRC3b92TkX22mTvP7PVHXGSpX3bGct+nYcngP7O2swwPOvbnMpoJh7XLOO
	 atK/3nHju5fUjsYGbsIUfZI4nrPQ46J9ySeyAnHc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A75C3A80A67; Mon, 13 Jan 2025 14:26:57 +0100 (CET)
Date: Mon, 13 Jan 2025 14:26:57 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 5/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 combine multiple notes
Message-ID: <Z4UUoUfYosf0c4ck@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <01f1853b12130b21d35849f4ee8427efffe523a5.1736552566.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01f1853b12130b21d35849f4ee8427efffe523a5.1736552566.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan 10 17:01, Brian Inglis wrote:
> Combine multiple notes after an entry separated by hyphen ") (" -> " - "
> 
> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> ---
>  winsup/doc/posix.xml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Good idea.


Corinna
