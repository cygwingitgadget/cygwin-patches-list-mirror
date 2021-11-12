Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta002.cacentral1.a.cloudfilter.net
 (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
 by sourceware.org (Postfix) with ESMTPS id 65C083858402
 for <cygwin-patches@cygwin.com>; Fri, 12 Nov 2021 16:30:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 65C083858402
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
 by cmsmtp with ESMTP
 id lVPBm9Wjqps7PlZRbmkfy3; Fri, 12 Nov 2021 16:30:27 +0000
Received: from [192.168.1.105] ([68.147.0.90]) by cmsmtp with ESMTP
 id lZRbm9CKm49dplZRbmf1Cw; Fri, 12 Nov 2021 16:30:27 +0000
X-Authority-Analysis: v=2.4 cv=RqTWkQqK c=1 sm=1 tr=0 ts=618e96a3
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=uYT-Tk0qkVT609LjNaIA:9 a=QEXdDO2ut3YA:10
 a=tiDzgGXBa_QA:10 a=sRI3_1zDfAgwuvI8zelB:22
Message-ID: <221514b7-28c9-2a33-92e2-61537b1407b4@SystematicSw.ab.ca>
Date: Fri, 12 Nov 2021 09:30:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Subject: Re: [PATCH 0/2] Fix a bad case of absolute path handling
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
References: <20211110203253.2933679-1-corinna-cygwin@cygwin.com>
 <f6a4f67f-1db4-4e53-7907-c7a7dcfbde79@cornell.edu>
Content-Language: en-CA
Organization: Systematic Software
In-Reply-To: <f6a4f67f-1db4-4e53-7907-c7a7dcfbde79@cornell.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfB/Lc00apcJEdRdkioLD1QvswMQaXcI0ROqBAoxGdXQ/xMH3ZCX9O63cwstIYS64fBtRPAJVaLyvZXnBVzZ4JFEZiC3fxd04meRnyyCm5yPExvqtij96
 +hWgyeOXeViOw4EtnE5zjkNEHTlTQ8MQLPLy8Lnxc2jDMmdzUHYdCBZk03OhEfpTPE3vWq6IEPJhBSFSmCyOBxqPrnqaQodq/jY=
X-Spam-Status: No, score=-1166.0 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=no autolearn_force=no version=3.4.4
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
X-List-Received-Date: Fri, 12 Nov 2021 16:30:30 -0000

On 2021-11-10 15:22, Ken Brown wrote:
> On 11/10/2021 3:32 PM, corinna-cygwin@cygwin.com wrote:
>> From: Corinna Vinschen <corinna@vinschen.de>
>>
>> As I told Takashi in PM, I will try to more often send patches to the
>> cygwin-patches ML before pushing them, so there's a chance to chime in.
> 
> LGTM.
> 
>> This patch series is supposed to address the `rm -rf' problem reported
>> in https://cygwin.com/pipermail/cygwin/2021-November/249837.html
>>
>> It was always frustrating, having to allow DOS drive letter paths for
>> backward compatibility.  This here is another case of ambiguity,
>> triggered by the `isabspath' macro handling "X:" as absolute path, even
>> without the trailing slash or backslash.
>>
>> Check out the 2nd patch for a more detailed description.
>>
>> While at it, I wonder if we might have a chance to fix these ambiguities
>> in a better way.  For instance, consider this:
>>
>>    $ mkdir -p test/c:
>>    $ cd test
>>
>> As non-admin:
>>
>>    $ touch c:/foo
>>    touch: cannot touch 'c:/foo': Permission denied
>>
>> As admin, even worse:
>>
>>    $ touch c:/foo
>>    $ ls /cygdrive/c/foo
>>    foo
>>
>> As long as we support DOS paths as input, I have a hard time to see how
>> to fix this, but maybe we can at least minimize the ambiguity somehow.
> 
> I can't immediately think of anything.  But is it really impossible to 
> phase out DOS path support over a period of time?  We could start with a 
> HEADS-UP, asking for comments, then a deprecation announcement, then 
> something like the old dosfilewarning option, then a more forceful 
> warning that can't be turned off, and finally removal of support.  This 
> could be done over a period of several years (not sure how many).
> 
> We could also put lines like
> 
>    # C:/ on /c type ntfs (binary,posix=0)
> 
> into the default /etc/fstab.

NO! BTDT GTS.
Try getting help from any DOS/cmd type command or subcommand.
Shell expands /? to list of all mapped drives /c /d ... /s /v /y which 
gives you a bunch of potentially destructive switches.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
