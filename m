Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by sourceware.org (Postfix) with ESMTPS id F19283858022
 for <cygwin-patches@cygwin.com>; Mon, 15 Mar 2021 12:18:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org F19283858022
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.201.226] ([213.196.212.127]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOzT4-1l5CjT2faG-00PQtj; Mon, 15
 Mar 2021 13:18:15 +0100
Date: Mon, 15 Mar 2021 04:19:04 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: Joe Lowe <joe@pismotec.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Treat Windows Store's "app execution aliases" as
 symbolic links
In-Reply-To: <86c7c1b6-06f9-9e60-e9d7-072b6e8c806f@pismotec.com>
Message-ID: <nycvar.QRO.7.76.6.2103150408230.50@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2103121611440.50@tvgsbejvaqbjf.bet>
 <ff661784-ae78-4a98-8f6d-cddd57b0d216@pismotec.com>
 <nycvar.QRO.7.76.6.2103140115180.50@tvgsbejvaqbjf.bet>
 <86c7c1b6-06f9-9e60-e9d7-072b6e8c806f@pismotec.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6aAt9f+dKM1T94kkKvG3GEg9WyZdIzBvnNZOg3EZY3h7kKI5kIo
 sRSn/m+WdZript7oQ+Ea4aBjy/MMyx4818fIcQ7SZkrKjmzwoL8ZD0NaLSdid8L//zZ9gWm
 kAO3gPosdUz19VK/nqUe6TPVkM486xptxGQWNP+4uAjNW76vcaxZUYCkxDdStL8jONQUBnL
 F44AlPTnTenl/LAPktzDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SMwt1A8TMSk=:wd/uDF9djDLflSTMSFAWka
 RdmKfjPUMk75ic5KqZ12//tUS+Uc6bmTuIhPlMOmi8+a7pEEw1Us4l7/wMLvezfqnmfzR9a/+
 CcuRZ/vsoSKuEVIq3hjZF7KO5TjUTs9iDnHRyB1zuDKZU/iPZcP05lh7R//5ScqOrbyJfkiXD
 dccuWibYscf85QyBqS2FTInTl1jrLovqgyqFQJZ76+cMcztBXh0++GyOkzKvgzAY6f1XxcWRs
 pE4YefS7oZAiAn2nR1CvoGL1k0ur/3TuyvxlHBNS3h193b0b7M/vdGtET/GO0/wx8gX/EcvCf
 EDRe0q7OZv0mK4eDlRXBqS8FnefiD3DLtufx25EO4OkR4c4IT8HkEq+LpvooQJuEbbEpRZmsm
 ja6j+OKNQiINTYAJ2iGUwUWyJ4RRcbw6KQ13SKPOvl1QOhAXckIsBKEv+/PXaHwhWs0NyuJ4Q
 gyWZj+Dp/pQN2FJgvmunsTgeMTcAK/y1SKE2fwMmt5VXBbY9XtENfuz5YVnMhTkFSZ8CmhxVa
 sH19ZuXgUf9RfqvyZRNqVgNd90WOY54a78IxMXb8FiyzWwdesO5FwWI+BtORU6pmXrusz8Rsj
 qGWKdQdNRUgFMPHyPmNS4WrIosCTHNWN2TBDwQQjZEOMnuoObVP80qN8hhQcGiqsYzbQatJfG
 J2vg8rlJgbhO2ONp1QOdKjdfXHRNxrpXKE79edLTLHHeGhw1MZs5xej6LMEbkDW2Euf++JKbC
 UtRS3DKzHV13MB2OnkhICxUjle0NqBzZR2Z5GgLeUAOuB+8ykCM3x0hL3pKc8i1K288qcZ2qB
 MJtom1+/qwh0iNMg4Xy0HzJJau3xUzHb97G1qH/blei6F5nVe4HbL6PVo74yaCMugq7gk4nmv
 HpEsiDXjECCH3ZGL0qgvKrENDPAmEosR+QF1pRDdI=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00, DATE_IN_PAST_06_12,
 DKIM_SIGNED, DKIM_VALID, FREEMAIL_FROM, GIT_PATCH_0, MALFORMED_FREEMAIL,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 15 Mar 2021 12:18:25 -0000

Hi Joe,

On Sat, 13 Mar 2021, Joe Lowe wrote:

> I agree on the usefulness to the user of showing appexec target executab=
le as
> symlink target. But I am uncertain about the effect on code.

Maybe. But I am concerned about the effect of not being able to do
anything useful with app execution aliases in the first place. I'd rather
have them represented as if they were symlinks (even if that is not 100%
accurate) than not being able to even answer the very simple (and
obvious!) question: where does this thing point to?

> One example: Any app that is able to archive/copy posix symlinks will co=
nvert
> the appexec to a symlink and silently drop the appexec data. Whether thi=
s is a
> significant issue depends on if most/all relevent store apps function th=
e same
> when the executable is exec-ed directly vs via the appexec link.

I do have bad news for you: WSL symlinks are _already_ supported
(https://github.com/cygwin/cygwin/blob/d10d0d9b03f85/winsup/cygwin/path.cc=
#L2561-L2630),
and just like app execution aliases, they are not faithfully recreated.

Likewise junctions:
https://github.com/cygwin/cygwin/blob/d10d0d9b03f85/winsup/cygwin/path.cc#=
L2540-L2560

This suggests to me that the endeavor to have archive/copy programs based
on Cygwin's runtime work as you expect is doomed from the start.

> Another example: Much code exists in the field that intentionally detect=
s
> symlinks, dereferences, and works directly on the target. This may not b=
e an
> issue, if most/all relevent store apps function the same when the execut=
able
> is exec-ed directly vs via the appexec link.

As far as I can tell, the only thing you _can_ do with an app execution
alias (apart from creating/deleting it) is to execute it. If you try to
read or write them, you get a "Permission denied".

Their intended use case seems to be the same as Debian Alternatives
(https://wiki.debian.org/DebianAlternatives) which _are_ implemented as
symbolic links.

So I still think that the best we can do with app execution aliases in
Cygwin is to display them as if they were plain old symbolic links.

Ciao,
Johannes

>
>
> Joe L.
>
>
>
> On 3/13/2021 4:21 PM, Johannes Schindelin wrote:
> > Hi Joe,
> >
> > On Fri, 12 Mar 2021, Joe Lowe wrote:
> >
> > > I am skeptical about this patch (part 1), interposing appexec repars=
e
> > > point
> > > data as symlinks for cygwin applications.
> > >
> > > The appexec reparse point data is essentially an extended attribute
> > > holding
> > > data that is used by CreateProcess(), more like a windows .lnk file =
or an
> > > X11
> > > .desktop file, not like a posix symlink. M$ just chose an unnecessar=
ily
> > > obtuse
> > > way to store the files data. This reminds me of old Macintosh zero l=
ength
> > > font
> > > files.
> >
> > The obvious difference being that you cannot read those 0-length files=
.
> > And you _can_ determine the target from reading .lnk or .desktop files=
.
> >
> > > The useful function of the patch would seem to be as a way to displa=
y a
> > > portion of the data in shell directory listings for the user. I sugg=
est
> > > this
> > > function is better provided by updated application code.
> >
> > I find your argument unconvincing.
> >
> > For all practical purposes, users are likely to want to treat app
> > execution aliases as if they were symbolic links.
> >
> > If users want to know more about the app execution alias than just the
> > path of the actual `.exe` (and that is a rather huge if), _then_ I wou=
ld
> > buy your argument that it should be queried via application code.
> >
> > But for the common case of reading the corresponding `.exe` or accessi=
ng
> > the path? Why should we follow your suggestion and keep making it real=
ly
> > hard for users to get to that information? I really don't get it.
> >
> > Ciao,
> > Johannes
> >
> > >
> > >
> > > The patch part 2 seems entirely appropriate.
> > >
> > >
> > > Joe L.
> > >
> > >
> > > On 2021-03-12 07:11, Johannes Schindelin via Cygwin-patches wrote:
> > > > When the Windows Store version of Python is installed, so-called "=
app
> > > > execution aliases" are put into the `PATH`. These are reparse poin=
ts
> > > > under the hood, with an undocumented format.
> > > >
> > > > We do know a bit about this format, though, as per the excellent
> > > > analysis:
> > > > https://www.tiraniddo.dev/2019/09/overview-of-windows-execution-al=
iases.html
> > > >
> > > >   The first 4 bytes is the reparse tag, in this case it's
> > > >   0x8000001B which is documented in the Windows SDK as
> > > >   IO_REPARSE_TAG_APPEXECLINK. Unfortunately there doesn't seem to
> > > >   be a corresponding structure, but with a bit of reverse
> > > >   engineering we can work out the format is as follows:
> > > >
> > > >   Version: <4 byte integer>
> > > >   Package ID: <NUL Terminated Unicode String>
> > > >   Entry Point: <NUL Terminated Unicode String>
> > > >   Executable: <NUL Terminated Unicode String>
> > > >   Application Type: <NUL Terminated Unicode String>
> > > >
> > > > Let's treat them as symbolic links. For example, in this developer=
's
> > > > setup, this will result in the following nice output:
> > > >
> > > >   $ cd $LOCALAPPDATA/Microsoft/WindowsApps/
> > > >
> > > >   $ ls -l python3.exe
> > > >   lrwxrwxrwx 1 me 4096 105 Aug 23  2020 python3.exe -> '/c/Program
> > > >   Files/WindowsApps/PythonSoftwareFoundation.Python.3.7_3.7.2544.0=
_x64__qbz5n2kfra8p0/python.exe'
> > > >
> > > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > > ---
> > > >    winsup/cygwin/path.cc | 24 ++++++++++++++++++++++++
> > > >    1 file changed, 24 insertions(+)
> > > >
> > > > diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> > > > index f3b9913bd0..63f377efb1 100644
> > > > --- a/winsup/cygwin/path.cc
> > > > +++ b/winsup/cygwin/path.cc
> > > > @@ -2538,6 +2538,30 @@ check_reparse_point_target (HANDLE h, bool
> > > > remote,
> > > > PREPARSE_DATA_BUFFER rp,
> > > >           if (check_reparse_point_string (psymbuf))
> > > >     return PATH_SYMLINK | PATH_REP;
> > > >        }
> > > > +  else if (!remote && rp->ReparseTag =3D=3D IO_REPARSE_TAG_APPEXE=
CLINK)
> > > > +    {
> > > > +      /* App execution aliases are commonly used by Windows Store=
 apps.
> > > > */
> > > > +      WCHAR *buf =3D (WCHAR *)(rp->GenericReparseBuffer.DataBuffe=
r + 4);
> > > > +      DWORD size =3D rp->ReparseDataLength / sizeof(WCHAR), n;
> > > > +
> > > > +      /*
> > > > +         It seems that app execution aliases have a payload of fo=
ur
> > > > +	 NUL-separated wide string: package id, entry point, executable
> > > > +	 and application type. We're interested in the executable. */
> > > > +      for (int i =3D 0; i < 3 && size > 0; i++)
> > > > +        {
> > > > +	  n =3D wcsnlen (buf, size - 1);
> > > > +	  if (i =3D=3D 2 && n > 0 && n < size)
> > > > +	    {
> > > > +	      RtlInitCountedUnicodeString (psymbuf, buf, n * sizeof(WCHA=
R));
> > > > +	      return PATH_SYMLINK | PATH_REP;
> > > > +	    }
> > > > +	  if (i =3D=3D 2)
> > > > +	    break;
> > > > +	  buf +=3D n + 1;
> > > > +	  size -=3D n + 1;
> > > > +	}
> > > > +    }
> > > >      else if (rp->ReparseTag =3D=3D IO_REPARSE_TAG_LX_SYMLINK)
> > > >        {
> > > >          /* WSL symlink.  Problem: We have to convert the path to =
UTF-16
> > > > for
> > > > --
> > > > 2.30.2
> > > >
> > >
> > >
>
