Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id D2E28385780D
 for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2020 10:07:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D2E28385780D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 0ARA7Hpm006013
 for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2020 02:07:17 -0800 (PST)
 (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "[192.168.1.100]"
 via SMTP by m0.truegem.net, id smtpd3msUjU; Fri Nov 27 02:07:09 2020
Subject: Re: [PATCH] Cygwin: Speed up mkimport
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20201126095620.38808-1-mark@maxrnd.com>
 <c9e9ed07-48fc-62d1-8288-c5ef88301a88@dronecode.org.uk>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <a8df021c-d340-a150-eeed-2063604e870f@maxrnd.com>
Date: Fri, 27 Nov 2020 02:07:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <c9e9ed07-48fc-62d1-8288-c5ef88301a88@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00, BODY_8BITS,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, SPF_HELO_NONE,
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
X-List-Received-Date: Fri, 27 Nov 2020 10:07:19 -0000

Jon Turney wrote:
> On 26/11/2020 09:56, Mark Geisert wrote:
>> @@ -86,8 +94,18 @@ for my $f (keys %text) {
>>       if (!$text{$f}) {
>>       unlink $f;
>>       } else {
>> -    system $objcopy, '-R', '.text', $f and exit 1;
>> -    system $objcopy, '-R', '.bss', '-R', '.data', "t-$f" and exit 1;
>> +    if ($forking && fork) {
>> +        # Testing shows parent does need to sleep a short time here,
>> +        # otherwise system is inundated with hundreds of objcopy processes
>> +        # and the forked perl processes that launched them.
>> +        my $delay = 0.01; # NOTE: Slower systems may need to raise this
>> +        select(undef, undef, undef, $delay); # Supports fractional seconds
>> +    } else {
>> +        # Do two objcopy calls at once to avoid one system() call overhead
>> +        system '(', $objcopy, '-R', '.text', $f, ')', '||',
>> +        $objcopy, '-R', '.bss', '-R', '.data', "t-$f" and exit 1;
>> +        exit 0 if $forking;
>> +    }
>>       }
>>   }
> 
> Hmm... not so sure about this.  This seems racy, as nothing ensures that these 
> objcopies have finished before we combine all the produced .o files into a library.

Good point.  I've added a hash to track the forked pids, and after each of these 
two time-consuming loops finishes I loop over the pids list doing waitpid() on 
each pid.

> I'm pretty sure with more understanding, this whole thing could be done better:  
> For example, from a brief look, it seems that the t-*.o files are produced by gas, 
> and then we remove .bss and .data sections.  Could we not arrange to assemble 
> these objects without those sections in the first place?

I looked over as's options in its man page but could not see anything obvious.  I 
wonder if defining the sections explicitly as zero-length somehow in mkimport's 
assembler snippets would accomplish the same thing.  I'll try this next.

Note that mkimport operates both on those tiny object files it creates with as, 
but also on the object files created by the whole Cygwin build.  So adjusting the 
latter object files would need to be done somewhere else.
Thanks,

..mark

