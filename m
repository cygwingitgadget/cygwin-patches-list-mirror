Return-Path: <cygwin-patches-return-1832-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18440 invoked by alias); 2 Feb 2002 02:47:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18375 invoked from network); 2 Feb 2002 02:46:59 -0000
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: For the curious: Setup.exe char-> String patch
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Date: Fri, 01 Feb 2002 18:47:00 -0000
Message-ID: <FC169E059D1A0442A04C40F86D9BA760014AB6@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: For the curious: Setup.exe char-> String patch
Thread-Index: AcGrkXOjkzalZH3AR/CDnkeqUqJqGgAAjLKQ
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R Van Sickle" <tiberius@braemarinc.com>,
	<cygwin-patches@cygwin.com>
X-SW-Source: 2002-q1/txt/msg00189.txt.bz2



> -----Original Message-----
> From: Gary R Van Sickle [mailto:tiberius@braemarinc.com]
>=20
> I think it would behoove us greatly to duplicate the semantics of
> std::string here, and return a zero-based offset on success,=20
> and an "npos"
> on failure.
=20
Whats a 'npos' defined as?
=20
> > geturl.cc:
> >
> >  static void
> > -init_dialog (char const *url, int length, HWND owner)
> > +init_dialog (String const url, int length, HWND owner)
>                 ^^^^^^^^^^^^^^^^
>=20
> This would be better written "const String &url".

Weeel, yes it would, yet another typo. Fortunately String copies are
very lightweight :}.
(One addition, one subtraction, and if test and 4 bytes of storage)

Rob
