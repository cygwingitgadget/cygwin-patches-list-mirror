Return-Path: <SRS0=1ukA=G2=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id DF52A3858C29
	for <cygwin-patches@cygwin.com>; Mon, 13 Nov 2023 06:01:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DF52A3858C29
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DF52A3858C29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1699855302; cv=none;
	b=yBLjgKWasn25vjfwGBA5BJFq+IeT7cCseG2n/qcc1x5VNInNm30ECL1i6Cn08nkvUaP/TusHAnt4GSaoRIBH6ttXiOzIus5Oz4m+hIi76smSQ2Irh2R7uq6968RKaEZyZ3jwpPVGDZYR6WkCg3lWivkkTKwEo9KDl6iCRvkS/WA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1699855302; c=relaxed/simple;
	bh=XA+9i1RXtP0QlhvZ+zdHeMrD4HENwKTHHrYNKJuqwls=;
	h=Date:From:To:Subject:Message-ID:MIME-Version; b=wsvsah4yn4sg8ssxpNS5WX2vAFB/egfz/N68RGsYF/sRKGumkaBh0ZBn3XzmqgyREarWyS4mmXprCkFpiCzX6aZf7KqaR8r0xz7xQlZeK+epjgAENU5DgfGF6G+BLMg2o0ecws0eedUwFRvRmjuueVCF8N+BihBtqdzmWX3JZR8=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost (mark@localhost)
	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id 3AD616na033711
	for <cygwin-patches@cygwin.com>; Sun, 12 Nov 2023 22:01:06 -0800 (PST)
	(envelope-from mark@maxrnd.com)
X-Authentication-Warning: m0.truegem.net: mark owned process doing -bs
Date: Sun, 12 Nov 2023 22:01:06 -0800 (PST)
From: Mark Geisert <mark@maxrnd.com>
X-X-Sender: mark@m0.truegem.net
To: cygwin-patches@cygwin.com
Subject: Which git hash to supply on Fixes: line
Message-ID: <Pine.BSF.4.63.2311122149490.32206@m0.truegem.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi folks,
I want to submit a patch that fixes 'profiler'.  The Fixes: line of the 
patch commentary should reference the original addition of profiler to the 
Cygwin source tree.

Using the gitweb interface, the commit display of profiler.cc shows:
author	  Mark Geisert <mark@maxrnd.com>  2021-07-15 21:49:55 -0700
committer Jon Turney <jon.turney@...>     2021-07-19 13:28:37 +0100
commit	9bd6c0b2b1081ae72d8273038309887fb27f6126 (patch)
tree	360d7d3cc748683eb9e63729a7e52a62012730e4 /winsup/utils/profiler.cc
parent	Cygwin: cfsetspeed: allow speed to be a numerical baud rate (diff)

Do I use the last 13 nibbles of the "commit" hash or the "tree" hash?

First time I've seen both; on previous patches I've supplied a hash but 
I'm not sure which one of these they were because I was relying on some 
other method to find them.
Thanks,

..mark
