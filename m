From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Greg Smith" <gsmith@nc.rr.com>, "Cygwin General MailList" <cygwin@cygwin.com>
Cc: <cygwin-patches@cygwin.com>
Subject: Re: pthreads works, sorta
Date: Tue, 26 Jun 2001 05:10:00 -0000
Message-id: <00ab01c0fe39$41ece8d0$0200a8c0@lifelesswks>
References: <3B37D1A6.39A2685@nc.rr.com> <03c701c0fdd7$82ddbde0$0200a8c0@lifelesswks> <3B37F19F.C9BCDA23@nc.rr.com> <003d01c0fe1c$1f7e3c80$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00336.html
Content-type: multipart/mixed; boundary="----------=_1583532848-65438-79"

This is a multi-part message in MIME format...

------------=_1583532848-65438-79
Content-length: 1943

----- Original Message -----
From: "Robert Collins" <robert.collins@itdomain.com.au>


>
> ----- Original Message -----
> From: "Greg Smith" <gsmith@nc.rr.com>
> To: "Cygwin General MailList" <cygwin@cygwin.com>
> Sent: Tuesday, June 26, 2001 12:21 PM
> Subject: Re: pthreads works, sorta
>
>
> > Robert Collins wrote:
> > > >
> > > > My (heavily threaded) application runs approximately 100x
> > > > slower than under linux and proceeds to the point where the
> > > > program thrashes because it is calling pthreads functions
> > > > faster than the pthreads implementation can deliver (we're
> > > > talking _mutex_lock/unlock and _cond_wait/signal here).
> > >
> > > Condition variables we can't do much about here, other than trying
> to
> > > get down to the metal and rewrite em without OS support. I'm not
> keen to
> > > try that, for what I hope are obvious reasons.
> >
> > True.
> >
>
> I've just reviewed my reading, and it doesn't look as though critical
> sections are going to be _much_ faster.
>
> --> Greg, do you know that your issue is thread syncronisation
> performance, or performance of I/O or other posix calls in between ?
You
> program shouldn't crash unless it manages to deadlock or trigger a
> race... certainly the pthread calls cannot happen except when your
> threads are active and have got cpu :].
>
> How many concurrent threads and mutexs and cond variables are we
talking
> here?
>

Also, if you use pthread_cond_timedwait, you might like to try the
attached patch, it fixes a misinterpretation of the time parameter in
the spec. That slight reading error would cause huge (potentially years
long!) delays. Threads would appear to hang... etc.

Changelog:
Tue Jun 26 22:10:00 2001  Robert Collins rbtcollins@hotmail.com

    * thread.cc (pthread_cond::TimedWait): Check for WAIT_TIMEOUT as
well as WAIT_ABANDONED.
    (__pthread_cond_timedwait): Calculate a relative wait from the
abstime parameter.

Rob


------------=_1583532848-65438-79
Content-Type: text/x-diff; charset=us-ascii;
 name="condtimedwaitisabsolute.patch"
Content-Disposition: inline; filename="condtimedwaitisabsolute.patch"
Content-Transfer-Encoding: base64
Content-Length: 2481

SW5kZXg6IHRocmVhZC5jYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBm
aWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2Msdgpy
ZXRyaWV2aW5nIHJldmlzaW9uIDEuMzYKZGlmZiAtdSAtcCAtcjEuMzYgdGhy
ZWFkLmNjCi0tLSB0aHJlYWQuY2MJMjAwMS8wNi8yNCAyMjoyNjo1MwkxLjM2
CisrKyB0aHJlYWQuY2MJMjAwMS8wNi8yNiAxMjowNDo0OQpAQCAtNDQsNiAr
NDQsNyBAQCBkZXRhaWxzLiAqLwogI2luY2x1ZGUgInNlY3VyaXR5LmgiCiAj
aW5jbHVkZSA8c2VtYXBob3JlLmg+CiAjaW5jbHVkZSA8c3RkaW8uaD4KKyNp
bmNsdWRlIDxzeXMvdGltZWIuaD4KIAogZXh0ZXJuIGludCB0aHJlYWRzYWZl
OwogCkBAIC00NzIsNiArNDczLDcgQEAgcHRocmVhZF9jb25kOjpUaW1lZFdh
aXQgKERXT1JEIGR3TWlsbGlzZQogICAgIGNhc2UgV0FJVF9GQUlMRUQ6CiAg
ICAgICByZXR1cm4gMDsJCQkvKiBQT1NJWCBkb2Vzbid0IGFsbG93IGVycm9y
cyBhZnRlciB3ZSBtb2RpZnkgdGhlIG11dGV4IHN0YXRlICovCiAgICAgY2Fz
ZSBXQUlUX0FCQU5ET05FRDoKKyAgICBjYXNlIFdBSVRfVElNRU9VVDoKICAg
ICAgIHJldHVybiBFVElNRURPVVQ7CiAgICAgY2FzZSBXQUlUX09CSkVDVF8w
OgogICAgICAgcmV0dXJuIDA7CQkJLyogd2UgaGF2ZSBiZWVuIHNpZ25hbGVk
ICovCkBAIC0xNjU0LDcgKzE2NTYsMTQgQEAgX19wdGhyZWFkX2NvbmRfdGlt
ZWR3YWl0IChwdGhyZWFkX2NvbmRfdAogICAgIHJldHVybiBFSU5WQUw7CiAg
IGlmICghdmVyaWZ5YWJsZV9vYmplY3RfaXN2YWxpZCAoKmNvbmQsIFBUSFJF
QURfQ09ORF9NQUdJQykpCiAgICAgcmV0dXJuIEVJTlZBTDsKKyAgc3RydWN0
IHRpbWViIGN1cnJTeXNUaW1lOworICBsb25nIHdhaXRsZW5ndGg7CisgIGZ0
aW1lKCZjdXJyU3lzVGltZSk7CisgIHdhaXRsZW5ndGggPSAoYWJzdGltZS0+
dHZfc2VjIC0gY3VyclN5c1RpbWUudGltZSkgKiAxMDAwOworICBpZiAod2Fp
dGxlbmd0aCA8IDApCisgICAgcmV0dXJuIEVUSU1FRE9VVDsKIAorICAvKiBp
ZiB0aGUgY29uZCB2YXJpYWJsZSBpcyBibG9ja2VkLCB0aGVuIHRoZSBhYm92
ZSB0aW1lciB0ZXN0IG1heWJlIHdyb25nLiAqc2hydWcqICovCiAgIGlmIChw
dGhyZWFkX211dGV4X2xvY2sgKCYoKmNvbmQpLT5jb25kX2FjY2VzcykpCiAg
ICAgc3lzdGVtX3ByaW50ZiAoIkZhaWxlZCB0byBsb2NrIGNvbmRpdGlvbiB2
YXJpYWJsZSBhY2Nlc3MgbXV0ZXgsIHRoaXMgJTBwXG4iLCAqY29uZCk7CiAK
QEAgLTE2NzEsNyArMTY4MCw3IEBAIF9fcHRocmVhZF9jb25kX3RpbWVkd2Fp
dCAocHRocmVhZF9jb25kX3QKICAgSW50ZXJsb2NrZWRJbmNyZW1lbnQgKCYo
KCp0aGVtdXRleCktPmNvbmR3YWl0cykpOwogICBpZiAocHRocmVhZF9tdXRl
eF91bmxvY2sgKCYoKmNvbmQpLT5jb25kX2FjY2VzcykpCiAgICAgc3lzdGVt
X3ByaW50ZiAoIkZhaWxlZCB0byB1bmxvY2sgY29uZGl0aW9uIHZhcmlhYmxl
IGFjY2VzcyBtdXRleCwgdGhpcyAlMHBcbiIsICpjb25kKTsKLSAgcnYgPSAo
KmNvbmQpLT5UaW1lZFdhaXQgKGFic3RpbWUtPnR2X3NlYyAqIDEwMDApOwor
ICBydiA9ICgqY29uZCktPlRpbWVkV2FpdCAod2FpdGxlbmd0aCk7CiAgICgq
Y29uZCktPm11dGV4LT5Mb2NrICgpOwogICBpZiAocHRocmVhZF9tdXRleF9s
b2NrICgmKCpjb25kKS0+Y29uZF9hY2Nlc3MpKQogICAgIHN5c3RlbV9wcmlu
dGYgKCJGYWlsZWQgdG8gbG9jayBjb25kaXRpb24gdmFyaWFibGUgYWNjZXNz
IG11dGV4LCB0aGlzICUwcFxuIiwgKmNvbmQpOwo=

------------=_1583532848-65438-79--
