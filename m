Return-Path: <SRS0=MpBi=KY=systematicsw.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by sourceware.org (Postfix) with ESMTPS id 949013858437
	for <cygwin-patches@cygwin.com>; Mon, 18 Mar 2024 14:10:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 949013858437
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=systematicsw.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=systematicsw.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 949013858437
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1710771027; cv=none;
	b=p1KSjYo10umA9iYVNMtLa4PUfQtoZcWLd2A2XnNh/PMPRIg09gpqQfC6Oo56LWqQJV1IkxkusnTa3d9w0N6W0gG6bP1slnqmEnJtZnyyiRiX3oep9hIsRKJ7Hv9bFdoHx9RE0H+jt0Udetw31fMcbjZMmwgfePVNygAqfxWsVaY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1710771027; c=relaxed/simple;
	bh=ZxJCH+9QnOePT2mqJdF26Hfw0sliVONO0lAbhmI7TTA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To; b=w3+ajWnYiGU+u8stGFbv/avoSKqd9sEIg1BsMFWA/A0Sgv/KHNUlS8fR+HfTFxd6+sz7S6jsXxsmJlI3ZL2SfbrUOQbpPlO1FJcu+ei2pxhjoVFhjcavR6tPd5H1L+GhML56Dmu4Ue82tMeJ2K4f6GW7BO/IBJ3VFhuntDLxSlY=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 1BC861C0FD4
	for <cygwin-patches@cygwin.com>; Mon, 18 Mar 2024 14:10:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf01.hostedemail.com (Postfix) with ESMTPA id B4CAA60009
	for <cygwin-patches@cygwin.com>; Mon, 18 Mar 2024 14:10:23 +0000 (UTC)
Message-ID: <1ebfb5dd-f5b8-4f6c-a6aa-e1b7873d7802@systematicsw.ab.ca>
Date: Mon, 18 Mar 2024 08:10:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup/cygwin/fhandler/proc.cc: format_proc_cpuinfo()
 Linux 6.8 cpuinfo flags
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <86a84fad25ec3b5c49e9b737dfccbdb2f510556e.1710519553.git.Brian.Inglis@SystematicSW.ab.ca>
 <ZfgKd7GX7o7gCoX7@calimero.vinschen.de>
Organization: Systematic Software
In-Reply-To: <ZfgKd7GX7o7gCoX7@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: ah4dtnnbpgmcpmiudwiuinnbqkaowsfq
X-Rspamd-Server: rspamout03
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: B4CAA60009
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX193gq0loNo1uMfh+xPrk8CjGDo3BAqP/+Q=
X-HE-Tag: 1710771023-844435
X-HE-Meta: U2FsdGVkX19Wo/HhsHY3bTmt6oEkCyf4fFEA0SP2RXoshh33cyQvlLdnnW60BnOqDUGrEiuw+ooVW9eDcL5VplT7v0aSUs1BtiHxs9lpq71eEbd2ebjH2cpYHPRx23lNEdHQHcps7ghebKcOQJaHGsNbmBuhRf59bj4LWCMVjB3T5NOK3ou8FJ+c/qlfNqM+w7ChJhyloQvMiCwM3WdgIDJ8xt4YddSPJ48poaZFioS1C/YdBoSRLnBoBJZrbdnbq9ob+labc8Z0r/8rkGommgDLGT7XJz6mjfeU7pEW/gFaNBji67JSMnARPs1E0QrN6Qqr0IXcNwrdKcWFV6w7gkoVLodxjBIl
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2024-03-18 03:33, Corinna Vinschen wrote:
> Hi Brian,
> 
> On Mar 16 10:44, Brian Inglis wrote:
>> add Linux 6.8 cpuinfo flags:
>> Intel 0x00000007:1 eax:17 fred		Flexible Return and Event Delivery;
>> AMD   0x8000001f   eax:4  sev_snp	SEV secure nested paging;
>> document unused and some unprinted bits that could look like omissions;
>> fix typos and misalignments;
> 
> I'm a bit puzzled about the "unused" slots.  You're adding them
> only in some places.  What makes them "look like omissions"?

Mainly because single bits are omitted, presumably because they do not want to 
pollute the symbol space with as yet unused features, just as they do not output 
all features as cpuinfo flags, until it indicates something about the build 
and/or system.

Compare the minimal common standard feature bits defined in the gcc lib cpuid.h 
and gcc cpuinfo.h headers, with Linux cpuinfo cpufeatures.h, and the output of 
the cpuid utility, where almost all bits in older cpuid entries are defined.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
