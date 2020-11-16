Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.9])
 by sourceware.org (Postfix) with ESMTPS id 5FC39385780A
 for <cygwin-patches@cygwin.com>; Mon, 16 Nov 2020 23:21:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5FC39385780A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id enoCkQJPn34axenoDklMox; Mon, 16 Nov 2020 16:21:17 -0700
X-Authority-Analysis: v=2.4 cv=LvQsdlRc c=1 sm=1 tr=0 ts=5fb3096d
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=g1voNRx-yjamnXpHBfkA:9 a=QEXdDO2ut3YA:10
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: proc(5) and xml version
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <072e5252-9056-2af8-bf62-caec89830d38@SystematicSw.ab.ca>
 <20201116120721.GA41926@calimero.vinschen.de>
 <96c4beb9-67a6-5f71-9d22-c7e5bbc6a0fc@dronecode.org.uk>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
Message-ID: <806e3ae9-badf-497e-8c56-eaf1bc9b0af1@SystematicSw.ab.ca>
Date: Mon, 16 Nov 2020 16:21:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <96c4beb9-67a6-5f71-9d22-c7e5bbc6a0fc@dronecode.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIak2fXMtcFkFRVU9u0vNqbVWkPKOoQY901knRZp6uwCsWZkUJbbTCy+Uydxh95Ok2RwETl5xVkRmevwWEcuGQwC2IXd6tnC6tAcnJNOkVgw8Kq2iot8
 W7ghNeksWDjuOC3JsTm49gTqU82sdQ57Ulx9CUKDxoRZORdouMAiWTMwPZh1HKSBariCd36BL15gJPFI43S2Qc3lEuAfsI/vrQI=
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Mon, 16 Nov 2020 23:21:19 -0000

On 2020-11-16 06:41, Jon Turney wrote:
> On 16/11/2020 12:07, Corinna Vinschen wrote:
>> Hi Brain,
>>
>> On Nov 13 07:25, Brian Inglis wrote:
>>> Hacked a Cygwin proc.5 man page FMOI over time, by combing through
>>> fhandler_proc..., converted to proc-5.xml using doclifter, back with xmlto
>>> as in the build, man width 80 output from both, and diff (all attached).
>>
>> Nice idea!
>>
> 
> Yes, nice work.
> 
>>> Unsure how this might best be fitted into the distro (cygwin, cygwin-doc,
>>> ...?) and/or whether there may be xml remediation possible to generate
>>> verbatim output left justified with zero margin, and character value
>>> displays, the major output issues in the diff? Content feedback is also
>>> welcome.
>>
>> This could replace the pathnames-proc and pathnames-proc-registry
>> sections in specialnames.xml.
>>
>> I think by using the refentry markup the man page would be generated
>> automagically, but Jon (CCed) is the definitiv source of wisdom here.
> 
> Yes, all refentries in the UG should have manpages generated from them (only 
> cygwin utilities currently).

I saw those but not specialnames, so should be able to incorporate the comments 
to update the content, generate the xml and adapt to the existing context as an 
update, then look at manpage generation.

> The install rule in the Makefile would probably need extending to install *.5 to 
> man5dir.
> 
> These would then be included in the cygwin-doc package.

Great, that sounds workable.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
