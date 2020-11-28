Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id E38AE385800A
 for <cygwin-patches@cygwin.com>; Sat, 28 Nov 2020 02:33:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E38AE385800A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id iq3JkAjDSktFkiq3KkjnRi; Fri, 27 Nov 2020 19:33:34 -0700
X-Authority-Analysis: v=2.4 cv=NYRYa0P4 c=1 sm=1 tr=0 ts=5fc1b6fe
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=94nOnFI1EgyDtX4ev68A:9 a=QEXdDO2ut3YA:10
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Speed up mkimport
To: cygwin-patches@cygwin.com
References: <20201126095620.38808-1-mark@maxrnd.com>
 <87wny76eur.fsf@Rainer.invalid>
 <ee4d7296-e9b3-13c8-cc15-f2e393b42e6f@maxrnd.com>
 <87360ubq7s.fsf@Rainer.invalid>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
Message-ID: <e23986e7-a53d-003a-491e-ffe33f11ae91@SystematicSw.ab.ca>
Date: Fri, 27 Nov 2020 19:33:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <87360ubq7s.fsf@Rainer.invalid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOwyX3TSwz77lQof67D6b3SRpUAfasBoE9yMlLcNx12qPCP4ceL7nqoSc+nllcneqJhjcufUFu50NAygrKhul9fQEtD/PvIbCigWZyPCkY4uVtMqFEUY
 vGRGua485vE6A9FUMvRg7pFFZGQOlAIWV4d9CgdOjgamF03iymCrjFJzLSBxhhWIw4tOgsKoGmXwPXEPj5SS+pJC6UyNSdS27SU=
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE,
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
X-List-Received-Date: Sat, 28 Nov 2020 02:33:36 -0000

On 2020-11-27 11:37, Achim Gratz wrote:
> Mark Geisert writes:
>> Still faster than two system commands :-).  But thanks for the
>> comment;
> 
> It still seems you are barking up the wrong tree.
> 
>> I thought I was merely grouping args, to get around Perl's
>> greedy arg list building for the system command.
> 
> Wot?  It just takes a list which you can build any which way you desire.
> The other option is to give it the full command line in a string, which
> does work for this script (but not on Windows).  If it finds shell
> metacharacters in the arguments it'll run a shell, otherwise the forked
> perl just does an execve.
> 
> If it's really the forking that is causing the slowdown, why not do
> either of those things:
> 
> a) Generate a complete shell script and fork once to run that.
> 
> b) Open up two pipes to an "xargs -P $ncpu/2 L 1 …" and feed in the file
> names.
> 
> Getting the error codes back to the script and handling the error is
> left as an exercise for the reader.

Use explicit binary paths to avoid path search overhead; for portability: /bin/ 
for base system, dir, file, and net utils including compressors, grep, and sed; 
/usr/bin/ otherwise; {/usr,}/sbin/ for some admin utils not elsewhere.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
