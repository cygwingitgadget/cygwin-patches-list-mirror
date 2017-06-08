Return-Path: <cygwin-patches-return-8772-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32407 invoked by alias); 8 Jun 2017 12:56:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 31621 invoked by uid 89); 8 Jun 2017 12:56:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=no version=3.3.2 spammy=H*c:application, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail-wr0-f182.google.com
Received: from mail-wr0-f182.google.com (HELO mail-wr0-f182.google.com) (209.85.128.182) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 08 Jun 2017 12:56:26 +0000
Received: by mail-wr0-f182.google.com with SMTP id q97so18223592wrb.2        for <cygwin-patches@cygwin.com>; Thu, 08 Jun 2017 05:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:subject:from:to:references:message-id:date         :user-agent:mime-version:in-reply-to;        bh=iPqbkMAuWFqavAZHQr7R67S/N8fUVI7/g8WXlyBueZo=;        b=l6GSui8zS60kd+upF4f/GKnTpSiuvZZ1pPbjGtXWAUozGwjYm9tgVX52PLvLdGOqTe         QfmIRkhXfEkMbh/LArRiNM6lgRQ4yQjNzv5ytI8Cr+N0A2JloE+3O+6bfyeDITtJP5Ed         NT07zcct8QMBnLdQSW+biOUgB0YlKDbQ/TDDLBEnIIjYYI63egXwaTrDTJOir33onQ9G         m4BlJOvKX6vKia1dIL1Gl2UBWZWL6X65BcTiYI1IFkCXCTJM+UfnH/GsAsYEeH9nk74n         LohhxVaQkWeh6G+Tg8BzyFhzBKpd/pBoOz5GRubBO3TLHT3RoU65YqI6w7kYw3EpWb6S         PkZA==
X-Gm-Message-State: AODbwcCBp7tIsWntGxpX22ie84sbGomHO75yPa8b5uacgMdzyBmwilrt	CsDVdtH0OGH5l46RDQI=
X-Received: by 10.223.152.18 with SMTP id v18mr28385380wrb.8.1496926588503;        Thu, 08 Jun 2017 05:56:28 -0700 (PDT)
Received: from [192.168.1.202] ([164.215.120.147])        by smtp.gmail.com with ESMTPSA id t195sm5669824wmt.27.2017.06.08.05.56.27        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Thu, 08 Jun 2017 05:56:27 -0700 (PDT)
Subject: Re: [PATCH] Add COMODO Internet Security and ConEmu to BLODA
From: David Macek <david.macek.0@gmail.com>
To: cygwin-patches@cygwin.com
References: <d8218978-47ae-411f-9134-fce3dfae21e1@gmail.com>
Message-ID: <dd142baf-0442-45b6-700c-6d97e33364d9@gmail.com>
Date: Thu, 08 Jun 2017 12:56:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <d8218978-47ae-411f-9134-fce3dfae21e1@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms040309040105030706090009"
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00043.txt.bz2

This is a cryptographically signed message in MIME format.

--------------ms040309040105030706090009
Content-Type: text/plain; charset=utf-8
Content-Language: cs
Content-Transfer-Encoding: quoted-printable
Content-length: 242

On 8. 6. 2017 14:48, David Macek wrote:
> COMODO Internet Security: Causing GPG failures <https://github.com/msys2/=
msys2/issues/38>

I wonder if it makes sense to include GPG failures as a known symptom of do=
dgy apps.

--=20
David Macek


--------------ms040309040105030706090009
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
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE3MDYwODEyNTYyNlow
LwYJKoZIhvcNAQkEMSIEIKf3tMlCnz+0uGSg75lasTBpkMyGATc9Z4a26N6U
fnFiMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
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
mVHykW27As5LWJAadekwDQYJKoZIhvcNAQEBBQAEggEAQGbFz8p+zdRDTpmJ
RGi3K5YYgk/qW8qf1B2wz1jfwLdBBNqidOE8936N7uCmj7IMwl8jtEt9Tlk8
cpNNyzrFqJWMS8W5bIoJBPKzhD+CLlXJ+ofuWY5/lG90D+SsgZfDrn/V2N7m
Dwx1yX0tXmpyterVrsWL3h2b2Z0u6K6/kNBu8jtyNDQ4FRIVuVe73IGm9CLF
ssZs9DZOEeT4091ZrEFgmI4sT+jyxYDJCURQRiUIapeNdVIpwrKAfPOGacL2
65Dr4LxFCQKyVdw3lth37wQ2s6jv98pbxat3znXBNhkPC+nNSvpZgtx7nuts
/a8T3ngiESLsrx6Jbvx9ySKgFwAAAAAAAA==

--------------ms040309040105030706090009--
