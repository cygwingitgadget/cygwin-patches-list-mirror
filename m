Return-Path: <SRS0=1ukA=G2=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 225673986404
	for <cygwin-patches@cygwin.com>; Mon, 13 Nov 2023 09:40:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 225673986404
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 225673986404
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1699868448; cv=none;
	b=I2/o/x/g0uvO868wqERtb/DClH/Npmd3kLYnfSLDDdOOVO501ugWn337RvycLQyNsV4NabDvc1I+HvT2/SbWZ0M7TNaIAExJvQ2sq/1KcaXOuB2/vUa7EdITPt2KNH/RKylesrqC93tqT2EUtjcHjeaAkDpszjJLMieN136qR84=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1699868448; c=relaxed/simple;
	bh=Q3oZfHjPWq+u0qXnrYHRq7fO2JmptYrHk3iE8eDmjCs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version; b=j1FiL7eDN7PO5CzTcyBtp+XvU3+f54/Z5SGK/VdH9qxVi8YsMU7p19+B3PWkKklbUf9yvxKCHdcvW8asKETBVcYm1UbFQ9vmq8IhS5AbhGARWUFZNH+oIO5eOo2XG9Lg0WkDUWXyudrqCwd/PszatV4BLg/gQrjw2S/k0Uz/5ng=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost (mark@localhost)
	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id 3AD9eBw6053081
	for <cygwin-patches@cygwin.com>; Mon, 13 Nov 2023 01:40:12 -0800 (PST)
	(envelope-from mark@maxrnd.com)
X-Authentication-Warning: m0.truegem.net: mark owned process doing -bs
Date: Mon, 13 Nov 2023 01:40:11 -0800 (PST)
From: Mark Geisert <mark@maxrnd.com>
X-X-Sender: mark@m0.truegem.net
To: cygwin-patches@cygwin.com
Subject: Re: Which git hash to supply on Fixes: line -- never mind
In-Reply-To: <Pine.BSF.4.63.2311122149490.32206@m0.truegem.net>
Message-ID: <Pine.BSF.4.63.2311130138160.52634@m0.truegem.net>
References: <Pine.BSF.4.63.2311122149490.32206@m0.truegem.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, 12 Nov 2023, Mark Geisert wrote:
> Hi folks,
> I want to submit a patch that fixes 'profiler'.  The Fixes: line of the patch 
> commentary should reference the original addition of profiler to the Cygwin 
> source tree.
>
> Using the gitweb interface, the commit display of profiler.cc shows:
> author	  Mark Geisert <mark@maxrnd.com>  2021-07-15 21:49:55 -0700
> committer Jon Turney <jon.turney@...>     2021-07-19 13:28:37 +0100
> commit	9bd6c0b2b1081ae72d8273038309887fb27f6126 (patch)
> tree	360d7d3cc748683eb9e63729a7e52a62012730e4 /winsup/utils/profiler.cc
> parent	Cygwin: cfsetspeed: allow speed to be a numerical baud rate (diff)
>
> Do I use the last 13 nibbles of the "commit" hash or the "tree" hash?

Never mind; I've figured it out.  It's the "commit" hash, which I 
determined by 'git log profiler.cc'.  Obvious in hindsight.
Cheers,

..mark
