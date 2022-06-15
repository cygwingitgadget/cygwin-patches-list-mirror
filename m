Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-047.btinternet.com (mailomta10-re.btinternet.com
 [213.120.69.103])
 by sourceware.org (Postfix) with ESMTPS id 5FED7385734C
 for <cygwin-patches@cygwin.com>; Wed, 15 Jun 2022 11:40:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5FED7385734C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
 by re-prd-fep-047.btinternet.com with ESMTP id
 <20220615114007.SQMT3222.re-prd-fep-047.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Wed, 15 Jun 2022 12:40:07 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 613A91242901948F
X-Originating-IP: [86.139.167.41]
X-OWM-Source-IP: 86.139.167.41 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedruddvuddggedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeffkeeigfdujeehteduiefgjeeltdelgeelteekudetfedtffefhfeufefgueettdenucfkphepkeeirddufeelrdduieejrdegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddthegnpdhinhgvthepkeeirddufeelrdduieejrdeguddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.105] (86.139.167.41) by
 re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613A91242901948F for cygwin-patches@cygwin.com;
 Wed, 15 Jun 2022 12:40:07 +0100
Message-ID: <b288ba30-650b-d114-c139-f1f5df6e8958@dronecode.org.uk>
Date: Wed, 15 Jun 2022 12:40:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] Cygwin: Make 'ulimit -c' control writing a coredump
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20220615112115.21040-1-jon.turney@dronecode.org.uk>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <20220615112115.21040-1-jon.turney@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1193.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_PASS, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Wed, 15 Jun 2022 11:40:10 -0000

On 15/06/2022 12:21, Jon Turney wrote:
> Factor out pre-formatting a command to be executed on fatal signal, and
> use that for both error_start (if present in the CYGWIN env var) and for
> 'dumper'.
> 
> Factor out executing that command, so we can use it from try_to_debug()
> and when a fatal signal occurs.
> 
> Because we can't control the size of the core dump written by that, only
> invoke dumper if the core file size limit is unlimited.
> 
> Otherwise, if that limit is greater than 0, we will write a .stackdump
> file, as previously.
> 
> Change the default limit from unlimited to 1 MB, to preserve that
> existing behaviour.

Maybe this design tries too hard not to change anything and instead we 
should:

keep default ulimit -c as unlimited

ulimit 0     write nothing
ulimit <=4K  write a .stackdump [*]
ulimit >4K   write a .core

In cases where we wrote something, check afterwards if it's bigger than 
the ulimit and if so, remove it.

(Maybe this still loses if e.g. 1MB of disk space remains, ulimit is 
2MB, actual size of coredump is 3MB, since we'll end up with a partial 
coredump when we shouldn't have written anything, but maybe that's 
what's supposed to happen?)

[*] where 4K is arbitrarily chosen as a bit bigger than any possible 
.stackdump currently.

> Adjust and clarify the associated documentation.
> 
> Also: Fix the (deprecated) cygwin_dumpstack() function so it will now
> write a .stackdump file, even when ulimit -c is zero.
> 
> (Note that cygwin_dumpstack() is still idempotent, which is perhaps odd)
> 
> Also: Fix so that the error_start JIT debugger is now invoked, even when
> ulimit -c is zero.
> 
> Also: Fix uses of console_printf() inside exec_debugger(). It's output
> is written via the Windows console device, so needs to use Windows-style
> line endings.
> 
> Future work: Perhaps we should use the absolute path to dumper, rather
> than assuming it is in PATH, although circumstances in which cygwin1.dll
> can be loaded, but dumper isn't in the PATH are probably rare.
> ---
>   winsup/cygwin/cygheap.cc    |   2 +-
>   winsup/cygwin/environ.cc    |   1 +
>   winsup/cygwin/exceptions.cc | 100 +++++++++++++++++++++++++-----------
>   winsup/cygwin/winsup.h      |   1 +
>   winsup/doc/cygwinenv.xml    |  22 +++++---
>   winsup/doc/utils.xml        |  31 ++++++-----
>   6 files changed, 107 insertions(+), 50 deletions(-)
