From: egor duda <deo@logos-m.ru>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: fileutils-4.0-3
Date: Sun, 17 Jun 2001 04:36:00 -0000
Message-id: <20258602010.20010617153433@logos-m.ru>
References: <Pine.GSO.4.21.0106122003330.3791-100000@devmail.dev.tivoli.com> <20010613105845.D1144@cygbert.vinschen.de> <12812308989.20010613152159@logos-m.ru> <20010613153123.K1144@cygbert.vinschen.de> <4385449600.20010614114100@logos-m.ru> <20010614170757.A1144@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00315.html
Content-type: multipart/mixed; boundary="----------=_1583532848-65438-73"

This is a multi-part message in MIME format...

------------=_1583532848-65438-73
Content-length: 1707

Hi!

Thursday, 14 June, 2001 Corinna Vinschen cygwin-patches@cygwin.com wrote:

>> >> well, CreateFile() accepts 0 as second argument, which is what we
>> >> need-- just query information no matter if anyone opened file in
>> >> DENYALL mode. i've just tested it on nt4.0 -- it works fine.
>> >> 
>> >> the only question is whether we should add new parameter to
>> >> fhandler::open(), say 'int cygwin_flags', or define new flag in
>> >> fcntl.h? for me, the first one looks preferable.
>> 
>> CV> Wow. I just read the MSDN entry of CreateFile and I must admit
>> CV> that I always slipped over that sentence without reading it.
>> CV> It seems obvious now. If that really works (as you state),
>> CV> it would be the ultimate solution for `fstat'.
>> 
>> CV> I think you're right using some internal flag. It's not needed
>> CV> to create a new fcntl flag.
>> 
>> patch attached. i was a bit confused to discover, however, that
>> stat_worker works somehow without it. AFAICS from stat_worker code,
>> if it cannot open file, it still tries to get as much information as
>> it can, file size and times included. so, du works for me either with
>> or without this patch.

CV> The patch is fine, IMO.

unfortunately, when file resides on a remote share,
CreateFile (fname,0,...,OPEN_EXISTING,...) returns valid handle even
if file doesn't exist! i've seen this on nt4, share is nt4 too. just
try to 'touch //server/share/non-exiting-file' -- it prints "file
doesn't exist" instead of creating it.

this patch is supposed to work around it. Can anybody test it in
w9x/w2k/samba environments?

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
query-open-2.ChangeLog
query-open-2.diff


------------=_1583532848-65438-73
Content-Type: text/plain; charset=us-ascii; name="query-open-2.ChangeLog"
Content-Disposition: inline; filename="query-open-2.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 301

MjAwMS0wNi0xNyAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBm
aGFuZGxlci5jYyAoZmhhbmRsZXJfYmFzZTo6b3Blbik6IFdvcmsgYXJvdW5k
IHdpbmRvd3MgYnVnIHdoZW4KCUNyZWF0ZUZpbGUoKSBpdGggZHdEZXNpcmVk
QWNjZXNzID09IDAgY2FsbGVkIG9uIHJlbW90ZSBzaGFyZSByZXR1cm5zCgl2
YWxpZCBoYW5kbGUgZXZlbiBpZiBmaWxlIGRvZXNuJ3QgZXhpc3QuCg==

------------=_1583532848-65438-73
Content-Type: text/x-diff; charset=us-ascii; name="query-open-2.diff"
Content-Disposition: inline; filename="query-open-2.diff"
Content-Transfer-Encoding: base64
Content-Length: 1176

SW5kZXg6IGZoYW5kbGVyLmNjCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNT
IGZpbGU6IC9jdnMvdWJlcmJhdW0vd2luc3VwL2N5Z3dpbi9maGFuZGxlci5j
Yyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS42NgpkaWZmIC11IC1wIC0yIC1y
MS42NiBmaGFuZGxlci5jYwotLS0gZmhhbmRsZXIuY2MJMjAwMS8wNi8xNSAw
MDoyMTowNgkxLjY2CisrKyBmaGFuZGxlci5jYwkyMDAxLzA2LzE3IDExOjMx
OjMyCkBAIC0zNzEsNCArMzcxLDE1IEBAIGZoYW5kbGVyX2Jhc2U6Om9wZW4g
KGludCBmbGFncywgbW9kZV90IG0KICAgICBmaWxlX2F0dHJpYnV0ZXMgfD0g
RklMRV9GTEFHX09WRVJMQVBQRUQ7CiAKKyAgLyogQ3JlYXRlRmlsZSgpIHdp
dGggZHdEZXNpcmVkQWNjZXNzID09IDAgd2hlbiBjYWxsZWQgb24gcmVtb3Rl
CisgICAgIHNoYXJlIHJldHVybnMgc29tZSBoYW5kbGUsIGV2ZW4gaWYgZmls
ZSBkb2Vzbid0IGV4aXN0LiBUaGlzIGNvZGUKKyAgICAgd29ya3MgYXJvdW5k
IHRoaXMgYnVnLiAqLworICBpZiAoZ2V0X3F1ZXJ5X29wZW4gKCkgJiYKKyAg
ICAgIGlzcmVtb3RlICgpICYmCisgICAgICBjcmVhdGlvbl9kaXN0cmlidXRp
b24gPT0gT1BFTl9FWElTVElORyAmJgorICAgICAgR2V0RmlsZUF0dHJpYnV0
ZXMgKGdldF93aW4zMl9uYW1lICgpKSA9PSAoRFdPUkQpIC0xKQorICAgIHsK
KyAgICAgIHNldF9lcnJubyAoRU5PRU5UKTsKKyAgICAgIGdvdG8gZG9uZTsK
KyAgICB9CiAgIHggPSBDcmVhdGVGaWxlQSAoZ2V0X3dpbjMyX25hbWUgKCks
IGFjY2Vzcywgc2hhcmVkLAogCQkgICAmc2VjX25vbmUsIGNyZWF0aW9uX2Rp
c3RyaWJ1dGlvbiwK

------------=_1583532848-65438-73--
