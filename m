Return-Path: <cygwin-patches-return-9032-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 125923 invoked by alias); 22 Feb 2018 12:37:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 125905 invoked by uid 89); 22 Feb 2018 12:37:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=no version=3.3.2 spammy=Been, pine, Pine, astounding
X-HELO: mail-wr0-f196.google.com
Received: from mail-wr0-f196.google.com (HELO mail-wr0-f196.google.com) (209.85.128.196) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 22 Feb 2018 12:37:00 +0000
Received: by mail-wr0-f196.google.com with SMTP id k9so10394437wre.9        for <cygwin-patches@cygwin.com>; Thu, 22 Feb 2018 04:37:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:subject:to:references:from:message-id:date         :user-agent:mime-version:in-reply-to;        bh=R4XZ72y35sLBPmlMozGklBK312VG3zTSUTEQClasQno=;        b=LKr1KpDuOxrIIGQuucEoKCYZbOK9aDFbYRHIZN/q3PYPHWQJTt/NHnR0N9BeNHFlqF         xrtriWuOQMC+2/sE2SVt8WUXSkWw441e/ME7ldi+XS+xqMitYawUfBMYZ1fgSFk7FpvI         1I0ZDKbvtft9DGWhquDwwFBN63sUgF7b95RaOKz+0Cv+Aa/NMY8e8ma433BTsiKxTf7a         ik1C5Gy6DXqP6sF0i10XnLMiAXpFEbnaKQzCfXPso4udUDODEIfVhmzGdGxED+QKp/Ds         dcY11YXfpGgT0I1hIry2+XGAudU4F9D4xsJuNc952H37tK/DNhiRKhJi7rP4v8h4xFlW         IWdg==
X-Gm-Message-State: APf1xPDbV6L7fPAWJoY8XJfzkla5hqlDqBIQnhxUehridxgw5s2T9eEp	vP/HRN5kgsc2p3JycaLXYwQqxjET
X-Google-Smtp-Source: AH8x225s9WQOi8O/pceydGwrleW7tIrRaUcfXK+KYnXm9vQgLPJw3kihlCX/5hGSx4WpXaVSbAJQBA==
X-Received: by 10.223.133.235 with SMTP id 40mr6051703wru.275.1519303018005;        Thu, 22 Feb 2018 04:36:58 -0800 (PST)
Received: from [192.168.1.202] ([164.215.120.147])        by smtp.gmail.com with ESMTPSA id b185sm370079wmb.24.2018.02.22.04.36.55        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Thu, 22 Feb 2018 04:36:55 -0800 (PST)
Subject: Re: [PATCH] doc/ntsec.xml: Fix typo
To: cygwin-patches@cygwin.com
References: <f1047ae4-4edf-6343-2929-c193e6cee77c@gmail.com> <20180221210534.GA7576@calimero.vinschen.de> <9501f8b9-f84a-ea43-93da-c0eeb8ca9d35@SystematicSw.ab.ca> <20180221213714.GB7576@calimero.vinschen.de> <dbe0ccb9-4752-cd76-e90b-8d88b5899302@Systemat <1403214d-ca26-02ad-5d59-eea94b7039bb@gmail.com> <Pine.BSF.4.63.1802220257200.76751@m0.truegem.net>
From: David Macek <david.macek.0@gmail.com>
Message-ID: <b84a4d06-ab31-8f65-5497-3ef9990802ce@gmail.com>
Date: Thu, 22 Feb 2018 12:37:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <Pine.BSF.4.63.1802220257200.76751@m0.truegem.net>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050000020100060703010704"
X-IsSubscribed: yes
X-SW-Source: 2018-q1/txt/msg00040.txt.bz2

This is a cryptographically signed message in MIME format.

--------------ms050000020100060703010704
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: cs
Content-Transfer-Encoding: quoted-printable
Content-length: 527

On 22. 2. 2018 12:04, Mark Geisert wrote:
> Been there, done that, even the "I'll have to try something else".=C2=A0 =
It's astounding how SeaMonkey, Pine, and probably gmane bork up the formatt=
ing of something that looks so benignly laid out to begin with.
>=20
> After much experience putting up with these and other MUAs from us, Corin=
na really does know *the* solution that just works.=C2=A0 'git format-patch=
' followed by ''.

Then I'll have to finally try `git send-email`.  Any important tips?

--=20
David Macek


--------------ms050000020100060703010704
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature
Content-length: 5425

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG
9w0BBwEAAKCCCygwggU6MIIEIqADAgECAhEA8NKGv1nOupZwd6rRteWxuDAN
BgkqhkiG9w0BAQsFADCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0
ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09N
T0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1
dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTcxMjA2MDAw
MDAwWhcNMTgxMjA2MjM1OTU5WjAoMSYwJAYJKoZIhvcNAQkBFhdkYXZpZC5t
YWNlay4wQGdtYWlsLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAMiufowzzzBSQMkii/5iXRFzr0/8MpPEtcd5IrIEHZWiGIxD4aSDbVrk
jsQysxOdFZR73+aLrlaW/5Oj7f5Vwh5LJR4xSofc+9o16b4j83Mb/2NHIxPa
ohO7XnzBjBozB/civayMy/tt1hrGyq48lRy9bSqWgVEh8jqyHvwSXAoFpTc+
8+/7qh+aNvZf5XphVNlwQlDyj3N+MQ+diKmqQBWjLa3RMH81h/XqENd46MPe
woUpicwsVTJzt6ThQ0DYRZqEWh5b034/Yf15VD2QgdFI6p9fCUzdGpjt7JiS
rpZ0VWVGA9wUyFFpxotf6ppVpFx9PxDubJjVI2QFgwN4NMUCAwEAAaOCAe0w
ggHpMB8GA1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQW
BBTmg3nUOANBeMhpKuXCLNd+smcSlDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0T
AQH/BAIwADAgBgNVHSUEGTAXBggrBgEFBQcDBAYLKwYBBAGyMQEDBQIwEQYJ
YIZIAYb4QgEBBAQDAgUgMEYGA1UdIAQ/MD0wOwYMKwYBBAGyMQECAQEBMCsw
KQYIKwYBBQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQvQ1BTMFoG
A1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9E
T1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmww
gYsGCCsGAQUFBwEBBH8wfTBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5jb21v
ZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1
cmVFbWFpbENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2Rv
Y2EuY29tMCIGA1UdEQQbMBmBF2RhdmlkLm1hY2VrLjBAZ21haWwuY29tMA0G
CSqGSIb3DQEBCwUAA4IBAQCaPAMg6yNRgKtjYsyNmleSq3d8Q41qxL7kB0Or
Kabu6OhPwptd5rDx6eVjyUDOsUEGPsNqa6wtgnjHzlay3FIt1wtjWv1APnpM
OrdmkRJbLQxDxh3STCMTZ5UfDnv1cGNaH2Rl6nEumv2UGaYmAriYVaLX4Bkr
69wXOrEpPVDRJhHQ+mB5TYQy5GyFQ2XIR9Ox2Xl9qETyB/mx5uokvDgshcnD
HD93dSJ1TtpJzslpNa5VAvujOmuCCqKunGjDqsnt46PTsnMxqsoPg2GJdEiZ
sMbuolwwxX3lhhU/bHP34mcclLQVe1HC7tIWs18eyy3SFju48VChd4S9ZiUf
o2euMIIF5jCCA86gAwIBAgIQapvhODv/K2ufAdXZuKdSVjANBgkqhkiG9w0B
AQwFADCBhTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExp
bWl0ZWQxKzApBgNVBAMTIkNPTU9ETyBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTMwMTEwMDAwMDAwWhcNMjgwMTA5MjM1OTU5WjCBlzELMAkG
A1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
BxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNV
BAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1
cmUgRW1haWwgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC+
s55XrCh2dUAWxzgDmNPGGHYhUPMleQtMtaDRfTpYPpynMS6n9jR22YRq2tA9
NEjk6vW7rN/5sYFLIP1of3l0NKZ6fLWfF2VgJ5cijKYy/qlAckY1wgOkUMgz
KlWlVJGyK+UlNEQ1/5ErCsHq9x9aU/x1KwTdF/LCrT03Rl/FwFrf1XTCwa2Q
ZYL55AqLPikFlgqOtzk06kb2qvGlnHJvijjI03BOrNpo+kZGpcHsgyO1/u1O
ZTaOo8wvEU17VVeP1cHWse9tGKTDyUGg2hJZjrqck39UIm/nKbpDSZ0JsMoI
w/JtOOg0JC56VzQgBo7ictReTQE5LFLG3yQK+xS1AgMBAAGjggE8MIIBODAf
BgNVHSMEGDAWgBS7r34CPfqm8TyEjq3uOJjs2TIy1DAdBgNVHQ4EFgQUgq9s
jPjF/pZhfOgfPStxSF7Ei8AwDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQI
MAYBAf8CAQAwEQYDVR0gBAowCDAGBgRVHSAAMEwGA1UdHwRFMEMwQaA/oD2G
O2h0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNlcnRpZmljYXRp
b25BdXRob3JpdHkuY3JsMHEGCCsGAQUFBwEBBGUwYzA7BggrBgEFBQcwAoYv
aHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQWRkVHJ1c3RDQS5j
cnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTANBgkq
hkiG9w0BAQwFAAOCAgEAeFyygSg0TzzuX1bOn5dW7I+iaxf28/ZJCAbU2C81
zd9A/tNx4+jsQgwRGiHjZrAYayZrrm78hOx7aEpkfNPQIHGG6Fvq3EzWf/Lv
x7/hk6zSPwIal9v5IkDcZoFD7f3iT7PdkHJY9B51csvU50rxpEg1OyOT8fk2
zvvPBuM4qQNqbGWlnhMpIMwpWZT89RY0wpJO+2V6eXEGGHsROs3njeP9Dqqq
AJaBa4wBeKOdGCWn1/Jp2oY6dyNmNppI4ZNMUH4Tam85S1j6E95u4+1Nuru8
4OrMIzqvISE2HN/56ebTOWlcrurffade2022O/tUU1gb4jfWCcyvB8czm12F
gX/y/lRjmDbEA08QJNB2729Y+io1IYO3ztveBdvUCIYZojTq/OCR6MvnzS6X
72HP0PRLRTiOSEmIDsS5N5w/8IW1Hva5hEFy6fDAfd9yI+O+IMMAj1KcL/Zo
9jzJ16HO5m60ttl1Enk8MQkz/W3JlHaeI5iKFn4UJu1/cP2YHXYPiWf2JyBz
sLBrGk1II+3yL8aorYew6CQvdVifC3HtwlSam9V1niiCfOBe2C12TdKGu05L
WIA3ZkFcWJGaNXOZ6Ggyh/TqvXG5v7zmEVDNXFnHn9tFpMpOUvxhcsjycBtH
0dZ0WrNw6gH+HF8TIhCnH3+zzWuDN0Rk6h9KVkfKehIxggQ4MIIENAIBATCB
rTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0
ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9u
IGFuZCBTZWN1cmUgRW1haWwgQ0ECEQDw0oa/Wc66lnB3qtG15bG4MA0GCWCG
SAFlAwQCAQUAoIICWzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0xODAyMjIxMjM2NTdaMC8GCSqGSIb3DQEJBDEiBCDd/Cdj
Nlt/EJ8BFlhJZtZfgMFluujnEzNNng4RTpRjtDBsBgkqhkiG9w0BCQ8xXzBd
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZI
hvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMC
AgEoMIG+BgkrBgEEAYI3EAQxgbAwga0wgZcxCzAJBgNVBAYTAkdCMRswGQYD
VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNB
IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
8NKGv1nOupZwd6rRteWxuDCBwAYLKoZIhvcNAQkQAgsxgbCgga0wgZcxCzAJ
BgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNV
BAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYD
VQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2Vj
dXJlIEVtYWlsIENBAhEA8NKGv1nOupZwd6rRteWxuDANBgkqhkiG9w0BAQEF
AASCAQB8t/h9bzkuoYMXDKMRcNc0Ug1qdmZfYA7bi3tmYb2ZAcAChnWrQsxU
sG+WduLb/N1ejkTmvPP0/XCjyWFfceFDscRe2goeHStkXf2ekz4B/vtQ5EHl
wV7D705bq/wTDsr9g22sHopBEKr1U51ONyqZsDRR1oHYyBWwfZ/PiKNBLcGA
dbybtMxwaeP2jEWftR9sfJSYd/+kgDdJXhiQ1Ifk4wSr3sf6iqGLUUcZeErc
tglxEkV5llda73fgaYKQK0/M1dTU5rkWQMEve8yJIQXBtcUZQ1s0IPeFzm8b
x94ZzCBj47ixOHF4fgP3DidToKlQs82Gd3haKAuEM5FxCeF8AAAAAAAA

--------------ms050000020100060703010704--
