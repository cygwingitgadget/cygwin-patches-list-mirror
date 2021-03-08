Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.13])
 by sourceware.org (Postfix) with ESMTPS id 156783850415
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 17:32:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 156783850415
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([68.147.0.90]) by shaw.ca with ESMTP
 id JJkUlWzYz2SWTJJkVlE1mn; Mon, 08 Mar 2021 10:32:56 -0700
X-Authority-Analysis: v=2.4 cv=fdJod2cF c=1 sm=1 tr=0 ts=60465fc8
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=IkcTkHD0fZMA:10 a=LF2dOfbMAAAA:8 a=w_pzkKWiAAAA:8 a=glQaCKPEvfmbXkiY-ikA:9
 a=QEXdDO2ut3YA:10 a=TX4KzpC5ujAA:10 a=TmiWL2DCWjWbbQwbIu5r:22
 a=sRI3_1zDfAgwuvI8zelB:22 a=BPzZvq435JnGatEyYwdK:22
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
References: <20210307163155.63871-1-Brian.Inglis@SystematicSW.ab.ca>
 <aada0b19-26ea-9db0-85f4-8f959441e05a@dronecode.org.uk>
 <38792da7-75f7-231d-0de2-d483b927820a@SystematicSw.ab.ca>
 <YEX5FO0ISV06h9QY@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
Subject: Re: [PATCH] winsup/doc/dll.xml: update MinGW/.org to MinGW-w64/.org
Message-ID: <b62c52a0-fee4-4cc4-bb57-e16169239d9a@SystematicSw.ab.ca>
Date: Mon, 8 Mar 2021 10:32:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEX5FO0ISV06h9QY@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGLMbsotstTTmkwaYNBebdIHH4/hu87orE/DJSJoL/kDdqr23u0U9Sff/KEtaFlML41XTXrHnIpvuLjyfLj8JyStSGPQfFiMWNC9tK104k1DEfOL1jJd
 VzX2DMGmKZKGFHXuOfya6w9wpHGcCEmS9LcfHOLWJqEgoOUIJuNct0+n57hKd5vkPb3tXNm9+IsA1RLITeP4wG8E60bj6GvI678=
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
X-List-Received-Date: Mon, 08 Mar 2021 17:32:58 -0000

On 2021-03-08 03:14, Corinna Vinschen via Cygwin-patches wrote:
> On Mar  7 13:26, Brian Inglis wrote:
>> On 2021-03-07 12:15, Jon Turney wrote:
>>> On 07/03/2021 16:31, Brian Inglis wrote:
>>>>    winsup/doc/dll.xml | 5 +++--
>>>>    1 file changed, 3 insertions(+), 2 deletions(-)

>>> I don't think the link here actually has much value, and would be
>>> inclined to drop it, as far as I can tell it's just giving that as an
>>> example of a toolchain which produces 'lib'-prefixed DLLs.
>>>
>>> Also, reading the whole page, the section "Linking against DLLs" needs
>>> updating since GNU ld has had the ability to link directly against DLLs
>>> (automatically generating the necessary import stubs) for a number of
>>> years.
>>>
>>> Also, there are other mentions of MinGW.org on the cygwin website (e.g.
>>> https://cygwin.com/links.html) which also need updating, if that URL is
>>> no longer valid.

>> I checked the tree and Corinna cleaned up some a few years ago.
>>
>> I already checked winsup/doc/ and there were no other substantive uses of
>> MinGW unless you would prefer *ALL* mentions of MinGW be suffixed with -w64.
>>
>> I did not look closely at cygwin-htdocs, as git complained when I tried to
>> update, so I wiped that repo,

> If git complained, your repo was just not in the latets state.
> Maybe just using `git reset --hard origin/master' would have fixed it.

Thanks - I'll try to remember to try that - on a pull conflict I normally try to 
checkout -- file(s), then -f, then origin/master, then plus -f, with status 
checks between, then commit -m merge when required, and re-pull origin/master to 
check resynced to upstream remote.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
