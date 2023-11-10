Return-Path: <SRS0=rMD3=GX=upm.es=pedroluis.castedo@sourceware.org>
Received: from neon-v1.ccupm.upm.es (neon-v1.ccupm.upm.es [138.100.198.71])
	by sourceware.org (Postfix) with ESMTPS id E26F13858D32
	for <cygwin-patches@cygwin.com>; Fri, 10 Nov 2023 17:44:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E26F13858D32
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=upm.es
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=upm.es
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E26F13858D32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=138.100.198.71
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1699638272; cv=none;
	b=cL7P/yJL6wnM5FGvnZAdGA3I418kdtD4TMg45mXokUB0/SnJFcCHwJ04KCBzewxg23QV25QPg8/ZDFmVtJTlwyVz+/dN/mn1hqaKZI/V4OoWLPYzB7toKGo57k5yu/Jy9CyLiLAQZx3pJFzMLi6QJOFWyZoYHr09QnJMLRut95g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1699638272; c=relaxed/simple;
	bh=4AuwowkV1Mu9b5en/y7ETmkjZO7U5PwMWMtxat17bp4=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From; b=lkS2IvAVRqGaNj7OcgTj7sHcjcxYbwAMVdKKzEwJf1is8efzPTqtZhyWH1eXwqnu3fsvK74B9dCIXMnbsQ/HxV181yoEBW9kqqGwmm4Q/MVwMFEeOy193pYXmpExYiE3IMuDQUQztdPIAEHQqbE4ukUrivIXRBCj18CNykyngzY=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from [10.152.189.53] ([138.4.235.63])
        (user=pedroluis.castedo@upm.es mech=PLAIN bits=0)
        by neon-v1.ccupm.upm.es (8.15.2/8.15.2/neon-v1-002) with ESMTPSA id 3AAHiRj8010236
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <cygwin-patches@cygwin.com>; Fri, 10 Nov 2023 17:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=upm.es; s=upm;
	t=1699638268; bh=4AuwowkV1Mu9b5en/y7ETmkjZO7U5PwMWMtxat17bp4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=E4Er4w8qiDls+b/OJIMQE7noAWy0DNx+mLmNWjr52nx+r1dc9gFg3xBwgJsCEYBR2
	 5h2R4Vw8hBNg1MHMxaCgU6YlEeE0/PbTHNGv6ODWLrSq3o+Tv90MjzOmaYk0wt8M+0
	 ArxI5T4dhgEL6mdwv2VwuZC4i4mBuUElwpzBdjTU=
Message-ID: <27a7257d-1e06-40ff-89ec-f100b8734802@upm.es>
Date: Fri, 10 Nov 2023 18:44:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix(libc): Fix handle of %E & %O modifiers at end of
 format string
Content-Language: es-ES, en-US
To: cygwin-patches@cygwin.com
References: <20231109190441.2826-1-pedroluis.castedo@upm.es>
 <4801ab90-2958-4fa2-87f2-21efdb41bbf4@Shaw.ca>
 <ZU4C+UIcYTtvWrrJ@calimero.vinschen.de>
From: Pedro Luis Castedo Cepeda <pedroluis.castedo@upm.es>
In-Reply-To: <ZU4C+UIcYTtvWrrJ@calimero.vinschen.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020201080501060702050100"
X-Spam-Status: No, score=-14.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a cryptographically signed message in MIME format.

--------------ms020201080501060702050100
Content-Type: multipart/mixed; boundary="------------yE2Xvhf30E1G4Hl1GLBkvK20"

--------------yE2Xvhf30E1G4Hl1GLBkvK20
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

El 10/11/2023 a las 11:16, Corinna Vinschen escribió:
> On Nov  9 23:17, Brian Inglis wrote:
>> On 2023-11-09 12:04, Pedro Luis Castedo Cepeda wrote:
>>> - Prevent strftime to parsing format string beyond its end when
>>>     it finish with "%E" or "%O".
>>> ---
>>>    newlib/libc/time/strftime.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/newlib/libc/time/strftime.c b/newlib/libc/time/strftime.c
>>> index 56f227c5f..c4e9e45a9 100644
>>> --- a/newlib/libc/time/strftime.c
>>> +++ b/newlib/libc/time/strftime.c
>>> @@ -754,6 +754,8 @@ __strftime (CHAR *s, size_t maxsize, const CHAR *format,
>>>          switch (*format)
>>>    	{
>>> +	case CQ('\0'):
>>> +	  break;
>>>    	case CQ('a'):
>>>    	  _ctloc (wday[tim_p->tm_wday]);
>>>    	  for (i = 0; i < ctloclen; i++)
>>
>> These cases appear to already be taken care of by setting and using
>> (depending on the config parameters) the "alt" variable for those modifiers,
>> and the default: return 0; for the format *character* (possibly wide) not
>> matching following any modifiers.
>>
>> Patches to newlib should go to the newlib mailing list at sourceware dot org.
> 
> Also, a simple reproducer would be nice.
> 
> 
> Thanks,
> Corinna

My first contribution. Sorry about posting to wrong mail list and, at 
best, minimalistic patch motivation reasoning. First time with git 
send-mail, too.

I came across this newlib "feature" trying to update GLib port to 
2.78.1. When trying to find out why test_strftime (glib/test/date.c)
was failing I discovered that one of the test format strings, "%E" was 
triggering a loop in g_date_strftime (glib/gdate.c) requiring more and 
more memory till it was stopped by a fortunate maximum size check in 
function.

The problem is that __strftime  (newlib/libc/time/strftime.c) doesn't 
check for '\0' after a terminal "%E" and it continues parsing the format 
string. Finally (not sure if intentionally), this triggers a direct 
return 0 from __strftime instead breaking the loop, preventing it from 
add '\0' to the end of returned string. Same for "%O", I think (not tested).

It seems that this trailing '\0' allows to differentiate returning an 
empty string from needing more space (at least, in Glib).

So, is it a newlib bug? Not really, I think this format string is 
bad-formed (%E should modify something, shouldn't it?) So undefined 
behaviour is OK. I could patch-out these format strings from the port.

But... from Glib tests, it seems that, at least:

- If G_OS_WIN32, terminal "%E" & "%O" are silently discarded.
- If __FreeBSD__ || __OpenBSD__ || __APPLE__ they are transformed to E & 
O, respectively.
- And if #else the same thing is expected.

So it seems that returning 0-terminated string is a common practice and 
I also think that this is more deterministic and, potentially, safer. 
That's why I sent the patch. It tries to be the shortest addition to 
check for end of string after %E & %O modifiers and takes G_OS_WIN32 
approach (only cause it's the simplest).

Best regards.


--------------yE2Xvhf30E1G4Hl1GLBkvK20
Content-Type: text/plain; charset=UTF-8; name="strftime_test.c"
Content-Disposition: attachment; filename="strftime_test.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RkYm9vbC5oPgojaW5jbHVkZSA8c3Ry
aW5nLmg+CiNpbmNsdWRlIDx0aW1lLmg+CiNpbmNsdWRlIDxsb2NhbGUuaD4KI2luY2x1ZGUg
PGFzc2VydC5oPgoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKewogIGNvbnN0
IHN0cnVjdCB0bSBkYXRlID0gewogICAgLnRtX3NlYyA9IDAsIC50bV9taW4gPSAwLCAudG1f
aG91ciA9IDAsIC50bV9tZGF5ID0gMSwgLnRtX21vbiA9IDAsCiAgICAudG1feWVhciA9IC0x
ODk5LCAudG1fd2RheSA9IDEsIC50bV95ZGF5ID0gMCwgLnRtX2lzZHN0ID0gLTEsCiAgICAu
dG1fZ210b2ZmID0gMCwgLnRtX3pvbmUgPSAweDAKICB9OwoKICBzZXRlbnYoIkxDX0FMTCIs
ICJlbl9VUy51dGYtOCIsIHRydWUpOwogIHNldGxvY2FsZSAoTENfQUxMLCAiIik7CgogIGNo
YXIgdG1wYnVmWzEyOF07CiAgc2l6ZV90IHRtcGxlbjsKCiAgdG1wYnVmWzBdID0gJ1wxJzsK
ICB0bXBsZW4gPSBzdHJmdGltZSh0bXBidWYsIHNpemVvZih0bXBidWYpLCAiJUUiLCAmZGF0
ZSk7CiAgYXNzZXJ0KHRtcGJ1ZlswXSA9ICdcMCcgfHwgc3RybmNtcCh0bXBidWYsICJFIiwg
MikpOwogIHRtcGxlbiA9IHN0cmZ0aW1lKHRtcGJ1Ziwgc2l6ZW9mKHRtcGJ1ZiksICIlTyIs
ICZkYXRlKTsKICBhc3NlcnQodG1wYnVmWzBdID0gJ1wwJyB8fCBzdHJuY21wKHRtcGJ1Ziwg
Ik8iLCAyKSk7CgogIHJldHVybiBFWElUX1NVQ0NFU1M7Cn0K

--------------yE2Xvhf30E1G4Hl1GLBkvK20--

--------------ms020201080501060702050100
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: Firma criptográfica S/MIME

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EuEwggfzMIIF26ADAgECAhA0gWDFH17by13ficq0VzOSMA0GCSqGSIb3DQEBCwUAMDsxCzAJ
BgNVBAYTAkVTMREwDwYDVQQKDAhGTk1ULVJDTTEZMBcGA1UECwwQQUMgUkFJWiBGTk1ULVJD
TTAeFw0xOTExMjgwODQ4MDlaFw0yOTExMjgwODQ4MDlaMGcxCzAJBgNVBAYTAkVTMREwDwYD
VQQKDAhGTk1ULVJDTTEOMAwGA1UECwwFQ2VyZXMxGDAWBgNVBGEMD1ZBVEVTLVEyODI2MDA0
SjEbMBkGA1UEAwwSQUMgU2VjdG9yIFDDumJsaWNvMIICIjANBgkqhkiG9w0BAQEFAAOCAg8A
MIICCgKCAgEAiJe1OQj5HBC0u+PEpSMkjoad+GCv7cc9ZBCMHfqVoySV0R9AaxXGDqll1B9b
1hCo0Rbk6on9fEyQTEVW3rL38Yk4l9M48XLKzu05u48zDrCTRjL5QpmDnoRr93EkLUPJvqkj
+Tj60G/IAUxfPBu9Z9PQ+NlJOe9/nV3Urb4gQONDwswU6cdBZQEZo65vyV6Zmcx4ZE4FhcRY
CuaPLfASNXA3Fa9pN9jFHD1Jsep+A4eguQAuQyyE0zrYIZCceV0YEf3Dyvi+ykXT9cdvee+r
YZaQGGrl/HC7Q7OBoGlKIEvgxzrEMlqh6U/EH+ZreJwP5oA2IGv3bPfMKWJNTF7hzfcvyo+a
dXYYpy0AMBHdgRw448IleOflA500NCaM8EsJuLwYvm7l4ng1ldSIXnQs3KigD3PjkG0vnFjZ
6z5kI4ixivwv1fmSVO+sA/mUouV6hGthtSd8urUtWSkZo47bDMzKg62n1gQl5oDym6ec8jmN
IrmfckixV6x9jR++rQOJrhXc0u/2M+c6Zq1u5XUJp1P7C4obRlXKgzTnPMTkbgH4MfhVZ9nL
SvpbOI5zhd9BxOJ8yT2FxkRY8lDlbGUaJS5YR869WLOtgjOMl3eddFI3vr7FwdWXLqx3L0jX
sMw4MwsuGqfy9HUslrBczu81uY2GzkZx7HaF546HrIGk2iECAwEAAaOCAsUwggLBMA4GA1Ud
DwEB/wQEAwIBBjASBgNVHRMBAf8ECDAGAQH/AgEAMIGVBggrBgEFBQcBAQSBiDCBhTBJBggr
BgEFBQcwAYY9aHR0cDovL29jc3Bmbm10cmNtY2EuY2VydC5mbm10LmVzL29jc3Bmbm10cmNt
Y2EvT2NzcFJlc3BvbmRlcjA4BggrBgEFBQcwAoYsaHR0cDovL3d3dy5jZXJ0LmZubXQuZXMv
Y2VydHMvQUNSQUlaRk5NVC5jcnQwHQYDVR0OBBYEFOcE7nCREZJE+Q6Sj1ZDHgcdvwScMB8G
A1UdIwQYMBaAFPd9xf3E6Jobd2Sn9R2gzL+HYJptMIHrBgNVHSAEgeMwgeAwgd0GBFUdIAAw
gdQwKQYIKwYBBQUHAgEWHWh0dHA6Ly93d3cuY2VydC5mbm10LmVzL2RwY3MvMIGmBggrBgEF
BQcCAjCBmQyBllN1amV0byBhIGxhcyBjb25kaWNpb25lcyBkZSB1c28gZXhwdWVzdGFzIGVu
IGxhIERlY2xhcmFjacOzbiBkZSBQcsOhY3RpY2FzIGRlIENlcnRpZmljYWNpw7NuIGRlIGxh
IEZOTVQtUkNNICggQy8gSm9yZ2UgSnVhbiwgMTA2LTI4MDA5LU1hZHJpZC1Fc3Bhw7FhKTCB
1AYDVR0fBIHMMIHJMIHGoIHDoIHAhoGQbGRhcDovL2xkYXBmbm10LmNlcnQuZm5tdC5lcy9D
Tj1DUkwsT1U9QUMlMjBSQUlaJTIwRk5NVC1SQ00sTz1GTk1ULVJDTSxDPUVTP2F1dGhvcml0
eVJldm9jYXRpb25MaXN0O2JpbmFyeT9iYXNlP29iamVjdGNsYXNzPWNSTERpc3RyaWJ1dGlv
blBvaW50hitodHRwOi8vd3d3LmNlcnQuZm5tdC5lcy9jcmxzL0FSTEZOTVRSQ00uY3JsMA0G
CSqGSIb3DQEBCwUAA4ICAQCiI56H2A0b6bYPmwaEXjZiKSvTdoPaM3AwTN87LyPcZj3/Mhi7
vj0x43ACr0pXH82fE2IcdRQ6onO4KE8z/Aw1pLoZ5Nh6sOxT3QLR+xs+YA4h9ZDVF1lYzkNW
U4rsiG1E3WkObRIIiIK9a3hS0VGe7ThV5/WnlZ2LvUmKxP/lPC0AuT9uww/noppk/o0eC+H8
Jpe7fRTFJJqgn4c8fIMsTYxGkoXxjJ8Y0S2qyVJhkuyJwYR2+p6ANbGcnyVHR04xXpPYCV1y
3ShwDEr59FSk3HcPPD27vNBfBCpHkLumOm/Zl/P5pIbVa5z9z5fIlGxlcG6vEzATi1+spK8B
ZIEQ4z0JofAxVuG4/INmpvKLYB0saSm/pMvdBfR4FyypmsY/v1Rg12LeJih7wHlu2/ypNedd
zgAVhQ6CkYV984FtfoLCQ3u11WeDSrLeV8QsQHc1h0ImXWiZWxOLpRtlbiXvBrTgk0rc9fdG
bkqBFjLibGQffAMAXMxXbTbVq/I9/hJKTACZB9i2lQ5BAZzKhJLgmnYIZNrf5QiA/I6zI/K7
3xCsCeq3WMjVPnTEkyDLiVhAM6Iv1SbM5hkb/StrB4naJK8KQwdOWSe+KxejxxeDv4nVsLT6
EESg2r521bJP6vs9M4YKGlDM4c9vJzvnAGnsirvl1XF7hqxcjxh3K2sXEjCCCuYwggjOoAMC
AQICEEYGZ0ht3J+jYeU2vgBgc28wDQYJKoZIhvcNAQELBQAwZzELMAkGA1UEBhMCRVMxETAP
BgNVBAoMCEZOTVQtUkNNMQ4wDAYDVQQLDAVDZXJlczEYMBYGA1UEYQwPVkFURVMtUTI4MjYw
MDRKMRswGQYDVQQDDBJBQyBTZWN0b3IgUMO6YmxpY28wHhcNMjIwMTE3MDkyODMwWhcNMjUw
MTE3MDkyODMwWjCCATcxCzAJBgNVBAYTAkVTMSowKAYDVQQKDCFVTklWRVJTSURBRCBQT0xJ
VEVDTklDQSBERSBNQURSSUQxNDAyBgNVBAsMK0NFUlRJRklDQURPIEVMRUNUUk9OSUNPIERF
IEVNUExFQURPIFBVQkxJQ08xSjBIBgNVBAsMQUVUUyBJTkcgWSBESVNFw5FPIElORCAtIERQ
VE8gSU5HIEVMRUNUIEVMRUNUUk9OIEFVVE9NIFkgRklTSUNBIEFQMRgwFgYDVQQFEw9JRENF
Uy0wODAzMTMzM0QxFzAVBgNVBAQMDkNBU1RFRE8gQ0VQRURBMRMwEQYDVQQqDApQRURSTyBM
VUlTMTIwMAYDVQQDDClDQVNURURPIENFUEVEQSBQRURSTyBMVUlTIC0gRE5JIDA4MDMxMzMz
RDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJBhLzsP3N1U2U18tSJ4w2oDNjxQ
j9+0dRkQdQ9moMGfU4PR+wWKTW9CESlB+CAQagniaV/9WEp9cntJLWHoUoOjNF7ob8r+SP0Y
PzeFTuM5QJaDe5n4SGvinuTbTt1qpuQmnBLPWUrXz1pq5enP7ZM9uA7nwI435Ud/TrfiR6Ta
dEhBmHlN0g08Zp8/HeBH0tohymcAjq2nsMcYUWvX8GYpV9osgHIjZ0jzT3Ptt3Omr8xNPNwS
VSC+TsQ8sFI8gUkA3CHPSaHsj2rwoIXBg8KaOszuuHlInqUm5rP3ASTgyBLrBHHNUfeTXyIA
AZ+ue46Nd7MCEEwI9W5BB7kKPA8CAwEAAaOCBbowggW2MIIBzgYDVR0RBIIBxTCCAcGBGHBl
ZHJvbHVpcy5jYXN0ZWRvQHVwbS5lc6SCAaMwggGfMSUwIwYJYIVUAQMFBwILDBZQUk9GRVNP
UiBUSVRVTEFSIERFIEVVMVMwUQYJYIVUAQMFBwIKDERFVFMgSU5HIFkgRElTRcORTyBJTkQg
LSBEUFRPIElORyBFTMOJQ1QgRUxFQ1RSw5NOIEFVVE9NIFkgRsONU0lDQSBBUDEnMCUGCWCF
VAEDBQcCCQwYcGVkcm9sdWlzLmNhc3RlZG9AdXBtLmVzMRUwEwYJYIVUAQMFBwIIDAZDRVBF
REExFjAUBglghVQBAwUHAgcMB0NBU1RFRE8xGTAXBglghVQBAwUHAgYMClBFRFJPIExVSVMx
GDAWBglghVQBAwUHAgQMCTA4MDMxMzMzRDEYMBYGCWCFVAEDBQcCAwwJUTI4MTgwMTVGMTAw
LgYJYIVUAQMFBwICDCFVTklWRVJTSURBRCBQT0xJVEVDTklDQSBERSBNQURSSUQxSDBGBglg
hVQBAwUHAgEMOUNFUlRJRklDQURPIEVMRUNUUk9OSUNPIERFIEVNUExFQURPIFBVQkxJQ08g
KG5pdmVsIG1lZGlvKTAMBgNVHRMBAf8EAjAAMCkGA1UdJQQiMCAGCCsGAQUFBwMEBggrBgEF
BQcDAgYKKwYBBAGCNxQCAjAOBgNVHQ8BAf8EBAMCBeAwHQYDVR0OBBYEFIhrb4tFH349ZSHW
jjIkvEVreCAoMB8GA1UdIwQYMBaAFOcE7nCREZJE+Q6Sj1ZDHgcdvwScMIHDBggrBgEFBQcB
AwSBtjCBszAIBgYEAI5GAQEwCwYGBACORgEDAgEPMBMGBgQAjkYBBjAJBgcEAI5GAQYBMG4G
BgQAjkYBBTBkMDAWKmh0dHBzOi8vd3d3LmNlcnQuZm5tdC5lcy9wZHMvUERTX1NQX2VzLnBk
ZhMCZXMwMBYqaHR0cHM6Ly93d3cuY2VydC5mbm10LmVzL3Bkcy9QRFNfU1BfZW4ucGRmEwJl
bjAVBggrBgEFBQcLAjAJBgcEAIvsSQEBMIIBLgYDVR0gBIIBJTCCASEwggEGBgorBgEEAaxm
AxECMIH3MCkGCCsGAQUFBwIBFh1odHRwOi8vd3d3LmNlcnQuZm5tdC5lcy9kcGNzLzCByQYI
KwYBBQUHAgIwgbwMgblDZXJ0aWZpY2FkbyBjdWFsaWZpY2FkbyBkZSBmaXJtYSBlbGVjdHLD
s25pY2EgZGUgZW1wbGVhZG8gcMO6YmxpY28uIFN1amV0byBhIGxhcyBjb25kaWNpb25lcyBk
ZSB1c28gZXhwdWVzdGFzIGVuIERQQyBkZSBGTk1ULVJDTSwgTklGOiBRMjgyNjAwNC1KIChD
L0pvcmdlIEp1YW4gMTA2LTI4MDA5LU1hZHJpZC1Fc3Bhw7FhKTAJBgcEAIvsQAEAMAoGCGCF
VAEDBQcCMH8GCCsGAQUFBwEBBHMwcTAyBggrBgEFBQcwAoYmaHR0cDovL3d3dy5jZXJ0LmZu
bXQuZXMvY2VydHMvQUNTUC5jcnQwOwYIKwYBBQUHMAGGL2h0dHA6Ly9vY3Nwc3AuY2VydC5m
bm10LmVzL29jc3BzcC9PY3NwUmVzcG9uZGVyMIHfBgNVHR8EgdcwgdQwgdGggc6ggcuGKmh0
dHA6Ly93d3cuY2VydC5mbm10LmVzL2NybHNhY3NwL0NSTDMzLmNybIaBnGxkYXA6Ly9sZGFw
c3AuY2VydC5mbm10LmVzL2NuPUNSTDMzLGNuPUFDJTIwU2VjdG9yJTIwUHVibGljbyxvdT1D
RVJFUyxvPUZOTVQtUkNNLEM9RVM/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDtiaW5hcnk/
YmFzZT9vYmplY3RjbGFzcz1jUkxEaXN0cmlidXRpb25Qb2ludDANBgkqhkiG9w0BAQsFAAOC
AgEAdNzLSPr5KZwm4RksOFDU5JrMDsw0Yt2+qaYcBuPxugoGsj+racfBAYaNajI2W0d3GI56
/a9/0QyozV0lI8PRibxRjBzpVlU14rUs/fecVAMXu1X3uMgIuYeC/RPRiUZWkfXJAWjTJYad
lCiw+GbtWeuHH6gklR2lCR/89jjdD1xWJM2u1VOcyYMXU47Q45g3HTk61kHGJbGXPjbQ7t81
KDrvB2MfZA+z4ivqubzc2SN9Pby8GBchr1Ikb6EqlNKMuDJBLYU33nDAcvvvWIEgLjf9NP/g
FDFZsJebuS9Y8INkGdOlRyed7yKI7170meIeMpefWLYXZy9EP0DqlGNzB45SlEXnkOfx4+9p
ADRs1HMOWNjt8/8Hp8rcG5P+//CGmOohiNYzvBtg8DbhOoML5vZm6MnjMnxm5tTsl/RBLkTY
v1WZL6lMN35gbsyzStkGGFsx/gD7Apds/KyXyBTHgOWdd1qz7lEQevmVb9ZZtVQ3Y9yn1/VR
D3QlZGpvUUs+5e7xGskMwslGNrGqsVK75KP/z+qogSySEuo7FLmXskUFagSsnLR1nnFuMyGb
+XZ3GBcZKFVY/GaAVgrlu8S3fVXcRn9CaH9OWRTWIKwK9JKVFjIbzq8B1zPLjoI5l+mzAM6R
3Wnbk5PVKNeuP/HI3cYE5AXQWEsSTBN8xgE6jUMxggOdMIIDmQIBATB7MGcxCzAJBgNVBAYT
AkVTMREwDwYDVQQKDAhGTk1ULVJDTTEOMAwGA1UECwwFQ2VyZXMxGDAWBgNVBGEMD1ZBVEVT
LVEyODI2MDA0SjEbMBkGA1UEAwwSQUMgU2VjdG9yIFDDumJsaWNvAhBGBmdIbdyfo2HlNr4A
YHNvMA0GCWCGSAFlAwQCAQUAoIIB8zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0yMzExMTAxNzQ0MjdaMC8GCSqGSIb3DQEJBDEiBCA0PRsURvg4JI8TOYRt
wOHacZ8qRKfi5GVqKzGIINOTYTBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGKBgkrBgEEAYI3EAQxfTB7MGcxCzAJBgNVBAYTAkVT
MREwDwYDVQQKDAhGTk1ULVJDTTEOMAwGA1UECwwFQ2VyZXMxGDAWBgNVBGEMD1ZBVEVTLVEy
ODI2MDA0SjEbMBkGA1UEAwwSQUMgU2VjdG9yIFDDumJsaWNvAhBGBmdIbdyfo2HlNr4AYHNv
MIGMBgsqhkiG9w0BCRACCzF9oHswZzELMAkGA1UEBhMCRVMxETAPBgNVBAoMCEZOTVQtUkNN
MQ4wDAYDVQQLDAVDZXJlczEYMBYGA1UEYQwPVkFURVMtUTI4MjYwMDRKMRswGQYDVQQDDBJB
QyBTZWN0b3IgUMO6YmxpY28CEEYGZ0ht3J+jYeU2vgBgc28wDQYJKoZIhvcNAQEBBQAEggEA
kDqDPPUb3P+IesMkxcV4VcHOoT4iMoKZIk+Dlb8ekd1B8rktNRD19slm7PwQMM8kw0kmVIG1
u1LjtbBb1YBoIH4SfwBYsnkXwEyoZL6Yh2ADah5sOJZFU6QGiVtdpbqoYOv5181ar32NhSiT
OxDCDyOJKNQ5hyFdLRbX5uWl+Wh8l3OHjNsFapkn9NVIVYCnpFMeupvcxR6Bt7/4PPwgP6DP
q5YxYRRzvdj5tfvXDC2ODnP0Fdl0TeRkwM/P5hJfWz2/Hv67lSraHxpGu/BYJXwJY2K/YEze
AATht55kYiIuXH1GAX9Zgawz1mkOmHEqRJL4mQMZj8zC2kaxCMXHSAAAAAAAAA==
--------------ms020201080501060702050100--
