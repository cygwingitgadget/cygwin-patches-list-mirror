From: "Trevor Forbes" <trevorforbes@ozemail.com.au>
To: "Cygwin-patches" <cygwin-patches@sources.redhat.com>
Subject: Exception using GDB
Date: Wed, 25 Jul 2001 02:42:00 -0000
Message-id: <047f01c114ee$38e66600$0300a8c0@ufo>
X-SW-Source: 2001-q3/msg00031.html
Content-type: multipart/mixed; boundary="----------=_1583532848-65438-90"

This is a multi-part message in MIME format...

------------=_1583532848-65438-90
Content-length: 309

A fix for the bad pointer exception when a debugger is attached. 

 * thread.cc (verifyable_object_isvalid): Don't validate
PTHREAD_MUTEX_INITIALIZER pointer as it will cause an exception in
IsBadWritePtr() when running GDB.

Note, Insight has a bug and it will not work without this patch.... 

Trevor







------------=_1583532848-65438-90
Content-Type: text/x-diff; charset=us-ascii; name="thread.diff"
Content-Disposition: inline; filename="thread.diff"
Content-Transfer-Encoding: base64
Content-Length: 724

SW5kZXg6IHRocmVhZC5jYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBm
aWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2Msdgpy
ZXRyaWV2aW5nIHJldmlzaW9uIDEuMzkKZGlmZiAtdSAtMyAtcCAtcjEuMzkg
dGhyZWFkLmNjCi0tLSB0aHJlYWQuY2MgMjAwMS8wNi8yOCAwMjoxOTo1NyAx
LjM5CisrKyB0aHJlYWQuY2MgMjAwMS8wNy8yNCAxMTowMToxNgpAQCAtNzQ3
LDcgKzc0Nyw3IEBAIGNoZWNrX3ZhbGlkX3BvaW50ZXIgKHZvaWQgKnBvaW50
ZXIpCiBpbnQKIHZlcmlmeWFibGVfb2JqZWN0X2lzdmFsaWQgKHZlcmlmeWFi
bGVfb2JqZWN0ICogb2JqZWN0LCBsb25nIG1hZ2ljKQogewotICBpZiAoIW9i
amVjdCkKKyAgaWYgKCFvYmplY3QgfHwgb2JqZWN0ID09IFBUSFJFQURfTVVU
RVhfSU5JVElBTElaRVIpCiAgICAgcmV0dXJuIDA7CiAgIGlmIChjaGVja192
YWxpZF9wb2ludGVyIChvYmplY3QpKQogICAgIHJldHVybiAwOwo=

------------=_1583532848-65438-90--
