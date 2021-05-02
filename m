Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.9])
 by sourceware.org (Postfix) with ESMTPS id 276473894436
 for <cygwin-patches@cygwin.com>; Sun,  2 May 2021 18:25:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 276473894436
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([68.147.0.90]) by shaw.ca with ESMTP
 id dGmVla2NmMrQqdGmWleGiB; Sun, 02 May 2021 12:25:28 -0600
X-Authority-Analysis: v=2.4 cv=Nv6yz+RJ c=1 sm=1 tr=0 ts=608eee98
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=IkcTkHD0fZMA:10 a=iMpC6L0jGsNNbTZxuiUA:9 a=QEXdDO2ut3YA:10
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
References: <20210420201326.4876-1-jon.turney@dronecode.org.uk>
 <d4964f52-518e-205b-c44f-02bea6a225d6@dronecode.org.uk>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
Subject: Re: [PATCH] Use automake (v5)
Message-ID: <42e189c7-5a2a-790a-a5c5-78b66fbcc516@SystematicSw.ab.ca>
Date: Sun, 2 May 2021 12:25:27 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <d4964f52-518e-205b-c44f-02bea6a225d6@dronecode.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfANZNVA810unk61kQgC+Zu8m+5isC9d3KI0P32a+ZZIIGdPBNTDjOBUvO3vg+jDBUlQKl3+W8oTNrorAEw68V1rZ29oIiDFhp69ZF2GB8sY7HqwFNtpt
 KIvuSeSruPFq6TUwyjQG+0Bu9EHkdnlfp+kkhzLuz9jvUURrOAsB3zx1AVAY3HPUY0hNUfZl7x6OPg4AT+I82yaL405lH42kT9k=
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
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
X-List-Received-Date: Sun, 02 May 2021 18:25:40 -0000

On 2021-05-02 09:28, Jon Turney wrote:
> Some possible items of future work I noted:

> * -Wimplicit-fallthrough, -Werror could (should?) be set in top-level 
> Makefile.am.common, rather than individual subdirs

Perhaps keep -Werror for Cygwin sources only where we can directly deal with new 
warnings generated due to prompt gcc releases with improvements under Cygwin 
(thanks to Achim and JonY).

With other distros' gcc releases lagging, package builds are getting more 
warnings during cygport builds, which would have to be dealt with either by more 
Cygwin patches and/or working with upstream, by toggling off -Werror, or 
specific -Wno-... options which could result in suppressing useful output, as 
well as delaying package releases.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
