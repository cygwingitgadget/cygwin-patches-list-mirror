From: egor duda <deo@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: case-sensitiveness of environment problem
Date: Wed, 18 Apr 2001 03:00:00 -0000
Message-id: <146324187977.20010418135812@logos-m.ru>
References: <27138147024.20010416101728@logos-m.ru> <20010417100306.C31974@redhat.com> <50254646181.20010417183909@logos-m.ru> <20010417122239.A25694@redhat.com> <129262643781.20010417205227@logos-m.ru> <20010417140927.E25644@redhat.com>
X-SW-Source: 2001-q2/msg00108.html

Hi!

Tuesday, 17 April, 2001 Christopher Faylor cgf@redhat.com wrote:

>>CF> I think we can solve this trivially by making getwinenv perform a
>>CF> case-sensitive comparison, though, can't we?  I think it probably should
>>CF> be case-sensitive anyway.
>>
>>probably. but what if someone runs something nasty like this?
>>
>>extern char** environ;
>>
>>char* x[]= { "FOO=bar",
>>             "foo=BAR",
>>             "FOO=very-long-environment-value-used-only-for-testing-purposes",
>>             0 };
>>char* arg[] = { "/bin/env", 0 };
>>
>>int
>>main (int argc, char** argv)
>>{
>>  environ = x;
>>  execvp ( arg[0], arg );
>>}
>>
>>i think external reference is a bad idea anyway.

CF> I've always thought that if someone plays with environ they get what they pay
CF> for anyway.

they should get it in their code, not in ours. i can easily imagine a
program which adds some variable to environment not checking if it's
already there. And if we only make env cache case-sensitive, we'll
still have a crash, and a very hard to debug one, as any heap
corruption problem. and one that is quite hard to reproduce , because
it depends on global environment which is quite different on different
machines. 

Also note, that program itself is possibly not using malloc() and
friends at all, but still crashes in free().

SUSv2 also says that program can manipulate 'environ' directly, it's
absolutely legal. it also says that "If more than one string in a
process' environment has the same the consequences are undefined."
Crash in cygwin1.dll probably matches "undefined consequences"
requirement, and formally complies with standard, but it's surely not
the best way to handle such situation.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

