Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 80B953858D1E; Tue, 11 Feb 2025 10:36:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 80B953858D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1739270177;
	bh=1/GdbKLehG4RxY7zg/Ezl0AkP+XKP9Re1PcCFyjZrSs=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Yjq28jdfn2UQE4fPXlwhu6PsZokftny29/NpQlPXWHa8HzZp1dggueQ+fTjHsc/26
	 LsB1kTAHFCy+GlBrLy1thqdKvN/99QmOkPCzZ8DcR8oeJVzdJyD4qzzNelG+MrVtjO
	 wz08xFLHlRWIFuEWVzT9+MhyqTX2PGFBBIpoyoK8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 79B86A80D4C; Tue, 11 Feb 2025 11:36:15 +0100 (CET)
Date: Tue, 11 Feb 2025 11:36:15 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Cygwin: make list of mounts for a volume in
 dos_drive_mappings
Message-ID: <Z6soHzMvH9hcJMRY@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <827294fb-0391-197f-6b53-52ea0f5e11e7@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <827294fb-0391-197f-6b53-52ea0f5e11e7@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb 10 17:13, Jeremy Drake via Cygwin-patches wrote:
> make mappings linked list in order rather than reverse order.

Why?  I'm not asking for myself, but for the commit message.
It may profit a lot from explaining what the change is supposed
to accomplish. :)


Thanks,
Corinna
