Return-Path: <cygwin-patches-return-9030-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 95887 invoked by alias); 22 Feb 2018 07:46:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 95869 invoked by uid 89); 22 Feb 2018 07:46:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=no version=3.3.2 spammy=H*UA:6.3, H*u:6.3, claims, HTo:U*cygwin-patches
X-HELO: mail-wm0-f65.google.com
Received: from mail-wm0-f65.google.com (HELO mail-wm0-f65.google.com) (74.125.82.65) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 22 Feb 2018 07:46:54 +0000
Received: by mail-wm0-f65.google.com with SMTP id z81so2010385wmb.4        for <cygwin-patches@cygwin.com>; Wed, 21 Feb 2018 23:46:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:subject:to:references:from:message-id:date         :user-agent:mime-version:in-reply-to;        bh=6Chwxo9zSqugDbDfQkUyi5dVYSZHLgYY1Aczc46V/oE=;        b=cFHl5q2J0lIDNbh2TaFZvO5ztd+ie+K6T3Lksq8UpjGflCxl/jL8ImXyF/A/rd2djb         RKZgl8I/IhG7/eZ+YtLe1s/KINf8E491I9iRUdChSKvyuSeZnPvp+nIBoTD/yrQeRuZ+         dB6o+6pW6H7XkixaFWhN0f9E6tZoqwD4M2tYrF6AdAdm85BCDdR6YzPDQmxvGJZqGVzu         h4AOvXOb7QCiMdnmlAgotFpOrEw67Oz8H51SH6bdhdKWscuKtMTw3ZQ/n7BkG0gwPENr         crQZRHEPkWtkfbAtJOd+LZ3VDuc034eMb36YNyTKOwvO1wa6J5KhDz7TZymPZD5QtyXv         Zzvw==
X-Gm-Message-State: APf1xPBqMf/GKeXIgiAgDSYcOIp3/P7REHRFz/ankJtUtDINtNaQS8W6	CX7NnKxtlEGRW5gSr50I6kUrhXFU
X-Google-Smtp-Source: AH8x226WEIsXKpRyhtSqNw6UYIYTB4ybl6WOKZonOHl1hQY/3y27ei+bDiImTRX0yDPJ7UCiL5/Sow==
X-Received: by 10.28.223.212 with SMTP id w203mr4420738wmg.96.1519285611650;        Wed, 21 Feb 2018 23:46:51 -0800 (PST)
Received: from [192.168.1.202] ([164.215.120.147])        by smtp.gmail.com with ESMTPSA id k45sm12568106wrf.62.2018.02.21.23.46.49        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Wed, 21 Feb 2018 23:46:50 -0800 (PST)
Subject: Re: [PATCH] doc/ntsec.xml: Fix typo
To: cygwin-patches@cygwin.com
References: <f1047ae4-4edf-6343-2929-c193e6cee77c@gmail.com> <20180221210534.GA7576@calimero.vinschen.de> <9501f8b9-f84a-ea43-93da-c0eeb8ca9d35@SystematicSw.ab.ca> <20180221213714.GB7576@calimero.vinschen.de> <dbe0ccb9-4752-cd76-e90b-8d88b5899302@SystematicSw.ab.ca>
From: David Macek <david.macek.0@gmail.com>
Message-ID: <1403214d-ca26-02ad-5d59-eea94b7039bb@gmail.com>
Date: Thu, 22 Feb 2018 07:46:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <dbe0ccb9-4752-cd76-e90b-8d88b5899302@SystematicSw.ab.ca>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000401010102060503060707"
X-IsSubscribed: yes
X-SW-Source: 2018-q1/txt/msg00038.txt.bz2

This is a cryptographically signed message in MIME format.

--------------ms000401010102060503060707
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: cs
Content-Transfer-Encoding: quoted-printable
Content-length: 490

On 2018-02-21 14:05, Corinna Vinschen wrote:
> The patch is malformed.  It claims to contain 7 lines (6 lines context,
> one line changed), but actually it has only 4 lines context.  Please
> check your git settings.

On 21. 2. 2018 22:56, Brian Inglis wrote:
> I can see why you strenuously request git format-patch/send-email attachm=
ents ;^>

I did use `git format-patch` to make that message (then sent using TB).
I guess I'll have to try something else next time.

--=20
David Macek


--------------ms000401010102060503060707
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
SIb3DQEJBTEPFw0xODAyMjIwNzQ2NTJaMC8GCSqGSIb3DQEJBDEiBCAvLWvb
hWg21ZFPnvSFiyHC/4qVJO6ONRnlw2scwGAD0TBsBgkqhkiG9w0BCQ8xXzBd
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
AASCAQCDkyJBBKHj2CsiXDtgTW7AFPjUTHAbXJi8BMUAxVQRs1egdLGDDk/V
puMirph2Clgh1nIbJDbtU7+Rc4O9ToXDu5OeNFm0Q28VZ/GmbQOdOYVx6Y2b
mour8omQiDoQZjDcYlDb70oMOTf75FnwJdUBOlt2ebyU0yBsjZxVwO8eXAdS
8TGZtCZmCer3YV5fjO6utH2t6Mv2RKZggdSzPdpxUySAUlwOeN6IKeZSqd5H
AI6Rk23P6tAQioLdRJXm8sOdbcBolrkegz1zUuai63ojSL4i/cvEf8pBNfvk
g5H2B+9+7jhyD4OO+MIIpZlipUqsEhtpVudyZKTng0qhlLTUAAAAAAAA

--------------ms000401010102060503060707--
