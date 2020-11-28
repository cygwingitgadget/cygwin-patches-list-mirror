Return-Path: <Christian.Franke@t-online.de>
Received: from mailout07.t-online.de (mailout07.t-online.de [194.25.134.83])
 by sourceware.org (Postfix) with ESMTPS id 374D43858004
 for <cygwin-patches@cygwin.com>; Sat, 28 Nov 2020 22:00:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 374D43858004
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=Christian.Franke@t-online.de
Received: from fwd30.aul.t-online.de (fwd30.aul.t-online.de [172.20.26.135])
 by mailout07.t-online.de (Postfix) with SMTP id AFEFE4258DF9
 for <cygwin-patches@cygwin.com>; Sat, 28 Nov 2020 23:00:05 +0100 (CET)
Received: from [192.168.2.101]
 (r9E0JmZfQhHg2aVsIJyO-IGrK8sfmxtWyRe58ZZVwlMLD+jsbXaafaqiDcFAIsxQFh@[79.230.165.86])
 by fwd30.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kj8G3-0MzmaG0; Sat, 28 Nov 2020 22:59:55 +0100
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: Fix access to block devices below /proc/sys.
To: cygwin-patches@cygwin.com
Message-ID: <9c5f23af-ac11-3856-7aab-88dd1c184429@t-online.de>
Date: Sat, 28 Nov 2020 22:59:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 SeaMonkey/2.53.4
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------F8AC271640F31858328A7141"
X-ID: r9E0JmZfQhHg2aVsIJyO-IGrK8sfmxtWyRe58ZZVwlMLD+jsbXaafaqiDcFAIsxQFh
X-TOI-EXPURGATEID: 150726::1606600795-00014A27-082AD56B/0/0 CLEAN NORMAL
X-TOI-MSGID: 58001171-b015-4e28-98ea-1f43c67fc804
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00, FREEMAIL_FROM,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Sat, 28 Nov 2020 22:00:12 -0000

This is a multi-part message in MIME format.
--------------F8AC271640F31858328A7141
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

There a very few but occasionally interesting use cases for read access 
to block devices below /proc/sys:

- Read raw images behind drive letters which are not linked to regular 
/dev/sdXN partitions. For example read decrypted images of VeraCrypt 
partitions or container files:
/proc/sys/DosDevices/X: -> /proc/sys/Device/VeraCryptVolumeX

- Read raw images of Volume Shadow Copies:
/proc/sys/Device/HarddiskVolumeShadowCopy*

Copying such an image actually works with 'dd', but 'ddrescue' reports a 
non seekable device. This is because fhandler_virtual::lseek() is used. 
It calls fhandler_procsys::fill_filebuf() which does not make any sense 
in this context. This lseek() always fails - without setting errno, BTW.

The attached experimental patch does not fix the lseek() (sorry), but 
handles such block devices with fhandler_dev_floppy instead. Tested with 
above use cases.

I'm not sure whether this could break access to other /proc/sys block 
devices. This would happen if fh->exists() returns virt_blk for devices 
which do not support IOCTL_DISK_GET_DRIVE_GEOMETRY* or 
IOCTL_DISK_GET_PARTITION_INFO*.

Regards,
Christian


--------------F8AC271640F31858328A7141
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-Fix-access-to-block-devices-below-proc-sys.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-Fix-access-to-block-devices-below-proc-sys.patch"

RnJvbSBlZDhmNDE5NTI0ZmM4MWEzNzgyODA1NzllYzNjMjNhZjUyN2Q0NzcyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxmcmFua2VAY29tcHV0
ZXIub3JnPgpEYXRlOiBTYXQsIDI4IE5vdiAyMDIwIDIyOjA5OjIzICswMTAwClN1YmplY3Q6
IFtQQVRDSF0gQ3lnd2luOiBGaXggYWNjZXNzIHRvIGJsb2NrIGRldmljZXMgYmVsb3cgL3By
b2Mvc3lzLgoKVXNlIGZoYW5kbGVyX2Rldl9mbG9wcHkgaW5zdGVhZCBvZiBmaGFuZGxlcl9w
cm9jc3lzIGZvciBzdWNoIGRldmljZXMuClRoZSByZWFkKCkvd3JpdGUoKSBmdW5jdGlvbnMg
ZnJvbSBmaGFuZGxlcl9wcm9jc3lzIGRvIG5vdCBlbnN1cmUKc2VjdG9yIGFsaWduZWQgdHJh
bnNmZXJzIGFuZCBsc2VlaygpIGZhaWxzIGFsd2F5cy4KClNpZ25lZC1vZmYtYnk6IENocmlz
dGlhbiBGcmFua2UgPGZyYW5rZUBjb21wdXRlci5vcmc+Ci0tLQogd2luc3VwL2N5Z3dpbi9w
YXRoLmNjIHwgMjkgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCAxOSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93
aW5zdXAvY3lnd2luL3BhdGguY2MgYi93aW5zdXAvY3lnd2luL3BhdGguY2MKaW5kZXggNGY1
ZjAzYTc2Li43ZTYyNDNkMzIgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vcGF0aC5jYwor
KysgYi93aW5zdXAvY3lnd2luL3BhdGguY2MKQEAgLTg2MywxOSArODYzLDI4IEBAIHBhdGhf
Y29udjo6Y2hlY2sgKGNvbnN0IGNoYXIgKnNyYywgdW5zaWduZWQgb3B0LAogCQkJZGV2LnBh
cnNlIChGSF9GUyk7CiAJCQlnb3RvIGlzX2ZzX3ZpYV9wcm9jc3lzOwogCQkgICAgICBjYXNl
IHZpcnRfYmxrOgotCQkJLyogQmxvY2sgc3BlY2lhbCBkZXZpY2UuICBJZiB0aGUgdHJhaWxp
bmcgc2xhc2ggaGFzIGJlZW4KLQkJCSAgIHJlcXVlc3RlZCwgdGhlIHRhcmdldCBpcyB0aGUg
cm9vdCBkaXJlY3Rvcnkgb2YgdGhlCi0JCQkgICBmaWxlc3lzdGVtIG9uIHRoaXMgYmxvY2sg
ZGV2aWNlLiAgU28gd2UgY29udmVydCB0aGlzCi0JCQkgICB0byBhIHJlYWwgZmlsZSBhbmQg
YXR0YWNoIHRoZSBiYWNrc2xhc2guICovCi0JCQlpZiAoY29tcG9uZW50ID09IDAgJiYgbmVl
ZF9kaXJlY3RvcnkpCisJCQkvKiBCbG9jayBzcGVjaWFsIGRldmljZS4gIENvbnZlcnQgdG8g
YSAvZGV2L3NkKiBsaWtlCisJCQkgICBibG9jayBkZXZpY2UgdW5sZXNzIHRoZSB0cmFpbGlu
ZyBzbGFzaCBoYXMgYmVlbgorCQkJICAgcmVxdWVzdGVkLiAgSW4gdGhpcyBjYXNlLCB0aGUg
dGFyZ2V0IGlzIHRoZSByb290CisJCQkgICBkaXJlY3Rvcnkgb2YgdGhlIGZpbGVzeXN0ZW0g
b24gdGhpcyBibG9jayBkZXZpY2UuCisJCQkgICBTbyB3ZSBjb252ZXJ0IHRoaXMgdG8gYSBy
ZWFsIGZpbGUgYW5kIGF0dGFjaCB0aGUKKwkJCSAgIGJhY2tzbGFzaC4gKi8KKwkJCWlmIChj
b21wb25lbnQgPT0gMCkKIAkJCSAgewotCQkJICAgIGRldi5wYXJzZSAoRkhfRlMpOwotCQkJ
ICAgIHN0cmNhdCAoZnVsbF9wYXRoLCAiXFwiKTsKLQkJCSAgICBmaWxlYXR0ciA9IEZJTEVf
QVRUUklCVVRFX0RJUkVDVE9SWQotCQkJCSAgICAgICB8IEZJTEVfQVRUUklCVVRFX0RFVklD
RTsKKwkJCSAgICBmaWxlYXR0ciA9IEZJTEVfQVRUUklCVVRFX0RFVklDRTsKKwkJCSAgICBp
ZiAoIW5lZWRfZGlyZWN0b3J5KQorCQkJICAgICAgLyogVXNlIGEgL2Rldi9zZCogZGV2aWNl
IG51bWJlciA+IC9kZXYvc2RkeC4KKwkJCQkgRklYTUU6IERlZmluZSBhIG5ldyBtYWpvciBE
RVZfaWNlIG51bWJlci4gKi8KKwkJCSAgICAgIGRldi5wYXJzZSAoREVWX1NEX0hJR0hQQVJU
X0VORCwgOTk5OSk7CisJCQkgICAgZWxzZQorCQkJICAgICAgeworCQkJCWRldi5wYXJzZSAo
RkhfRlMpOworCQkJCXN0cmNhdCAoZnVsbF9wYXRoLCAiXFwiKTsKKwkJCQlmaWxlYXR0ciB8
PSBGSUxFX0FUVFJJQlVURV9ESVJFQ1RPUlk7CisJCQkgICAgICB9CiAJCQkgICAgZ290byBv
dXQ7CiAJCQkgIH0KLQkJCWZhbGx0aHJvdWdoOworCQkJYnJlYWs7CiAJCSAgICAgIGNhc2Ug
dmlydF9jaHI6CiAJCQlpZiAoY29tcG9uZW50ID09IDApCiAJCQkgIGZpbGVhdHRyID0gRklM
RV9BVFRSSUJVVEVfREVWSUNFOwotLSAKMi4yOS4yCgo=
--------------F8AC271640F31858328A7141--
