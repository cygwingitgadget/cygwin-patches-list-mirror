Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id C32D63858D34
 for <cygwin-patches@cygwin.com>; Wed, 13 May 2020 22:40:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C32D63858D34
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: from localhost (mark@localhost)
 by m0.truegem.net (8.12.11/8.12.11) with ESMTP id 04DMejX8082453
 for <cygwin-patches@cygwin.com>; Wed, 13 May 2020 15:40:45 -0700 (PDT)
 (envelope-from mark@maxrnd.com)
X-Authentication-Warning: m0.truegem.net: mark owned process doing -bs
Date: Wed, 13 May 2020 15:40:45 -0700 (PDT)
From: Mark Geisert <mark@maxrnd.com>
X-X-Sender: mark@m0.truegem.net
To: cygwin-patches@cygwin.com
Subject: Re [Cygwin PATCH */9] tzcode resync -- for discussion only
Message-ID: <Pine.BSF.4.63.2005131531040.41959@m0.truegem.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 13 May 2020 22:40:50 -0000

I'm not absolutely sure yet but I think this patch set isn't complete. 
What's been posted is OK for discussion (on cygwin-developers?) but would 
need to be augmented if you're going to apply as-is.

I had a git commit/revert mishap and these are recovered file versions.  I 
belatedly discovered there's no record in the patches of my creating 
directory winsup/cygwin/tzcode or of my deleting localtime.cc and 
tz_posixrules.h from winsup/cygwin in my local repository.

When it becomes time to submit the final patch versions, I'll do so from a 
brand new repository.  Sorry for any confusion.

..mark
