Return-Path: <SRS0=Rby/=4M=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-041.btinternet.com (mailomta28-sa.btinternet.com [213.120.69.34])
	by sourceware.org (Postfix) with ESMTPS id C875C382CE15
	for <cygwin-patches@cygwin.com>; Wed, 14 Dec 2022 17:37:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C875C382CE15
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20221214173736.GEII8077.sa-prd-fep-041.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Wed, 14 Dec 2022 17:37:36 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6139452E47E245D9
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefgddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedvtefhtddtudfgtdfftdeiieehhfekudejkeffvdeuhfeutdduueduveffkeeuueenucffohhmrghinhepghhithdqshgtmhdrtghomhenucfkphepkedurdduheefrdelkedrvdegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtiegnpdhinhgvthepkedurdduheefrdelkedrvdegiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.153.98.246) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 6139452E47E245D9; Wed, 14 Dec 2022 17:37:36 +0000
Message-ID: <5de5fda5-b43c-affd-2c61-ad9986c1bf96@dronecode.org.uk>
Date: Wed, 14 Dec 2022 17:37:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] Cygwin: Improve FAQ on early breakpoint for ASLR
Content-Language: en-GB
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
 Cygwin Patches <cygwin-patches@cygwin.com>
References: <20221103170430.4448-1-jon.turney@dronecode.org.uk>
 <alpine.BSO.2.21.2211031120540.30152@resin.csoft.net>
 <Y2TqvPTB7Hui2jmJ@calimero.vinschen.de>
 <4ccbb5e1-ee4f-8944-ed44-4af7fa79f048@dronecode.org.uk>
 <f2942e0e-ea5e-7ba9-8770-b422628dafad@gmail.com>
 <a2e01953-f6ef-cf08-f6e1-0c7632391ede@dronecode.org.uk>
 <Y3NuGWbczdW5f+rC@calimero.vinschen.de>
 <8a0287ed-6f20-4a05-b584-966bfded6833@dronecode.org.uk>
 <Y4TImGsIsHnJya3W@calimero.vinschen.de>
 <5spqn8n0-q9r4-48r5-qo91-0o4qs27358s1@tzk.qr>
 <9ae73a17-051e-b577-ccfc-a33c96076390@dronecode.org.uk>
 <769CE863-866A-4E6B-A7D6-8EFA09B5D9F8@gmx.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <769CE863-866A-4E6B-A7D6-8EFA09B5D9F8@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3570.1 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 11/12/2022 14:45, Johannes Schindelin wrote:
> On December 11, 2022 2:54:02 PM GMT+01:00, Jon Turney <jon.turney@dronecode.org.uk> wrote:
>> On 05/12/2022 15:23, Johannes Schindelin wrote:
>>> On Mon, 28 Nov 2022, Corinna Vinschen wrote:
>>>> On Nov 28 13:00, Jon Turney wrote:
>>>>> On 15/11/2022 10:46, Corinna Vinschen wrote:
>>>>>>
>>>>>> It would be great if we could get used to using the same syntax as the
>>>>>> Linux kernel project to document stuff.  I'm trying to follow their lead
>>>>>> for a while.  For fixes to former commits, it looks like this in the
>>>>>> kernel, at the end of the commit message:
>>>>>>
>>>>>> Fixes: 123456789012 ("title of commit 123456789012")
>>>>>>
>>>>>> Yeah, core.abbrev is 12 digits.  I'm using this setting for quite some
>>>>>> time locally.
>>>>>
>>>>> Sounds good.  Is there some script to automate generating this kind of
>>>>> comment from a commit-id?
>>>>
>>>> I don't think so, at least I don't see anything like that in git docs...
>>>
>>> It's note _quite_ what you asked for, but `git show --pretty=reference -s
>>> <commit>` (https://git-scm.com/docs/git-show#_pretty_formats) gives you
>>> _almost_ what you are looking for.
>>>
>>> But you can always call `git show -s --format='%h ("%s")' <commit>`, and
>>> even configure an alias for this:
>>>
>>> 	git config --global alias.pretty-print-commit \
>>> 		"-c core.abbrev=12 show -s --format='%h (\"%s\")'"
>>>
>> Thanks!
>>
>> I added '-c core.pager=', but this is what I was looking for, to save a
>> bit of copying and pasting and editing.
>>
> 
> Better use `git -P`, then... (see https://git-scm.com/docs/git#Documentation/git.txt--P for full details)
> 

I started off with that, but that fails when used with:

fatal: alias 'pretty-print-commit' changes environment variables.
You can use '!git' in the alias to do this

... which I'm sure tells me the right way to write this :)

