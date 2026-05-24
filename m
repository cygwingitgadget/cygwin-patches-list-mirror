Return-Path: <SRS0=1B9v=DV=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id F0C424BA9028
	for <cygwin-patches@cygwin.com>; Sun, 24 May 2026 08:52:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F0C424BA9028
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F0C424BA9028
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1779612728; cv=none;
	b=EOsQRmdXkF/hPT1gzWHlWjWkjwE4cjb6e8TwH7wZMDATm1YvFXMwOf4OofNb8sTjpiCCK7wIaWkLCkxTSxepYOCFJLPQ+589i+RFuCUm37jgc4BYpIku7gwpKQuSecioICDgW8/SHg7/fmfDDBf/lhJDcrqT3PLDSgNJMGZYZPk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1779612728; c=relaxed/simple;
	bh=QKiPcwcvQPbi/fZDiy0MWe0MAyfV8p6/CDc7o+Y1vUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=fEFvDqjp+8Kon0gQCYg043wUKkVk4biYWR1iT/0l328sI9E2sPxv/bmymrCQvitFN6b7XgBs27xADA5xHQjVLRHjrTulrhAyA8CRScrWh/lKwWyypK5xTExm5MBvK7kN+SQMzKbxjzT9xzEbZ48E8s5VEtA8IKC5WV9DYcJziAg=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F0C424BA9028
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 64O97W5C052751
	for <cygwin-patches@cygwin.com>; Sun, 24 May 2026 02:07:32 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdLHoIpU; Sun May 24 02:07:23 2026
Message-ID: <d44c62ec-084b-48df-adce-2259496b5991@maxrnd.com>
Date: Sun, 24 May 2026 01:51:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Implement 'reserved' marker in fdtable entries
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <https://cygwin.com/pipermail/cygwin-patches/2026q2/014989.html>
 <20260522072913.574-1-mark@maxrnd.com>
 <e5a59828-cdab-4d8a-980c-14b52a5c0d32@dronecode.org.uk>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <e5a59828-cdab-4d8a-980c-14b52a5c0d32@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,BODY_8BITS,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jon,

Thank you for the review.  I've replied inline below...

On 5/22/2026 3:19 AM, Jon Turney wrote:
> On 22/05/2026 08:28, Mark Geisert wrote:
[...]
>> ---
>>   winsup/cygwin/local_includes/cygheap.h | 31 +++++++++++++++++++++-----
>>   winsup/cygwin/local_includes/dtable.h  |  4 +++-
>>   winsup/cygwin/syscalls.cc              | 14 +++++-------
>>   3 files changed, 35 insertions(+), 14 deletions(-)
>>
>> diff --git a/winsup/cygwin/local_includes/cygheap.h b/winsup/cygwin/ 
>> local_includes/cygheap.h
>> index 74cfff652..1eccf6d36 100644
>> --- a/winsup/cygwin/local_includes/cygheap.h
>> +++ b/winsup/cygwin/local_includes/cygheap.h
>> @@ -576,9 +576,13 @@ class cygheap_fdmanip
>>     fhandler_base *operator -> () const {return cygheap->fdtab[fd];}
>>     bool isopen () const
>>     {
>> -    if (cygheap->fdtab[fd])
>> +    /* check fdtab entry present (i.e. non-NULL) and not a "reserved" 
>> marker */
>> +    if (cygheap->fdtab[fd] && cygheap->fdtab[fd] != (fhandler_base *) 
>> (int64_t) fd)
>>         return true;
>> -    set_errno (EBADF);
>> +    /* check fdtab entry is not present */
>> +    if (cygheap->fdtab[fd] == NULL)
>> +      set_errno (EBADF);
>> +    /* remaining case is fdtab entry present and is a "reserved" 
>> marker */
>>       return false;
> 
> Hmm.. we end up here without setting errno.  That doesn't seem right.

Yes, it's a puzzling discrepancy but this was what I needed to do get my 
testcases to work correctly.  I checked some of the calling sites as 
part of debugging and found isopen() is more like 
is-fdtab[fd]-a-pointer-because-i'm-going-use-it-as-such().  That is why 
I bother to separate out the "reserved" case.  And then I found that 
doing set_errno(EBADF) for that case too had various syscalls returning 
EBADF for no good reason.  I believe because they weren't expecting a 
fatal (to the syscall) error to happen internally.

>>     }
>>   };
>> @@ -595,7 +599,11 @@ class cygheap_fdnew : public cygheap_fdmanip
>>       else
>>         fd = cygheap->fdtab.find_unused_handle (seed_fd + 1);
>>       if (fd >= 0)
>> -      locked = lockit;
>> +      {
>> +        locked = lockit;
>> +        /* mark as "reserved" for open(), or other syscall, in 
>> progress */
>> +        cygheap->fdtab[fd] = (fhandler_base *)(int64_t) fd;
> 
> So, we're already relying on "a small integer cast to pointer can't 
> collide with an actual pointer value we might get" (which is fine).
> 
> But then there's no reason why we can't use a distinct constant (like 1 
> or -1), to indicate a reserved slow throughout, which would make this 
> easier to understand?

Yeah, I thought of using a single constant value after I submitted the 
patch.  I do like -1 for shock value when/if things get broken ;-(.  In 
any case this should be a #define somewhere useful.

> 
>> +      }
>>       else
>>         {
>>       /* errno set by find_unused_handle */
>> @@ -607,7 +615,18 @@ class cygheap_fdnew : public cygheap_fdmanip
>>     ~cygheap_fdnew ()
>>     {
>>       if (cygheap->fdtab[fd])
>> -      cygheap->fdtab[fd]->inc_refcnt ();
>> +      {
>> +        /* check if fdtab entry is a "reserved" marker */
>> +        if (cygheap->fdtab[fd] == (fhandler_base *)(int64_t) fd)
>> +          {
>> +            /* remove "reserved" marker */
>> +            cygheap->fdtab.lock ();
>> +            cygheap->fdtab[fd] = NULL;
>> +            cygheap->fdtab.unlock ();
>> +          }
>> +        else
>> +          cygheap->fdtab[fd]->inc_refcnt ();
>> +      }
>>     }
>>     void operator = (fhandler_base *fh) {cygheap->fdtab[fd] = fh;}
>>   };
>> @@ -620,7 +639,9 @@ public:
>>     {
>>       if (lockit)
>>         cygheap->fdtab.lock ();
>> -    if (fd >= 0 && fd < (int) cygheap->fdtab.size && cygheap- 
>> >fdtab[fd] != NULL)
>> +    /* this is similar to ::isopen() above, but doesn't set_errno() 
>> on fail */
>> +    if (fd >= 0 && fd < (int) cygheap->fdtab.size && cygheap- 
>> >fdtab[fd] &&
>> +    cygheap->fdtab[fd] != (fhandler_base *)(int64_t) fd)
>>         {
>>       this->fd = fd;
>>       locked = lockit;
>> diff --git a/winsup/cygwin/local_includes/dtable.h b/winsup/cygwin/ 
>> local_includes/dtable.h
>> index 7803fae1b..a434554fb 100644
>> --- a/winsup/cygwin/local_includes/dtable.h
>> +++ b/winsup/cygwin/local_includes/dtable.h
>> @@ -51,7 +51,9 @@ public:
>>     inline int not_open (int fd)
>>     {
>>       lock ();
>> -    int res = fd < 0 || fd >= (int) size || fds[fd] == NULL;
>> +    /* treat fds entry marked "reserved" same as not present fds 
>> entry */
>> +    int res = fd < 0 || fd >= (int) size ||
>> +              fds[fd] == NULL || fds[fd] == (fhandler_base *) 
>> (int64_t) fd;
>>       unlock ();
>>       return res;
>>     }
>> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
>> index 7a8e5d4fd..e42771c18 100644
>> --- a/winsup/cygwin/syscalls.cc
>> +++ b/winsup/cygwin/syscalls.cc
>> @@ -1460,6 +1460,12 @@ open (const char *unix_path, int flags, ...)
>>     __try
>>       {
>> +      /* try to reserve a new fd now rather than later in this block */
> 
> Uh, this comment could say that why we do this. I guess because that's 
> because we're going to fail here if we've already hit the OPEN_MAX limit?

Sure, I can make this more specific.  This definition could go anywhere 
inside the __try block before the call to fh_open_with_arch() which 
eventually does the NtCreateFile().  And yes it's protection against 
OPEN_MAX.

>> +      cygheap_fdnew fd;
>> +
>> +      if (fd < 0)
>> +        __leave;        /* errno already set */
>> +
>>         syscall_printf ("open(%s, %y)", unix_path, flags);
>>         if (!*unix_path)
>>       {
[...]
Thanks again,

..mark
