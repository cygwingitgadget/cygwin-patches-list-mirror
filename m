Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.13])
 by sourceware.org (Postfix) with ESMTPS id 837F63850419
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 18:19:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 837F63850419
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([68.147.0.90]) by shaw.ca with ESMTP
 id JKTalXO2Q2SWTJKTblEMvu; Mon, 08 Mar 2021 11:19:31 -0700
X-Authority-Analysis: v=2.4 cv=fdJod2cF c=1 sm=1 tr=0 ts=60466ab3
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=IkcTkHD0fZMA:10 a=iMpC6L0jGsNNbTZxuiUA:9 a=QEXdDO2ut3YA:10
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup/doc/dll.xml: update MinGW/.org to MinGW-w64/.org
To: cygwin-patches@cygwin.com
References: <20210307163155.63871-1-Brian.Inglis@SystematicSW.ab.ca>
 <aada0b19-26ea-9db0-85f4-8f959441e05a@dronecode.org.uk>
 <38792da7-75f7-231d-0de2-d483b927820a@SystematicSw.ab.ca>
 <YEX5FO0ISV06h9QY@calimero.vinschen.de>
 <b62c52a0-fee4-4cc4-bb57-e16169239d9a@SystematicSw.ab.ca>
 <87pn098s1j.fsf@Rainer.invalid>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
Message-ID: <70c973ec-f8c7-f5cc-1d38-f0306b8521c2@SystematicSw.ab.ca>
Date: Mon, 8 Mar 2021 11:19:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <87pn098s1j.fsf@Rainer.invalid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIAyCO9atL8YaBomsF/1X6F0D73V1g/qzZSGPXvDeJEBZf5czuLWfRO5t4pIpY0HlblLorHuUtt6qzbVBPiY64mFnh0//rWYotuj/0P/dPhOYpGewxpL
 Jkc6tn+LE/hA+yrYvYuYEiI4kn9hszoPyu17334XACaNhUaBiRB8l0GRsOXNFbPexhQySYONTXJn7rUkcv5OsjTaLD58Vz+6GSw=
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
X-List-Received-Date: Mon, 08 Mar 2021 18:19:33 -0000

On 2021-03-08 10:38, Achim Gratz wrote:
> Brian Inglis writes:
>> Thanks - I'll try to remember to try that - on a pull conflict I
>> normally try to checkout -- file(s), then -f, then origin/master, then
>> plus -f, with status checks between, then commit -m merge when
>> required, and re-pull origin/master to check resynced to upstream
>> remote.
> 
> git status
> 
> That usually tells you what it is that prevents pulling.  Aside from
> that, you can always do

It's normally a merge conflict which will not be satisfied by regular commands 
to restore the working files to upstream.

> git remote update
> 
> to get the objects and then figure out how to pull the branch.

Thanks for that last tip which is the first I have heard of that command.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
