From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "egor duda" <cygwin-patches@cygwin.com>
Cc: <cygwin-patches@cygwin.com>
Subject: Re: src/winsup/cygwin ChangeLog thread.cc thread.h ...
Date: Thu, 27 Sep 2001 06:03:00 -0000
Message-id: <004801c14755$01a57f20$01000001@lifelesswks>
References: <20010925114527.23687.qmail@sourceware.cygnus.com> <14472692346.20010927144858@logos-m.ru> <007b01c14743$2a0005b0$01000001@lifelesswks> <12280602580.20010927170049@logos-m.ru>
X-SW-Source: 2001-q3/msg00210.html

I'm just thinking about the best fix - I know what the problem is.

Rob
----- Original Message -----
From: "egor duda" <deo@logos-m.ru>
To: "Robert Collins" <robert.collins@itdomain.com.au>
Cc: <cygwin-patches@cygwin.com>
Sent: Thursday, September 27, 2001 11:00 PM
Subject: Re: src/winsup/cygwin ChangeLog thread.cc thread.h ...


> Hi!
>
> Thursday, 27 September, 2001 Robert Collins
robert.collins@itdomain.com.au wrote:
>
> >> rscc>         * thread.cc (pthread_cond::BroadCast): Use address
with
> RC> verifyable_object_isvalid().
> >> rscc>         (pthread_cond::Signal): Ditto.
> >>
> >> [...]
> >>
> >> Robert, i have problems with your last patch. at program startup
> >> read_etc_passwd() is called recursively and second call blocks at
> >> pthread_mutex_lock()
>
> RC> Huh, strange. I ran with the .dll for some time with no trouble,
and am
> RC> about to switch to it in this environment as well.
>
> here's the relevant part of backtrace from gdb:
>
> #2  0x610678e6 in __pthread_mutex_lock (mutex=0x610a44c8)
>     at
../../../../../../src/sourceware/src/winsup/cygwin/thread.cc:1955
> #3  0x610407c6 in pthread_mutex_lock (mutex=0x610a44c8)
>     at
../../../../../../src/sourceware/src/winsup/cygwin/pthread.cc:240
> #4  0x61035fb1 in read_etc_passwd ()
>     at
../../../../../../src/sourceware/src/winsup/cygwin/passwd.cc:124
> #5  0x61036ea2 in internal_getpwent (pos=0)
>     at
../../../../../../src/sourceware/src/winsup/cygwin/passwd.cc:356
> #6  0x610460cb in cygsid::get_id (this=0x22c2c0, search_grp=0,
type=0x0)
>     at
../../../../../../src/sourceware/src/winsup/cygwin/sec_helper.cc:169
> #7  0x6104b182 in get_nt_attribute (file=0x614f136c
"e:\\unix\\etc\\group",
>     attribute=0x22d488, uidret=0x22d48e, gidret=0x22d490)
>     at
../../../../../../src/sourceware/src/winsup/cygwin/security.h:52
> #8  0x6104b5e5 in get_file_attribute (use_ntsec=1073741824,
>     file=0x614f136c "e:\\unix\\etc\\group", attribute=0x22d488,
>     uidret=0x22d48e, gidret=0x22d490)
>     at
../../../../../../src/sourceware/src/winsup/cygwin/security.cc:1219
> #9  0x61012dca in fhandler_disk_file::fstat (this=0x614f0b3c,
buf=0x22d480)
>     at
../../../../../../src/sourceware/src/winsup/cygwin/fhandler.cc:964
> #10 0x6105df7b in _fstat (fd=4, buf=0x22d480)
>     at
../../../../../../src/sourceware/src/winsup/cygwin/syscalls.cc:1012
> #11 0x6108f9e4 in _fstat_r (ptr=0x61098020, fd=4, pstat=0x22d480)
>     at
../../../../../../../src/sourceware/src/newlib/libc/reent/fstatr.c:62
> #12 0x6108fa44 in __smakebuf (fp=0xa011aec)
>     at
../../../../../../../src/sourceware/src/newlib/libc/stdio/makebuf.c:50
> #13 0x6108d2b3 in __srefill (fp=0xa011aec)
>     at
../../../../../../../src/sourceware/src/newlib/libc/stdio/refill.c:88
> #14 0x61081ccb in __srget (fp=0xa011aec)
>     at
../../../../../../../src/sourceware/src/newlib/libc/stdio/rget.c:37
> #15 0x61083270 in fgets (buf=0x22d7f0 "$", n=200, fp=0xa011aec)
>     at
../../../../../../../src/sourceware/src/newlib/libc/../libc/include/stdi
o.h:290
> #16 0x61029c49 in read_etc_group ()
>     at ../../../../../../src/sourceware/src/winsup/cygwin/grp.cc:165
> #17 0x6102a10e in internal_getgrent (pos=0)
>     at ../../../../../../src/sourceware/src/winsup/cygwin/grp.cc:265
> #18 0x61046153 in cygsid::get_id (this=0x22dd10, search_grp=1,
type=0x0)
>     at
../../../../../../src/sourceware/src/winsup/cygwin/sec_helper.cc:187
> #19 0x6104b1a9 in get_nt_attribute (file=0x614f0af4
"e:\\unix\\etc\\passwd",
>     attribute=0x22eed8, uidret=0x22eede, gidret=0x22eee0)
>     at
../../../../../../src/sourceware/src/winsup/cygwin/security.h:53
> #20 0x6104b5e5 in get_file_attribute (use_ntsec=1073741824,
>     file=0x614f0af4 "e:\\unix\\etc\\passwd", attribute=0x22eed8,
>     uidret=0x22eede, gidret=0x22eee0)
>     at
../../../../../../src/sourceware/src/winsup/cygwin/security.cc:1219
> #21 0x61012dca in fhandler_disk_file::fstat (this=0x614f02c4,
buf=0x22eed0)
>     at ../../../../../../src/sourceware/src/winsup/cygwin/fhandler.cc:
964
> #22 0x6105df7b in _fstat (fd=3, buf=0x22eed0)
>     at
../../../../../../src/sourceware/src/winsup/cygwin/syscalls.cc:1012
> #23 0x6108f9e4 in _fstat_r (ptr=0x61098020, fd=3, pstat=0x22eed0)
>     at
../../../../../../../src/sourceware/src/newlib/libc/reent/fstatr.c:62
> #24 0x6108fa44 in __smakebuf (fp=0xa011a94)
>     at
../../../../../../../src/sourceware/src/newlib/libc/stdio/makebuf.c:50
> #25 0x6108d2b3 in __srefill (fp=0xa011a94)
>     at
../../../../../../../src/sourceware/src/newlib/libc/stdio/refill.c:88
> #26 0x61081ccb in __srget (fp=0xa011a94)
>     at
../../../../../../../src/sourceware/src/newlib/libc/stdio/rget.c:37
> #27 0x61083270 in fgets (buf=0x22f130 "+", n=1024, fp=0xa011a94)
>     at
../../../../../../../src/sourceware/src/newlib/libc/../libc/include/stdi
o
> .h:290
> #28 0x61036105 in read_etc_passwd ()
>     at
../../../../../../src/sourceware/src/winsup/cygwin/passwd.cc:150
> #29 0x61036ea2 in internal_getpwent (pos=0)
>     at
../../../../../../src/sourceware/src/winsup/cygwin/passwd.cc:356
> #30 0x6106ab6e in internal_getlogin (user=@0x614f0094)
>     at ../../../../../../src/sourceware/src/winsup/cygwin/uinfo.cc:172
> #31 0x6106ad76 in uinfo_init ()
>     at ../../../../../../src/sourceware/src/winsup/cygwin/uinfo.cc:222
>
> Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet
2:5020/496.19
>
>
