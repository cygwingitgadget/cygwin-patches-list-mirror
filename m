From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Billinghurst, David \(CRTS\)" <David.Billinghurst@riotinto.com>, <cygwin@cygwin.com>, <cygwin-patches@cygwin.com>
Subject: [PATCH] Re: pthreads update for the adventurous
Date: Fri, 13 Apr 2001 16:56:00 -0000
Message-id: <04e501c0c475$3d059e50$0200a8c0@lifelesswks>
References: <8D00C32549556B4E977F81DBC24E985DC80C@crtsmail1.technol_exch.corp.riotinto.org>
X-SW-Source: 2001-q2/msg00058.html
Content-type: multipart/mixed; boundary="----------=_1583532847-65438-43"

This is a multi-part message in MIME format...

------------=_1583532847-65438-43
Content-length: 2328

Thanks for the report David. That bugs been in cygwin's pthread support
forever - but it's gone now. (Cross fingers)

If you apply the attached patch to your CVS working directory and make a
new cygwin1.dll the test should pass.

Otherwise, you can wait for the next snapshot.

Chris: I hope the changelog and patch are ok..

==
Saturday Apr 14 2001  Robert Collins <rbtcollins@hotmail.com>
 * thread.h (MTinterface): Add threadcount.
 * thread.cc (MTinterface::Init): Set threadcount to 1.
 (__pthread_create): Increment threadcount.
 (__pthread_exit): Decrement threadcount and call exit() from the last
thread.
==

Rob

----- Original Message -----
From: "Billinghurst, David (CRTS)" <David.Billinghurst@riotinto.com>
To: <cygwin@cygwin.com>
Sent: Friday, April 13, 2001 10:55 PM
Subject: RE: pthreads update for the adventurous


> OK.  I'll bite.
>
> I have built cygwin1.dll from cvs, then proceeded to build and test
gcc-3.0
> with --enable-threads=posix.  This seems to work OK.
>
> I then tried example 1 from
>
http://www.llnl.gov/computing/tutorials/workshops/workshop/pthreads/MAIN
.htm
> l (below) using standard cygwin gcc-2.95.3-2 and the gcc-3.0 I built.
There
> appears to be a problem with pthread_exit() as the program never
exits.  I
> tried to debug this, but soon got lost.
>
>
>
>
/***********************************************************************
****
> ***
> * FILE: hello.c
> * DESCRIPTION:
> *   A "hello world" Pthreads program.  Demonstrates thread creation
and
> *   termination.
> *
> * SOURCE:
> * LAST REVISED: 9/20/98 Blaise Barney
>
************************************************************************
****
> **/
>
> #include <pthread.h>
> #include <stdio.h>
> #define NUM_THREADS 5
>
> void *PrintHello(void *threadid)
> {
>    printf("\n%d: Hello World!\n", threadid);
>    pthread_exit(NULL);
> }
>
> int main()
> {
>    pthread_t threads[NUM_THREADS];
>    int rc, t;
>    for(t=0;t<NUM_THREADS;t++){
>       printf("Creating thread %d\n", t);
>       rc = pthread_create(&threads[t], NULL, PrintHello, (void *)t);
>       if (rc){
>          printf("ERROR; return code from pthread_create() is %d\n",
rc);
>          exit(-1);
>       }
>    }
>    pthread_exit(NULL);
> }
>
>
> --
> Want to unsubscribe from this list?
> Check out: http://cygwin.com/ml/#unsubscribe-simple
>
>

------------=_1583532847-65438-43
Content-Type: text/plain; charset=us-ascii; name="pthread_exit.ChangeLog"
Content-Disposition: inline; filename="pthread_exit.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 387

U2F0dXJkYXkgQXByIDE0IDIwMDEgIFJvYmVydCBDb2xsaW5zIDxyYnRjb2xs
aW5zQGhvdG1haWwuY29tPgoJKiB0aHJlYWQuaCAoTVRpbnRlcmZhY2UpOiBB
ZGQgdGhyZWFkY291bnQuCgkqIHRocmVhZC5jYyAoTVRpbnRlcmZhY2U6Oklu
aXQpOiBTZXQgdGhyZWFkY291bnQgdG8gMS4KCShfX3B0aHJlYWRfY3JlYXRl
KTogSW5jcmVtZW50IHRocmVhZGNvdW50LgoJKF9fcHRocmVhZF9leGl0KTog
RGVjcmVtZW50IHRocmVhZGNvdW50IGFuZCBjYWxsIGV4aXQoKSBmcm9tIHRo
ZSBsYXN0IHRocmVhZC4K

------------=_1583532847-65438-43
Content-Type: text/x-diff; charset=us-ascii; name="pthread_exit.patch"
Content-Disposition: inline; filename="pthread_exit.patch"
Content-Transfer-Encoding: base64
Content-Length: 2331

SW5kZXg6IHRocmVhZC5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZp
bGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL3RocmVhZC5oLHYKcmV0
cmlldmluZyByZXZpc2lvbiAxLjE2CmRpZmYgLXUgLXAgLXIxLjE2IHRocmVh
ZC5oCi0tLSB0aHJlYWQuaAkyMDAxLzA0LzEzIDE1OjI4OjIwCTEuMTYKKysr
IHRocmVhZC5oCTIwMDEvMDQvMTMgMjM6NTA6MTQKQEAgLTMzMyw2ICszMzMs
NyBAQCBwdWJsaWM6CiAgIC8qIHdlIG1heSBnZXQgMCBmb3IgdGhlIFRscyBp
bmRleC4uIGdycnIgKi8KICAgaW50IGluZGV4YWxsb2NhdGVkOwogICBpbnQg
Y29uY3VycmVuY3k7CisgIGxvbmcgaW50IHRocmVhZGNvdW50OwogCiAgIC8v
IFVzZWQgZm9yIG1haW4gdGhyZWFkIGRhdGEsIGFuZCBzaWdwcm9jIHRocmVh
ZAogICBzdHJ1Y3QgX19yZWVudF90IHJlZW50czsKQEAgLTM0Niw3ICszNDcs
NyBAQCBwdWJsaWM6CiAKICAgdm9pZCBJbml0IChpbnQpOwogCi0gICAgTVRp
bnRlcmZhY2UgKCk6cmVlbnRfaW5kZXggKDApLCBpbmRleGFsbG9jYXRlZCAo
MCkgCisgICAgTVRpbnRlcmZhY2UgKCk6cmVlbnRfaW5kZXggKDApLCBpbmRl
eGFsbG9jYXRlZCAoMCksIHRocmVhZGNvdW50ICgxKQogICB7CiAgICAgcHRo
cmVhZF9wcmVwYXJlID0gTlVMTDsKICAgICBwdGhyZWFkX2NoaWxkICAgPSBO
VUxMOwpJbmRleDogdGhyZWFkLmNjCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
UkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL3RocmVhZC5j
Yyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4yMwpkaWZmIC11IC1wIC1yMS4y
MyB0aHJlYWQuY2MKLS0tIHRocmVhZC5jYwkyMDAxLzA0LzEzIDE1OjI4OjIw
CTEuMjMKKysrIHRocmVhZC5jYwkyMDAxLzA0LzEzIDIzOjUwOjE2CkBAIC0y
OTEsNiArMjkxLDcgQEAgTVRpbnRlcmZhY2U6OkluaXQgKGludCBmb3JrZWQp
CiAgICAgfQogCiAgIGNvbmN1cnJlbmN5ID0gMDsKKyAgdGhyZWFkY291bnQg
PSAxOyAvKiAxIGN1cnJlbnQgdGhyZWFkIHdoZW4gSW5pdCBvY2N1cnMuKi8K
IAogICBpZiAoZm9ya2VkKQogICAgIHJldHVybjsKQEAgLTY2NCw2ICs2NjUs
NyBAQCBfX3B0aHJlYWRfY3JlYXRlIChwdGhyZWFkX3QgKiB0aHJlYWQsIGNv
CiAgICAgICAqdGhyZWFkID0gTlVMTDsKICAgICAgIHJldHVybiBFQUdBSU47
CiAgICAgfQorICBJbnRlcmxvY2tlZEluY3JlbWVudCgmTVRfSU5URVJGQUNF
LT50aHJlYWRjb3VudCk7CiAKICAgcmV0dXJuIDA7CiB9CkBAIC0xMjE0LDEw
ICsxMjE2LDEyIEBAIF9fcHRocmVhZF9leGl0ICh2b2lkICp2YWx1ZV9wdHIp
CiAgIGNsYXNzIHB0aHJlYWQgKnRocmVhZCA9IF9fcHRocmVhZF9zZWxmICgp
OwogCiAgIE1UX0lOVEVSRkFDRS0+ZGVzdHJ1Y3RvcnMuSXRlcmF0ZU51bGwg
KCk7Ci0vLyBGSVhNRTogcnVuIHRoZSBkZXN0cnVjdG9ycyBvZiB0aHJlYWRf
a2V5IGl0ZW1zIGhlcmUKIAogICB0aHJlYWQtPnJldHVybl9wdHIgPSB2YWx1
ZV9wdHI7Ci0gIEV4aXRUaHJlYWQgKDApOworICBpZiAoSW50ZXJsb2NrZWRE
ZWNyZW1lbnQoJk1UX0lOVEVSRkFDRS0+dGhyZWFkY291bnQpID09IDApCisg
ICAgZXhpdCAoMCk7CisgIGVsc2UKKyAgICBFeGl0VGhyZWFkICgwKTsKIH0K
IAogaW50Cg==

------------=_1583532847-65438-43--
