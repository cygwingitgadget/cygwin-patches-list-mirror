From: egor duda <deo@logos-m.ru>
To: "Robert Collins" <robert.collins@itdomain.com.au>
Cc: cygwin-patches@cygwin.com
Subject: Re: PTHREAD_COND_INITIALIZER support
Date: Thu, 15 Nov 2001 06:06:00 -0000
Message-ID: <15895533840.20011115170602@logos-m.ru>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F28E@itdomain002.itdomain.net.au> <92602986318.20011109105819@logos-m.ru> <17285934467.20011115142602@logos-m.ru> <030601c16dd0$1a48ac40$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/msg00229.html
Message-ID: <20011115060600.Yn_UTjB-G7_NNZoIMH4BLorf_n8I2DWilqE_S1kW0gs@z>

Hi!

Thursday, 15 November, 2001 Robert Collins robert.collins@itdomain.com.au wrote:

RC> ----- Original Message -----
RC> From: "egor duda" <deo@logos-m.ru>
RC> ..
>> ed> yes. i'm going to add a bunch of pthread tests after this checkin.
>>
>> done too.
>>
>> Robert, can you please take a look at winsup.api/pthread/condvar3_1.c
>> test? it looks like when condition variable is signalled, two threads
>> wake on it instead of one. it's quite stable effect, so i don't think
>> we have a race here.

RC> Ok, it's probably the wakeup code. Do you have a sinlge or dual machine?

single. do you see the same output? :

awk = 42
sig = 21
tot = 18
Assertion failed: (signaled == awoken), ...

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
