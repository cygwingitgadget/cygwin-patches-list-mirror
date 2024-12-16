Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4252F3858D21; Mon, 16 Dec 2024 12:04:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4252F3858D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1734350652;
	bh=m7LhwK98q///5Zj3EIMkfTdUuix5Ayb9H6r9IkalRNU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=FIZQKE4O9KBlP8tgU+TuAbz2F5023Oz9v2hDCz5akMAlqbLpqZAi64GN7ZDrSLPHy
	 js0SVfYdS+Kb6UC8jwy9kGW3yk8xZ+6FI9iX5+165XfiTHL17ABEuwT5+XWOuWXl7j
	 ekZoVrOdGojkLJFbeHcR8R0J22Cg/oZNZFhRR9lA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3D2FFA8088D; Mon, 16 Dec 2024 13:04:10 +0100 (CET)
Date: Mon, 16 Dec 2024 13:04:10 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: doc: add SCHED_BATCH, SCHED_IDLE and
 SCHED_RESET_ON_FORK
Message-ID: <Z2AXOteT9HEJd68j@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <e6173854-bc4f-b498-0a93-7044f4049b89@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6173854-bc4f-b498-0a93-7044f4049b89@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,

On Dec 12 17:36, Christian Franke wrote:
> Aligns doc with recent commits...

I got a build error due to a stray slash:

.../winsup/doc/posix.xml:1777: parser error : Opening and ending tag mismatch: para line 1772 and literal
set to </literal>IDLE_PRIORITY_CLASS</literal>.
                 ^

Fixed and pushed.


Thanks,
Corinna
