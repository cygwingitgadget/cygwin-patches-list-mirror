Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id 4EAB53857427
 for <cygwin-patches@cygwin.com>; Tue, 18 May 2021 18:56:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4EAB53857427
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 47A58CB70
 for <cygwin-patches@cygwin.com>; Tue, 18 May 2021 14:56:47 -0400 (EDT)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 43D65CB6D
 for <cygwin-patches@cygwin.com>; Tue, 18 May 2021 14:56:47 -0400 (EDT)
Date: Tue, 18 May 2021 11:56:47 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [RFC] FAST_CWD warnings on ARM64 insider preview
Message-ID: <alpine.BSO.2.21.2105181151200.14962@resin.csoft.net>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="9191230013440-829643451-1621364207=:14962"
X-Spam-Status: No, score=-13.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_LOW,
 SPF_HELO_PASS, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 18 May 2021 18:56:52 -0000

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--9191230013440-829643451-1621364207=:14962
Content-Type: text/plain; charset=US-ASCII

I have been trying out x86_64 msys2 (a fork of cygwin) on Windows insider
preview builds on ARM64, which added support for x86_64 emulation.  I was
getting the notorious FAST_CWD warnings, which were interfering with
MINGW CMake.  Last night late, I went looking at the cause, and found some
code that attempted to disable FAST_CWD warnings, but only on i686, and
trying to look at GetNativeSystemInfo, which was lying.  I quickly put
together this patch, and it seems to work.

Note I did this late at night, with no real regard to investigating or
matching code style.  This patch is currently more in an RFC state, if the
approach looks OK, and I'd be grateful for any pointers on getting it into
shape for evental acceptance.

Thanks,
Jeremy
--9191230013440-829643451-1621364207=:14962
Content-Type: text/plain; charset=US-ASCII; name=0001-cygwin-suppress-FAST_CWD-warnings-on-ARM64.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSO.2.21.2105181156470.14962@resin.csoft.net>
Content-Description: 
Content-Disposition: attachment; filename=0001-cygwin-suppress-FAST_CWD-warnings-on-ARM64.patch

RnJvbSAzNDZkZmI3OGZjNTUyMmQ1ZDcyODg1NzFkNjM1MzAzYzY5YTUyNzBh
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSmVyZW15IERyYWtl
IDxjeWd3aW5AamRyYWtlLmNvbT4NCkRhdGU6IFR1ZSwgMTggTWF5IDIwMjEg
MDA6NDg6NTIgLTA3MDANClN1YmplY3Q6IFtQQVRDSF0gY3lnd2luOiBzdXBw
cmVzcyBGQVNUX0NXRCB3YXJuaW5ncyBvbiBBUk02NC4NCg0KVGhlIG9sZCBj
aGVjayB3YXMgaW5zdWZmaWNpZW50OiBuZXcgaW5zaWRlciBwcmV2aWV3IGJ1
aWxkcyBvZiBXaW5kb3dzDQphbGxvdyBydW5uaW5nIHg4Nl82NCBwcm9jZXNz
IG9uIEFSTTY0LiAgVGhlIElzV293NjRQcm9jZXNzMiBmdW5jdGlvbg0Kc2Vl
bXMgdG8gYmUgdGhlIGludGVuZGVkIHdheSB0byBmaWd1cmUgdGhpcyBzaXR1
YXRpb24gb3V0Lg0KLS0tDQogd2luc3VwL2N5Z3dpbi9wYXRoLmNjIHwgMzAg
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9wYXRoLmNjIGIvd2luc3VwL2N5Z3dp
bi9wYXRoLmNjDQppbmRleCBkZDcwNDg0ODYuLjVjNGFkY2Q0OSAxMDA2NDQN
Ci0tLSBhL3dpbnN1cC9jeWd3aW4vcGF0aC5jYw0KKysrIGIvd2luc3VwL2N5
Z3dpbi9wYXRoLmNjDQpAQCAtNDcwOCwyOSArNDcwOCwxOSBAQCBmaW5kX2Zh
c3RfY3dkICgpDQogICAgIHsNCiAgICAgICBib29sIHdhcm4gPSAxOw0KIA0K
LSNpZm5kZWYgX194ODZfNjRfXw0KLSAgICAgICNpZm5kZWYgUFJPQ0VTU09S
X0FSQ0hJVEVDVFVSRV9BUk02NA0KLSAgICAgICNkZWZpbmUgUFJPQ0VTU09S
X0FSQ0hJVEVDVFVSRV9BUk02NCAxMg0KLSAgICAgICNlbmRpZg0KKyNpZm5k
ZWYgSU1BR0VfRklMRV9NQUNISU5FX0FSTTY0DQorI2RlZmluZSBJTUFHRV9G
SUxFX01BQ0hJTkVfQVJNNjQgMHhBQTY0DQorI2VuZGlmDQogDQotICAgICAg
U1lTVEVNX0lORk8gc2k7DQorICAgICAgVVNIT1JUIHByb2NtYWNoaW5lLCBu
YXRpdmVtYWNoaW5lOw0KIA0KICAgICAgIC8qIENoZWNrIGlmIHdlJ3JlIHJ1
bm5pbmcgaW4gV09XNjQgb24gQVJNNjQuICBTa2lwIHRoZSB3YXJuaW5nIGFz
IGxvbmcgYXMNCi0JIHRoZXJlJ3Mgbm8gc29sdXRpb24gZm9yIGZpbmRpbmcg
dGhlIEZBU1RfQ1dEIHBvaW50ZXIgb24gdGhhdCBzeXN0ZW0uDQotDQotCSAy
MDE4LTA3LTEyOiBBcHBhcmVudGx5IGN1cnJlbnQgQVJNNjQgV09XNjQgaGFz
IGEgYnVnOg0KLQkgSXQncyBHZXROYXRpdmVTeXN0ZW1JbmZvIHJldHVybnMg
UFJPQ0VTU09SX0FSQ0hJVEVDVFVSRV9JTlRFTCBpbg0KLQkgd1Byb2Nlc3Nv
ckFyY2hpdGVjdHVyZS4gIFNpbmNlIHRoYXQncyBhbiBpbnZhbGlkIHZhbHVl
IChhIDMyIGJpdA0KLQkgaG9zdCBzeXN0ZW0gaG9zdGluZyBhIDMyIGJpdCBl
bXVsYXRvciBmb3IgaXRzZWxmPykgd2UgY2FuIHVzZSB0aGlzDQotCSB2YWx1
ZSBhcyBhbiBpbmRpY2F0b3IgdG8gc2tpcCB0aGUgbWVzc2FnZSBhcyB3ZWxs
LiAqLw0KLSAgICAgIGlmICh3aW5jYXAuaXNfd293NjQgKCkpDQotCXsNCi0J
ICBHZXROYXRpdmVTeXN0ZW1JbmZvICgmc2kpOw0KLQkgIGlmIChzaS53UHJv
Y2Vzc29yQXJjaGl0ZWN0dXJlID09IFBST0NFU1NPUl9BUkNISVRFQ1RVUkVf
QVJNNjQNCi0JICAgICAgfHwgc2kud1Byb2Nlc3NvckFyY2hpdGVjdHVyZSA9
PSBQUk9DRVNTT1JfQVJDSElURUNUVVJFX0lOVEVMKQ0KLQkgICAgd2FybiA9
IDA7DQotCX0NCi0jZW5kaWYgLyogIV9feDg2XzY0X18gKi8NCisJIHRoZXJl
J3Mgbm8gc29sdXRpb24gZm9yIGZpbmRpbmcgdGhlIEZBU1RfQ1dEIHBvaW50
ZXIgb24gdGhhdCBzeXN0ZW0uICovDQorDQorICAgICAgdHlwZWRlZiBCT09M
IChXSU5BUEkgKiBJc1dvdzY0UHJvY2VzczJfdCkoSEFORExFIGhQcm9jZXNz
LCBVU0hPUlQgKnBQcm9jZXNzTWFjaGluZSwgVVNIT1JUICpwTmF0aXZlTWFj
aGluZSk7DQorICAgICAgSXNXb3c2NFByb2Nlc3MyX3QgcGZuSXNXb3c2NFBy
b2Nlc3MyID0gKElzV293NjRQcm9jZXNzMl90KUdldFByb2NBZGRyZXNzKEdl
dE1vZHVsZUhhbmRsZSgia2VybmVsMzIuZGxsIiksICJJc1dvdzY0UHJvY2Vz
czIiKTsNCisgICAgICBpZiAocGZuSXNXb3c2NFByb2Nlc3MyICYmIHBmbklz
V293NjRQcm9jZXNzMihHZXRDdXJyZW50UHJvY2VzcygpLCAmcHJvY21hY2hp
bmUsICZuYXRpdmVtYWNoaW5lKSAmJiBuYXRpdmVtYWNoaW5lID09IElNQUdF
X0ZJTEVfTUFDSElORV9BUk02NCkNCisJd2FybiA9IDA7DQogDQogICAgICAg
aWYgKHdhcm4pDQogCXNtYWxsX3ByaW50ZiAoIkN5Z3dpbiBXQVJOSU5HOlxu
Ig0KLS0gDQoyLjMxLjEud2luZG93cy4xDQoNCg==

--9191230013440-829643451-1621364207=:14962--
