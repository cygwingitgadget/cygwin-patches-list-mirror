Return-Path: <cygwin-patches-return-1833-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29298 invoked by alias); 2 Feb 2002 02:59:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29264 invoked from network); 2 Feb 2002 02:59:40 -0000
From: "Gary R Van Sickle" <tiberius@braemarinc.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: For the curious: Setup.exe char-> String patch
Date: Fri, 01 Feb 2002 18:59:00 -0000
Message-ID: <000b01c1ab95$a12cf740$2101a8c0@BRAEMARINC.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000C_01C1AB63.56928740"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <FC169E059D1A0442A04C40F86D9BA760014AB6@itdomain003.itdomain.net.au>
X-MS-TNEF-Correlator: 00000000B03CC41A0A406141B2DADC7F0FA7B35AA4C7BD00
X-SW-Source: 2002-q1/txt/msg00190.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_000C_01C1AB63.56928740
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1311

> -----Original Message-----
> From: Robert Collins [mailto:robert.collins@itdomain.com.au]
> > -----Original Message-----
> > From: Gary R Van Sickle [mailto:tiberius@braemarinc.com]
> > 
> > I think it would behoove us greatly to duplicate the semantics of
> > std::string here, and return a zero-based offset on success, 
> > and an "npos"
> > on failure.
>  
> Whats a 'npos' defined as?
>  

"static const size_type npos = -1;"  It's a member of basic_string, so
something like this would do it:

class String
{
	static const long npos = -1;
};

and then you just have to compare to "String::npos" everywhere.

I don't know if initing to -1 is actually legal in the class declaration,
but you get the drift.

> > > geturl.cc:
> > >
> > >  static void
> > > -init_dialog (char const *url, int length, HWND owner)
> > > +init_dialog (String const url, int length, HWND owner)
> >                 ^^^^^^^^^^^^^^^^
> > 
> > This would be better written "const String &url".
> 
> Weeel, yes it would, yet another typo. Fortunately String copies are
> very lightweight :}.
> (One addition, one subtraction, and if test and 4 bytes of storage)

??? You're doing some sort of ref counting?  Isn't that a bit ambitious for
our current needs?

-- 
Gary R. Van Sickle
Braemar Inc.
11481 Rupp Dr.
Burnsville, MN 55337

------=_NextPart_000_000C_01C1AB63.56928740
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"
Content-length: 3221

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
AADAAAAAAAAARgAAAAABhQAAAAAAAAsAG4AIIAYAAAAAAMAAAAAAAABGAAAA
AA6FAAAAAAAAAwAcgAggBgAAAAAAwAAAAAAAAEYAAAAAEYUAAAAAAAADAB6A
CCAGAAAAAADAAAAAAAAARgAAAAAYhQAAAAAAAAIB+A8BAAAAEAAAALA8xBoK
QGFBstrcfw+ns1oCAfoPAQAAABAAAACwPMQaCkBhQbLa3H8Pp7NaAgH7DwEA
AACgAAAAAAAAADihuxAF5RAaobsIACsqVsIAAG1zcHN0LmRsbAAAAAAATklU
Qfm/uAEAqgA32W4AAABDOlxEb2N1bWVudHMgYW5kIFNldHRpbmdzXGdhcnlf
dnMuQlJBRU1BUklOQ1xMb2NhbCBTZXR0aW5nc1xBcHBsaWNhdGlvbiBEYXRh
XE1pY3Jvc29mdFxPdXRsb29rXG1haWxib3gucHN0AAMA/g8FAAAAAwANNP03
AAACAX8AAQAAADEAAAAwMDAwMDAwMEIwM0NDNDFBMEE0MDYxNDFCMkRBREM3
RjBGQTdCMzVBQTRDN0JEMDAAAAAAAwAGEKuHDy0DAAcQugMAAAMAEBABAAAA
AwAREAAAAAAeAAgQAQAAAGUAAAAtLS0tLU9SSUdJTkFMTUVTU0FHRS0tLS0t
RlJPTTpST0JFUlRDT0xMSU5TTUFJTFRPOlJPQkVSVENPTExJTlNASVRET01B
SU5DT01BVS0tLS0tT1JJR0lOQUxNRVNTQUdFLS0tAAAAACRD

------=_NextPart_000_000C_01C1AB63.56928740--
