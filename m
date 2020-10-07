Return-Path: <towo@towo.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 6F4B63857800
 for <cygwin-patches@cygwin.com>; Wed,  7 Oct 2020 16:55:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6F4B63857800
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=towo.net
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=towo@towo.net
Received: from [192.168.178.45] ([95.90.245.244]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mo73N-1kk5zR36JX-00pZE9 for <cygwin-patches@cygwin.com>; Wed, 07 Oct 2020
 18:55:26 +0200
To: cygwin-patches@cygwin.com
From: Thomas Wolff <towo@towo.net>
Subject: drop ambiguous-wide behaviour from Unicode CJK locales
Message-ID: <dad43925-fa94-e993-7c9f-10229321c335@towo.net>
Date: Wed, 7 Oct 2020 18:55:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------80E73E6BD596AB06389DC412"
X-Provags-ID: V03:K1:9z3Nk54kuMgKpbW51zOAisBGjQppg/CH0lQCjWC8ltRwzIGp7Lr
 jA/+6+8m0bUtRbwFbPt788loC4s9ABdR+nnUet+AO2SHYFH+0Dz7lsMZLnHOa3laAHcTqJC
 2U623LeHfF2utUTzt4Vaa3FstDEpIXVYgzsGU0LRChcFuyqiT8g8sdApj7jCM2VGg05xeV0
 iX+K8zmu8HOw4Gp+6D45w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G6FYzZowxkI=:mU+zDYqJNoD/nqz1ySM39g
 cfVdQpdF2OkDfm53xdyrc8JXcZz7wlMS+Nkw0+/MxehuknoZLaor4okPmcWCdauNCUpH/Jo0Q
 XYCQPlQ+tudOR75BQNmGKtqWw2KMnlT486ifLpy8xDQZJ1kWY/XU5ihKszIdIAiuVbdRAQ5wU
 S3sZc0gHSy5q7HTN571UaqnWeMDnkC9LvKJEjI3MKoszcNzLHFCMgGg0/J78kYKkavZVf6Fp8
 hh1NmVffII8PnC2jxZgWQjnwwqoB29UEzbN9cL9pFJxEEv07x1dflcm8+wS+Yi3Efc2GOTh6F
 byCbKUBUn55tvBVkXgEcI8Y02uDKlPmDbcq722KzaT9xBRuBUTMcTVuQkSDMRvUWTvjriSxaO
 6zodmZvxjlaBEKIUwD+ZSmcE8PhMphb4t5BnfeOmU5aanAw28CGIm3kZgS3cfiWNUX7HkPTMo
 mG+YYGcoLhaSFwDqh1E7krwV71HO6w1RECox/UTt66kYaVjGr0cXrvOSnjFxLbGvEuyOd+9V5
 Gd7tX+YonQ8vbDxG766lmYMlRpPa6RYcgfbkhQ8NduwjcAK2YYm6MYoyUhkRtCoC5sfbW3wzo
 nXM4+MLR2eB9l8z0qmPOtU9SqN1JJiaDH+VkidEnNdtWBKL/+Penerta9Np789gSlx5moP+Fo
 TLamVXlFCpavlJjbVPQYw5zt/k0r+anlMiu69hxlcahB7ro4t0MddPCWbgnKIiQZg0IvsykNK
 5d+P5OOLAXogA7D+nh0R9LQ4OlT3MYn/YtZPmn4ebEQmrW/JXSxvEUUwkMtZKf0q5KvgD45hK
 I+pEZYgJV0RktsMzaqkA34rmoL/STX+BkjVB8dBNMoNkvQ0n1k4pXV7FoJMEo3qDzBKhqsj
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 07 Oct 2020 16:55:30 -0000

This is a multi-part message in MIME format.
--------------80E73E6BD596AB06389DC412
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

It seems that ambiguous-wide behaviour (i.e. double-width property for 
characters in the East Asian Ambiguous width category) for CJK locales 
with UTF-8 encoding is inconsistent with Linux locale definitions.
The attached patch changes that. Characters like ─ ü æ are no longer 
wide in the following locales:
ja_JP.utf8
ko_KR.utf8
zh_*.utf8
but only in ja, ko, zh locales with legacy encoding. Explicit modifiers 
@cjkwide and @cjknarrow are not affected.
Thomas

--------------80E73E6BD596AB06389DC412
Content-Type: text/plain; charset=UTF-8;
 name="0001-drop-ambiguous-wide-behaviour-from-Unicode-CJK-local.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-drop-ambiguous-wide-behaviour-from-Unicode-CJK-local.pa";
 filename*1="tch"

RnJvbSBhNWU2YzFkYWFmYmYwMDZkNDM5NGI0MDVhNjM5MmNhNjY5NmY4YzhjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaG9tYXMgV29sZmYgPHRvd29AdG93by5uZXQ+CkRh
dGU6IFdlZCwgNyBPY3QgMjAyMCAxODozNTo1NCArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
b3AgYW1iaWd1b3VzLXdpZGUgYmVoYXZpb3VyIGZyb20gVW5pY29kZSBDSksgbG9jYWxlcwoK
LS0tCiBuZXdsaWIvbGliYy9sb2NhbGUvbG9jYWxlLmMgfCAxOCArKysrKy0tLS0tLS0tLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL25ld2xpYi9saWJjL2xvY2FsZS9sb2NhbGUuYyBiL25ld2xpYi9saWJj
L2xvY2FsZS9sb2NhbGUuYwppbmRleCAyYzQ1MmJhOTguLjk2ODY0Mjc0NSAxMDA2NDQKLS0t
IGEvbmV3bGliL2xpYmMvbG9jYWxlL2xvY2FsZS5jCisrKyBiL25ld2xpYi9saWJjL2xvY2Fs
ZS9sb2NhbGUuYwpAQCAtNzgsMTIgKzc4LDkgQEAgVGhpcyBpbXBsZW1lbnRhdGlvbiBhbHNv
IHN1cHBvcnRzIHRoZSBtb2RpZmllcnMgPDwiY2prbmFycm93Ij4+IGFuZAogPDwiY2prd2lk
ZSI+Piwgd2hpY2ggYWZmZWN0IGhvdyB0aGUgZnVuY3Rpb25zIDw8d2N3aWR0aD4+IGFuZCA8
PHdjc3dpZHRoPj4KIGhhbmRsZSBjaGFyYWN0ZXJzIGZyb20gdGhlICJDSksgQW1iaWd1b3Vz
IFdpZHRoIiBjYXRlZ29yeSBvZiBjaGFyYWN0ZXJzCiBkZXNjcmliZWQgYXQgaHR0cDovL3d3
dy51bmljb2RlLm9yZy9yZXBvcnRzL3RyMTEvI0FtYmlndW91cy4KLVRoZXNlIGNoYXJhY3Rl
cnMgaGF2ZSBhIHdpZHRoIG9mIDEgZm9yIHNpbmdsZWJ5dGUgY2hhcnNldHMgYW5kIGEgd2lk
dGggb2YgMgotZm9yIG11bHRpYnl0ZSBjaGFyc2V0cyBvdGhlciB0aGFuIFVURi04LgotRm9y
IFVURi04LCB0aGVpciB3aWR0aCBkZXBlbmRzIG9uIHRoZSBsYW5ndWFnZSBzcGVjaWZpZXI6
Ci1pdCBpcyAyIGZvciA8PCJ6aCI+PiAoQ2hpbmVzZSksIDw8ImphIj4+IChKYXBhbmVzZSks
IGFuZCA8PCJrbyI+PiAoS29yZWFuKSwKLWFuZCAxIGZvciBldmVyeXRoaW5nIGVsc2UuIFNw
ZWNpZnlpbmcgPDwiY2prbmFycm93Ij4+IG9yIDw8ImNqa3dpZGUiPj4KLWZvcmNlcyBhIHdp
ZHRoIG9mIDEgb3IgMiwgcmVzcGVjdGl2ZWx5LCBpbmRlcGVuZGVudCBvZiBjaGFyc2V0IGFu
ZCBsYW5ndWFnZS4KK1RoZXNlIGNoYXJhY3RlcnMgaGF2ZSBhIHdpZHRoIG9mIDEgZm9yIHNp
bmdsZWJ5dGUgY2hhcnNldHMgYW5kIFVURi04LAorYW5kIGEgd2lkdGggb2YgMiBmb3IgbXVs
dGlieXRlIGNoYXJzZXRzIG90aGVyIHRoYW4gVVRGLTguIFNwZWNpZnlpbmcKKzw8ImNqa25h
cnJvdyI+PiBvciA8PCJjamt3aWRlIj4+IGZvcmNlcyBhIHdpZHRoIG9mIDEgb3IgMiwgcmVz
cGVjdGl2ZWx5LgogCiBUaGlzIGltcGxlbWVudGF0aW9uIGFsc28gc3VwcG9ydHMgdGhlIG1v
ZGlmaWVyIDw8ImNqa3NpbmdsZSI+PgogdG8gZW5mb3JjZSBzaW5nbGUtd2lkdGggY2hhcmFj
dGVyIHByb3BlcnRpZXMuCkBAIC05MDMsMTcgKzkwMCwxMiBAQCByZXN0YXJ0OgogICAgICAg
LyogRGV0ZXJtaW5lIHRoZSB3aWR0aCBmb3IgdGhlICJDSksgQW1iaWd1b3VzIFdpZHRoIiBj
YXRlZ29yeSBvZgogICAgICAgICAgY2hhcmFjdGVycy4gVGhpcyBpcyB1c2VkIGluIHdjd2lk
dGgoKS4gQXNzdW1lIHNpbmdsZSB3aWR0aCBmb3IKICAgICAgICAgIHNpbmdsZS1ieXRlIGNo
YXJzZXRzLCBhbmQgZG91YmxlIHdpZHRoIGZvciBtdWx0aS1ieXRlIGNoYXJzZXRzCi0gICAg
ICAgICBvdGhlciB0aGFuIFVURi04LiBGb3IgVVRGLTgsIHVzZSBkb3VibGUgd2lkdGggZm9y
IHRoZSBFYXN0IEFzaWFuCi0gICAgICAgICBsYW5ndWFnZXMgKCJqYSIsICJrbyIsICJ6aCIp
LCBhbmQgc2luZ2xlIHdpZHRoIGZvciBldmVyeXRoaW5nIGVsc2UuCisgICAgICAgICBvdGhl
ciB0aGFuIFVURi04LiBGb3IgVVRGLTgsIHVzZSBzaW5nbGUgd2lkdGguCiAgICAgICAgICBT
aW5nbGUgd2lkdGggY2FuIGFsc28gYmUgZm9yY2VkIHdpdGggdGhlICJAY2prbmFycm93IiBt
b2RpZmllci4KICAgICAgICAgIERvdWJsZSB3aWR0aCBjYW4gYWxzbyBiZSBmb3JjZWQgd2l0
aCB0aGUgIkBjamt3aWRlIiBtb2RpZmllci4KICAgICAgICAqLwogICAgICAgbG9jLT5jamtf
bGFuZyA9IGNqa3dpZGUgfHwKLQkJICAgICAgKCFjamtuYXJyb3cgJiYgbWJjX21heCA+IDEK
LQkJICAgICAgICYmIChjaGFyc2V0WzBdICE9ICdVJwotCQkJICAgfHwgc3RybmNtcCAobG9j
YWxlLCAiamEiLCAyKSA9PSAwCi0JCQkgICB8fCBzdHJuY21wIChsb2NhbGUsICJrbyIsIDIp
ID09IDAKLQkJCSAgIHx8IHN0cm5jbXAgKGxvY2FsZSwgInpoIiwgMikgPT0gMCkpOworCQkg
ICAgICAoIWNqa25hcnJvdyAmJiBtYmNfbWF4ID4gMSAmJiBjaGFyc2V0WzBdICE9ICdVJyk7
CiAgICAgICBpZiAoY2prc2luZ2xlKQogCWxvYy0+Y2prX2xhbmcgPSAtMTsJLyogRGlzYWJs
ZSBDSksgZHVhbC13aWR0aCAqLwogI2lmZGVmIF9fSEFWRV9MT0NBTEVfSU5GT19fCi0tIAoy
LjI4LjAKCg==
--------------80E73E6BD596AB06389DC412--
