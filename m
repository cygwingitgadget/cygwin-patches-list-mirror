Return-Path: <cygwin-patches-return-8275-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9634 invoked by alias); 24 Nov 2015 22:59:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 9601 invoked by uid 89); 24 Nov 2015 22:59:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.2 required=5.0 tests=AWL,BAYES_00,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-wm0-f41.google.com
Received: from mail-wm0-f41.google.com (HELO mail-wm0-f41.google.com) (74.125.82.41) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Tue, 24 Nov 2015 22:59:06 +0000
Received: by wmuu63 with SMTP id u63so116355152wmu.0        for <cygwin-patches@cygwin.com>; Tue, 24 Nov 2015 14:59:03 -0800 (PST)
X-Received: by 10.28.130.7 with SMTP id e7mr844264wmd.68.1448405943812;        Tue, 24 Nov 2015 14:59:03 -0800 (PST)
Received: from [192.168.168.1] ([193.165.236.27])        by smtp.gmail.com with ESMTPSA id vu4sm20329211wjc.2.2015.11.24.14.59.02        for <cygwin-patches@cygwin.com>        (version=TLSv1/SSLv3 cipher=OTHER);        Tue, 24 Nov 2015 14:59:02 -0800 (PST)
From: David Macek <david.macek.0@gmail.com>
Subject: [PATCH] Add a section describing peculiarities of how Cygwin creates NTFS symlinks
References: <20151118200719.GW6402@calimero.vinschen.de>
To: cygwin-patches@cygwin.com
X-Enigmail-Draft-Status: N1110
Message-ID: <5654EBB5.7070100@gmail.com>
Date: Tue, 24 Nov 2015 22:59:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20151118200719.GW6402@calimero.vinschen.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms010903070206090305060606"
X-IsSubscribed: yes
X-SW-Source: 2015-q4/txt/msg00028.txt.bz2

This is a cryptographically signed message in MIME format.

--------------ms010903070206090305060606
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-length: 1116

First take on how to describe dereferencing of Cygwin-only symlinks path co=
mponents when creating NTFS symlinks.

Note that I haven't tried building the documentation, so I don't know if th=
e added paragraph breaks anything. Hopefully not.

	* pathnames.xml: Add a section describing peculiarities
	of how Cygwin creates NTFS symlinks

---
 winsup/doc/pathnames.xml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/doc/pathnames.xml b/winsup/doc/pathnames.xml
index cdbf9fa..9077303 100644
--- a/winsup/doc/pathnames.xml
+++ b/winsup/doc/pathnames.xml
@@ -407,6 +407,9 @@ these two settings, see <xref linkend=3D"using-cygwinen=
v"></xref>.
 On AFS, native symlinks are the only supported type of symlink due to
 AFS lacking support for DOS attributes.  This is independent from the
 <literal>winsymlinks</literal> setting.</para>
+<para>Creation of native symlinks follows special rules to ensure the links
+are usable outside of Cygwin. This includes dereferencing any Cygwin-only
+symlinks that lie in the target path.</para>
 </listitem>
=20
 <listitem>
--=20
2.6.2.windows.1

--=20
David Macek


--------------ms010903070206090305060606
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature
Content-length: 5767

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG
9w0BBwEAAKCCDG8wggYzMIIFG6ADAgECAgMMb3owDQYJKoZIhvcNAQELBQAw
gYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYD
VQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYD
VQQDEy9TdGFydENvbSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENs
aWVudCBDQTAeFw0xNDEyMzEwNDA5MDRaFw0xNjAxMDExNTQ4NTNaMEoxIDAe
BgNVBAMMF2RhdmlkLm1hY2VrLjBAZ21haWwuY29tMSYwJAYJKoZIhvcNAQkB
FhdkYXZpZC5tYWNlay4wQGdtYWlsLmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAKbpPNd+Pp5CEiIO1+wAcCp1S4GbGIuZHV3nlqVKxdWC
3S7GS6T43FAN7JNUEaTDEVW1pwrwI8FiPOo7PFd7L/MQ3w/Qz3/n9tjQ0PZw
vIM7BlSZAq+Nvr3ZcAALhvoWfNX7kbrMHbIDCVr8+7sFMDMNv1A6HsyEu0n/
XeQbF4dlcj49ZISLjK719quaFVUPzFeUH6hbU+8wgT37qoQETgDv54TbMak8
YxKaSvEodRbiE+9YQDVh2E8rwMGzdzDMyXkpgwHAL5cjVH46qy8Ajzm6op2R
Zaske2uDRtx21aNyMJ6y0nGGbO8RP+oe+7BVl0iVfXau4ElYzsB3nPjoIo0C
AwEAAaOCAt0wggLZMAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0GA1UdJQQW
MBQGCCsGAQUFBwMCBggrBgEFBQcDBDAdBgNVHQ4EFgQUBL8Kj4Gx090YO2Pq
G6VWrPmPuvowHwYDVR0jBBgwFoAUU3Ltkpzg2ssBXHx+ljVO8tS4UYIwIgYD
VR0RBBswGYEXZGF2aWQubWFjZWsuMEBnbWFpbC5jb20wggFMBgNVHSAEggFD
MIIBPzCCATsGCysGAQQBgbU3AQIDMIIBKjAuBggrBgEFBQcCARYiaHR0cDov
L3d3dy5zdGFydHNzbC5jb20vcG9saWN5LnBkZjCB9wYIKwYBBQUHAgIwgeow
JxYgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwAwIBARqBvlRo
aXMgY2VydGlmaWNhdGUgd2FzIGlzc3VlZCBhY2NvcmRpbmcgdG8gdGhlIENs
YXNzIDEgVmFsaWRhdGlvbiByZXF1aXJlbWVudHMgb2YgdGhlIFN0YXJ0Q29t
IENBIHBvbGljeSwgcmVsaWFuY2Ugb25seSBmb3IgdGhlIGludGVuZGVkIHB1
cnBvc2UgaW4gY29tcGxpYW5jZSBvZiB0aGUgcmVseWluZyBwYXJ0eSBvYmxp
Z2F0aW9ucy4wNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5zdGFydHNz
bC5jb20vY3J0dTEtY3JsLmNybDCBjgYIKwYBBQUHAQEEgYEwfzA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3Auc3RhcnRzc2wuY29tL3N1Yi9jbGFzczEvY2xp
ZW50L2NhMEIGCCsGAQUFBzAChjZodHRwOi8vYWlhLnN0YXJ0c3NsLmNvbS9j
ZXJ0cy9zdWIuY2xhc3MxLmNsaWVudC5jYS5jcnQwIwYDVR0SBBwwGoYYaHR0
cDovL3d3dy5zdGFydHNzbC5jb20vMA0GCSqGSIb3DQEBCwUAA4IBAQAvpl7Y
byib9IPXw8Sy+DhrFSv7DLbKrjWrLeUWJp4MMUc8WoPW4oXLr5cW5d2OGTIS
3HVYh5LtD/+2i8Res811qCA1pn5ojH0tEmpJHe9qHWXrcg7Z/qsTsjHytszW
oHYfG94vIdYSxVGxl/xC1phdpPBX3sEnIVbaLBInKKbhSHkGhHoWJ7lG2S6q
vNeYK8BjTBVAUPRpK1sKzfuzMdgpKkr+QOAa/rmP1ATXlhmxPTYa1DNCxYl0
JCogJi8yzXPOO+ba1ckoUlb/icBTw0tl1rREHmuWHdTU5KfAi62Z1oonB/vd
dXtt2OgR+C2H/c1Er7xRKjk3AVshLcPWtvdyMIIGNDCCBBygAwIBAgIBHzAN
BgkqhkiG9w0BAQsFADB9MQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRD
b20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUg
U2lnbmluZzEpMCcGA1UEAxMgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMDcxMDI0MjEwMTU1WhcNMTcxMDI0MjEwMTU1WjCBjDELMAkG
A1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNl
Y3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0
YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxwmDzM4t2BqxKaQu
E6uWvooyg4ymiEGWVUet1G8SD+rqvyNH4QrvnEIaFHxOhESip7vMz39ScLpN
LbL1QpOlPW/tFIzNHS3qd2XRNYG5Sv9RcGE+T4qbLtsjjJbi6sL7Ls/f/X9f
tTyhxvxWkf8KW37iKrueKsxw2HqolH7GM6FX5UfNAwAu4ZifkpmZzU1slBhy
WwaQPEPPZRsWoTb7q8hmgv6Nv3Hg9rmA1/VPBIOQ6SKRkHXG0Hhmq1dOFoAF
I411+a/9nWm5rcVjGcIWZ2v/43Yksq60jExipA4l5uv9/+Hm33mbgmCszdj/
Dthf13tgAv2O83hLJ0exTqfrlwIDAQABo4IBrTCCAakwDwYDVR0TAQH/BAUw
AwEB/zAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYEFFNy7ZKc4NrLAVx8fpY1
TvLUuFGCMB8GA1UdIwQYMBaAFE4L7xqkQFulF2mHMMo0aEPQQa7yMGYGCCsG
AQUFBwEBBFowWDAnBggrBgEFBQcwAYYbaHR0cDovL29jc3Auc3RhcnRzc2wu
Y29tL2NhMC0GCCsGAQUFBzAChiFodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9z
ZnNjYS5jcnQwWwYDVR0fBFQwUjAnoCWgI4YhaHR0cDovL3d3dy5zdGFydHNz
bC5jb20vc2ZzY2EuY3JsMCegJaAjhiFodHRwOi8vY3JsLnN0YXJ0c3NsLmNv
bS9zZnNjYS5jcmwwgYAGA1UdIAR5MHcwdQYLKwYBBAGBtTcBAgEwZjAuBggr
BgEFBQcCARYiaHR0cDovL3d3dy5zdGFydHNzbC5jb20vcG9saWN5LnBkZjA0
BggrBgEFBQcCARYoaHR0cDovL3d3dy5zdGFydHNzbC5jb20vaW50ZXJtZWRp
YXRlLnBkZjANBgkqhkiG9w0BAQsFAAOCAgEAjoHKsyWLGrmmIFvWbclENF8g
1dAgjk5PxNap5nPzOx72+3t9Rkdo9UsV5ZiWPwH0EDa4eEZ/Jm0+3J/Sdi2c
U8qDvGJJdf9qkTXpsV9h20eRreq6kyCBmnX45ma0B1E79NGKPkLZtXaj6Qh/
7nct9Zq/a3DqkgLF8k70euOXsdtijf6Xe6X1hUHlJUobxYuYwKSmbu2LVngs
5gXRjkAbd3wCphLf/lpRZA39lA3gEyu5dIkYVgVgEPG7uNMFsFb2Xabi7+zz
R76OQn0/1cNd46xyUKx0C1jgXYL+Q4fvqPp/CIAEovHjngGRMy26S2z88u3O
sjLfuhXRROLKSZwUJdKZzWBCT7HPbm8az8PfpV7wv7YD4nuJ1Rg/zcDXBLgk
uBvhDskXOX+Wos74gMz4AYf1y6Oh+Ds+OXYd3IOrcU6ft4DPZk837MbN6zn8
TysrVCdOyT20iyLtBEg90AFOeELwiY5o2NWQH0kZQnYEBfBUsHkOr1IR2caL
JZ1Ltr19v5N/LwPbC44D2Z61XSFSWs8wcKYm1lFsVkCM6VCsqEwzmETfVBqX
YcXo6R9WG0TSe+qCPp0u3fzvXLFJiHXdzQ4EXqRk9H1KCKPcZmEDAQ2wRIjT
rlaDQFFKgK1YHpHEBPPAjIgaAP8aby4+n5y/061KsNHA2MamE34xDzWhWHkx
ggPtMIID6QIBATCBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0
Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRl
IFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJ
bnRlcm1lZGlhdGUgQ2xpZW50IENBAgMMb3owDQYJYIZIAWUDBAIBBQCgggIp
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE1
MTEyNDIyNTkwMVowLwYJKoZIhvcNAQkEMSIEIB2u/duXfZalTWWHNzhSladR
SkuBGgQ8yOTtva8uD37KMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYI
KoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgaUGCSsGAQQB
gjcQBDGBlzCBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29t
IEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNp
Z25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRl
cm1lZGlhdGUgQ2xpZW50IENBAgMMb3owgacGCyqGSIb3DQEJEAILMYGXoIGU
MIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkG
A1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYG
A1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBD
bGllbnQgQ0ECAwxvejANBgkqhkiG9w0BAQEFAASCAQBxCeLD1qkOatENqMwf
ej1n2pfGKZ6qiT4PmplqF7ne4MB+89vBBQTtU2RvGmipcpbqLZ+oYCQQCxjn
CnM3GRtTWHhFzG8IFEKphjjXpeN4t/uBZSfnNJf9D08nnED6E2H+Eg9JVeWg
YQvg2tyUh+vz6R22V+Ar8pc2uzgj/D4GWeR5D+s60W+Q8PJP9yezAInFjFV2
vwik8rBxxLqaOTDum3Giv9IKorgSVmB5WdpNyhHe7OLp4p6DX8QKTV2G9ZCT
0YD9J+NK1C5e9S/IPt7GjezSZqGGXS5XPjsclgntDesppqWRXnEelqyWreOv
URC1TDghD5IcL0fvFMh10LkeAAAAAAAA

--------------ms010903070206090305060606--
