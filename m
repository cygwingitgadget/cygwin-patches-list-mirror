Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta001.cacentral1.a.cloudfilter.net
 (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
 by sourceware.org (Postfix) with ESMTPS id A19603858400
 for <cygwin-patches@cygwin.com>; Fri, 25 Feb 2022 18:35:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org A19603858400
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
 by cmsmtp with ESMTP
 id NZbqn0cVL43SgNfR9nI3FS; Fri, 25 Feb 2022 18:35:27 +0000
Received: from [10.0.0.5] ([184.64.124.72]) by cmsmtp with ESMTP
 id NfR8nZ5nDQV6mNfR8nyVIV; Fri, 25 Feb 2022 18:35:27 +0000
X-Authority-Analysis: v=2.4 cv=PbTsOwtd c=1 sm=1 tr=0 ts=6219216f
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=IkcTkHD0fZMA:10 a=94nOnFI1EgyDtX4ev68A:9 a=QEXdDO2ut3YA:10
Message-ID: <2526762f-71f0-2341-03cc-27f18c0c30f3@SystematicSw.ab.ca>
Date: Fri, 25 Feb 2022 11:35:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Provide virtual /dev/fd and
 /dev/{stdin,stdout,stderr} symlinks
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <cover.1645450518.git.johannes.schindelin@gmx.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
In-Reply-To: <cover.1645450518.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJVmQZRXwj3pyxVv1KeZvETlnVsIMrUjod028l+C1vx/8bwnkd2DOahOV4D9Dn5e8eD8VtVGf17FaqYTIdl8Ntt6ueMj15cWy/7nKhZ8YvzSa4GGuOV9
 5HY+ChYtqZ9m51uqUYeAvhDlDdVvrjG2LncK3Og5rsEFQr3gRr2sEVdYRk/shLVSOExCDQDfp3qwQjFxfm5RdqxiwoUfw3ohAWY=
X-Spam-Status: No, score=-1163.8 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL,
 SPF_HELO_NONE, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.4
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
X-List-Received-Date: Fri, 25 Feb 2022 18:35:29 -0000

On 2022-02-21 06:36, Johannes Schindelin wrote:
> These symbolic links are crucial e.g. to support process substitution (Bash's
> very nice `<(SOME-COMMAND)` feature).
> 
> For various reasons, it is a bit cumbersome (or impossible) to generate these
> symbolic links in all circumstances where Git for Windows wants to use its
> close fork of the Cygwin runtime.
> 
> Therefore, let's just handle these symbolic links as implicit, virtual ones.
> 
> If there is appetite for it, I wonder whether we should do something similar
> for `/dev/shm` and `/dev/mqueue`? Are these even still used in Cygwin?

Looks like that would make sense, as Cygwin appears to create all of 
those only on first startup (and probably rechecks if they need created 
every startup) e.g.

Cygwin-32 $ ls -Fglot /dev/ | tail -6
lrwxrwxrwx  1       13 Apr 29  2012 fd -> /proc/self/fd/
lrwxrwxrwx  1       15 Apr 29  2012 stderr -> /proc/self/fd/2
lrwxrwxrwx  1       15 Apr 29  2012 stdout -> /proc/self/fd/1|
lrwxrwxrwx  1       15 Apr 29  2012 stdin -> /proc/self/fd/0
drwxr-xr-x+ 1        0 Apr 29  2012 mqueue/
drwxr-xr-x+ 1        0 Apr 29  2012 shm/

Cygwin-64 $ ls -Fglot /dev/ | tail -6
drwxrwxrwt+ 1        0 Dec  2  2017 shm/
lrwxrwxrwx  1       13 May 14  2013 fd -> /proc/self/fd/
lrwxrwxrwx  1       15 May 14  2013 stderr -> /proc/self/fd/2
lrwxrwxrwx  1       15 May 14  2013 stdout -> /proc/self/fd/1|
lrwxrwxrwx  1       15 May 14  2013 stdin -> /proc/self/fd/0
drwxrwxrwt+ 1        0 May 14  2013 mqueue/

so they would all get 2006-12-01 00:00:00+0000 birth time.

[Looks like I ran something using shm in 2017!]

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
