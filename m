Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-047.btinternet.com (mailomta9-re.btinternet.com
 [213.120.69.102])
 by sourceware.org (Postfix) with ESMTPS id 6738A381DCE5
 for <cygwin-patches@cygwin.com>; Thu, 19 Mar 2020 15:41:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6738A381DCE5
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
 by re-prd-fep-047.btinternet.com with ESMTP id
 <20200319154125.WTGO21762.re-prd-fep-047.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Thu, 19 Mar 2020 15:41:25 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [31.51.206.134]
X-OWM-Source-IP: 31.51.206.134 (GB)
X-OWM-Env-Sender: @
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrudefledgkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghenucfkphepfedurdehuddrvddtiedrudefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddujegnpdhinhgvthepfedurdehuddrvddtiedrudefgedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.117] (31.51.206.134) by
 re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5E3A16DE069FE6E9 for cygwin-patches@cygwin.com;
 Thu, 19 Mar 2020 15:41:04 +0000
Subject: Re: [PATCH] Cygwin: Use a separate Start Menu folder for WoW64
 installs
To: cygwin-patches@cygwin.com
References: <20200319135837.2104-1-jon.turney@dronecode.org.uk>
 <20200319150249.GC778468@calimero.vinschen.de>
 <20200319150419.GD778468@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <38387a81-5368-e6ec-b653-fd6f6e05478f@dronecode.org.uk>
Date: Thu, 19 Mar 2020 15:40:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319150419.GD778468@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.3 required=5.0 tests=FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_PASS,
 SPF_NONE autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin-patches mailing list <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <http://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 19 Mar 2020 15:41:27 -0000

On 19/03/2020 15:04, Corinna Vinschen wrote:
> On Mar 19 16:02, Corinna Vinschen wrote:
>> On Mar 19 13:58, Jon Turney wrote:
>>> This aligns the shortcuts to documentation with the setup changes in
>>> https://sourceware.org/pipermail/cygwin-apps/2020-March/039873.html
[...]
>> Good idea, please push.
> 
> ...this requires a new release of setup and Cygwin in lockstep, right?

Worse than that, since this postinstall script checks if smpc_dir 
exists, and does nothing if it doesn't.

So I think I probably want to change that to creating the smpc_dir if it 
doesn't exist, so we don't require that the updated setup has run (and 
completed, creating that directory) before we run that postinstall script.

Sigh.


