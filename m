From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin@cygwin.com>, <cygwin-patches@cygwin.com>
Subject: Re: pthreads works, sorta - got it
Date: Wed, 27 Jun 2001 07:20:00 -0000
Message-id: <00e501c0ff14$6ad8dd40$806410ac@local>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F09E@itdomain002.itdomain.net.au> <20010627012932.I19058@redhat.com> <20010627013502.K19058@redhat.com> <008201c0ff0d$8fe3c2a0$806410ac@local> <009701c0ff0e$4d796400$806410ac@local>
X-SW-Source: 2001-q2/msg00353.html
Content-type: multipart/mixed; boundary="----------=_1583532848-65438-82"

This is a multi-part message in MIME format...

------------=_1583532848-65438-82
Content-length: 3620

Got the bug... attached is a correct patch that doesn't break anything
AFAICT.

GCC was optimising the variable access when the macro
check_null_empty-path_errno was used, and accessing the memory area _before_
the readcheck! The overhead of a proper function should be lower than that
of VirtualQueryHowever, so I've made it a function. It could have the guts
of check_null_empty_path copied into it for speed, but that's optional IMO.

Wed Jun 27 23:30:00 2001  Robert Collins <rbtcollins@hotmail.com>

    * path.h  (check_null_empty_path_errno): Convert to a function
prototype.
    * path.cc (check_null_empty_path_errno): New function.
    (check_null_empty_path): Change from VirtualQuery to IsBadWritePtr.
    * resource.cc (getrlimit): Ditto.
    (setrlimit): Ditto.
    * thread.cc (check_valid_pointer): Ditto.


----- Original Message -----
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Robert Collins" <robert.collins@itdomain.com.au>; <cygwin@cygwin.com>;
<cygwin-patches@cygwin.com>
Sent: Wednesday, June 27, 2001 11:37 PM
Subject: Re: pthreads works, sorta


> The last patch was bad - sorry! (path.cc had a copy-n-pasto).
>
> Rob
> ----- Original Message -----
> From: "Robert Collins" <robert.collins@itdomain.com.au>
> To: <cygwin@cygwin.com>; <cygwin-patches@cygwin.com>
> Sent: Wednesday, June 27, 2001 11:32 PM
> Subject: Re: pthreads works, sorta
>
>
> > changelog:
> >
> > Wed Jun 27 23:30:00 2001  Robert Collins <rbtcollins@hotmail.com>
> >
> >     * path.cc (check_null_empty_path): Change from VirtualQuery to
> > IsBadWritePtr.
> >     * resource.cc (getrlimit): Ditto.
> >     (setrlimit): Ditto.
> >     * thread.cc (check_valid_pointer): Ditto.
> >
> >
> > What about the other instances of virtualQuery? Or are the appropriate..
> >
> > Rob (Your humble delegate).
> >
> >
> >
> > ----- Original Message -----
> > From: "Christopher Faylor" <cgf@redhat.com>
> > To: <cygwin@cygwin.com>
> > Sent: Wednesday, June 27, 2001 3:35 PM
> > Subject: Re: pthreads works, sorta
> >
> >
> > > On Wed, Jun 27, 2001 at 01:29:32AM -0400, Christopher Faylor wrote:
> > > >On Wed, Jun 27, 2001 at 01:10:35PM +1000, Robert Collins wrote:
> > > >>> -----Original Message-----
> > > >>> From: Greg Smith [ mailto:gsmith@nc.rr.com ]
> > > >>
> > > >>>
> > > >>> More experimenting with my home computer, dual pIII 850:
> > > >>>
> > > >>> 1. 117  157 328
> > > >>> 2. 822 1527 ---
> > > >>> 3. 194  240 453
> > > >>> 4. 169  181 516
> > > >>>
> > > >>As usual, I write a missive, then solve the puzzle.
> > > >>
> > > >>try this:
> > > >>
> > > >>
> > > >>int __stdcall
> > > >>check_valid_pointer (void *pointer)
> > > >>{
> > > >>  if (!pointer || IsBadWritePtr(pointer, sizeof
(verifyable_object)))
> > > >>    return EFAULT;
> > > >>  return 0;
> > > >>}
> > > >
> > > >This is not quite the same thing as VirtualQuery.  This verifies that
> the
> > > >process can write to memory.  It doesn't verify that it is
accessible.
> > > >
> > > >Maybe that is not important but I would have to think about this.
> > > >
> > > >Nice find, though, Rob.
> > >
> > > I've thought about it.  IsBadWritePtr should be fine in both
> > check_null_empty_path
> > > and check_valid_pointer.
> > >
> > > Could you submit a patch, Rob?  If you are motivated, I'd appreciate a
> > cleanup
> > > patch for resource.cc, too.
> > >
> > > cgf
> > >
> > > --
> > > Unsubscribe info:      http://cygwin.com/ml/#unsubscribe-simple
> > > Bug reporting:         http://cygwin.com/bugs.html
> > > Documentation:         http://cygwin.com/docs.html
> > > FAQ:                   http://cygwin.com/faq/
> > >
> > >
> >
>

------------=_1583532848-65438-82
Content-Type: text/x-diff; charset=us-ascii; name="virtualquery.patch"
Content-Disposition: inline; filename="virtualquery.patch"
Content-Transfer-Encoding: base64
Content-Length: 4872

PyB2aXJ0dWFscXVlcnkucGF0Y2gKSW5kZXg6IHBhdGguY2MKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9j
eWd3aW4vcGF0aC5jYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4xNTQKZGlm
ZiAtdSAtcCAtcjEuMTU0IHBhdGguY2MKLS0tIHBhdGguY2MJMjAwMS8wNi8y
NCAyMjoyNjo1MgkxLjE1NAorKysgcGF0aC5jYwkyMDAxLzA2LzI3IDE0OjE2
OjI4CkBAIC0zMzU3LDE0ICszMzU3LDI0IEBAIGN5Z3dpbl9zcGxpdF9wYXRo
IChjb25zdCBjaGFyICpwYXRoLCBjaGEKIGludCBfX3N0ZGNhbGwKIGNoZWNr
X251bGxfZW1wdHlfcGF0aCAoY29uc3QgY2hhciAqbmFtZSkKIHsKLSAgTUVN
T1JZX0JBU0lDX0lORk9STUFUSU9OIG07Ci0gIGlmICghbmFtZSB8fCAhVmly
dHVhbFF1ZXJ5IChuYW1lLCAmbSwgc2l6ZW9mIChtKSkgfHwgKG0uU3RhdGUg
IT0gTUVNX0NPTU1JVCkpCi0gICAgcmV0dXJuIEVGQVVMVDsKKyAgaWYgKCFu
YW1lIHx8IElzQmFkU3RyaW5nUHRyIChuYW1lLCBNQVhfUEFUSCArIDEpKQor
ICAgIHsKKyAgICAgIHJldHVybiBFRkFVTFQ7CisgICAgfQogCiAgIGlmICgh
Km5hbWUpCiAgICAgcmV0dXJuIEVOT0VOVDsKIAogICByZXR1cm4gMDsKK30K
KworaW50IF9fc3RkY2FsbAorY2hlY2tfbnVsbF9lbXB0eV9wYXRoX2Vycm5v
KGNvbnN0IGNoYXIgKm5hbWUpCit7IAorICBpbnQgX19lcnI7IAorICBpZiAo
KF9fZXJyID0gY2hlY2tfbnVsbF9lbXB0eV9wYXRoIChuYW1lKSkpIAorICAg
IHNldF9lcnJubyAoX19lcnIpOyAKKyAgcmV0dXJuIF9fZXJyOyAKIH0KIAog
LyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwpJbmRleDogcGF0
aC5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnMvc3Jj
L3NyYy93aW5zdXAvY3lnd2luL3BhdGguaCx2CnJldHJpZXZpbmcgcmV2aXNp
b24gMS4zMApkaWZmIC11IC1wIC1yMS4zMCBwYXRoLmgKLS0tIHBhdGguaAky
MDAxLzA2LzI0IDIyOjI2OjUyCTEuMzAKKysrIHBhdGguaAkyMDAxLzA2LzI3
IDE0OjE2OjI4CkBAIC0xNTEsMjAgKzE1MSwxMiBAQCBjbGFzcyBwYXRoX2Nv
bnYKIGludCBfX3N0ZGNhbGwgZ2V0X2RldmljZV9udW1iZXIgKGNvbnN0IGNo
YXIgKm5hbWUsIGludCAmdW5pdCwgQk9PTCBmcm9tX2NvbnYgPSBGQUxTRSkg
IF9fYXR0cmlidXRlX18gKChyZWdwYXJtKDMpKSk7CiBpbnQgX19zdGRjYWxs
IHNsYXNoX3VuY19wcmVmaXhfcCAoY29uc3QgY2hhciAqcGF0aCkgX19hdHRy
aWJ1dGVfXyAoKHJlZ3Bhcm0oMSkpKTsKIGludCBfX3N0ZGNhbGwgY2hlY2tf
bnVsbF9lbXB0eV9wYXRoIChjb25zdCBjaGFyICpuYW1lKSBfX2F0dHJpYnV0
ZV9fICgocmVncGFybSgxKSkpOworaW50IF9fc3RkY2FsbCBjaGVja19udWxs
X2VtcHR5X3BhdGhfZXJybm8gKGNvbnN0IGNoYXIgKm5hbWUpIF9fYXR0cmli
dXRlX18gKChyZWdwYXJtKDEpKSk7CiAKIGNvbnN0IGNoYXIgKiBfX3N0ZGNh
bGwgZmluZF9leGVjIChjb25zdCBjaGFyICpuYW1lLCBwYXRoX2NvbnYmIGJ1
ZiwgY29uc3QgY2hhciAqd2luZW52ID0gIlBBVEg9IiwKIAkJCWludCBudWxs
X2lmX25vdGZvdW5kID0gMCwgY29uc3QgY2hhciAqKmtub3duX3N1ZmZpeCA9
IE5VTEwpICBfX2F0dHJpYnV0ZV9fICgocmVncGFybSgzKSkpOwogCiAvKiBD
b21tb24gbWFjcm9zIGZvciBjaGVja2luZyBmb3IgaW52YWxpZCBwYXRoIG5h
bWVzICovCi0KLSNkZWZpbmUgY2hlY2tfbnVsbF9lbXB0eV9wYXRoX2Vycm5v
KHNyYykgXAotKHsgXAotICBpbnQgX19lcnI7IFwKLSAgaWYgKChfX2VyciA9
IGNoZWNrX251bGxfZW1wdHlfcGF0aChzcmMpKSkgXAotICAgIHNldF9lcnJu
byAoX19lcnIpOyBcCi0gIF9fZXJyOyBcCi19KQotCiAjZGVmaW5lIGlzZHJp
dmUocykgKGlzYWxwaGEgKCoocykpICYmIChzKVsxXSA9PSAnOicpCiAKIHN0
YXRpYyBpbmxpbmUgYm9vbApJbmRleDogcmVzb3VyY2UuY2MKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9j
eWd3aW4vcmVzb3VyY2UuY2MsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTAK
ZGlmZiAtdSAtcCAtcjEuMTAgcmVzb3VyY2UuY2MKLS0tIHJlc291cmNlLmNj
CTIwMDEvMDYvMjQgMjI6MjY6NTIJMS4xMAorKysgcmVzb3VyY2UuY2MJMjAw
MS8wNi8yNyAxNDoxNjoyOQpAQCAtMTA1LDggKzEwNSw3IEBAIGV4dGVybiAi
QyIKIGludAogZ2V0cmxpbWl0IChpbnQgcmVzb3VyY2UsIHN0cnVjdCBybGlt
aXQgKnJscCkKIHsKLSAgTUVNT1JZX0JBU0lDX0lORk9STUFUSU9OIG07Ci0g
IGlmICghcmxwIHx8ICFWaXJ0dWFsUXVlcnkgKHJscCwgJm0sIHNpemVvZiAo
bSkpIHx8IChtLlN0YXRlICE9IE1FTV9DT01NSVQpKQorICBpZiAoIXJscCB8
fCBJc0JhZFdyaXRlUHRyIChybHAsIHNpemVvZiAoc3RydWN0IHJsaW1pdCkp
KQogICAgIHsKICAgICAgIHNldF9lcnJubyAoRUZBVUxUKTsKICAgICAgIHJl
dHVybiAtMTsKQEAgLTE0MSw4ICsxNDAsNyBAQCBleHRlcm4gIkMiCiBpbnQK
IHNldHJsaW1pdCAoaW50IHJlc291cmNlLCBjb25zdCBzdHJ1Y3QgcmxpbWl0
ICpybHApCiB7Ci0gIE1FTU9SWV9CQVNJQ19JTkZPUk1BVElPTiBtOwotICBp
ZiAoIXJscCB8fCAhVmlydHVhbFF1ZXJ5IChybHAsICZtLCBzaXplb2YgKG0p
KSB8fCAobS5TdGF0ZSAhPSBNRU1fQ09NTUlUKSkKKyAgaWYgKCFybHAgfHwg
SXNCYWRXcml0ZVB0ciAoKHZvaWQgKikgcmxwLCBzaXplb2YgKHN0cnVjdCBy
bGltaXQpKSkKICAgICB7CiAgICAgICBzZXRfZXJybm8gKEVGQVVMVCk7CiAg
ICAgICByZXR1cm4gLTE7CkluZGV4OiB0aHJlYWQuY2MKPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3
aW4vdGhyZWFkLmNjLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjM4CmRpZmYg
LXUgLXAgLXIxLjM4IHRocmVhZC5jYwotLS0gdGhyZWFkLmNjCTIwMDEvMDYv
MjYgMTQ6NTc6MzMJMS4zOAorKysgdGhyZWFkLmNjCTIwMDEvMDYvMjcgMTQ6
MTY6MzAKQEAgLTczOSw5ICs3MzksNyBAQCB2ZXJpZnlhYmxlX29iamVjdDo6
fnZlcmlmeWFibGVfb2JqZWN0ICgpCiBpbnQgX19zdGRjYWxsCiBjaGVja192
YWxpZF9wb2ludGVyICh2b2lkICpwb2ludGVyKQogewotICBNRU1PUllfQkFT
SUNfSU5GT1JNQVRJT04gbTsKLSAgaWYgKCFwb2ludGVyIHx8ICFWaXJ0dWFs
UXVlcnkgKHBvaW50ZXIsICZtLCBzaXplb2YgKG0pKQotICAgICAgfHwgKG0u
U3RhdGUgIT0gTUVNX0NPTU1JVCkpCisgIGlmICghcG9pbnRlciB8fCBJc0Jh
ZFdyaXRlUHRyKHBvaW50ZXIsIHNpemVvZiAodmVyaWZ5YWJsZV9vYmplY3Qp
KSkKICAgICByZXR1cm4gRUZBVUxUOwogICByZXR1cm4gMDsKIH0K

------------=_1583532848-65438-82--
