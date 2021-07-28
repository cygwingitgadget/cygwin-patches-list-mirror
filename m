Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-043.btinternet.com (mailomta9-re.btinternet.com
 [213.120.69.102])
 by sourceware.org (Postfix) with ESMTPS id 9636A3853800
 for <cygwin-patches@cygwin.com>; Wed, 28 Jul 2021 19:56:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9636A3853800
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
 by re-prd-fep-043.btinternet.com with ESMTP id
 <20210728195630.NLFV22650.re-prd-fep-043.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Wed, 28 Jul 2021 20:56:30 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9BDD03DECFFCC
X-Originating-IP: [86.139.158.70]
X-OWM-Source-IP: 86.139.158.70 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvtddrgeelgdduuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeejtdfghfevhfeuhfdtjeejfeeiffdvgfegleeuveeiheetgfejudeviedvffehfeenucffohhmrghinheptgihghifihhnrdgtohhmpdhgihhthhhusgdrtghomhenucfkphepkeeirddufeelrdduheekrdejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepkeeirddufeelrdduheekrdejtddpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.139.158.70) by
 re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9BDD03DECFFCC for cygwin-patches@cygwin.com;
 Wed, 28 Jul 2021 20:56:30 +0100
Subject: Re: [PATCH 0/3] Add more winsymlinks values
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20210719163134.9230-1-jon.turney@dronecode.org.uk>
 <YPfYgz0EHe7Yw5ko@calimero.vinschen.de>
 <0b2f3506-b5f8-5e73-b92f-62583dbd4fdb@dronecode.org.uk>
 <YPl+7gROlATG/ggs@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <8c228092-1699-35aa-7558-106f49fde87f@dronecode.org.uk>
Date: Wed, 28 Jul 2021 20:55:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPl+7gROlATG/ggs@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1194.0 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 28 Jul 2021 19:56:33 -0000

On 22/07/2021 15:21, Corinna Vinschen wrote:
> On Jul 22 14:53, Jon Turney wrote:
>> On 21/07/2021 09:19, Corinna Vinschen wrote:
>>> On Jul 19 17:31, Jon Turney wrote:
>>>> I'm not sure this is the best idea, since it adds more configurations that
>>>> aren't going to get tested often, but the idea is that this would enable
>>>> proper and consistent control of the symlink type used from setup, as
>>>> discussed in [1].
>>>>
>>>> [1] https://cygwin.com/pipermail/cygwin-apps/2021-May/041327.html
>>>
>>> Why isn't it sufficient to use 'winsymlinks:native' from setup?
>>
>> I think in the default Windows configuration (developer mode off, no
>> SeCreateSymbolicLinkPrivilege), 'native' will try to create a native symlink
>> and fail, and fallback to WSL IO_REPARSE_TAG_LX_SYMLINK reparse point, then
>> magic cookie + sys attribute.
>>
>> This leads to cygwin installations with WSL symlinks created by post-install
>> scripts, which can't be put into Docker containers [1], which is the
>> original problem I was trying to fix.
>>
>> [1] https://cygwin.com/pipermail/cygwin/2020-August/245994.html
> 
> Did nobody ask the Docker guys why they fail to support perfectly
> valid reparse points?

It seems so e.g. [1]. The answer isn't much beyond "yes, that doesn't 
work", though.

[1] https://github.com/moby/moby/issues/41058#issuecomment-692968944

>> I haven't yet looked at adding 'native' symlink support to setup itself, but
>> it's probably going to be a bit of a pain.
> 
> That may be not a bad idea after all.  Setup typically runs as elevated
> process, so it has the required permissions to create native symlinks.
> Scripts could then run with CYGWIN=winsymlinks:native by default.
> 
> As long as nobody has the hare-brained idea to move a Cygwin distro
> manually, native symlinks should be just as well as Cygwin symlinks.

I'm pretty reluctant to add this to setup in any form which isn't 
initially  "keep doing what we currently do, unless you explicitly ask 
for symlinks to be made a different way".  (especially since when we 
changed what we were doing in Cygwin 3.1.5, it opened this whole can of 
worms)

So I don't think that gets us any further forward if setup doesn't have 
useful control over the kinds of symlinks made by post-install scripts.

>>> The way we express symlinks shouldn't be a user choice, really.  The
>>> winsymlinks thingy was only ever introduced in a desperate attempt to
>>> improve access to symlinks from native tools, and I still don't see a
>>> way around that.  But either way, what's the advantage in allowing the
>>> user complete control over the type, even if the type is only useful in
>>> Cygwin?
 >>
>> If we can come up with a fixed policy that works everywhere, there is no
>> advantage.  But that seems unlikely :)
>>
>> I could buy an argument that 'native' should be the default (although maybe
>> all that does is slow things down in the majority of installs?).
> 
> It may slow down installations a tiny little bit because the target
> paths have to be converted to POSIX, but I doubt this is more than just
> a marginal slowdown.

My assumption was that "the majority of installs" are running where 
native symlink creation isn't permitted, so the slowdown I meant was 
that adds "try to create a native symlink, fail and fallback" for every 
symlink creation.
