Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id DF4C8384A40A
 for <cygwin-patches@cygwin.com>; Thu, 26 Nov 2020 10:07:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DF4C8384A40A
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 0AQA7wu4016828
 for <cygwin-patches@cygwin.com>; Thu, 26 Nov 2020 02:07:58 -0800 (PST)
 (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "[192.168.1.100]"
 via SMTP by m0.truegem.net, id smtpdDO8srg; Thu Nov 26 02:07:57 2020
Subject: Re: [PATCH] Cygwin: Speed up mkimport
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
References: <20201126095620.38808-1-mark@maxrnd.com>
Message-ID: <de0a9c1f-75ff-64c8-d9f8-2a22336d516e@maxrnd.com>
Date: Thu, 26 Nov 2020 02:07:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <20201126095620.38808-1-mark@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 26 Nov 2020 10:08:00 -0000

Previously, Mark Geisert wrote:
> Cut mkimport elapsed time in half by forking each iteration of the two
> time-consuming loops within.  Only do this if more than one CPU is
> present.  In the second loop, combine the two 'objdump' calls into one
                                                  ^^^^^^^
That should say objcopy.  The code is correct though.

..mark
