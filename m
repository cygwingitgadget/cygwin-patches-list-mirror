Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 55CA8387086E
 for <cygwin-patches@cygwin.com>; Tue, 26 May 2020 07:10:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 55CA8387086E
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 04Q7A1mt083695
 for <cygwin-patches@cygwin.com>; Tue, 26 May 2020 00:10:01 -0700 (PDT)
 (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "[192.168.1.100]"
 via SMTP by m0.truegem.net, id smtpdeXepVP; Tue May 26 00:09:53 2020
Subject: Re: [PATCH 1/3 v3] Cygwin: tzcode resync: basics
To: cygwin-patches@cygwin.com
References: <20200522093253.995-1-mark@maxrnd.com>
 <20200522093253.995-2-mark@maxrnd.com>
 <20200525120634.GD6801@calimero.vinschen.de>
 <20200525154901.GG6801@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <bcff83ee-c3b6-0b99-90d6-650694562250@maxrnd.com>
Date: Tue, 26 May 2020 00:09:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <20200525154901.GG6801@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 26 May 2020 07:10:06 -0000

Hi Corinna,

Corinna Vinschen wrote:
> Hi Mark,
> 
>> On May 22 02:32, Mark Geisert wrote:
> On May 25 14:06, Corinna Vinschen wrote:
>>> Modifies winsup/cygwin/Makefile.in to build localtime.o from items in
>>> new winsup/cygwin/tzcode subdirectory.  Compiler option "-fpermissive"
>>> is used to accept warnings about missing casts on the return values of
>>> malloc() calls.  This patch also removes existing localtime.cc and
>>> tz_posixrules.h from winsup/cygwin as they are superseded by the
>>> subsequent patches in this set.
>>> [...]
>>> @@ -246,6 +246,15 @@ MATH_OFILES:= \
>>>   	tgammal.o \
>>>   	truncl.o
>>>   
>>> +TZCODE_OFILES:=localtime.o
>>> +
>>> +localtime.o: $(srcdir)/tzcode/localtime.cc $(srcdir)/tzcode/localtime.c.patch
>>> +	(cd $(srcdir)/tzcode && \
>>> +		patch -u -o localtime.c.patched localtime.c localtime.c.patch)
>>> +	$(CXX) ${CXXFLAGS} ${localtime_CFLAGS} \
>>> +		-I$(target_builddir)/winsup/cygwin \
>>> +		-I$(srcdir) -I$(srcdir)/tzcode -c -o $@ $<
>>> +
>>
>> This doesn't work well for me.  That rule is the top rule in Makefile.in
>> now, so just calling `make' doesn't build the DLL anymore, only
>> localtime.o.  The rule should get moved way down Makefile.in.

Oops.  My workflow didn't make this apparent to me.  Thanks for the fix.

>> What still bugs me is that we get these -fpermissive warnings (albeit
>> non-fatal) and the fact that we don't get a dependencies file.  On
>> second thought, there's no good reason to keep localtime.cc a C++ file.
>> Converting this file to a plain C wrapper drops the C++-specific warning
>> and thus allows to revert the localtime.o build rule to use ${COMMON_CFLAGS}.
>>
>> So I took the liberty to tweak your patch a bit.  I created a followup
>> patchset, which I'd like you to take a look at.
>>
>> I attached the followup patches to this mail.  Please scrutinize it and
>> don't hesitate to discuss the changes.  For a start:
>>
>> - I do not exactly like the name "localtime_wrapper.c" but I don't
>>    have a better idea.

localtime_cygwin.c?  cyglocaltime.c?  Not much nicer IMO.

>> - muto's are C++-only, so I changed rwlock_wrlock/rwlock_unlock to use
>>    Windows SRWLocks.  I think this is a good thing and I'm inclined
>>    to drop the muto datatype entirely in favor of using SRWLocks since
>>    they are cleaner and langauge-agnostic.
> 
> Two changes in my patchset:
> 
> - I didn't initialize the SRWLOCK following the books.  Fixed that.
> 
> - Rather than creating the patched file in the source dir, I changed
>    the Makefile.in rule so that the patched file is created in the build
>    dir.  This drops the requirement to tweak .gitignore.  It's also
>    cleaner.
> 
> - Splitting the build rule for localtime.c.patched from the build rule
>    for localtime.o makes sure that the patched file is not regenerated
>    every time we build localtime.o.
> 
> I attached my patchset again, but only patch 3 and 4 actually changed.

All the above are great improvements.  But I would now remove the "// Get ready 
to wrap NetBSD's localtime.c" line and blank line following it.  Good to go!
Thank you,

..mark
