Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C3FE03857B98; Mon, 25 Nov 2024 11:32:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C3FE03857B98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732534360;
	bh=KbA+EihinAZuTHvxpdNs/TbTUSVlvX/dpPO0W3bPkXw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ruWxNvoqmBDi89ye9ZMSqhGhbrq+GUEbWrae99U3p+BQKHnFx3UFJgO6v7qukVXMP
	 K6BkdI/mpo5AyeMeDF2biD4z8BPrj9hoXoxoVDJdNFSPyrZmgy6JphQjt7sI0nOC53
	 lV3OE07fTK2sVUYy1OvLrpjnv/vGQyBwcPoUKR+M=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id BB660A80C06; Mon, 25 Nov 2024 12:32:38 +0100 (CET)
Date: Mon, 25 Nov 2024 12:32:38 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: revert use of CancelSyncronousIo on wait_thread.
Message-ID: <Z0RgVp5RHzGRDDCy@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <65158100-4a68-30c8-8060-e8fef1861c5d@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65158100-4a68-30c8-8060-e8fef1861c5d@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 23 08:37, Jeremy Drake via Cygwin-patches wrote:
> From: Jeremy Drake <cygwin@jdrake.com>
> 
> It appears this is causing hangs on native x86_64 in similar scenarios
> as the hangs on ARM64, because `CancelSynchronousIo` is returning `TRUE`
> but not canceling the `ReadFile` call as expected.
> 
> Addresses: https://github.com/msys2/MSYS2-packages/issues/4340#issuecomment-2491401847
> Fixes: b091b47b9e56 ("cygthread: suspend thread before terminating.")
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
> see also https://github.com/msys2/msys2-runtime/pull/243
> 
>  winsup/cygwin/pinfo.cc   | 10 +++-------
>  winsup/cygwin/sigproc.cc | 12 ++----------
>  2 files changed, 5 insertions(+), 17 deletions(-)

Pushed.


Thanks,
Corinna
