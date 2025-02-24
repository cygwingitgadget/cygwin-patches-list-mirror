Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 78D573858D34; Mon, 24 Feb 2025 11:44:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 78D573858D34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1740397483;
	bh=iwgjqUTG+ky2wUFz9NpcIAJTIwGzOU6Cxt8pFmgT76Y=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=s2LU1np+4xiHlWqcHUPdxI+uYO4MGwgn5NB9x5dfmFWTvhfZAYTIxwwwDZKCHZ6n3
	 JkxHRf3m/poXFzllyCCjkmEWQewTLkSf02aKuySTNHCzlWpFtTERM2R4OVrJYIqxkG
	 Jm6NYsbZFUVDIJvUKbZ+QDgUbEFtQ3PWqR/XrtFI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4665DA80610; Mon, 24 Feb 2025 12:44:41 +0100 (CET)
Date: Mon, 24 Feb 2025 12:44:41 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8 0/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 TOG Issue 8 ISO 9945 updates
Message-ID: <Z7xbqZPOc065srJK@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1740246116.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1740246116.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Feb 22 10:48, Brian Inglis wrote:
> Missed title update squeezed into last patch.
> 
> Brian Inglis (5):
>   Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 TOG Issue 8 ISO 9945 move new POSIX
>   Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 new additions available
>   Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 not implemented new additions
>   Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 move or remove dropped entries
>   Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 combine multiple notes
> 
>  winsup/doc/posix.xml | 297 +++++++++++++++++++++++++++----------------
>  1 file changed, 186 insertions(+), 111 deletions(-)

Pushed with just a single change: I added posix_close in January,
so I removed it from the unimplemented interfaces (and forgot to
add it to the implemented interfaces so I had to add YA patch to
the set).

Thanks,
Corinna
