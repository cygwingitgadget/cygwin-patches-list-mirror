From: egor duda <deo@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: case-sensitiveness of environment problem
Date: Tue, 17 Apr 2001 07:40:00 -0000
Message-id: <50254646181.20010417183909@logos-m.ru>
References: <27138147024.20010416101728@logos-m.ru> <20010417100306.C31974@redhat.com>
X-SW-Source: 2001-q2/msg00100.html

Hi!

Tuesday, 17 April, 2001 Christopher Faylor cgf@redhat.com wrote:

>>  if cygwin environment contains both 'Path' and 'PATH', creating
>>windows environment from it causes crash due to reallocating memory
>>object which is externally referenced. this patch fixes that.
>>
>>i feel that we need a bit more tweaking with environment to deal with
>>it case-insensitiveness under win32.

CF> I don't think that this is due to case insensitivity as much as someone
CF> supplying a non-malloced PATH string.

it is. suppose we have cygwin environment containing

Path=/bin
PATH=/bin:/usr/bin:/usr/local/bin:/home/user/bla/bla/bla

and we call winenv(envp, FALSE) to create win32 environment form it
(in exec()). Code in winenv scans environment and calls getwinenv for
every variable. When it sees 'Path' it creates new entry in
environment cache and place native representation of /bin there. it
 also places 'conv->native' to newenvp. now things come to 'PATH' --
getwinenv finds exiting environment cache entry (cache lookup is
case-insensitive), but path is longer, so conv->native is
realloc()ated. but in the same time newenvp[0] still contains old
(and already invalid) pointer. So, it absolutely doesn't matter if
it's 'Path' and 'PATH' or 'fOo' and 'FoO', and it doesn't matter are
those variables are malloc()ed or not. the problem is with external
reference to env cache from newenvp.

CF> Your patch doesn't look right, since it is storing the environ string in
CF> an alloca'ed buffer.  Since alloca is stack based, won't the buffer be
CF> overwritten once the function returns?

this buffer is temporary and used internally in winenv. all data is
copied to 'envblock' later.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

