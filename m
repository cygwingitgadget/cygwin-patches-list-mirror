Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta001.cacentral1.a.cloudfilter.net
 (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
 by sourceware.org (Postfix) with ESMTPS id CE8753858D1E
 for <cygwin-patches@cygwin.com>; Mon, 11 Jul 2022 18:06:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CE8753858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
 by cmsmtp with ESMTP
 id AvSCohWUQS8WrAxnao3CqU; Mon, 11 Jul 2022 18:06:22 +0000
Received: from [10.0.0.5] ([184.64.124.72]) by cmsmtp with ESMTP
 id AxnZoVqfKuJwwAxnZoqw49; Mon, 11 Jul 2022 18:06:22 +0000
X-Authority-Analysis: v=2.4 cv=F+BEy4tN c=1 sm=1 tr=0 ts=62cc669e
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=IkcTkHD0fZMA:10 a=iMpC6L0jGsNNbTZxuiUA:9 a=QEXdDO2ut3YA:10
Message-ID: <6d69e6a3-9cd5-dbfc-f5bc-cc91865c31f0@SystematicSw.ab.ca>
Date: Mon, 11 Jul 2022 12:06:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Update FAQs for removal of 32-bit Cygwin
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20220707114343.65340-1-jon.turney@dronecode.org.uk>
 <YsvU+P+djrd0OawP@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
In-Reply-To: <YsvU+P+djrd0OawP@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEmV6sE2zxeasqolXyc1GKjS49yxBUScKHfwDNhVp5vN17VadCb6BQSCB3oGSBe6NRVSq8TLHydxq6OvFj9u8nW6g+BVrkfn73/wDWNiRKdYo3/qPdpu
 BTqx7pYBNEOXTOe4fJucvXeNuLaCXJ7tD0QJl0axyuKhAxDBJLZcwAnvcuKvnuENbqAR6FwaDVYEny6mHCq31IuPTGAzClyPp9k=
X-Spam-Status: No, score=-1163.8 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, SPF_HELO_NONE, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Mon, 11 Jul 2022 18:06:24 -0000

On 2022-07-11 01:44, Corinna Vinschen wrote:
> On Jul  7 12:43, Jon Turney wrote:
>> Update FAQs for removal of 32-bit Cygwin
>> Also update FAQs for dropping support for Windows Vista/Server 20008

Now that's planning ahead! Talk about the Cygwin Time Machine ;^>

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
