Return-Path: <cygwin-patches-return-8771-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 117391 invoked by alias); 8 Jun 2017 12:48:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 108802 invoked by uid 89); 8 Jun 2017 12:48:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.6 required=5.0 tests=BAYES_00,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=Antivirus, H*UA:6.3, H*u:6.3, crashes
X-HELO: mail-wm0-f52.google.com
Received: from mail-wm0-f52.google.com (HELO mail-wm0-f52.google.com) (74.125.82.52) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 08 Jun 2017 12:48:53 +0000
Received: by mail-wm0-f52.google.com with SMTP id 7so137216668wmo.1        for <cygwin-patches@cygwin.com>; Thu, 08 Jun 2017 05:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:from:subject:to:message-id:date:user-agent         :mime-version;        bh=bYQBdL4KZVurqmFane4u1chD8xUATpD8radjUzxtXrc=;        b=ZtN+pXKHh7/w7Cdv2hAELz49I3on5ue/zwg1L7o5CIFhIYEftqP+kSPpZ+kkYWta8r         e+J8y3V6bWbJdGIKuaYYd7s9detbqckgHKiAqrEN401nhfNrFsyp60hH/gpXqXBV9vaS         lOdS3qw5fQrHnrmfakiQqrIIe1LPGyzp6h5uYN7F87+UhGMGQNQj3LjdimjS9EnWhUUS         4dT1rmCchAYqb9aOfz0W2qglRDEoItIXtebSwcVHvKAJKPUsO/ECfD3adD/yv+EpFGBx         ONBi3Ol6VouGUXENNI34dUKo9hnGwsVEemPOjwBetVUDQ9yToIn30yB4r/fcjCTapigx         dUcg==
X-Gm-Message-State: AODbwcCDXZS4Y8SPAQHwCQlWqxAN8Y2UpT52wsn90T2K97d+FE45+y20	ZQioR2fZ9yK+0Gojc7s=
X-Received: by 10.28.88.3 with SMTP id m3mr3515891wmb.28.1496926135570;        Thu, 08 Jun 2017 05:48:55 -0700 (PDT)
Received: from [192.168.1.202] ([164.215.120.147])        by smtp.gmail.com with ESMTPSA id k19sm7787140wmg.9.2017.06.08.05.48.54        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Thu, 08 Jun 2017 05:48:54 -0700 (PDT)
From: David Macek <david.macek.0@gmail.com>
Subject: [PATCH] Add COMODO Internet Security and ConEmu to BLODA
To: cygwin-patches@cygwin.com
Message-ID: <d8218978-47ae-411f-9134-fce3dfae21e1@gmail.com>
Date: Thu, 08 Jun 2017 12:48:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.1.0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050101000500030704050608"
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00042.txt.bz2

This is a cryptographically signed message in MIME format.

--------------ms050101000500030704050608
Content-Type: text/plain; charset=utf-8
Content-Language: cs
Content-Transfer-Encoding: quoted-printable
Content-length: 2143

ConEmu: There has been at least one report of it causing crashes <https://g=
ithub.com/Maximus5/ConEmu/issues/1158>

COMODO Internet Security: Causing GPG failures <https://github.com/msys2/ms=
ys2/issues/38>

---
 winsup/doc/faq-using.xml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/doc/faq-using.xml b/winsup/doc/faq-using.xml
index c62e03996..b6b152e4e 100644
--- a/winsup/doc/faq-using.xml
+++ b/winsup/doc/faq-using.xml
@@ -1273,6 +1273,8 @@ behaviour which affect the operation of other program=
s, such as Cygwin.
 <listitem><para>Bufferzone from Trustware</para></listitem>
 <listitem><para>ByteMobile laptop optimization client</para></listitem>
 <listitem><para>COMODO Firewall Pro</para></listitem>
+<listitem><para>COMODO Internet Security</para></listitem>
+<listitem><para>ConEmu (try disabling "Inject ConEmuHk" or see <ulink url=
=3D"https://conemu.github.io/en/ConEmuHk.html#Third_party_problems">ConEmuH=
k documentation</ulink>)</para></listitem>
 <listitem><para>Citrix Metaframe Presentation Server/XenApp (see <ulink ur=
l=3D"http://support.citrix.com/article/CTX107825">Citrix Support page</ulin=
k>)</para></listitem>
 <listitem><para>Credant Guardian Shield</para></listitem>
 <listitem><para>Earthlink Total-Access</para></listitem>
@@ -1298,7 +1300,7 @@ behaviour which affect the operation of other program=
s, such as Cygwin.
 <listitem><para>Webroot Spy Sweeper with Antivirus</para></listitem>
 <listitem><para>Windows Defender </para></listitem>
 <listitem><para>Windows LiveOneCare</para></listitem>
-<listitem><para>IBM Security Trusteer Rapport (see <ulink url=3D"http://ww=
w-03.ibm.com/software/products/en/trusteer-rapport">its home page</ulink></=
para></listitem>
+<listitem><para>IBM Security Trusteer Rapport (see <ulink url=3D"http://ww=
w-03.ibm.com/software/products/en/trusteer-rapport">its home page</ulink>)<=
/para></listitem>
 </itemizedlist></para>
 <para>Sometimes these problems can be worked around, by temporarily or par=
tially
 disabling the offending software.  For instance, it may be possible to dis=
able
--=20
2.13.0.windows.1

--=20
David Macek


--------------ms050101000500030704050608
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature
Content-length: 5039

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG
9w0BBwEAAKCCCf0wggSvMIIDl6ADAgECAhEA4CPLFRKDU4mtYW56VGdrITAN
BgkqhkiG9w0BAQsFADBvMQswCQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1
c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4dGVybmFsIFRUUCBOZXR3b3Jr
MSIwIAYDVQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290MB4XDTE0MTIy
MjAwMDAwMFoXDTIwMDUzMDEwNDgzOFowgZsxCzAJBgNVBAYTAkdCMRswGQYD
VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hB
LTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBD
QTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAImxDdp6UxlOcFId
vFamBia3uEngludRq/HwWhNJFaO0jBtgvHpRQqd5jKQi3xdhTpHVdiMKFNNK
An+2HQmAbqUEPdm6uxb+oYepLkNSQxZ8rzJQyKZPWukI2M+TJZx7iOgwZOak
+FaA/SokFDMXmaxE5WmLo0YGS8Iz1OlAnwawsayTQLm1CJM6nCpToxDbPSBh
PFUDjtlOdiUCISn6o3xxdk/u4V+B6ftUgNvDezVSt4TeIj0sMC0xf1m9Ujew
M2ktQ+v61qXxl3dnUYzZ7ifrvKUHOHaMpKk4/9+M9QOsSb7K93OZOg8yq5yV
OhM9DkY6V3RhUL7GQD/L5OKfoiECAwEAAaOCARcwggETMB8GA1UdIwQYMBaA
FK29mHo0tCb3+sQmVO8DveAky1QaMB0GA1UdDgQWBBSSYWuC4aKgqk/sZ/HC
o/e0gADB7DAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAd
BgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEQYDVR0gBAowCDAGBgRV
HSAAMEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwudXNlcnRydXN0LmNv
bS9BZGRUcnVzdEV4dGVybmFsQ0FSb290LmNybDA1BggrBgEFBQcBAQQpMCcw
JQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZI
hvcNAQELBQADggEBABsqbqxVwTqriMXY7c1V86prYSvACRAjmQ/FZmpvsfW0
tXdeDwJhAN99Bf4Ss6SAgAD8+x1banICCkG8BbrBWNUmwurVTYT7/oKYz1gb
4yJjnFL4uwU2q31Ypd6rO2Pl2tVz7+zg+3vio//wQiOcyraNTT7kSxgDsqgt
1Ni7QkuQaYUQ26Y3NOh74AEQpZzKOsefT4g0bopl0BqKu6ncyso20fT8wmQp
Na/WsadxEdIDQ7GPPprsnjJT9HaSyoY0B7ksyuYcStiZDcGG4pCS+1pCaiMh
EOllx/XVu37qjIUgAmLq0ToHLFnFmTPyOInltukWeh95FPZKEBom+nyK+5sw
ggVGMIIELqADAgECAhEA7jWZUfKRbbsCzktYkBp16TANBgkqhkiG9w0BAQsF
ADCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0
ZWQxQTA/BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNh
dGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE2MTIwNzAwMDAwMFoXDTE3
MTIwNzIzNTk1OVowKDEmMCQGCSqGSIb3DQEJARYXZGF2aWQubWFjZWsuMEBn
bWFpbC5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDSdGB3
LNdiiNwX0VyJ5ApLoZ75Wem214/8L0jaWpOifs6nmdTavFLyfaknieRHlVWl
+6apV7PXQ+cGAeS1CnDWl0gqJrLShiRgk7FICLyDdknrB9La7vU7F3Z0f5Uu
lIrpNzFu500dvWnRHU5FFqelBClhgmFTdi4hJzAAEk6EL5PjEBr51mazG51q
hJIClKMFMHmxTbYih2j9jt7eUnit8QdfTnGUK8mXyo20Pw4Zt3TfkYjXPKPu
v94xOQUCo/WjwR0vNWh645S13y7UgKVF1RFpx1SlaCc/sT75qX7rFgiGDLJq
jY9uGeEsrBLsGnipol+C1hUpoqTSTEyrSubPAgMBAAGjggH1MIIB8TAfBgNV
HSMEGDAWgBSSYWuC4aKgqk/sZ/HCo/e0gADB7DAdBgNVHQ4EFgQUnD1y33Pa
oNEZqv89tlOefJP+NSEwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAw
IAYDVR0lBBkwFwYIKwYBBQUHAwQGCysGAQQBsjEBAwUCMBEGCWCGSAGG+EIB
AQQEAwIFIDBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEBATArMCkGCCsGAQUF
BwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBdBgNVHR8EVjBU
MFKgUKBOhkxodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9TSEEyNTZD
bGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGQBggr
BgEFBQcBAQSBgzCBgDBYBggrBgEFBQcwAoZMaHR0cDovL2NydC5jb21vZG9j
YS5jb20vQ09NT0RPU0hBMjU2Q2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1
cmVFbWFpbENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2Rv
Y2EuY29tMCIGA1UdEQQbMBmBF2RhdmlkLm1hY2VrLjBAZ21haWwuY29tMA0G
CSqGSIb3DQEBCwUAA4IBAQARpKHCoudMqqobSMyfhAhTbCjZD0dUtIC83DEF
HUkLoKKOm7+YM8psKWdbvEdfZzZCHLvC5iuGxl9h6glYbmzuNHGunAIlqPM+
s0D15Ow/xg5ka4d1oc8Rj0K/DiZ33buB2G1ooimd8lic4GihIcs77+EPyed4
OwEhPVc/KeF04EXWyKm+n6z4uACyCloa3weA2uBFrPAG92iUzRoVlI3CrCcd
gm6XmiyHkE1OPlp8Qt/YEx5z/6IJH+XLAOH4UN3Rq/ImfIrjSxD4KhKxMeLo
z7q4whYjLOhFH6khwFXeAbFH++AOPHE6qQdHfBuzFyBBvgBzGLZbIZFo19qp
HEonMYIERDCCBEACAQEwgbEwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoT
EUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBD
bGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAO41
mVHykW27As5LWJAadekwDQYJYIZIAWUDBAIBBQCgggJjMBgGCSqGSIb3DQEJ
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE3MDYwODEyNDg1M1ow
LwYJKoZIhvcNAQkEMSIEIM8NiTarr22jaX0F1pJbLtdcmK8nG/0RtfamaETI
u3PHMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAw
BwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgcIGCSsGAQQBgjcQBDGBtDCBsTCB
mzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQ
MA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQx
QTA/BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlv
biBhbmQgU2VjdXJlIEVtYWlsIENBAhEA7jWZUfKRbbsCzktYkBp16TCBxAYL
KoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoT
EUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBD
bGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAO41
mVHykW27As5LWJAadekwDQYJKoZIhvcNAQEBBQAEggEArHAXCG4rUVa+lxCL
tal0Ylun2WIKBkLxbT8kL5WW3EujL/dJm/PJdnm/0IxFkuHo5+gS+oQ1FIRr
hTYIEC2aIUCmeQeDiYY195TMFgoyvVGNW8aEIYy2it22gFzQR+wub6mswSZa
v0XDTmgo9JyAkU4dhuMuM6aI4OeGIF7tjHCVDegVY0TlXNMOX5Urgr/X+j6r
nXlQ3HCfIO16JToxfCEiO+sJRGgy0SZMBoJ3xwXz+nBzYH9Ear1hRQBKI5nl
gP2ybYytmIweFqNl+zJuKFAiye7xX0KCv6ZDinnoa8bbqmchWcnoxbANhvC2
zkXGw2o06sUXU6Mv42QRB/+UGAAAAAAAAA==

--------------ms050101000500030704050608--
