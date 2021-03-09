Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.137])
 by sourceware.org (Postfix) with ESMTPS id 8F90F386EC7D
 for <cygwin-patches@cygwin.com>; Tue,  9 Mar 2021 06:08:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8F90F386EC7D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([68.147.0.90]) by shaw.ca with ESMTP
 id JVXqlgLrenRGtJVXrlGHFL; Mon, 08 Mar 2021 23:08:39 -0700
X-Authority-Analysis: v=2.4 cv=cagXElPM c=1 sm=1 tr=0 ts=604710e7
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=IkcTkHD0fZMA:10 a=uYT-Tk0qkVT609LjNaIA:9 a=QEXdDO2ut3YA:10
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
References: <20210307163155.63871-1-Brian.Inglis@SystematicSW.ab.ca>
 <aada0b19-26ea-9db0-85f4-8f959441e05a@dronecode.org.uk>
 <38792da7-75f7-231d-0de2-d483b927820a@SystematicSw.ab.ca>
 <YEX5FO0ISV06h9QY@calimero.vinschen.de>
 <b62c52a0-fee4-4cc4-bb57-e16169239d9a@SystematicSw.ab.ca>
 <87pn098s1j.fsf@Rainer.invalid>
 <70c973ec-f8c7-f5cc-1d38-f0306b8521c2@SystematicSw.ab.ca>
 <87lfax8nu3.fsf@Rainer.invalid>
 <b81497ce-72d0-f11e-a381-568aa407b98a@cornell.edu>
 <YEaPTIQ2I1DgpPgt@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
Subject: Re: [PATCH] winsup/doc/dll.xml: update MinGW/.org to MinGW-w64/.org
Message-ID: <a4f074eb-f708-0c6d-348c-2216e0af4b96@SystematicSw.ab.ca>
Date: Mon, 8 Mar 2021 23:08:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEaPTIQ2I1DgpPgt@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJIQIRG2Qlz1AlKSgUl1Q8vIkC5DDEvXkHKvcTiPD4mUgdbh1o0cn6hnqg2Mzl1yGaer71mRSHWQGxiVLJD+IvNSJLz57J2iZwEQ/lYTwFJhhaClptso
 IfTYuf+NPGD+focpyxacM3d1E/w+s0VgGfHqrRK5P+XWduJRNWxwQPp27St3kNZ8S82oioiXBYh37kUSAHReZG3MQM3kSrMHNcg=
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 09 Mar 2021 06:08:42 -0000

On 2021-03-08 13:55, Corinna Vinschen via Cygwin-patches wrote:
> On Mar  8 15:20, Ken Brown via Cygwin-patches wrote:
>> On 3/8/2021 2:09 PM, Achim Gratz wrote:
>>> Brian Inglis writes:
>>>> It's normally a merge conflict which will not be satisfied by regular
>>>> commands to restore the working files to upstream.
>>>
>>> So you're pulling on an unclean work tree?  That's a no-no, either keep
>>> your changes on a separate branch (that you can rebase or merge later)
>>> or stash them away for the pull.
>>>
>>> As Corinna said, if you're prepared to lose any local changes then
>>>
>>> git reset --hard
>>>
>>> will do that.  But you should be sure you really didn't want any of your
>>> unfinished business around any more.
>>
>> If the unfinished business consists of local commits that haven't yet been
>> applied upstream, then I typically do the following:
>>
>> git fetch  # Find out if upstream has changed since my last pull.  If so...
>> git format-patch -n  # save n local commits
>> git reset --hard origin/master
>> git am 00*  # reapply my local commits
> 
> I'm doing this a bit differently:
> 
>    git fetch

I changed to pull origin/master as I always want to get all updates;
Achim suggests remote update

>    git rebase -i origin/master

I've figured out that enough to do your tweaks without hacking patches

> I like git rebase, it's a very nifty tool, especially using the
> interactive mode.

Agreed - I trust myself more using interactive mode commands than gitk

It's been months since I had to wipe and re-clone newlib-cygwin and that's 
saying a lot.

[Thanks for all the help to a git rookie who pled orgs/projects to use/*allow* 
source/version control (often only MS SourceSafe/TeamSource? or cvs) sometimes 
on my own with whatever was/could be installed (Windows Cygwin hg, RHEL/Solaris 
cvs/rcs, Solaris/SunOS sccs/vi).]

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
