Return-Path: <cygwin-patches-return-8128-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 96065 invoked by alias); 18 Apr 2015 21:25:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 96048 invoked by uid 89); 18 Apr 2015 21:25:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.2 required=5.0 tests=AWL,BAYES_00,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-lb0-f170.google.com
Received: from mail-lb0-f170.google.com (HELO mail-lb0-f170.google.com) (209.85.217.170) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Sat, 18 Apr 2015 21:25:56 +0000
Received: by lbbqq2 with SMTP id qq2so105699172lbb.3        for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2015 14:25:52 -0700 (PDT)
X-Received: by 10.112.148.101 with SMTP id tr5mr9951864lbb.0.1429392352772;        Sat, 18 Apr 2015 14:25:52 -0700 (PDT)
Received: from [192.168.1.27] (79.160.132.106.static.lyse.net. [79.160.132.106])        by mx.google.com with ESMTPSA id jq15sm3263448lab.27.2015.04.18.14.25.51        for <cygwin-patches@cygwin.com>        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Sat, 18 Apr 2015 14:25:52 -0700 (PDT)
Message-ID: <5532CBBB.5010103@gmail.com>
Date: Sat, 18 Apr 2015 21:25:00 -0000
From: David Macek <david.macek.0@gmail.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix inconsistencies in docs regarding fstab and executable file detection
References: <55326E6D.7010703@gmail.com>
In-Reply-To: <55326E6D.7010703@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms020601060304080105060207"
X-IsSubscribed: yes
X-SW-Source: 2015-q2/txt/msg00029.txt.bz2

This is a cryptographically signed message in MIME format.

--------------ms020601060304080105060207
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-length: 2703

The inline list of mount options seemed redundant, so the paragraph now poi=
nts
to the list below it.

List of executable extensions updated according to fhandler_disk_file.cc. L=
ist
of executable magic numbers updated according to path.h (has_exec_chars).

	* pathnames.xml: Fix inconsistencies in docs regarding fstab and
	executable file detection
---
 winsup/doc/pathnames.xml | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/winsup/doc/pathnames.xml b/winsup/doc/pathnames.xml
index 00eb133..cdbf9fa 100644
--- a/winsup/doc/pathnames.xml
+++ b/winsup/doc/pathnames.xml
@@ -81,9 +81,8 @@ see <xref linkend=3D"cygdrive"></xref></para>
 <para>The fourth field describes the mount options associated
 with the filesystem.  It is formatted as a comma separated list of
 options.  It contains at least the type of mount (binary or text) plus
-any additional options appropriate to the filesystem type.  Recognized
-options are binary, text, nouser, user, exec, notexec, cygexec, nosuid,
-posix=3D[0|1].  The meaning of the options is as follows.</para>
+any additional options appropriate to the filesystem type.  The list of
+the options, including their meaning, follows.</para>
=20
 <screen>
   acl       - Cygwin uses the filesystem's access control lists (ACLs) to
@@ -136,14 +135,14 @@ executability, this is not possible on filesystems wh=
ich don't support
 permissions at all (like FAT/FAT32), or if ACLs are ignored on filesystems
 supporting them (see the aforementioned <literal>acl</literal> mount optio=
n).
 In these cases, the following heuristic is used to evaluate if a file is
-executable: Files ending in certain extensions (.exe, .com, .bat, .btm,
-.cmd) are assumed to be executable.  Files whose first two characters begin
-with '#!' are also considered to be executable.
+executable: Files ending in certain extensions (.exe, .com, .lnk) are
+assumed to be executable.  Files whose first two characters are "#!", "MZ",
+or ":\n" are also considered to be executable.
 The <literal>exec</literal> option is used to instruct Cygwin that the
 mounted file is "executable".  If the <literal>exec</literal> option is us=
ed
 with a directory then all files in the directory are executable.
 This option allows other files to be marked as executable and avoids the
-overhead of opening each file to check for a '#!'.  The
+overhead of opening each file to check for "magic" bytes.  The
 <literal>cygexec</literal> option is very similar to <literal>exec</litera=
l>,
 but also prevents Cygwin from setting up commands and environment variables
 for a normal Windows program, adding another small performance gain.  The
--=20
2.3.5

--=20
David Macek


--------------ms020601060304080105060207
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature
Content-length: 5743

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEH
AQAAoIIMbzCCBjMwggUboAMCAQICAwxvejANBgkqhkiG9w0BAQsFADCBjDEL
MAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsT
IlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMT
L1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50
IENBMB4XDTE0MTIzMTA0MDkwNFoXDTE2MDEwMTE1NDg1M1owSjEgMB4GA1UE
AwwXZGF2aWQubWFjZWsuMEBnbWFpbC5jb20xJjAkBgkqhkiG9w0BCQEWF2Rh
dmlkLm1hY2VrLjBAZ21haWwuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEApuk8134+nkISIg7X7ABwKnVLgZsYi5kdXeeWpUrF1YLdLsZL
pPjcUA3sk1QRpMMRVbWnCvAjwWI86js8V3sv8xDfD9DPf+f22NDQ9nC8gzsG
VJkCr42+vdlwAAuG+hZ81fuRuswdsgMJWvz7uwUwMw2/UDoezIS7Sf9d5BsX
h2VyPj1khIuMrvX2q5oVVQ/MV5QfqFtT7zCBPfuqhAROAO/nhNsxqTxjEppK
8Sh1FuIT71hANWHYTyvAwbN3MMzJeSmDAcAvlyNUfjqrLwCPObqinZFlqyR7
a4NG3HbVo3IwnrLScYZs7xE/6h77sFWXSJV9dq7gSVjOwHec+OgijQIDAQAB
o4IC3TCCAtkwCQYDVR0TBAIwADALBgNVHQ8EBAMCBLAwHQYDVR0lBBYwFAYI
KwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBQEvwqPgbHT3Rg7Y+obpVas
+Y+6+jAfBgNVHSMEGDAWgBRTcu2SnODaywFcfH6WNU7y1LhRgjAiBgNVHREE
GzAZgRdkYXZpZC5tYWNlay4wQGdtYWlsLmNvbTCCAUwGA1UdIASCAUMwggE/
MIIBOwYLKwYBBAGBtTcBAgMwggEqMC4GCCsGAQUFBwIBFiJodHRwOi8vd3d3
LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMIH3BggrBgEFBQcCAjCB6jAnFiBT
dGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgEBGoG+VGhpcyBj
ZXJ0aWZpY2F0ZSB3YXMgaXNzdWVkIGFjY29yZGluZyB0byB0aGUgQ2xhc3Mg
MSBWYWxpZGF0aW9uIHJlcXVpcmVtZW50cyBvZiB0aGUgU3RhcnRDb20gQ0Eg
cG9saWN5LCByZWxpYW5jZSBvbmx5IGZvciB0aGUgaW50ZW5kZWQgcHVycG9z
ZSBpbiBjb21wbGlhbmNlIG9mIHRoZSByZWx5aW5nIHBhcnR5IG9ibGlnYXRp
b25zLjA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLnN0YXJ0c3NsLmNv
bS9jcnR1MS1jcmwuY3JsMIGOBggrBgEFBQcBAQSBgTB/MDkGCCsGAQUFBzAB
hi1odHRwOi8vb2NzcC5zdGFydHNzbC5jb20vc3ViL2NsYXNzMS9jbGllbnQv
Y2EwQgYIKwYBBQUHMAKGNmh0dHA6Ly9haWEuc3RhcnRzc2wuY29tL2NlcnRz
L3N1Yi5jbGFzczEuY2xpZW50LmNhLmNydDAjBgNVHRIEHDAahhhodHRwOi8v
d3d3LnN0YXJ0c3NsLmNvbS8wDQYJKoZIhvcNAQELBQADggEBAC+mXthvKJv0
g9fDxLL4OGsVK/sMtsquNast5RYmngwxRzxag9bihcuvlxbl3Y4ZMhLcdViH
ku0P/7aLxF6zzXWoIDWmfmiMfS0Sakkd72odZetyDtn+qxOyMfK2zNagdh8b
3i8h1hLFUbGX/ELWmF2k8FfewSchVtosEicopuFIeQaEehYnuUbZLqq815gr
wGNMFUBQ9GkrWwrN+7Mx2CkqSv5A4Br+uY/UBNeWGbE9NhrUM0LFiXQkKiAm
LzLNc8475trVyShSVv+JwFPDS2XWtEQea5Yd1NTkp8CLrZnWiicH+911e23Y
6BH4LYf9zUSvvFEqOTcBWyEtw9a293IwggY0MIIEHKADAgECAgEeMA0GCSqG
SIb3DQEBBQUAMH0xCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBM
dGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWdu
aW5nMSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0
eTAeFw0wNzEwMjQyMTAxNTVaFw0xNzEwMjQyMTAxNTVaMIGMMQswCQYDVQQG
EwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJl
IERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRD
b20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0EwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDHCYPMzi3YGrEppC4Tq5a+
ijKDjKaIQZZVR63UbxIP6uq/I0fhCu+cQhoUfE6ERKKnu8zPf1Jwuk0tsvVC
k6U9b+0UjM0dLep3ZdE1gblK/1FwYT5Pipsu2yOMluLqwvsuz9/9f1+1PKHG
/FaR/wpbfuIqu54qzHDYeqiUfsYzoVflR80DAC7hmJ+SmZnNTWyUGHJbBpA8
Q89lGxahNvuryGaC/o2/ceD2uYDX9U8Eg5DpIpGQdcbQeGarV04WgAUjjXX5
r/2dabmtxWMZwhZna//jdiSyrrSMTGKkDiXm6/3/4ebfeZuCYKzN2P8O2F/X
e2AC/Y7zeEsnR7FOp+uXAgMBAAGjggGtMIIBqTAPBgNVHRMBAf8EBTADAQH/
MA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUU3Ltkpzg2ssBXHx+ljVO8tS4
UYIwHwYDVR0jBBgwFoAUTgvvGqRAW6UXaYcwyjRoQ9BBrvIwZgYIKwYBBQUH
AQEEWjBYMCcGCCsGAQUFBzABhhtodHRwOi8vb2NzcC5zdGFydHNzbC5jb20v
Y2EwLQYIKwYBBQUHMAKGIWh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL3Nmc2Nh
LmNydDBbBgNVHR8EVDBSMCegJaAjhiFodHRwOi8vd3d3LnN0YXJ0c3NsLmNv
bS9zZnNjYS5jcmwwJ6AloCOGIWh0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL3Nm
c2NhLmNybDCBgAYDVR0gBHkwdzB1BgsrBgEEAYG1NwECATBmMC4GCCsGAQUF
BwIBFiJodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMDQGCCsG
AQUFBwIBFihodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9pbnRlcm1lZGlhdGUu
cGRmMA0GCSqGSIb3DQEBBQUAA4ICAQAKgwh9eKssBly4Y4xerhy5I3dNoXHY
fYa8PlVLL/qtXnkFgdtY1o95CfegFJTwqBBmf8pyTUnFsukDFUI22zF5bVHz
uJ+GxhnSqN2sD1qetbYwBYK2iyYA5Pg7Er1A+hKMIzEzcduRkIMmCeUTyMyi
kfbUFvIBivtvkR8ZFAk22BZy+pJfAoedO61HTz4qSfQoCRcLN5A0t4DkuVhT
MXIzuQ8CnykhExD6x4e6ebIbrjZLb7L+ocR0y4YjCl/Pd4MXU91y0vTipgr/
O75CDUHDRHCCKBVmz/Rzkc/b970MEeHt5LC3NiWTgBSvrLEuVzBKM586YoRD
9Dy3OHQgWI270g+5MYA8GfgI/EPT5G7xPbCDz+zjdH89PeR3U4So4lSXur6H
6vp+m9TQXPF3a0LwZrp8MQ+Z77U1uL7TelWO5lApsbAonrqASfTpaprFVkL4
nyGH+NHST2ZJPWIBk81i6Vw0ny0qZW2Niy/QvVNKbb43A43ny076khXO7cNb
BIRdJ/6qQNq9Bqb5C0Q5nEsFcj75oxQRqlKf6TcvGbjxkJh8BYtv9ePsXklA
xtm8J7GCUBthHSQgepbkOexhJ0wP8imUkyiPHQ0GvEnd83129fZjoEhdGwXV
27ioRKbj/cIq7JRXun0NbeY+UdMYu9jGfIpDLtUUGSgsg2zMGs5R4jGCA90w
ggPZAgEBMIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20g
THRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2ln
bmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVy
bWVkaWF0ZSBDbGllbnQgQ0ECAwxvejAJBgUrDgMCGgUAoIICHTAYBgkqhkiG
9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNTA0MTgyMTI1
MTVaMCMGCSqGSIb3DQEJBDEWBBQFfJ8gQjLv8FW9ulY0CQEEfBxV2DBsBgkq
hkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIH
MA0GCCqGSIb3DQMCAgEoMIGlBgkrBgEEAYI3EAQxgZcwgZQwgYwxCzAJBgNV
BAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1
cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFy
dENvbSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQQID
DG96MIGnBgsqhkiG9w0BCRACCzGBl6CBlDCBjDELMAkGA1UEBhMCSUwxFjAU
BgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFs
IENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNz
IDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMMb3owDQYJKoZI
hvcNAQEBBQAEggEAFEtocU3nqMQHjTQnWebUDFl2l8jjzD423393pR0lkkW0
A4wmC33lVJ0IGdb61ptmdI4RLQYYZu70tV1tw238puTRq4asLF2u/0Csa7h/
UyiZX0RTUTt4c0qS4SiPniFo3lJl9hF4VHeCshD0WBMi+gOX8ovpoNqylm3r
F3z2pFPgCJZAaun1ewYDuLvF1ka89MTwjSP1IIJwfZc3W3/9L2sFoRgOaxx3
kGUsi0qp+o6qgNI2QmcugapnYcAzw+RXH/WWkoJoxjJ+Og3uOrJ0w8mH4ImC
uK42N9AQ6wmgPOR2wWkdHcDzrzvH0tul64Ytayfn/YGB8Wk1POKOgox5EAAA
AAAAAA==

--------------ms020601060304080105060207--
