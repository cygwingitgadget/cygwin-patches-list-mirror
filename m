Return-Path: <cygwin-patches-return-1945-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27303 invoked by alias); 4 Mar 2002 22:46:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27252 invoked from network); 4 Mar 2002 22:46:03 -0000
content-class: urn:content-classes:message
Subject: RE: Silence pedantic warnings at header file level
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 Mar 2002 14:46:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA76008AB0E@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Silence pedantic warnings at header file level
Thread-Index: AcHDzh/62uKV2jzySI+1xqxrsUb14QAAC/Yw
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Danny Smith" <danny_r_smith_2001@yahoo.co.nz>,
	"cygwin-patches" <cygwin-patches@cygwin.com>
X-SW-Source: 2002-q1/txt/msg00302.txt.bz2

Would this also fix the 'is not a prototype' error that cinstall
experiences?

Rob

> -----Original Message-----
> From: Danny Smith [mailto:danny_r_smith_2001@yahoo.co.nz]=20
> Sent: Tuesday, March 05, 2002 9:44 AM
> To: cygwin-patches
> Subject: RFC: Silence pedantic warnings at header file level
>=20
>=20
> GCC 3.x has a a new pragma that causes the rest of the code=20
> in the current file to be treated as if it came from a system header
>=20
> Putting this right after the header guard of runtime and=20
> w32api headers would silence all the "long long"  and=20
> bitfield pedantic warnings that still occur.  It would also=20
> allow cleanup of the anonymous union __extension__ business.
>=20
> #if defined __GNUC__ && __GNUC__ >=3D 3
> #pragma GCC system_header
> #endif
>=20
>=20
> This approach is used in GCC's STL headers.
>=20
> Any comments
>=20
> Danny
>=20
http://movies.yahoo.com.au - Yahoo! Movies
- Vote for your nominees in our online Oscars pool.
