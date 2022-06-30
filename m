Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta002.cacentral1.a.cloudfilter.net
 (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
 by sourceware.org (Postfix) with ESMTPS id 609A8385C306
 for <cygwin-patches@cygwin.com>; Thu, 30 Jun 2022 19:03:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 609A8385C306
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
 by cmsmtp with ESMTP
 id 6yNto0DlzSp396zS4oTPoD; Thu, 30 Jun 2022 19:03:44 +0000
Received: from [10.0.0.5] ([184.64.124.72]) by cmsmtp with ESMTP
 id 6zS3oP5AjC3uh6zS4oznRW; Thu, 30 Jun 2022 19:03:44 +0000
X-Authority-Analysis: v=2.4 cv=a6MjSGeF c=1 sm=1 tr=0 ts=62bdf390
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=IkcTkHD0fZMA:10 a=94nOnFI1EgyDtX4ev68A:9 a=QEXdDO2ut3YA:10
Message-ID: <f766aa3a-6bca-5d6b-50c9-316e87816ea1@SystematicSw.ab.ca>
Date: Thu, 30 Jun 2022 13:03:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [EXTERNAL] Re: [PATCH] Cygwin: spawn: Treat empty path as the
 current directory.
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20220627124427.184-1-takashi.yano@nifty.ne.jp>
 <c4a8d150-4d16-2af5-a7ac-26e42f9befb8@cornell.edu>
 <DM8PR09MB7095DDCF46700AB235A53717A5BA9@DM8PR09MB7095.namprd09.prod.outlook.com>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
In-Reply-To: <DM8PR09MB7095DDCF46700AB235A53717A5BA9@DM8PR09MB7095.namprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMJ6glI8T6/t1ne4yXFMfrBG4T4rX3SaMEqCo52wBa2nDQFyB6H29m2xSFYLZCAyOl0sX5hLdyUQN8vrjkgGFJJp81cN0oOUs/RBoIBpCDqs8NcvHUEe
 tm9u/SscYl8pp0ibOKkJqCp6gX/JnTqlNuzpFdReM5z5IKbknRLlDqScZwIAsElqjR3U8QFs3mj9xn6bUZV+lf6G1R7FysjZ15E=
X-Spam-Status: No, score=-1164.2 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE,
 SPF_NONE, TXREP,
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
X-List-Received-Date: Thu, 30 Jun 2022 19:03:48 -0000


On 2022-06-30 12:35, Lavrentiev, Anton (NIH/NLM/NCBI) [C] via 
Cygwin-patches wrote:
>> However, use of this feature is deprecated, and POSIX notes that a
>> conforming application shall use an explicit pathname (e.g., .)  to
>> specify the current working directory.

> Since "SHALL" does not mean "MUST", I think this patch is correct.

It appears you may be confusing POSIX's (1.5 Terminology)
*shall* (mandatory) and *should* (recommended):

"*SHALL*

For an implementation that conforms to POSIX.1-2017, describes a feature 
or behavior that is mandatory. An application can rely on the existence 
of the feature or behavior.

For an application or user, describes a behavior that is mandatory.

*SHOULD*

For an implementation that conforms to POSIX.1-2017, describes a feature 
or behavior that is recommended but not mandatory. An application should 
not rely on the existence of the feature or behavior. An application 
that relies on such a feature or behavior cannot be assured to be 
portable across conforming implementations.

For an application, describes a feature or behavior that is recommended 
programming practice for optimum portability."

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
