Return-Path: <cygwin-patches-return-6572-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24063 invoked by alias); 13 Jul 2009 09:23:22 -0000
Received: (qmail 24048 invoked by uid 22791); 13 Jul 2009 09:23:21 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f224.google.com (HELO mail-ew0-f224.google.com) (209.85.219.224)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 13 Jul 2009 09:23:16 +0000
Received: by ewy24 with SMTP id 24so141628ewy.2         for <cygwin-patches@cygwin.com>; Mon, 13 Jul 2009 02:23:13 -0700 (PDT)
Received: by 10.210.35.5 with SMTP id i5mr4738431ebi.40.1247476993022;         Mon, 13 Jul 2009 02:23:13 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 28sm9398160eyg.42.2009.07.13.02.23.11         (version=SSLv3 cipher=RC4-MD5);         Mon, 13 Jul 2009 02:23:12 -0700 (PDT)
Message-ID: <4A5B0003.7070704@gmail.com>
Date: Mon, 13 Jul 2009 09:23:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: 1.7 winbase.h (ilockcmpexch) compile error
References: <Pine.CYG.4.58.0906241239470.2248@PC1163-8460-XP.flightsafety.com> <4A53BC5D.7010401@gmail.com> <4A53E449.4020504@gmail.com> <20090713015220.GA1392@ednor.casa.cgf.cx> <20090713085009.GA11234@calimero.vinschen.de>
In-Reply-To: <20090713085009.GA11234@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00026.txt.bz2

Corinna Vinschen wrote:
> On Jul 12 21:52, Christopher Faylor wrote:

>> There is a subtle difference in the generated code if you do this:
>>
>> --- winbase.h   7 Jul 2009 21:41:43 -0000       1.16
>> +++ winbase.h   13 Jul 2009 01:46:17 -0000
>> @@ -56,7 +56,7 @@
>>  {
>>    return
>>    ({
>> -    register long ret __asm ("%eax");
>> +    register long ret;
>>      __asm __volatile ("lock cmpxchgl %2, %1"
>>         : "=a" (ret), "=m" (*t)
>>         : "r" (v), "m" (*t), "0" (c)
>>
>> but does it really matter?  This causes the esi register to be used
>> rather than the edx register.
>>
>> with _asm ("%eax")
>>     160e:       8b 5d 08                mov    0x8(%ebp),%ebx
>>     1611:       8d 53 08                lea    0x8(%ebx),%edx
>>     1614:       f0 0f b1 0a             lock cmpxchg %ecx,(%edx)
>>     1618:       85 c0                   test   %eax,%eax
>>     161a:       74 37                   je     1653 <pthread_mutex::_trylock(pthread*)+0x53>
>>
>> without
>>     1616:       8b 5d 08                mov    0x8(%ebp),%ebx
>>     1619:       8d 73 08                lea    0x8(%ebx),%esi
>>     161c:       f0 0f b1 0e             lock cmpxchg %ecx,(%esi)
>>     1620:       85 c0                   test   %eax,%eax
>>     1622:       74 44                   je     1668 <pthread_mutex::_trylock(pthread*)+0x68>
>>
>>
>> And, more crucially, it compiles with gcc 3.4.
>>
>> Should I check this variation in?
> 
> The affected operations have nothing to do with %eax.  Why does the
> compiler change the usage of some entirely unrelated register?  This
> looks suspicious.

  I did explore this, and I didn't like the look of it.  I found more diffs in
the rest of the file, not just a couple of changed registers, but some
functions spilled more registers to the stack and had larger frames and longer
prologues as a result.  I wrote:

>  (I experimented briefly with removing the register asm from the source and
> building it with gcc-4.3.2, and the results were disappointing; we actually
> got worse register allocation, resulting in some functions having larger stack
> frames and more registers saved/restored, so I guess the RA can still benefit
> from the extra hint.)

  For examining these changes, I compiled the files using --save-temps and ran
a quick "sed -i -e's/^L[^ ]*:'/LLABEL/' on the generated .s file to reduce the
amount of extraneous diffs caused by renumbering of local labels when I
compared the before-and-after versions.

>> Is there a chance that using the esi register obliterates data in the
>> calling function?

  It should be properly saved and restored.  I didn't see anything that I
could nail down as incorrect code gen, but it was notably worse which I
figured was a consequence of how a lot of the optimisers don't try and look
inside asms.  So I figured the register allocator really does benefit from
being given the hint about where to put 'ret'.

  I guess the best thing would be to add a __GNUC_ version check:

{
  return
  ({
    register long ret
#if __GNUC__ >= 4
    /* Register asms trip a reload bug in gcc-3.4.4.  */
                  __asm ("%eax");
#endif
    __asm __volatile ("lock cmpxchgl %2, %1"
       : "=a" (ret), "=m" (*t)
       : "r" (v), "m" (*t), "0" (c)

... but I'd also suggest having a good look at the generated assembly and
making sure it does correctly save and restore the used registers and doesn't
do anything else too bizarre.

    cheers,
      DaveK
