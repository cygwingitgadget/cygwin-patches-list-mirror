Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-041.btinternet.com (mailomta26-re.btinternet.com
 [213.120.69.119])
 by sourceware.org (Postfix) with ESMTPS id 42D98386FC2B
 for <cygwin-patches@cygwin.com>; Tue,  4 May 2021 18:35:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 42D98386FC2B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-041.btinternet.com with ESMTP id
 <20210504183558.MZUR9545.re-prd-fep-041.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Tue, 4 May 2021 19:35:58 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9C0CC3186910C
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrvdefiedguddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgeeuhfekvdefieeghfehtdejheeigedthefhhfehfffgheehgedtffeljeetueeunecukfhppeekuddrudehfedrleekrddvgeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeekuddrudehfedrleekrddvgeeipdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (81.153.98.246) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC3186910C for cygwin-patches@cygwin.com;
 Tue, 4 May 2021 19:35:58 +0100
Subject: Re: [PATCH 2/2] Move source files used in utils/mingw/ into that
 subdirectory
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20210502152537.32312-1-jon.turney@dronecode.org.uk>
 <20210502152537.32312-3-jon.turney@dronecode.org.uk>
 <YI/VCcOj36ydUiEw@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <0d4d3343-45ec-2e25-0985-e99db9b46c01@dronecode.org.uk>
Date: Tue, 4 May 2021 19:34:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YI/VCcOj36ydUiEw@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3571.5 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Tue, 04 May 2021 18:36:00 -0000

On 03/05/2021 11:48, Corinna Vinschen wrote:
> On May  2 16:25, Jon Turney wrote:
>> Move all the source files used in utils/mingw/ into that subdirectory,
>> so the built objects are in the expected place.
>>
>> (path.cc requires some more unpicking, and even then there is genuinely
>> some shared code, so use a trivial file which includes the real path.cc
>> so the object file is generated where expected)
> 
> This patchset LGTM, except one thing which isn't your fault:
> 
>> index b96ad40c1..a7797600c 100644
>> --- a/winsup/utils/strace.cc
>> +++ b/winsup/utils/mingw/strace.cc
>> @@ -21,11 +21,11 @@ details. */
>>   #include <time.h>
>>   #include <signal.h>
>>   #include <errno.h>
>> -#include "../cygwin/include/sys/strace.h"
>> -#include "../cygwin/include/sys/cygwin.h"
>> -#include "../cygwin/include/cygwin/version.h"
>> -#include "../cygwin/cygtls_padsize.h"
>> -#include "../cygwin/gcc_seh.h"
>> +#include "../../cygwin/include/sys/strace.h"
>> +#include "../../cygwin/include/sys/cygwin.h"
>> +#include "../../cygwin/include/cygwin/version.h"
>> +#include "../../cygwin/cygtls_padsize.h"
>> +#include "../../cygwin/gcc_seh.h"
> 
> What about adding -I../../cygwin -I../../cygwin/include to the build
> rules and get rid of the relative paths inside the sources?

That seems fraught as it allows cygwin system headers to be picked up in 
preference to mingw ones?

Using '-idirafter' gets you a build, but it would be much more work to 
check that you've actually built what you wanted to...
