Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 081C13858D35
 for <cygwin-patches@cygwin.com>; Tue, 25 Aug 2020 07:29:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 081C13858D35
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 07P7TIXf061219
 for <cygwin-patches@cygwin.com>; Tue, 25 Aug 2020 00:29:18 -0700 (PDT)
 (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "[192.168.1.100]"
 via SMTP by m0.truegem.net, id smtpdblps4R; Tue Aug 25 00:29:08 2020
Subject: Re: [PATCH] Cygwin: malloc tune-up
To: cygwin-patches@cygwin.com
References: <20200824045913.1216-1-mark@maxrnd.com>
 <20200824094843.GZ3272@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <65eafa55-54e3-7d5b-3fa0-4f3dce99a668@maxrnd.com>
Date: Tue, 25 Aug 2020 00:29:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <20200824094843.GZ3272@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 25 Aug 2020 07:29:23 -0000

Hi Corinna,
Well, this patch turned out to be half-baked.  Locking is working correctly 
because USE_LOCKS was set to 1 for malloc.cc's compilation.  The torture test I 
run validated that.  OTOH as you said, MSPACES was set 1 for malloc.cc but 0 for 
malloc_wrapper.cc.  So this patch yields a malloc facility like pre-3.2 but 
using internal locking on data structures instead of function-level locking.  An 
improvement, but not the whole package that I'm attempting to deliver because 
there's still thread contention on the internal locks.  Properly operating 
mspaces should get rid of that or at least lower it significantly.

I appreciate your comments on TLS variables and fork safety.  I will investigate 
this area further.  The mspaces should/will survive a fork but obviously the 
threads that created them won't.  Memory blocks can be freed by any thread; 
there's no need to create threads in the child process just to manage mspaces.

I have more work to do then I'll submit a v2 of the patch.
Thanks & Regards,

..mark
