From: Victor Tsou <vtsou@good.com>
To: "'cygwin-patches@cygwin.com '" <cygwin-patches@cygwin.com>
Subject: [PATCH] Serial code stack corruption
Date: Mon, 10 Dec 2001 15:23:00 -0000
Message-ID: <E1740305C340D411AC5500B0D020FF7A010656F2@stmail01.good.com>
X-SW-Source: 2001-q4/msg00297.html
Content-type: multipart/mixed; boundary="----------=_1583532850-65438-124"
Message-ID: <20011210152300.GR0MBIh2DDlhpW9IharXHWlVdwCSYnc9dMOKtCyfvxI@z>

This is a multi-part message in MIME format...

------------=_1583532850-65438-124
Content-length: 642

Title: [PATCH] Serial code stack corruption






WaitCommEvent was called in overlapped mode with a pointer to a stack variable passed in for lpEvtMask. When the asynchronous request completes in the future, the function might no longer be in scope. In such cases, data on the stack is erroneously overwritten with the event mask.

This patch cancels the WaitCommEvent request by calling SetCommMask. This is the only documented method of cancelling the eventmask update.

Â 


Attachment:
ChangeLog
Description: Binary data
Attachment:
fhandler_serial.cc-patch
Description: Binary data
Attachment:
select.cc-patch
Description: Binary data


------------=_1583532850-65438-124
Content-Type: text/plain; charset=us-ascii; name="ChangeLog"
Content-Disposition: inline; filename="ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 236

MjAwMS0xMi0xMCAgVmljdG9yIFRzb3UgIDx2dHNvdUBnb29kLmNvbT4KCgkq
IGZoYW5kbGVyX3NlcmlhbC5jYyAoZmhhbmRsZXJfc2VyaWFsOjpyYXdfcmVh
ZCk6IENhbmNlbCBXYWl0Q29tbUV2ZW50CgkgIG9wZXJhdGlvbiBvbiBleGl0
LgoJKiBzZWxlY3QuY2MgKHBlZWtfc2VyaWFsKTogRGl0dG8uCg==

------------=_1583532850-65438-124
Content-Type: text/x-diff; charset=us-ascii; name="fhandler_serial.cc-patch"
Content-Disposition: inline; filename="fhandler_serial.cc-patch"
Content-Transfer-Encoding: base64
Content-Length: 314

LS0tIGZoYW5kbGVyX3NlcmlhbC5jYy1vcmlnCU1vbiBEZWMgMTAgMTQ6MDE6
MDkgMjAwMQorKysgZmhhbmRsZXJfc2VyaWFsLmNjCU1vbiBEZWMgMTAgMTQ6
MTM6NTUgMjAwMQpAQCAtMTQ4LDYgKzE0OCw3IEBAIGZoYW5kbGVyX3Nlcmlh
bDo6cmF3X3JlYWQgKHZvaWQgKnB0ciwgc2kKICAgICB9CiAKIG91dDoKKyAg
U2V0Q29tbU1hc2soZ2V0X2hhbmRsZSAoKSwgMCk7CiAgIHJldHVybiB0b3Q7
CiB9CiAK

------------=_1583532850-65438-124
Content-Type: text/x-diff; charset=us-ascii; name="select.cc-patch"
Content-Disposition: inline; filename="select.cc-patch"
Content-Transfer-Encoding: base64
Content-Length: 842

LS0tIHNlbGVjdC5jYy1vcmlnCU1vbiBEZWMgMTAgMTQ6MDE6MDggMjAwMQor
Kysgc2VsZWN0LmNjCU1vbiBEZWMgMTAgMTQ6MDQ6NTIgMjAwMQpAQCAtODYy
LDYgKzg2MiwxNCBAQCBzdHJ1Y3Qgc2VyaWFsaW5mCiAgICAgc2VsZWN0X3Jl
Y29yZCAqc3RhcnQ7CiAgIH07CiAKK3N0cnVjdCBBdXRvUmVsZWFzZVBvcnQK
KyAgeworICAgIEF1dG9SZWxlYXNlUG9ydChIQU5ETEUgX2gpIHsgdGhpcy0+
aCA9IGg7IH0KKyAgICB+QXV0b1JlbGVhc2VQb3J0KCkgeyBTZXRDb21tTWFz
ayAoaCwgMCk7IH0KKyAgcHJpdmF0ZToKKyAgICBIQU5ETEUgaDsKKyAgfTsK
Kwogc3RhdGljIGludAogcGVla19zZXJpYWwgKHNlbGVjdF9yZWNvcmQgKnMs
IGJvb2wpCiB7CkBAIC04NzgsNiArODg2LDcgQEAgcGVla19zZXJpYWwgKHNl
bGVjdF9yZWNvcmQgKnMsIGJvb2wpCiAgIEhBTkRMRSBoOwogICBzZXRfaGFu
ZGxlX29yX3JldHVybl9pZl9ub3Rfb3BlbiAoaCwgcyk7CiAgIGludCByZWFk
eSA9IDA7CisgIEF1dG9SZWxlYXNlUG9ydCBfKGgpOwogCiAgIGlmIChzLT5y
ZWFkX3NlbGVjdGVkICYmIHMtPnJlYWRfcmVhZHkgfHwgKHMtPndyaXRlX3Nl
bGVjdGVkICYmIHMtPndyaXRlX3JlYWR5KSkKICAgICB7Cg==

------------=_1583532850-65438-124--
