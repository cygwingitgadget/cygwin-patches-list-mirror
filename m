From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Greg Smith" <gsmith@nc.rr.com>
Cc: <cygwin-patches@cygwin.com>
Subject: Re: Deadly embrace between pthread_cond_wait and pthread_cond_signal
Date: Thu, 21 Jun 2001 07:31:00 -0000
Message-id: <01da01c0fa5f$1bfe6d70$0200a8c0@lifelesswks>
References: <3B3181E5.E6F0D06A@nc.rr.com>
X-SW-Source: 2001-q2/msg00322.html
Content-type: multipart/mixed; boundary="----------=_1583532848-65438-75"

This is a multi-part message in MIME format...

------------=_1583532848-65438-75
Content-length: 2192

Correct a deadlock situation...
Changelog:
2001-06-22  Robert Collins  rbtcollins@hotmail.com

    * thread.cc (__pthread_cond_timedwait): Lock the waiting mutex
before the condition protect mutex to avoid deadlocking.
    (__pthread_cond_wait): Ditto.


Greg, as far as speed goes, there is a major optimisation I want to
make, which is to make all process private mutex's critical sections,
instead of system wide mutex's. This should be a lot faster... when I
get that done :].

Rob

----- Original Message -----
From: "Greg Smith" <gsmith@nc.rr.com>
To: <cygwin@cygwin.com>
Sent: Thursday, June 21, 2001 3:11 PM
Subject: Deadly embrace between pthread_cond_wait and
pthread_cond_signal


> I am using the cygwin-src snapshot from June 19.
>
> Suppose I have a thread, t1, that looks like:
> void *t1() {
>    pthread_mutex_lock(&lock);
>    pthread_cond_wait(&cond,&lock);
>    pthread_mutex_unlock(&lock);
> }
> and a thread, t2, that looks like:
> void *t2() {
>    pthread_mutex_lock(&lock);
>    pthread_cond_signal(&cond);
>    sleep(1);
>    pthread_cond_signal(&cond);
>    pthread_mutex_unlock(&lock);
> }
>
> When thread t1 wakes up as a result of the first pthread_cond_signal
> issued by thread t2, __pthread_cond_wait in thread.cc obtains internal
> mutex `cond_access' then hangs trying to acquire external mutex `lock'
> which is owned by thread t2.
>
> When thread t2 issues the second pthread_cond_signal, still holding
> external mutex `lock', pthread_cond::Signal in thread.cc tries to
> get internal mutex `cond_access' and hangs because it is owned by t1.
>
> So, t1 has `cond_access' and is waiting on `lock'
> and t2 has `lock' and is waiting on `cond_access'.
>
> As a workaround, I moved the pthread_mutex_lock for cond_access in
> __pthread_cond_wait from before the (*cond)->mutex->Lock() to after
> it, and my application has gotten a whole lot further than ever before
> using native cygwin pthreads, although it does seem to be running as
> slow as molasses compared to linux.  But maybe that's cause of my
> debug stuff I had to add.
>
> Thanks,
>
> Greg
>
> --
> Want to unsubscribe from this list?
> Check out: http://cygwin.com/ml/#unsubscribe-simple
>
>

------------=_1583532848-65438-75
Content-Type: text/x-diff; charset=us-ascii; name="deadlockwait.patch"
Content-Disposition: inline; filename="deadlockwait.patch"
Content-Transfer-Encoding: base64
Content-Length: 2619

PyBhdGZvcmsuQ2hhbmdlTG9nCj8gYXRmb3JrLnBhdGNoCj8gYnJvYWRjYXN0
Zml4LkNoYW5nZUxvZwo/IGJyb2FkY2FzdGZpeC5wYXRjaAo/IGNsaXBib2Fy
ZC5jaGFuZ2Vsb2cKPyBjb25kX3NpZ25hbF9maXgucGF0Y2gKPyBjdXJyZW50
LnN0YXRlCj8gY3lnd2luLmNoYW5nZQo/IGRlYWRsb2Nrd2FpdC5wYXRjaAo/
IGZoYW5kbGVyX2ZpZm8uY2MKPyBnZXRwd25hbV9yLkNoYW5nZUxvZwo/IGdl
dHB3bmFtX3IucGF0Y2gKPyBpcGMuY2MKPyBuZXdsaWIuY2hhbmdlCj8gbnQu
cGF0Y2gKPyBwc2hhcmVkLkNoYW5nZUxvZwo/IHBzaGFyZWQucGF0Y2gKPyBw
dGhyZWFkX2NvbmRfYnJvYWRjYXN0X2ZpeC5wYXRjaAo/IHB0aHJlYWRfZXhp
dC5DaGFuZ2VMb2cKPyBwdGhyZWFkX2V4aXQucGF0Y2gKPyBzaG0uY2MKPyB0
aHJlYWQuZ29vZAo/IHR6LmNoYW5nZWxvZwo/IHR6LnBhdGNoCj8gd2VkLnBh
dGNoCj8gaW5jbHVkZS9zeXMvaXBjLmgKPyBpbmNsdWRlL3N5cy9zaG0uaApJ
bmRleDogdGhyZWFkLmNjCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZp
bGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL3RocmVhZC5jYyx2CnJl
dHJpZXZpbmcgcmV2aXNpb24gMS4zNApkaWZmIC11IC1wIC1yMS4zNCB0aHJl
YWQuY2MKLS0tIHRocmVhZC5jYwkyMDAxLzA2LzE0IDIzOjUzOjI3CTEuMzQK
KysrIHRocmVhZC5jYwkyMDAxLzA2LzIxIDE0OjI4OjQ3CkBAIC0xNjcyLDkg
KzE2NzIsOSBAQCBfX3B0aHJlYWRfY29uZF90aW1lZHdhaXQgKHB0aHJlYWRf
Y29uZF90CiAgIGlmIChwdGhyZWFkX211dGV4X3VubG9jayAoJigqY29uZCkt
PmNvbmRfYWNjZXNzKSkKICAgICBzeXN0ZW1fcHJpbnRmICgiRmFpbGVkIHRv
IHVubG9jayBjb25kaXRpb24gdmFyaWFibGUgYWNjZXNzIG11dGV4LCB0aGlz
ICUwcFxuIiwgKmNvbmQpOwogICBydiA9ICgqY29uZCktPlRpbWVkV2FpdCAo
YWJzdGltZS0+dHZfc2VjICogMTAwMCk7CisgICgqY29uZCktPm11dGV4LT5M
b2NrICgpOwogICBpZiAocHRocmVhZF9tdXRleF9sb2NrICgmKCpjb25kKS0+
Y29uZF9hY2Nlc3MpKQogICAgIHN5c3RlbV9wcmludGYgKCJGYWlsZWQgdG8g
bG9jayBjb25kaXRpb24gdmFyaWFibGUgYWNjZXNzIG11dGV4LCB0aGlzICUw
cFxuIiwgKmNvbmQpOwotICAoKmNvbmQpLT5tdXRleC0+TG9jayAoKTsKICAg
aWYgKEludGVybG9ja2VkRGVjcmVtZW50ICgmKCgqY29uZCktPndhaXRpbmcp
KSA9PSAwKQogICAgICgqY29uZCktPm11dGV4ID0gTlVMTDsKICAgSW50ZXJs
b2NrZWREZWNyZW1lbnQgKCYoKCp0aGVtdXRleCktPmNvbmR3YWl0cykpOwpA
QCAtMTcxOSw5ICsxNzE5LDkgQEAgX19wdGhyZWFkX2NvbmRfd2FpdCAocHRo
cmVhZF9jb25kX3QgKiBjbwogICBpZiAocHRocmVhZF9tdXRleF91bmxvY2sg
KCYoKmNvbmQpLT5jb25kX2FjY2VzcykpCiAgICAgc3lzdGVtX3ByaW50ZiAo
IkZhaWxlZCB0byB1bmxvY2sgY29uZGl0aW9uIHZhcmlhYmxlIGFjY2VzcyBt
dXRleCwgdGhpcyAlMHBcbiIsICpjb25kKTsKICAgcnYgPSAoKmNvbmQpLT5U
aW1lZFdhaXQgKElORklOSVRFKTsKKyAgKCpjb25kKS0+bXV0ZXgtPkxvY2sg
KCk7CiAgIGlmIChwdGhyZWFkX211dGV4X2xvY2sgKCYoKmNvbmQpLT5jb25k
X2FjY2VzcykpCiAgICAgc3lzdGVtX3ByaW50ZiAoIkZhaWxlZCB0byBsb2Nr
IGNvbmRpdGlvbiB2YXJpYWJsZSBhY2Nlc3MgbXV0ZXgsIHRoaXMgJTBwXG4i
LCAqY29uZCk7Ci0gICgqY29uZCktPm11dGV4LT5Mb2NrICgpOwogICBpZiAo
SW50ZXJsb2NrZWREZWNyZW1lbnQgKCYoKCpjb25kKS0+d2FpdGluZykpID09
IDApCiAgICAgKCpjb25kKS0+bXV0ZXggPSBOVUxMOwogICBJbnRlcmxvY2tl
ZERlY3JlbWVudCAoJigoKnRoZW11dGV4KS0+Y29uZHdhaXRzKSk7Cg==

------------=_1583532848-65438-75--
