Return-Path: <cygwin-patches-return-5989-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13473 invoked by alias); 7 Oct 2006 19:13:59 -0000
Received: (qmail 13460 invoked by uid 22791); 7 Oct 2006 19:13:57 -0000
X-Spam-Check-By: sourceware.org
Received: from jetspin.drizzle.com (HELO jetspin.drizzle.com) (216.162.192.5)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 07 Oct 2006 19:13:56 +0000
Received: from mutable2.home.mutable.net (wet193.drizzle.com [216.162.201.193]) 	by jetspin.drizzle.com (8.13.1/8.13.1) with ESMTP id k97JDsTU013123 	for <cygwin-patches@cygwin.com>; Sat, 7 Oct 2006 12:13:54 -0700
Content-class: urn:content-classes:message
Subject: RE: Patch to enable proper handling of Win32 //?/GLOBALROOT/device paths
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Oct 2006 19:13:00 -0000
Message-ID: <5DE1FE5AC2164C4BB6BA31575FF42CDA0A4C7F@mutable2.home.mutable.net>
In-Reply-To: <20061007114408.GA4843@calimero.vinschen.de>
From: <d3@mutable.net>
To: <cygwin-patches@cygwin.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00007.txt.bz2

Thanks for the feedback. I've got a few supporting points though that
may shed some more light on this.

On Windows XP the only way to access VSS volumes is by specifying the
temporary and dynamically generated GLOBALROOT path that the VSS COM API
creates for you. You cannot persist and map them to a drive or share
like you can on Server 2003 with the VSS API.=20

I suppose you could map these under in Cygwin with an fhandler if you
had a way to create them. Creating them might be the issue though since
the only name for them will be a dynamically generated //?/GLOBALROOT
path. The VSS COM API will name these on the fly when you create them.
Under Windows XP they are also temporary and only exist for as long as
you hold a reference to the COM API that created them so unless Cygwin
will hold this reference to the COM interface internally, they cannot be
accessed once whatever tool that creates them exits. Furthermore once
you create one, you have to use that COM API to query for this dynamic
GLOBALROOT name. Given their temporary nature, it seems to me for Cygwin
to really support POSIXy VSS mappings it will have to expose APIs for
creating/releasing/managing these that map to the VSS COM API so that a
utility or tool can access this new cygwin API. Perhaps this is a more
POSIXy way to expose them but that is a lot more work than I can sign up
for at this point.

However Cygwin already specifically allows access to the other form of
GLOBALROOT access, //./GLOBALROOT, so you can already access most of the
NT device namespace today. You can use tools like rsync with this form
to access NT volumes right now. Unfortunately VSS volumes are not
accessible under this form, which is why I added support for the
//?/GLOBALROOT form. My patch is just to even out the GLOBALROOT access
that already exists in Cygwin.

With my patch you can use a tool like vshadow.exe to create a snapshot
and then execute a tool like rsync to access them via the dynamic
GLOBALROOT path, which vshadow provides via an environment variable.
=46rom my research into using tools like rsync on Win32, this is exactly
what some people are trying to do as vshadow is known to be the tool
available from MS for creating VSS snapshot volumes on Windows. Trying
to use it with rsync is of course failing though. This patch address
that.


david
=20

> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com [mailto:cygwin-patches-
> owner@cygwin.com] On Behalf Of Corinna Vinschen
> Sent: Saturday, October 07, 2006 4:44 AM
> To: cygwin-patches@cygwin.com
> Subject: Re: Patch to enable proper handling of Win32
> //?/GLOBALROOT/device paths
>=20
> On Oct  6 15:32, d3@mutable.net wrote:
> > This patch is to enable Win32 device paths in the form of:
> >
> > //?/GLOBALROOT/Device/Harddisk0/Partition1/
> > //?/GLOBALROOT/Device/Harddiskvolume1/
> > //?/GLOBALROOT/Device/HarddiskVolumeShadowCopy1/
> >
> > Etc...
> >
> > This patch to cygwin enables tools like rsync to access Win32 volume
> > shadow copies that can be created with Win32 tools like vshadow.exe
so
> > that you can access open files, SQL, and Exchange databases.
> >
> > A note about the change in fhandle_disk_file.cc: The patch enforces
> > Win32 style paths (i.e. backslashes) because the NT kernal functions
do
> > not like mixed paths when accessing \\?\GLOBALROOT. They will only
> > accept backslashes.
> >
> > Here is a rsync test I have been successfully using with this patch
> > applied:
> >
> > rsync -av --modify-window=3D2
> > //?/globalroot/device/harddiskvolume1/testfiles/
server::test/testfiles/
>=20
> Sorry, but I have a hard time to see how accessing GLOBALROOT directly
> would be good for us.  Usually we don't want Cygwin to make more
> concessions related to Windows or NT paths than already necessary.
> These paths should rather only be used under the hood and Cygwin is
> supposed to provide a POSIXy way to access stuff.
>=20
> So, what should the patch accomplish?  Access to harddisks and
> partitions is already possible using POSIX paths, access to files or
> directories, naturally, too.  One new thing here is that you can
access
> the whole NT namespace, which is not very useful, unless you allow
> qualified access.  This in turn requires fhandlers which know the
> devices they are supposed to access, as well as matching POSIX paths.
> Raw access to NT devices is not what Cygwin is designed for(*).
>=20
> The really interesting new thing would be the ability to access volume
> shadow copies.  Opening up GLOBALROOT access just to access shadow
> copies looks rather wrong to me.  Rather there should be a useful
> mapping from the NT paths to POSIX-like paths.  I don't know off-hand
> how these paths would look like(**), though.  I assume the
> implementation could look very similar to the implementation of the
> cygdrive fhandler(***).
>=20
>=20
> Corinna
>=20
>=20
> (*) Though in the long run it could be funny to allow something
similar
>     to generic SCSI access (/dev/sgX).  For instance, the /Device
> directory
>     in the NT namespace could be mapped to /dev/nt/ or something.
>=20
> (**) Is there some shadow copy concept in the POSIX world somewhere?
Does
>     anybody know about this and how device names are constructed for
this
>     access?
>=20
> (***) Please don't forget to sign and send the copyright assignment
form
>     when providing longer patches.  See http://cygwin.com/contrib.html
>=20
> --
> Corinna Vinschen                  Please, send mails regarding Cygwin
to
> Cygwin Project Co-Leader          cygwin AT cygwin DOT com
> Red Hat
