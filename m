From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Robert Collins" <robert.collins@itdomain.com.au>, <cygwin@cygwin.com>, <cygwin-patches@cygwin.com>
Subject: Re: pthreads works, sorta
Date: Wed, 27 Jun 2001 06:35:00 -0000
Message-id: <009701c0ff0e$4d796400$806410ac@local>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F09E@itdomain002.itdomain.net.au> <20010627012932.I19058@redhat.com> <20010627013502.K19058@redhat.com> <008201c0ff0d$8fe3c2a0$806410ac@local>
X-SW-Source: 2001-q2/msg00351.html
Content-type: multipart/mixed; boundary="----------=_1583532848-65438-81"

This is a multi-part message in MIME format...

------------=_1583532848-65438-81
Content-length: 2359

The last patch was bad - sorry! (path.cc had a copy-n-pasto).

Rob
----- Original Message -----
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin@cygwin.com>; <cygwin-patches@cygwin.com>
Sent: Wednesday, June 27, 2001 11:32 PM
Subject: Re: pthreads works, sorta


> changelog:
>
> Wed Jun 27 23:30:00 2001  Robert Collins <rbtcollins@hotmail.com>
>
>     * path.cc (check_null_empty_path): Change from VirtualQuery to
> IsBadWritePtr.
>     * resource.cc (getrlimit): Ditto.
>     (setrlimit): Ditto.
>     * thread.cc (check_valid_pointer): Ditto.
>
>
> What about the other instances of virtualQuery? Or are the appropriate..
>
> Rob (Your humble delegate).
>
>
>
> ----- Original Message -----
> From: "Christopher Faylor" <cgf@redhat.com>
> To: <cygwin@cygwin.com>
> Sent: Wednesday, June 27, 2001 3:35 PM
> Subject: Re: pthreads works, sorta
>
>
> > On Wed, Jun 27, 2001 at 01:29:32AM -0400, Christopher Faylor wrote:
> > >On Wed, Jun 27, 2001 at 01:10:35PM +1000, Robert Collins wrote:
> > >>> -----Original Message-----
> > >>> From: Greg Smith [ mailto:gsmith@nc.rr.com ]
> > >>
> > >>>
> > >>> More experimenting with my home computer, dual pIII 850:
> > >>>
> > >>> 1. 117  157 328
> > >>> 2. 822 1527 ---
> > >>> 3. 194  240 453
> > >>> 4. 169  181 516
> > >>>
> > >>As usual, I write a missive, then solve the puzzle.
> > >>
> > >>try this:
> > >>
> > >>
> > >>int __stdcall
> > >>check_valid_pointer (void *pointer)
> > >>{
> > >>  if (!pointer || IsBadWritePtr(pointer, sizeof (verifyable_object)))
> > >>    return EFAULT;
> > >>  return 0;
> > >>}
> > >
> > >This is not quite the same thing as VirtualQuery.  This verifies that
the
> > >process can write to memory.  It doesn't verify that it is accessible.
> > >
> > >Maybe that is not important but I would have to think about this.
> > >
> > >Nice find, though, Rob.
> >
> > I've thought about it.  IsBadWritePtr should be fine in both
> check_null_empty_path
> > and check_valid_pointer.
> >
> > Could you submit a patch, Rob?  If you are motivated, I'd appreciate a
> cleanup
> > patch for resource.cc, too.
> >
> > cgf
> >
> > --
> > Unsubscribe info:      http://cygwin.com/ml/#unsubscribe-simple
> > Bug reporting:         http://cygwin.com/bugs.html
> > Documentation:         http://cygwin.com/docs.html
> > FAQ:                   http://cygwin.com/faq/
> >
> >
>

------------=_1583532848-65438-81
Content-Type: text/x-diff; charset=us-ascii; name="virtualquery.patch"
Content-Disposition: inline; filename="virtualquery.patch"
Content-Transfer-Encoding: base64
Content-Length: 2851

PyB2aXJ0dWFscXVlcnkucGF0Y2gKSW5kZXg6IHBhdGguY2MKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9j
eWd3aW4vcGF0aC5jYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4xNTQKZGlm
ZiAtdSAtcCAtcjEuMTU0IHBhdGguY2MKLS0tIHBhdGguY2MJMjAwMS8wNi8y
NCAyMjoyNjo1MgkxLjE1NAorKysgcGF0aC5jYwkyMDAxLzA2LzI3IDEzOjM0
OjI0CkBAIC0zMzU3LDggKzMzNTcsNyBAQCBjeWd3aW5fc3BsaXRfcGF0aCAo
Y29uc3QgY2hhciAqcGF0aCwgY2hhCiBpbnQgX19zdGRjYWxsCiBjaGVja19u
dWxsX2VtcHR5X3BhdGggKGNvbnN0IGNoYXIgKm5hbWUpCiB7Ci0gIE1FTU9S
WV9CQVNJQ19JTkZPUk1BVElPTiBtOwotICBpZiAoIW5hbWUgfHwgIVZpcnR1
YWxRdWVyeSAobmFtZSwgJm0sIHNpemVvZiAobSkpIHx8IChtLlN0YXRlICE9
IE1FTV9DT01NSVQpKQorICBpZiAoIW5hbWUgfHwgSXNCYWRXcml0ZVB0ciAo
KHZvaWQgKikgbmFtZSwgMSkpCiAgICAgcmV0dXJuIEVGQVVMVDsKIAogICBp
ZiAoISpuYW1lKQpJbmRleDogcmVzb3VyY2UuY2MKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4v
cmVzb3VyY2UuY2MsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTAKZGlmZiAt
dSAtcCAtcjEuMTAgcmVzb3VyY2UuY2MKLS0tIHJlc291cmNlLmNjCTIwMDEv
MDYvMjQgMjI6MjY6NTIJMS4xMAorKysgcmVzb3VyY2UuY2MJMjAwMS8wNi8y
NyAxMzozNDoyNApAQCAtMTA1LDggKzEwNSw3IEBAIGV4dGVybiAiQyIKIGlu
dAogZ2V0cmxpbWl0IChpbnQgcmVzb3VyY2UsIHN0cnVjdCBybGltaXQgKnJs
cCkKIHsKLSAgTUVNT1JZX0JBU0lDX0lORk9STUFUSU9OIG07Ci0gIGlmICgh
cmxwIHx8ICFWaXJ0dWFsUXVlcnkgKHJscCwgJm0sIHNpemVvZiAobSkpIHx8
IChtLlN0YXRlICE9IE1FTV9DT01NSVQpKQorICBpZiAoIXJscCB8fCBJc0Jh
ZFdyaXRlUHRyIChybHAsIHNpemVvZiAoc3RydWN0IHJsaW1pdCkpKQogICAg
IHsKICAgICAgIHNldF9lcnJubyAoRUZBVUxUKTsKICAgICAgIHJldHVybiAt
MTsKQEAgLTE0MSw4ICsxNDAsNyBAQCBleHRlcm4gIkMiCiBpbnQKIHNldHJs
aW1pdCAoaW50IHJlc291cmNlLCBjb25zdCBzdHJ1Y3QgcmxpbWl0ICpybHAp
CiB7Ci0gIE1FTU9SWV9CQVNJQ19JTkZPUk1BVElPTiBtOwotICBpZiAoIXJs
cCB8fCAhVmlydHVhbFF1ZXJ5IChybHAsICZtLCBzaXplb2YgKG0pKSB8fCAo
bS5TdGF0ZSAhPSBNRU1fQ09NTUlUKSkKKyAgaWYgKCFybHAgfHwgSXNCYWRX
cml0ZVB0ciAoKHZvaWQgKikgcmxwLCBzaXplb2YgKHN0cnVjdCBybGltaXQp
KSkKICAgICB7CiAgICAgICBzZXRfZXJybm8gKEVGQVVMVCk7CiAgICAgICBy
ZXR1cm4gLTE7CkluZGV4OiB0aHJlYWQuY2MKPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vdGhy
ZWFkLmNjLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjM4CmRpZmYgLXUgLXAg
LXIxLjM4IHRocmVhZC5jYwotLS0gdGhyZWFkLmNjCTIwMDEvMDYvMjYgMTQ6
NTc6MzMJMS4zOAorKysgdGhyZWFkLmNjCTIwMDEvMDYvMjcgMTM6MzQ6MjUK
QEAgLTczOSw5ICs3MzksNyBAQCB2ZXJpZnlhYmxlX29iamVjdDo6fnZlcmlm
eWFibGVfb2JqZWN0ICgpCiBpbnQgX19zdGRjYWxsCiBjaGVja192YWxpZF9w
b2ludGVyICh2b2lkICpwb2ludGVyKQogewotICBNRU1PUllfQkFTSUNfSU5G
T1JNQVRJT04gbTsKLSAgaWYgKCFwb2ludGVyIHx8ICFWaXJ0dWFsUXVlcnkg
KHBvaW50ZXIsICZtLCBzaXplb2YgKG0pKQotICAgICAgfHwgKG0uU3RhdGUg
IT0gTUVNX0NPTU1JVCkpCisgIGlmICghcG9pbnRlciB8fCBJc0JhZFdyaXRl
UHRyKHBvaW50ZXIsIHNpemVvZiAodmVyaWZ5YWJsZV9vYmplY3QpKSkKICAg
ICByZXR1cm4gRUZBVUxUOwogICByZXR1cm4gMDsKIH0K

------------=_1583532848-65438-81--
