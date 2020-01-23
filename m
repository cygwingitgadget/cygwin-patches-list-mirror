Return-Path: <cygwin-patches-return-9997-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 109441 invoked by alias); 23 Jan 2020 17:13:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 109430 invoked by uid 89); 23 Jan 2020 17:13:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.2 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM10-MW2-obe.outbound.protection.outlook.com
Received: from mail-mw2nam10on2118.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) (40.107.94.118) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 17:13:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=FTVCX4j1meKzOsTX59hnsYYhnOYo59Fge0y+bwsFNQuw2q3XoR7wSX4m9wQnKDHgjFuFVaBrbR3cWf2CMz5X5c4dalOG6x8YuGypW3tWqp+uO5uxI/bkBuaSmdLGq/5h+yN01HjyIzVl7Gjbws1zpsBbxQ3u8gFYFtoma0s85aQqzQZQ6mJdbYLCKdVvRo3oEtjzyHSovSzVUzWAecMQwR8IwkB75cx37s7pCsAFAk4ProVKUWuel2PxsBFG8PEwAMJBwuCAMw9B3Z6jKA/2cTmv1k9ZXjUaDq2oLEYn8Drs26DQ3CYOe5x0lFXXo6JtqGaZ6Zk2yWqrSMMHY6lGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=srjuEgfRYY5uBRvR8kZRGk2EhRwYjZUI2w8WaFln8Dg=; b=DIoKHCOQGAxW8aY8+RmMGFLo8sGQiPkkTkdyK8CJGjY8qIo8ligvvr2dlAGalIg8SibWDYrG4Dm41wPAm3f1NSwo+mwrdDf0I2kRYCylVwkYByR02a57+m530As6NFOj6F2++eUpUSW3KBQgTyfWpfTkEFuQN0WXHy9nZgb0IFXDMEjazSTEil0RN9emPWKyMT9Ooeoc0TacE9VbD2v5ir1GIPFfIIWpKZYKveAk/qAUrhbA6tgLbGv7uJ0Wdozu3Oj0aB86J4MUk2HLz5+HyTIPed0GSgNuJOtt/nDBCPscBVmKmDYHRyccZwE+5Yhl5Tl0Srud1jarWvOB5Oh9dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=srjuEgfRYY5uBRvR8kZRGk2EhRwYjZUI2w8WaFln8Dg=; b=QYnObgj9GX3BEeR2CWyJO/LnAbh/upwA1pPoo3dl+qkD20pYJpyx3M/cS8/wxYhtqZ7Hv2pLCZIeXKkc+9TPKv6fC8XZsg84rBSsd9e1wuzhEOhWmXT7B8GAYBVWGpD5xwhtbTubnkayg8lrGofU9L6+Lpu+VeRKSZt8ljq+B5w=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6SPR01MB0053.namprd04.prod.outlook.com (20.178.229.204) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Thu, 23 Jan 2020 17:12:59 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020 17:12:59 +0000
Received: from [10.13.22.8] (65.112.130.194) by BL0PR01CA0017.prod.exchangelabs.com (2603:10b6:208:71::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.21 via Frontend Transport; Thu, 23 Jan 2020 17:12:58 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 0/3] Fix the O_PATH support for FIFOs
Date: Thu, 23 Jan 2020 17:13:00 -0000
Message-ID: <5da4ce10-7834-4476-8078-ddb47971e18f@cornell.edu>
References: <20200123163015.12354-1-kbrown@cornell.edu>
In-Reply-To: <20200123163015.12354-1-kbrown@cornell.edu>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:2331;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;	boundary="_002_5da4ce10783444768078ddb47971e18fcornelledu_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qL57UtxX7JYdYiys2SVcWuh5T+LmSHNKHAi4vd7Mv8nSNd6nuTIFYBAvZHMGM5hFfdnzfj4TyOOxg8T6Ph5Vew==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00103.txt


--_002_5da4ce10783444768078ddb47971e18fcornelledu_
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <4BD265B69352924D8AAE5BCDF0A79842@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Content-length: 1970

On 1/23/2020 11:31 AM, Ken Brown wrote:
> Commit aa55d22c, "Cygwin: honor the O_PATH flag when opening a FIFO",
> fixed a hang but otherwise didn't accomplish the purpose of the O_PATH
> flag as stated in the Linux man page for open(2):
>=20
>      Obtain a file descriptor that can be used for two purposes: to
>      indicate a location in the filesystem tree and to perform
>      operations that act purely at the file descriptor level.  The
>      file itself is not opened, and other file operations (e.g.,
>      read(2), write(2), fchmod(2), fchown(2), fgetxattr(2),
>      ioctl(2), mmap(2)) fail with the error EBADF.
>=20
>      [The man page goes on to describe operations that *can* be
>      performed: close(2), fchdir(2), fstat(2),....]
>=20
>      Opening a file or directory with the O_PATH flag requires no
>      permissions on the object itself (but does require execute
>      permission on the directories in the path prefix).
>=20
> The first problem in the current implementation is that if open(2) is
> called on a FIFO, fhandler_base::device_access_denied is called and
> tries to open the FIFO with read access, which isn't supposed to be
> required.  This is fixed by the first patch in this series.
>=20
> The second patch makes fhandler_fifo::open call fhandler_base::open_fs
> if O_PATH is set, so that we actually obtain a handle that can be used
> for the purposes stated above.
>=20
> The third page tweaks fhandler_fifo::fcntl and fhandler_fifo::dup so
> that they work with O_PATH.
>=20
> In a followup email I'll provide the program I used to test this
> implementation.

Test program attached.

$ gcc -o o_path_fifo_test o_path_fifo_test.c

$ ./o_path_fifo_test.exe
The following calls should fail with EBADF:
read: OK
write: OK
fchmod: OK
fchown: OK
ioctl: OK
fgetxattr: OK
mmap: OK

The following calls should succeed:
fstat: OK
fstatfs: OK
fcntl_dup: OK
fcntl_getfl: OK
fcntl_setfl: OK
fcntl_getfd: OK
fcntl_setfd: OK
close: OK

--_002_5da4ce10783444768078ddb47971e18fcornelledu_
Content-Type: text/plain; name="o_path_fifo_test.c"
Content-Description: o_path_fifo_test.c
Content-Disposition: attachment; filename="o_path_fifo_test.c"; size=2583;
	creation-date="Thu, 23 Jan 2020 17:12:59 GMT";
	modification-date="Thu, 23 Jan 2020 17:12:59 GMT"
Content-ID: <C41A8AC8BFF90A4C8BAB1B0AD281A9AC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Content-length: 3502

I2RlZmluZSBfR05VX1NPVVJDRQ0KI2luY2x1ZGUgPHN5cy9zdGF0Lmg+DQoj
aW5jbHVkZSA8ZXJybm8uaD4NCiNpbmNsdWRlIDxzdGRpby5oPg0KI2luY2x1
ZGUgPHN0ZGxpYi5oPg0KI2luY2x1ZGUgPGZjbnRsLmg+DQojaW5jbHVkZSA8
dW5pc3RkLmg+DQojaW5jbHVkZSA8c3lzL2lvY3RsLmg+DQojaW5jbHVkZSA8
ZmNudGwuaD4NCiNpbmNsdWRlIDxzeXMvdmZzLmg+DQojaW5jbHVkZSA8c3lz
L3hhdHRyLmg+DQojaW5jbHVkZSA8c3lzL21tYW4uaD4NCg0KI2RlZmluZSBG
SUZPX1BBVEggIi90bXAvbXlmaWZvIg0KDQppbnQNCm1haW4gKCkNCnsNCiAg
c3RydWN0IHN0YXQgczsNCiAgaW50IGZkOw0KDQogIGlmIChta2ZpZm8gKEZJ
Rk9fUEFUSCwgU19JUlVTUiB8IFNfSVdVU1IgfCBTX0lXR1JQKSA8IDANCiAg
ICAgICYmIGVycm5vICE9IEVFWElTVCkNCiAgICB7DQogICAgICBwZXJyb3Ig
KCJta2ZpZm8iKTsNCiAgICAgIGV4aXQgKDEpOw0KICAgIH0NCg0KICBmZCA9
IG9wZW4gKEZJRk9fUEFUSCwgT19QQVRIKTsNCiAgaWYgKGZkIDwgMCkNCiAg
ICB7DQogICAgICBwZXJyb3IgKCJvcGVuIik7DQogICAgICBleGl0ICgxKTsN
CiAgICB9DQogIHByaW50ZiAoIlRoZSBmb2xsb3dpbmcgY2FsbHMgc2hvdWxk
IGZhaWwgd2l0aCBFQkFERjpcbiIpOw0KDQogIGVycm5vID0gMDsNCiAgaWYg
KHJlYWQgKGZkLCBOVUxMLCAwKSA8IDAgJiYgZXJybm8gPT0gRUJBREYpDQog
ICAgcHJpbnRmICgicmVhZDogT0tcbiIpOw0KICBlbHNlDQogICAgcGVycm9y
ICgicmVhZCIpOw0KDQogIGVycm5vID0gMDsNCiAgaWYgKHdyaXRlIChmZCwg
TlVMTCwgMCkgPCAwICYmIGVycm5vID09IEVCQURGKQ0KICAgIHByaW50ZiAo
IndyaXRlOiBPS1xuIik7DQogIGVsc2UNCiAgICBwZXJyb3IgKCJ3cml0ZSIp
Ow0KDQogIGVycm5vID0gMDsNCiAgaWYgKGZjaG1vZCAoZmQsIDApIDwgMCAm
JiBlcnJubyA9PSBFQkFERikNCiAgICBwcmludGYgKCJmY2htb2Q6IE9LXG4i
KTsNCiAgZWxzZQ0KICAgIHBlcnJvciAoImZjaG1vZCIpOw0KDQogIGVycm5v
ID0gMDsNCiAgaWYgKGZjaG93biAoZmQsIC0xLCAtMSkgPCAwICYmIGVycm5v
ID09IEVCQURGKQ0KICAgIHByaW50ZiAoImZjaG93bjogT0tcbiIpOw0KICBl
bHNlDQogICAgcGVycm9yICgiZmNob3duIik7DQoNCiAgZXJybm8gPSAwOw0K
ICBpZiAoaW9jdGwgKGZkLCBGSU9OQklPLCBOVUxMKSA8IDAgJiYgZXJybm8g
PT0gRUJBREYpDQogICAgcHJpbnRmICgiaW9jdGw6IE9LXG4iKTsNCiAgZWxz
ZQ0KICAgIHBlcnJvciAoImlvY3RsIik7DQoNCiAgZXJybm8gPSAwOw0KICBp
ZiAoZmdldHhhdHRyIChmZCwgIiIsIE5VTEwsIDApIDwgMCAmJiBlcnJubyA9
PSBFQkFERikNCiAgICBwcmludGYgKCJmZ2V0eGF0dHI6IE9LXG4iKTsNCiAg
ZWxzZQ0KICAgIHBlcnJvciAoImZnZXR4YXR0ciIpOw0KDQogIGVycm5vID0g
MDsNCiAgaWYgKG1tYXAgKE5VTEwsIDEsIDAsIE1BUF9TSEFSRUQsIGZkLCAw
KSA9PSBNQVBfRkFJTEVEICYmIGVycm5vID09IEVCQURGKQ0KICAgIHByaW50
ZiAoIm1tYXA6IE9LXG4iKTsNCiAgZWxzZQ0KICAgIHBlcnJvciAoIm1tYXAi
KTsNCg0KICBwcmludGYgKCJcblRoZSBmb2xsb3dpbmcgY2FsbHMgc2hvdWxk
IHN1Y2NlZWQ6XG4iKTsNCg0KICBpZiAoZnN0YXQgKGZkLCAmcykgPCAwKQ0K
ICAgIHBlcnJvciAoImZzdGF0Iik7DQogIGVsc2UNCiAgICBwcmludGYgKCJm
c3RhdDogT0tcbiIpOw0KDQogIHN0cnVjdCBzdGF0ZnMgc3Q7DQogIGlmIChm
c3RhdGZzIChmZCwgJnN0KSA8IDApDQogICAgcGVycm9yICgiZnN0YXRmcyIp
Ow0KICBlbHNlDQogICAgcHJpbnRmICgiZnN0YXRmczogT0tcbiIpOw0KDQog
IGlmIChmY250bCAoZmQsIEZfRFVQRkQsIDApIDwgMCkNCiAgICBwZXJyb3Ig
KCJmY250bF9kdXAiKTsNCiAgZWxzZQ0KICAgIHByaW50ZiAoImZjbnRsX2R1
cDogT0tcbiIpOw0KDQogIGludCBmbGFncyA9IGZjbnRsIChmZCwgRl9HRVRG
TCk7DQogIGlmIChmbGFncyA8IDApDQogICAgcGVycm9yICgiZmNudGxfZ2V0
ZmwiKTsNCiAgZWxzZQ0KICAgIHByaW50ZiAoImZjbnRsX2dldGZsOiBPS1xu
Iik7DQoNCiAgaWYgKGZsYWdzID49IDApDQogICAgew0KICAgICAgaWYgKGZj
bnRsIChmZCwgRl9TRVRGTCwgZmxhZ3MpIDwgMCkNCglwZXJyb3IgKCJmY250
bF9zZXRmbCIpOw0KICAgICAgZWxzZQ0KCXByaW50ZiAoImZjbnRsX3NldGZs
OiBPS1xuIik7DQogICAgfQ0KDQogIGZsYWdzID0gZmNudGwgKGZkLCBGX0dF
VEZEKTsNCiAgaWYgKGZsYWdzIDwgMCkNCiAgICBwZXJyb3IgKCJmY250bF9n
ZXRmZCIpOw0KICBlbHNlDQogICAgcHJpbnRmICgiZmNudGxfZ2V0ZmQ6IE9L
XG4iKTsNCg0KICBpZiAoZmxhZ3MgPj0gMCkNCiAgICB7DQogICAgICBpZiAo
ZmNudGwgKGZkLCBGX1NFVEZELCBmbGFncykgPCAwKQ0KCXBlcnJvciAoImZj
bnRsX3NldGZkIik7DQogICAgICBlbHNlDQoJcHJpbnRmICgiZmNudGxfc2V0
ZmQ6IE9LXG4iKTsNCiAgICB9DQoNCiAgaWYgKGNsb3NlIChmZCkgPCAwKQ0K
ICAgIHBlcnJvciAoImNsb3NlIik7DQogIGVsc2UNCiAgICBwcmludGYgKCJj
bG9zZTogT0tcbiIpOw0KfQ0K

--_002_5da4ce10783444768078ddb47971e18fcornelledu_--
