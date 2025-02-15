Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 653FD3858C53; Sat, 15 Feb 2025 10:29:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 653FD3858C53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1739615353;
	bh=syzFfW6Rt/WMcuqhmgQ/PjChLx3XJvSLcB7WT2SXvEM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=e8LdOEBNnSHMp6BaRuZOo8l9kce6Di9Rz0hPXBHhRUIl3jkrA0TBR3iL9YI1bsSxL
	 u9kR+KyeWiBPa0m3uyXyR2izcpHLqmjcTaFhANn3ZWY/0J6cOYsq+rt9aLGe9sS3RC
	 SNRKjJ0oM7rhtoxb38XqJFBBvhZnkTSdvcUUHvno=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5D0FCA80CC9; Sat, 15 Feb 2025 11:29:11 +0100 (CET)
Date: Sat, 15 Feb 2025 11:29:11 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 0/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 TOG Issue 8 ISO 9945 updates
Message-ID: <Z7BsdyPyN1sM6SpV@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

Hi Brian,

On Jan 17 10:01, Brian Inglis wrote:
> Please note some changes are displaced due to rebase conflicts.
> 
> Brian Inglis (5):
>   Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 TOG Issue 8 ISO 9945 move new
>   Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 new additions available
>   Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 not implemented new additions
>   Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 move or remove dropped entries
>   Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 combine multiple notes
> 
>  winsup/doc/posix.xml | 285 ++++++++++++++++++++++++++++---------------
>  1 file changed, 184 insertions(+), 101 deletions(-)
> 
> -- 
> 2.45.1

since we're going 3.6 (hopefully) in two weeks, is there a new patchset
forthcoming?  From what I can tell, the number of changes compared to v7
isn't that big and it might be nice to get this into the repo for the
3.6 docs.  I'm waiting for your stuff before adding POSIX 1.e and eaccess.


Thanks,
Corinna
