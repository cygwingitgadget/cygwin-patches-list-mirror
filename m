Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-041.btinternet.com (mailomta11-sa.btinternet.com
 [213.120.69.17])
 by sourceware.org (Postfix) with ESMTPS id 3F3FD386103B
 for <cygwin-patches@cygwin.com>; Thu, 22 Oct 2020 18:58:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3F3FD386103B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
 by sa-prd-fep-041.btinternet.com with ESMTP id
 <20201022185800.IUIX29142.sa-prd-fep-041.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Thu, 22 Oct 2020 19:58:00 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9B8A7174E68CE
X-Originating-IP: [86.139.158.27]
X-OWM-Source-IP: 86.139.158.27 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrjeekgdehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepudekiefgledvudfhgeevffehieeuieeujeehfeelffdtgeeltefguedtvdegffejnecuffhomhgrihhnpehgnhhurdhorhhgnecukfhppeekiedrudefledrudehkedrvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeekiedrudefledrudehkedrvdejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.139.158.27) by
 sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9B8A7174E68CE for cygwin-patches@cygwin.com;
 Thu, 22 Oct 2020 19:58:00 +0100
Subject: Re: [PATCH 3/3] Remove recursive configure for cygwin
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20201021194705.19056-1-jon.turney@dronecode.org.uk>
 <20201021194705.19056-4-jon.turney@dronecode.org.uk>
 <20201022172710.GS5492@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <fb4a8bf6-9b4a-3e77-cb32-bdd7fcce49fe@dronecode.org.uk>
Date: Thu, 22 Oct 2020 19:57:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201022172710.GS5492@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1194.4 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_SHORT, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Thu, 22 Oct 2020 18:58:02 -0000

On 22/10/2020 18:27, Corinna Vinschen wrote:
> On Oct 21 20:47, Jon Turney wrote:
>> There's doesn't seem to be much use in independently building these
>> subdirectories,
> 
> Uhm... that doesn't match how I'm working in these dirs.  I'm building
> the subdirs independently all the time, especially during debugging
> sessions.  I'd not want to lose the ability to build in the
> cygwin or utils dirs independently.

Sorry for being unclear here.  What I mean here is we are currently 
handling those subdirectories as if they are independent packages, which 
could distributed and built separately.

(See discussion of AC_CONFIG_SUBDIRS in [1])

[1] 
https://www.gnu.org/software/autoconf/manual/autoconf-2.69/html_node/Subdirectories.html

This doesn't remove the ability to run make in those subdirectories.

>> so allowing them to be independently configured seems
>> pointless and overcomplicated.
> 
> There's not much of a reason to allow independent configuring, I guess,
> but apart from the base configure run during a build from top-level,
> I sometimes run configure only in the dir I change or add files.

I actually skimped on writing the rules which reconfigure when needed 
when make is run in a subdirectory, as working them out seemed complex 
and a bit redundant, as when I convert to automake, it writes them for you.

I guess I should take another look at that.

>> The order in which the subdirectories are built is still a little odd,
>> as cygwin is linked with libcygserver, and cygserver is then linked with
>> cygwin. So, we build the cygwin directory first, which invokes a build
>> of libcygserver in the cygserver directory, and then build in the
>> cygserver directory to build the cygserver executable.
> 
> Does creating a new subdir called libcygserver just to build the lib
> clean up things, perhaps?

I did experiment with something like that, but I'm not sure if it makes 
things any clearer, as:

(i) It's the same source files built with/without -D__OUTSIDE_CYGWIN__
(ii) building libcygserver requires the generated file globals.h

