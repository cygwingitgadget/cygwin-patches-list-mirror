From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Greg Smith" <rys@epaibm.rtpnc.epa.gov>, <cygwin@cygwin.com>
Cc: <cygwin-patches@cygwin.com>
Subject: Re: hang in pthread_cond_signal
Date: Thu, 14 Jun 2001 16:25:00 -0000
Message-id: <03cb01c0f529$7b826020$0200a8c0@lifelesswks>
References: <3B290FE5.22678B61@trex.rtpnc.epa.gov>
X-SW-Source: 2001-q2/msg00305.html
Content-type: multipart/mixed; boundary="----------=_1583532848-65438-72"

This is a multi-part message in MIME format...

------------=_1583532848-65438-72
Content-length: 734

----- Original Message -----
From: "Greg Smith" <rys@epaibm.rtpnc.epa.gov>
To: <cygwin@cygwin.com>
Sent: Friday, June 15, 2001 5:26 AM
Subject: hang in pthread_cond_signal


> I am using the cygwin-src snapshot from June 10.
>
> Seems pthread_cond_signal can hang while another thread
> is waiting on the condition AND a pthread_cond_signal
> has been previously issued when no one was waiting on the
> condition.  Below is a testcase that illustrates the
> problem:
>
> Thanks,
>
> Greg
>

Thanks for the testcase Greg. The attached patch fixes your testcase.

Rob

Changelog:


Fri June 15 09:25:00  Robert Collins <rbtcollins@hotmail.com>

    * thread.cc (pthread_cond::Signal): Release the condition access
variable correctly.



------------=_1583532848-65438-72
Content-Type: text/x-diff; charset=us-ascii; name="cond_signal_fix.patch"
Content-Disposition: inline; filename="cond_signal_fix.patch"
Content-Transfer-Encoding: base64
Content-Length: 1188

SW5kZXg6IHRocmVhZC5jYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBm
aWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2Msdgpy
ZXRyaWV2aW5nIHJldmlzaW9uIDEuMzMKZGlmZiAtdSAtcCAtcjEuMzMgdGhy
ZWFkLmNjCi0tLSB0aHJlYWQuY2MJMjAwMS8wNi8wNyAxOTo1NTowNgkxLjMz
CisrKyB0aHJlYWQuY2MJMjAwMS8wNi8xNCAyMzoyMzo1OQpAQCAtNDQyLDcg
KzQ0MiwxMiBAQCBwdGhyZWFkX2NvbmQ6OlNpZ25hbCAoKQogICBpZiAocHRo
cmVhZF9tdXRleF9sb2NrICgmY29uZF9hY2Nlc3MpKQogICAgIHN5c3RlbV9w
cmludGYgKCJGYWlsZWQgdG8gbG9jayBjb25kaXRpb24gdmFyaWFibGUgYWNj
ZXNzIG11dGV4LCB0aGlzICUwcFxuIiwgdGhpcyk7CiAgIGlmICghdmVyaWZ5
YWJsZV9vYmplY3RfaXN2YWxpZCAobXV0ZXgsIFBUSFJFQURfTVVURVhfTUFH
SUMpKQotICAgIHJldHVybjsKKyAgICB7CisgICAgICBpZiAocHRocmVhZF9t
dXRleF91bmxvY2sgKCZjb25kX2FjY2VzcykpCisgICAgICAgIHN5c3RlbV9w
cmludGYgKCJGYWlsZWQgdG8gdW5sb2NrIGNvbmRpdGlvbiB2YXJpYWJsZSBh
Y2Nlc3MgbXV0ZXgsIHRoaXMgJTBwXG4iLAorICAgICAgICAgICAgICAgICAg
ICAgICB0aGlzKTsKKyAgICAgIHJldHVybjsKKyAgICB9CiAgIFB1bHNlRXZl
bnQgKHdpbjMyX29ial9pZCk7CiAgIGlmIChwdGhyZWFkX211dGV4X3VubG9j
ayAoJmNvbmRfYWNjZXNzKSkKICAgICBzeXN0ZW1fcHJpbnRmICgiRmFpbGVk
IHRvIHVubG9jayBjb25kaXRpb24gdmFyaWFibGUgYWNjZXNzIG11dGV4LCB0
aGlzICUwcFxuIiwgdGhpcyk7Cg==

------------=_1583532848-65438-72--
