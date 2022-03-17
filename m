Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id D4704385DC31
 for <cygwin-patches@cygwin.com>; Thu, 17 Mar 2022 03:06:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D4704385DC31
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 22H36X8A094964
 for <cygwin-patches@cygwin.com>; Wed, 16 Mar 2022 20:06:33 -0700 (PDT)
 (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "[192.168.1.100]"
 via SMTP by m0.truegem.net, id smtpdYhGexz; Wed Mar 16 19:06:26 2022
Subject: Re: [PATCH] Cygwin: Fix gmondump formatting goofs
To: cygwin-patches@cygwin.com
References: <20220315004730.15783-1-mark@maxrnd.com>
 <YjGVOi2/U1W6N2xu@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <82807ebd-fb9f-7b22-8a5c-481be755402d@maxrnd.com>
Date: Wed, 16 Mar 2022 20:06:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <YjGVOi2/U1W6N2xu@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, KAM_LINKBAIT, NICE_REPLY_A, SPF_HELO_NONE, SPF_NONE,
 TXREP, T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Thu, 17 Mar 2022 03:06:36 -0000

Corinna Vinschen wrote:
> On Mar 14 17:47, Mark Geisert wrote:
>> The rewrite of %X to %p was malhandled.  Fix that/them.
> 
> This should probably go into 3.3 as well.  Care to write a
> matching entry for the release/3.3.5 file?
Done, under separate patch
https://cygwin.com/pipermail/cygwin-patches/2022q1/011851.html
Cheers,

..mark
