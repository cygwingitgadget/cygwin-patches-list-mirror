Return-Path: <cygwin-patches-return-1659-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17978 invoked by alias); 7 Jan 2002 15:49:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17964 invoked from network); 7 Jan 2002 15:49:11 -0000
Message-ID: <C2D7D58DBFE9D111B0480060086E96350689B61C@mail_server.gft.com>
From: =?iso-8859-1?Q?=22Schaible=2C_J=F6rg=22?= <Joerg.Schaible@gft.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: FW: [PATCH] Update 2 - Setup.exe property sheet patch
Date: Mon, 07 Jan 2002 07:49:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-SW-Source: 2002-q1/txt/msg00016.txt.bz2

did not recognize, that Robert mailed twice - one private, one to the list

-----Original Message-----
From: Schaible, J=F6rg=20
Sent: Monday, January 07, 2002 3:24 PM
To: 'Robert Collins'
Subject: RE: [PATCH] Update 2 - Setup.exe property sheet patch


Hi Robert,

unfortunately is this document not freely available and have to be purchased
from the ISO commitee, but I can cite here:

------------------- 10.3.2 ---------------
If a virtual member function "vf" is declared in a class "Base" and in a
derived class "Derived", derived directly or indirectly from "Base", a
member function "vf" with the same name and same parameter list as
"Base::vf" is declared, then "Dervived::vf" is also virtual (wether or not
so declared) and it overrides(97) "Base::vf". For conveniance we say that
any virtual function overrides itself. Then in any well-formed class, for
each virtual function declared in that class or any of its direct or
indirect base classes there is a unique "final overrider" that overrides
that function and every other overrider of that function. The rules for
member lookup (10.2) are used to determin the final overrider for a virtual
function in the scope of a derived class but ignoring names introduced by
"using-declaration"s. [Example:

struct A {
	virtual void f();
};
struct B : virtual A {
	virtual void f();
};

struct C : B , virtual A {
	using A::f;
}
void foo() {
	C c;
	c.f();	// calls "B::f", the final overrider
	c.C::f();	// calls "A::f" because of the using-declaration
-- end example]

97) A function with the same name but a different parameter list (clause 13)
as a virtual function is not necessarily virtual and does not override. The
use of the "virtual" specifier in the declaration of an overriding function
is legal but redundant (has empty semantics). Access control (clause 11) is
not considered in determining overriding.
------------------------------------

Regards,
J=F6rg

BTW: The address book entries are managed in a company wide Exchange server,
so no modification possible. It seems that you've setup your mail client to
accept "," as separator, while normally only ";" is accepted.



>-----Original Message-----
>From: Robert Collins [mailto:robert.collins@itdomain.com.au]
>Sent: Monday, January 07, 2002 2:47 PM
>To: Schaible, J=F6rg
>Subject: Fw: [PATCH] Update 2 - Setup.exe property sheet patch
>
>
>
>=3D=3D=3D
>----- Original Message -----
>From: "Robert Collins" <robert.collins@itdomain.com.au>
>To: <Schaible>; "J=F6rg" <Joerg.Schaible@gft.com>;
><cygwin-patches@sourceware.cygnus.com>
>Sent: Tuesday, January 08, 2002 12:46 AM
>Subject: Re: [PATCH] Update 2 - Setup.exe property sheet patch
>
>
>> I'm sorry Jorg, but I don't have the standard to reference. Do you
>know
>> of an on-line copy? (Googling for "c++ standard 10.3.2" gave me lots
>of
>> useless hits :})
>>
>> I got my info from the C++ FAQS second edition (Cline Lomow & Girou),
>> FAQ 33.09.
>>
>> Rob
>> =3D=3D=3D
>> ----- Original Message -----
>> From: "Schaible, J=F6rg" <Joerg.Schaible@gft.com>
>> >My understanding is that this is not 100% the case. Or more
>> >pedantically - in a class derived from a a class with virtual
>> >functions,
>> >those virtual functions wil get overriden, but if not declared
>virtual
>> >themselves, any further derivations will not. I believe that the
>> >technique of doing this to allow inlining of code calling references
>to
>> >an object is called 'final classes'.
>>
>> Sorry, Gary is right. See 10.3.2 of the standard.
>>
>> Regards,
>> J=F6rg
>>
>>
>
