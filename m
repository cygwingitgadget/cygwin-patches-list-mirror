From: egor duda <deo@logos-m.ru>
To: Robert Collins <robert.collins@itdomain.com.au>
Cc: cygwin-patches@cygwin.com
Subject: Re: PTHREAD_COND_INITIALIZER
Date: Tue, 25 Sep 2001 04:56:00 -0000
Message-id: <6214257951.20010925155455@logos-m.ru>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F1C6@itdomain002.itdomain.net.au> <342526142.20010925114613@logos-m.ru> <1001414378.1761.45.camel@lifelesswks> <11811589024.20010925151026@logos-m.ru> <1001418247.1825.69.camel@lifelesswks>
X-SW-Source: 2001-q3/msg00199.html

Hi!

Tuesday, 25 September, 2001 Robert Collins robert.collins@itdomain.com.au wrote:

>> RC> I really don't see any benefit from using NULL in this instance, and I
>> RC> do see benefits from not using NULL.
>> 
>> the benefit from using NULL is portability. I understand that cygwin
>> is not supposed to that portable as, say, Apache, but nevertheless.
 
RC> Ok, I'll accept that. So we use void *(-2), void * (-3) and so on -
RC> address's so high up they can never be valid for pthread objects because
RC> pthread objects are larger than the remaining address space.

ok, you're probably right. i'll change my patch and resubmit it.

[...]

>> I'll check this stuff into cygwin testsuite tonight. it
>> needs just minor cleanup currently.

RC> You might want to check with cgf first about copyright issues? I don't
RC> know - is the testsuite GPL compatible.

it's LGPLed.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
