Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E8596385782C; Mon, 13 Jan 2025 13:27:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E8596385782C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736774858;
	bh=m6Cksjia2AiSPR/y5O/SjLXaCiBCARQEpTw20yx++LI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=LtDSMR0SablDzhQvKjofaZ7N6UyrLVD69va42HEEPBZT0rJ5YMyVzTF9jv1ZqLQiM
	 Q0+48+eE7SV+1eIYS74bSnkVmPZ+gN3FnLjjIWgG0DiGOuqqzUmGrz8/JjuWJpnP/m
	 NIoaNO8MyZ/5+Xesna2K9YVqlOV08ep/NtMU3wb4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5F5F5A80A67; Mon, 13 Jan 2025 14:27:37 +0100 (CET)
Date: Mon, 13 Jan 2025 14:27:37 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 6/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 group variants with base
Message-ID: <Z4UUyaB1LwvQawul@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <76ec9f45a016f163efebca0ae7aa143682349a42.1736552566.git.Brian.Inglis@SystematicSW.ab.ca>
 <d9088746-b3ad-40d5-a9b0-37a01a7cfe89@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9088746-b3ad-40d5-a9b0-37a01a7cfe89@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jan 12 17:59, Jon Turney wrote:
> On 11/01/2025 00:01, Brian Inglis wrote:
> > Move circular Ff/Fl and similar functions before hyperbolic Fh? and
> > similar entries to keep base entries together with their -f -l variants.
> 'alphabetic ordering except not in some places as an aesthetic choice' seems
> like a terrible idea to me.

ACK
