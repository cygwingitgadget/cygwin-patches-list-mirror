Return-Path: <cygwin-patches-return-9036-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63121 invoked by alias); 23 Feb 2018 13:24:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 59663 invoked by uid 89); 23 Feb 2018 13:24:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=no version=3.3.2 spammy=H*UA:6.3, H*u:6.3, HTo:U*cygwin-patches
X-HELO: mail-wr0-f172.google.com
Received: from mail-wr0-f172.google.com (HELO mail-wr0-f172.google.com) (209.85.128.172) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 23 Feb 2018 13:24:32 +0000
Received: by mail-wr0-f172.google.com with SMTP id u49so14075518wrc.10        for <cygwin-patches@cygwin.com>; Fri, 23 Feb 2018 05:24:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:subject:to:references:from:message-id:date         :user-agent:mime-version:in-reply-to;        bh=+AXxu8IilZMugrBVwlo3M0uIC7SJKZ81hP30r64MdLE=;        b=CAI4GITBRu5PMCkObMmMyjGczs7uRzTaEejYf3PKY3B7VuEAGRcFC7NmwgJLDv34uC         pv4gN3Jmg6DC01xqj5WeeADYGAdc54EglSuga7J/0CO2SFtdZ19W8xo1avUtF5R2wE/3         teUni3JrMvEV4tip3F4Uui8VK02AjLW6CUVTUdowJpJvJa/jE3eOz5wILFscPfp4XKnV         5Gp0EBLoOfgY+4rBR02ST4Yq2geNNgGVJdfrOsGHRCCin/T4kg2oJ/DQZ5NamkKqzAzG         1+E/jeCRsHjcwQMq2T3OobECqs66BImArkaV43lGRfkhQBH6jWSLnhn5F6rw6WwOdoA0         X2Rg==
X-Gm-Message-State: APf1xPB4lT7gep/MI85XjPlPJgOHzjapCdFnyIAUXFqFIkkFkgtWGD/W	3RYyV7aHxM7HVcWnMLo/sTdIPckO
X-Google-Smtp-Source: AH8x225G524Y2pU2u5m9jCrbgnOcrmDpmNbfiIprm6nHIegIdAVgJnDIbpGbttXlOo7vRtXdahYlsw==
X-Received: by 10.223.160.42 with SMTP id k39mr1818439wrk.138.1519392269655;        Fri, 23 Feb 2018 05:24:29 -0800 (PST)
Received: from [192.168.1.202] ([164.215.120.147])        by smtp.gmail.com with ESMTPSA id p21sm1508675wmc.45.2018.02.23.05.24.27        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Fri, 23 Feb 2018 05:24:28 -0800 (PST)
Subject: Re: [PATCH] doc/faq-using.xml: Add BeyondTrust and Cylance to BLODA
To: cygwin-patches@cygwin.com
References: <20180223132244.19372-1-david.macek.0@gmail.com>
From: David Macek <david.macek.0@gmail.com>
Message-ID: <7b5f25db-61d4-f847-2031-ee3fd19c600a@gmail.com>
Date: Fri, 23 Feb 2018 13:24:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180223132244.19372-1-david.macek.0@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms080906090907020900070605"
X-IsSubscribed: yes
X-SW-Source: 2018-q1/txt/msg00044.txt.bz2

This is a cryptographically signed message in MIME format.

--------------ms080906090907020900070605
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: cs
Content-Transfer-Encoding: quoted-printable
Content-length: 197

On 23. 2. 2018 14:22, david.macek.0@gmail.com wrote:
> From: David Macek <david.macek.0@gmail.com>

My first attempt at git-send-email, please excuse and remove the extra line.

--=20
David Macek


--------------ms080906090907020900070605
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
SIb3DQEJBTEPFw0xODAyMjMxMzI0MjlaMC8GCSqGSIb3DQEJBDEiBCBK8iS5
yuFVlCLZcV4XtJ/O2h9jhCBzBpsQyaVa3NeupDBsBgkqhkiG9w0BCQ8xXzBd
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
AASCAQBBcpam5D75FSOLl1loX18GQ8VcVKLf62uVn1TDdYdHsLzQZMz4uZAW
IvhSM37n+JiXxe/aO/jzhHWwK+TqMIvW/hPQk+6DDe1WJPjk3ubMDMxjXobD
2cmwygRqLnyesPwE6L2z87b/wy9RP8YwFMa5Iyu2WEAQuxn04Rz9JUIKVzUC
gulvYeWk2/xr1SeBhm5m5AKwyoy/t81X/ecTa1K9wR3H+t3jP8cxUgvjondB
oz2sWbGF213QPPk1B5T+XZ7MiEMLl1L2I7kAy+662rNX8pTGu27DeVimNrOQ
Ix+r6Bso0wyYad7XI03rGUzDeU725gd3RpYqc2A3VXO9/ZafAAAAAAAA

--------------ms080906090907020900070605--
