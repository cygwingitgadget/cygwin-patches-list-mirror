Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1D3FF4BA2E3B; Mon, 30 Mar 2026 08:34:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1D3FF4BA2E3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1774859672;
	bh=VqbBvC4wJSX4l4OY63WrRI4ryVrXRnJQLZz2FJFPxSk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tATnCz7dQqO2NbwQWaFKIfRwWsJEttdcg0XCS9HXtN3H1/UFITdJo5DfT9JF26jsV
	 xEI+XfmijqWT4BR3vjK9FMzMdXgYoy+uesn1FncleOsj93C2Id6aEkWuaqsyQcrQjm
	 y+vGOiahenJbvIRSL0I5LPi0S9w45Sx3rYiaMePg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3CBBFA80C43; Mon, 30 Mar 2026 10:34:30 +0200 (CEST)
Date: Mon, 30 Mar 2026 10:34:30 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Igor Podgainoi <Igor.Podgainoi@arm.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>
Subject: Re: [PATCH 1/1] Cygwin: Fix SEH and signal handling on AArch64
Message-ID: <aco1lg07YbVH7rVR@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Igor Podgainoi <Igor.Podgainoi@arm.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>
References: <cover.1774613608.git.igor.podgainoi@arm.com>
 <042c0cc99b70b4ec9959d4977b8cfcb224200bbb.1774613608.git.igor.podgainoi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <042c0cc99b70b4ec9959d4977b8cfcb224200bbb.1774613608.git.igor.podgainoi@arm.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Igor,

On Mar 27 12:43, Igor Podgainoi wrote:
> This patch adds the SEH_CODE macro (defined in exception.h), allowing
> a single EXCEPTION_HANDLER_DATA metadata definition to be used on both
> AArch64 and x86_64 architectures.
> 
> It also fixes an issue related to stack replacement in _dll_crt0 that
> impacts SEH and signal handling, where due to an epilogue optimization
> on AArch64 the epilogue might appear before _main_tls->call. However,
> after the stack replacement this optimization becomes broken.

Can you explain why this problem only affects aarch64 and not x86_64
as well?


Thanks,
Corinna
