Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B9E703858CD1; Mon, 18 Mar 2024 09:33:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B9E703858CD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1710754425;
	bh=8Xj2j5W0O2IOzbDkE55It9ArRxmDCaxoBJsd1frVpSo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mZMpCmvNiLi1PVNO0aZXd1WYrWkKz4bmcXxOjj7+oZY/ity+tAVdWQhC94vnK5jAe
	 QTBGsYtvA0k+JXLwEbvGsvXlftvaFAn2ATv8K7PfPdBuJLT90t4DJKGH16QzxtvaEN
	 Xf5k5leKCtXVLrqlkJ9juS+gYVzQRcHgyPONQB6s=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id ED42EA80BFE; Mon, 18 Mar 2024 10:33:43 +0100 (CET)
Date: Mon, 18 Mar 2024 10:33:43 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup/cygwin/fhandler/proc.cc: format_proc_cpuinfo()
 Linux 6.8 cpuinfo flags
Message-ID: <ZfgKd7GX7o7gCoX7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>,
	cygwin-patches@cygwin.com
References: <86a84fad25ec3b5c49e9b737dfccbdb2f510556e.1710519553.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86a84fad25ec3b5c49e9b737dfccbdb2f510556e.1710519553.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

Hi Brian,

On Mar 16 10:44, Brian Inglis wrote:
> add Linux 6.8 cpuinfo flags:
> Intel 0x00000007:1 eax:17 fred		Flexible Return and Event Delivery;
> AMD   0x8000001f   eax:4  sev_snp	SEV secure nested paging;
> document unused and some unprinted bits that could look like omissions;
> fix typos and misalignments;

I'm a bit puzzled about the "unused" slots.  You're adding them
only in some places.  What makes them "look like omissions"?


Thanks,
Corinna
