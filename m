Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id DCAFB3857C65
 for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2020 04:19:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DCAFB3857C65
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 09F4JjP0076624
 for <cygwin-patches@cygwin.com>; Wed, 14 Oct 2020 21:19:45 -0700 (PDT)
 (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "[192.168.1.100]"
 via SMTP by m0.truegem.net, id smtpdLASnKn; Wed Oct 14 21:19:39 2020
Subject: Re: [PATCH v2 0/6] Some AF_UNIX fixes
To: cygwin-patches@cygwin.com
References: <20201004164948.48649-1-kbrown@cornell.edu>
 <87bd83c6-5333-6287-01ce-d91ffec83244@cornell.edu>
 <20201013114933.GJ26704@calimero.vinschen.de>
 <ea3b1e6a-8857-cd1f-349d-6fc64c2d1b77@cornell.edu>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <9d20509e-486b-ce79-0701-22557702b2b0@maxrnd.com>
Date: Wed, 14 Oct 2020 21:19:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <ea3b1e6a-8857-cd1f-349d-6fc64c2d1b77@cornell.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
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
X-List-Received-Date: Thu, 15 Oct 2020 04:19:49 -0000

Ken Brown via Cygwin-patches wrote:
> Are you aware of any test suite that I could run?  I've been using examples from 
> Kerrisk's book, because that's what I read to learn the basics of sockets.  But 
> those are just examples and are not meant to be comprehensive.

In ye olden days I used to use Stevens+Rago "Advanced Programming In The Unix 
Environment, 2nd ed.".  Chapter 17 covers UNIX domain sockets as advanced IPC. 
It's more examples but maybe they hit different corners of the playing field.  I 
don't know of a test suite or even a standalone program that exercises AF_UNIX.

..mark
