Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta002.cacentral1.a.cloudfilter.net
 (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
 by sourceware.org (Postfix) with ESMTPS id 107CC3858421
 for <cygwin-patches@cygwin.com>; Wed, 19 Jan 2022 19:12:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 107CC3858421
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
 by cmsmtp with ESMTP
 id A7ScntqG5yr5HAGNOns7XQ; Wed, 19 Jan 2022 19:12:10 +0000
Received: from [192.168.1.105] ([68.147.0.90]) by cmsmtp with ESMTP
 id AGNNnHYTpUcbnAGNOnbYiP; Wed, 19 Jan 2022 19:12:10 +0000
X-Authority-Analysis: v=2.4 cv=OO00YAWB c=1 sm=1 tr=0 ts=61e8628a
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=IkcTkHD0fZMA:10 a=94nOnFI1EgyDtX4ev68A:9 a=QEXdDO2ut3YA:10
Message-ID: <41c0e46f-bbd3-6e7a-e433-66fa94f95187@SystematicSw.ab.ca>
Date: Wed, 19 Jan 2022 12:12:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] Silence more build rules
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20220119131521.51616-1-jon.turney@dronecode.org.uk>
 <YegioLvRwD4+T3PF@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
In-Reply-To: <YegioLvRwD4+T3PF@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKhHBJLS71zJsUaVqIIr8pjmf1LgSbyKR9zp+XDzxakw34hVzzmrokY8Rxa9rMCGxVGo6nD2R/EmUkqY2o7FUq9+dlJS8VRaa+9WQdgX7VFiM7svnrjo
 N1JIBN4wJMX2JZ76WFh0TMseQhx8jYXNYpPDeje8xNo5P22/h/4FXYw4AKe84zTeTsUS7UJz6VhJY/PGrUQ3CKIFGXyGjkVZNck=
X-Spam-Status: No, score=-1160.7 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_BARRACUDACENTRAL,
 SPF_HELO_NONE, SPF_NONE, TXREP autolearn=no autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 19 Jan 2022 19:12:12 -0000

On 2022-01-19 07:39, Corinna Vinschen wrote:
> On Jan 19 13:15, Jon Turney wrote:
>> Jon Turney (4):
>>    Cygwin: silence most custom build rules
>>    Cygwin: silence dblatex when building PDFs
>>    Cygwin: silence xsltproc when writing chunked html
>>    Cygwin: silence xsltproc when writing manpages
>>
>>   winsup/cygwin/Makefile.am | 38 ++++++++++++++++-----------------
>>   winsup/doc/Makefile.am    | 45 ++++++++++++++++++++++-----------------
>>   2 files changed, 45 insertions(+), 38 deletions(-)

Hopefully these are now changed to be the helpful type of build rules 
that output only "CC foo" when commands work and show the complete 
command line and diagnostics when commands err?

Or do we have to now have to rerun with V=1 to see error diagnostics?

Some tests can be particularly obscure when hunting down the command 
responsible and output resulting from failures: others DTRT!

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
