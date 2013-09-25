Return-Path: <cygwin-patches-return-7901-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26344 invoked by alias); 25 Sep 2013 10:42:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26319 invoked by uid 89); 25 Sep 2013 10:41:59 -0000
Received: from dagedig.emsys.de (HELO dagedig.emsys.de) (195.145.211.174) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 25 Sep 2013 10:41:59 +0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.5 required=5.0 tests=AWL,BAYES_50,RDNS_NONE autolearn=no version=3.3.2
X-HELO: dagedig.emsys.de
Received: from emsys.de (unknown [192.168.60.202])	by dagedig.emsys.de (Postfix) with ESMTP id DBBE9B800BC	for <cygwin-patches@cygwin.com>; Wed, 25 Sep 2013 12:41:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by emsys.de (Postfix) with ESMTP id B1E59AC8115;	Wed, 25 Sep 2013 12:41:53 +0200 (CEST)
Received: from [127.0.0.1] (medicus2.lan.emsys.de [192.168.60.76])	by emsys.de (Postfix) with ESMTP id 727A6AC80B0;	Wed, 25 Sep 2013 12:41:53 +0200 (CEST)
Message-ID: <5242BDCD.6090003@emsys.de>
Date: Wed, 25 Sep 2013 10:42:00 -0000
From: Paul Kunysch <paul.kunysch@emsys.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Fix sem_getvalue
References: <52389689.1030801@emsys.de>
In-Reply-To: <52389689.1030801@emsys.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms030009040701070105090705"
X-SW-Source: 2013-q3/txt/msg00008.txt.bz2

Dies ist eine kryptografisch unterzeichnete Nachricht im MIME-Format.

--------------ms030009040701070105090705
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-length: 653

> That looks like a reasonable fix.  Did you trace through all of the
> callers of semaphore::_getvalue to make sure that some of them aren't
> relying on the old behavior?

I did not look for other callers.

I just wrote a very simple test for sem_getvalue() and copied different=20
cygwin1.dll versions to my test-application.
--=20

Kunysch, Paul
Software Development

emsys Embedded Systems GmbH
Werner von Siemens Str. 20
98693 Ilmenau
Germany

Tel.: +49 3677 68977-16   Fax: +49 3677 68977-19
E-Mail: paul.kunysch@emsys.de
Internet: www.emsys.de

CEO: Dr.-Ing. Karsten Pahnke
office: Ilmenau
Register of commerce in county court Jena: HRB 304988


--------------ms030009040701070105090705
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Kryptografische Unterschrift
Content-length: 5389

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEH
AQAAoIILKzCCBRowggQCoAMCAQICEG0Z6qcZT2ozIuYiMnqqcd4wDQYJKoZI
hvcNAQEFBQAwga4xCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJVVDEXMBUGA1UE
BxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0
d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMTYwNAYD
VQQDEy1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQg
RW1haWwwHhcNMTEwNDI4MDAwMDAwWhcNMjAwNTMwMTA0ODM4WjCBkzELMAkG
A1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
BxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxOTA3BgNV
BAMTMENPTU9ETyBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJKEhFtL
V5jUXi+LpOFAyKNTWF9mZfEyTvefMn1V0HhMVbdClOD5J3EHxcZppLkyxPFA
GpDMJ1Zifxe1cWmu5SAb5MtjXmDKokH2auGj/7jfH0htZUOMKi4rYzh337EX
rMLaggLW1DJq1GdvIBOPXDX65VSAr9hxCh03CgJQU2yVHakQFLSZlVkSMf8J
otJM3FLb3uJAAVtIaN3FSrTg7SQfOq9xXwfjrL8UO7AlcWg99A/WF1hGFYE8
aIuLgw9teiFX5jSw2zJ+40rhpVJyZCaRTqWSD//gsWD9Gm9oUZljjRqLpcxC
m5t9ImPTqaD8zp6Q30QZ9FxbNboW86eb/8ECAwEAAaOCAUswggFHMB8GA1Ud
IwQYMBaAFImCZ33EnSZwAEu0UEh83j2uBG59MB0GA1UdDgQWBBR6E04AdFvG
eGNkJ8Ev4qBbvHnFezAOBgNVHQ8BAf8EBAMCAQYwEgYDVR0TAQH/BAgwBgEB
/wIBADARBgNVHSAECjAIMAYGBFUdIAAwWAYDVR0fBFEwTzBNoEugSYZHaHR0
cDovL2NybC51c2VydHJ1c3QuY29tL1VUTi1VU0VSRmlyc3QtQ2xpZW50QXV0
aGVudGljYXRpb25hbmRFbWFpbC5jcmwwdAYIKwYBBQUHAQEEaDBmMD0GCCsG
AQUFBzAChjFodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVROQWRkVHJ1c3RD
bGllbnRfQ0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1
c3QuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQCF1r54V1VtM39EUv5C1QaoAQOA
ivsNsv1Kv/avQUn1G1rF0q0bc24+6SZ85kyYwTAo38v7QjyhJT4KddbQPTmG
ZtGhm7VNm2+vKGwdr+XqdFqo2rHA8XV6L566k3nK/uKRHlZ0sviN0+BDchvt
j/1gOSBH+4uvOmVIPJg9pSW/ve9g4EnlFsjrP0OD8ODuDcHTzTNfm9C9YGqz
O/761Mk6PB/tm/+bSTO+Qik5g+4zaS6CnUVNqGnagBsePdIaXXxHmaWbCG0S
mYbWXVcHG6cwvktJRLiQfsrReTjrtDP6oDpdJlieYVUYtCHVmdXgQ0BCML7q
peeU0rD+83X5f27nMIIGCTCCBPGgAwIBAgIRAKvJY9UqLmHmng6mkgCEzHsw
DQYJKoZIhvcNAQEFBQAwgZMxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVh
dGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNP
TU9ETyBDQSBMaW1pdGVkMTkwNwYDVQQDEzBDT01PRE8gQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTMwNzAxMDAwMDAw
WhcNMTUwNzAxMjM1OTU5WjCCARcxCzAJBgNVBAYTAkRFMQ4wDAYDVQQREwU5
ODY5MzETMBEGA1UECBMKVGh1ZXJpbmdlbjEQMA4GA1UEBxMHSWxtZW5hdTEc
MBoGA1UECRMTRWhyZW5iZXJnc3RyYXNzZSAxMTETMBEGA1UEChMKRU1TWVMg
R21iSDEOMAwGA1UECxMFYWRtaW4xMDAuBgNVBAsTJ0lzc3VlZCB0aHJvdWdo
IEVNU1lTIEdtYkggRS1QS0kgTWFuYWdlcjEfMB0GA1UECxMWQ29ycG9yYXRl
IFNlY3VyZSBFbWFpbDEVMBMGA1UEAxMMUGF1bCBLdW55c2NoMSQwIgYJKoZI
hvcNAQkBFhVwYXVsLmt1bnlzY2hAZW1zeXMuZGUwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQC/32LSMJz6D9EalQ2l0JgrfkPk90SmtCLET4fN
wbxCwTJtvELcuABmr3PUMiOh7RKzwnT69pY1dcCzM9azO+IR742hWroGOQIM
zMEzIEwDuY4FN5+5lHKaITnXrMfiVXAW9VAbqvWY622k/T8jsXloFdiS3DZc
20uVXlrC9Vo2UM/XjPsLT2id5r0pa7fgtdCTTY1w1GuwELXhvfvO0vLhERK2
GYAbbEMBSJGjVtaPHj4kF9kS1oC91jp0AOh7lH+fTe+jeBU1jkXPsBiavfDq
umntfWuM8FbqEN6r+ff4wFycE0JU4H5YCPte5xiojX0jBRfRdU1MIDz3fvBw
R3DrAgMBAAGjggHPMIIByzAfBgNVHSMEGDAWgBR6E04AdFvGeGNkJ8Ev4qBb
vHnFezAdBgNVHQ4EFgQUx7WRowZ8RE1T8ec9NrV3HG1TGnYwDgYDVR0PAQH/
BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsG
AQUFBwMCMEYGA1UdIAQ/MD0wOwYMKwYBBAGyMQECAQMFMCswKQYIKwYBBQUH
AgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQvQ1BTMFcGA1UdHwRQME4w
TKBKoEiGRmh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET0NsaWVudEF1
dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYgGCCsGAQUFBwEB
BHwwejBSBggrBgEFBQcwAoZGaHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09N
T0RPQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAk
BggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMCAGA1UdEQQZ
MBeBFXBhdWwua3VueXNjaEBlbXN5cy5kZTANBgkqhkiG9w0BAQUFAAOCAQEA
CG6ouSgVfexl/4s8iIdDDHclqykdetSt+TlBNBKGJjEN2bHOiBLmWqXlRx5Q
AsFEfEAxX2v1CtOgcLg+OoVk6YOaSVeD6eYbaUPWWwAp+i/C5hhs3C3/tdm4
8OAYx5cTZgDkgp8nFSdL0rZXYi2af8GiyRs5+0fgRUixE0kiAszpFTLZQUwW
07iZlbb5EGTVPTypN7gbmn6yRz3VP1iJX4s9M9sjbM6v7Sj5zs3f0EypnZVN
42r9/fTGaVEU/qN7DbffLoR6WhA01trEqQB76mv9z70J87A2mVPcF68nIAiB
G/XxgFJnKOXIIv/XbIRB2gMVqLHZvT+NcPYJ0GzHgjGCBBwwggQYAgEBMIGp
MIGTMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRl
ZDE5MDcGA1UEAxMwQ09NT0RPIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQg
U2VjdXJlIEVtYWlsIENBAhEAq8lj1SouYeaeDqaSAITMezAJBgUrDgMCGgUA
oIICRzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0xMzA5MjUxMDQxMTdaMCMGCSqGSIb3DQEJBDEWBBTr/P6rvGWXMew11yju
g0+ENzAxAjBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMC
AgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIG6BgkrBgEEAYI3EAQxgaww
gakwgZMxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0
ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1p
dGVkMTkwNwYDVQQDEzBDT01PRE8gQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFu
ZCBTZWN1cmUgRW1haWwgQ0ECEQCryWPVKi5h5p4OppIAhMx7MIG8BgsqhkiG
9w0BCRACCzGBrKCBqTCBkzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0
ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09N
T0RPIENBIExpbWl0ZWQxOTA3BgNVBAMTMENPTU9ETyBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAKvJY9UqLmHmng6mkgCE
zHswDQYJKoZIhvcNAQEBBQAEggEAlF/RGTs4tbDwbtJr2bipb7LZlYxDVdD8
WpFhxjnmJhkQykWMS0/ZnA5nGMAJ+fiV/iXQkKWiHEqQgohrUGrBN7p83Li8
7WJ/LDuo3+yQ5RCVFjHiNm1Sg9rq1YtsPkYjb7SLm8ZKJhNI1QzD5EjvURSM
czU7Q4dO9ioL5KvT8l4squCeV7ixtdBlSHdJYVnXy+G2Xc5y18yj4Yivx1/r
lsMIU8ACBeR2vp9R5vRIT+S3s1Y+aN/IWQsjt3z9ykxQpN/tsx5FA+gb9XTO
/5Ym+dPtsRw+JAsd5nPgGt+b/nL/mFoaJK+Co+QsyNfwSp47au1Gt5euiQJR
oXy42u8pLwAAAAAAAA==

--------------ms030009040701070105090705--
