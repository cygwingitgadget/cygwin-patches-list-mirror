Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by sourceware.org (Postfix) with ESMTPS id 4CDF53861024
 for <cygwin-patches@cygwin.com>; Sun, 14 Mar 2021 00:21:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4CDF53861024
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.201.226] ([89.1.215.248]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzBp-1l3I783D4j-00HxaW; Sun, 14
 Mar 2021 01:21:15 +0100
Date: Sun, 14 Mar 2021 01:21:15 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: Joe Lowe <joe@pismotec.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Treat Windows Store's "app execution aliases" as
 symbolic links
In-Reply-To: <ff661784-ae78-4a98-8f6d-cddd57b0d216@pismotec.com>
Message-ID: <nycvar.QRO.7.76.6.2103140115180.50@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2103121611440.50@tvgsbejvaqbjf.bet>
 <ff661784-ae78-4a98-8f6d-cddd57b0d216@pismotec.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rK8G5Xhg4lk8FuqS+TZ4Tm220v5g16DL2YIlKEpQIg17V0iHNpE
 oWXFoLsp0EQugQpebLUTK/CpuTQnT7I4/OgfhTP8kSSEIR8CQ/T3WfZwuBwOiKMBBOfZtYV
 Zbi5OokM/ay0hBQKwXHz9oJ6UI6t9Y7MrkQ2e3lpDbjLkwCapDXEgRenu49GadK7flotFF/
 CkUd4Xquf/omMUy4xqUpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3ca96oZK/EY=:E66+tyaCcVAMFxTDmFYSfu
 /NTqhg9HF7hp7Ock9a/ROqrqR2zt8pbRN+vfmExYH4aIB0XDiEkDiL5B/dwntoMawKLN50fQ3
 4RaQkDNyXCb0ZNgm6akTWmH4W4desulNjbl511GxegVtz8cQbdRzFQI2ehY+ae+xbuKV7e3r3
 IshyO10+ylgxzHLQklfliNgMyJXQucTzeKEyYATwUh6mOUV7NCzTo0dYKh+p9kPlGk4Svvmu1
 1jW8hqdkUoVnUmanUxRWy1/8Xc6QZlyo2/ogb81A8EmG4kH+yg1NWa38fhtnr1xLjWLgvVkAz
 eU5jCQWiMQcH9hiwuaNLLN3etrYe+rE+Nm1VTeEsfab6a7DSYKm+3+Y9liu13BUPvolnJbdsQ
 2CbgFjpKvFQoHEUHzymbxyhW+cgdsJ3QYzO3LqvJeBQkNrAZigDzmnNYA+HUPkEchfvCD+tEM
 Shw5BfdfYdjzmKwK6kuLpJwGsZozlvx/X8jS9p/ochsTYLEmKOrjDvhOAZQ4Jxi6HBssFSlXF
 AVfRB9giGnvc/yzXCqZ/207OBQ66aZt4C3lW25J/u8zz5Nakmi2neI/CrNh8at9UmS9oXLYmz
 KBxoIJEsvo5Kv2x2SSUHWBuSNX4iL98F4Me+ePQmAFeqk+JZjpELuDgYZAbMTry31XDVhqm25
 2xRIwKVHozvZdUr/MbzB9C0U8w9btCyMU6e47jTYZZM0rcBQN6DjwL9dtBePGq1EWvDFOgAd3
 XcyNL5Vh5TUQDvsVC52VV+Az15oOKJ35yKfCOuadxhuqM43odaHJfHgWswI110qgNz8lHDsTn
 mqVHa3X7T8w/Xf2sUzGahPA+c0JoOiYmMHsXU2d9Gzip5GX71OCoM2B9GAplNXkUIOAHAcmlJ
 U4T2dLHn8bp9uz1PPOBZEyfO2tUfGzD7u91lGb7ec=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, GIT_PATCH_0, MALFORMED_FREEMAIL,
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
X-List-Received-Date: Sun, 14 Mar 2021 00:21:25 -0000

Hi Joe,

On Fri, 12 Mar 2021, Joe Lowe wrote:

> I am skeptical about this patch (part 1), interposing appexec reparse po=
int
> data as symlinks for cygwin applications.
>
> The appexec reparse point data is essentially an extended attribute hold=
ing
> data that is used by CreateProcess(), more like a windows .lnk file or a=
n X11
> .desktop file, not like a posix symlink. M$ just chose an unnecessarily =
obtuse
> way to store the files data. This reminds me of old Macintosh zero lengt=
h font
> files.

The obvious difference being that you cannot read those 0-length files.
And you _can_ determine the target from reading .lnk or .desktop files.

> The useful function of the patch would seem to be as a way to display a
> portion of the data in shell directory listings for the user. I suggest =
this
> function is better provided by updated application code.

I find your argument unconvincing.

For all practical purposes, users are likely to want to treat app
execution aliases as if they were symbolic links.

If users want to know more about the app execution alias than just the
path of the actual `.exe` (and that is a rather huge if), _then_ I would
buy your argument that it should be queried via application code.

But for the common case of reading the corresponding `.exe` or accessing
the path? Why should we follow your suggestion and keep making it really
hard for users to get to that information? I really don't get it.

Ciao,
Johannes

>
>
> The patch part 2 seems entirely appropriate.
>
>
> Joe L.
>
>
> On 2021-03-12 07:11, Johannes Schindelin via Cygwin-patches wrote:
> > When the Windows Store version of Python is installed, so-called "app
> > execution aliases" are put into the `PATH`. These are reparse points
> > under the hood, with an undocumented format.
> >
> > We do know a bit about this format, though, as per the excellent analy=
sis:
> > https://www.tiraniddo.dev/2019/09/overview-of-windows-execution-aliase=
s.html
> >
> >  The first 4 bytes is the reparse tag, in this case it's
> >  0x8000001B which is documented in the Windows SDK as
> >  IO_REPARSE_TAG_APPEXECLINK. Unfortunately there doesn't seem to
> >  be a corresponding structure, but with a bit of reverse
> >  engineering we can work out the format is as follows:
> >
> >  Version: <4 byte integer>
> >  Package ID: <NUL Terminated Unicode String>
> >  Entry Point: <NUL Terminated Unicode String>
> >  Executable: <NUL Terminated Unicode String>
> >  Application Type: <NUL Terminated Unicode String>
> >
> > Let's treat them as symbolic links. For example, in this developer's
> > setup, this will result in the following nice output:
> >
> >  $ cd $LOCALAPPDATA/Microsoft/WindowsApps/
> >
> >  $ ls -l python3.exe
> >  lrwxrwxrwx 1 me 4096 105 Aug 23  2020 python3.exe -> '/c/Program
> >  Files/WindowsApps/PythonSoftwareFoundation.Python.3.7_3.7.2544.0_x64_=
_qbz5n2kfra8p0/python.exe'
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >   winsup/cygwin/path.cc | 24 ++++++++++++++++++++++++
> >   1 file changed, 24 insertions(+)
> >
> > diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> > index f3b9913bd0..63f377efb1 100644
> > --- a/winsup/cygwin/path.cc
> > +++ b/winsup/cygwin/path.cc
> > @@ -2538,6 +2538,30 @@ check_reparse_point_target (HANDLE h, bool remo=
te,
> > PREPARSE_DATA_BUFFER rp,
> >          if (check_reparse_point_string (psymbuf))
> >    return PATH_SYMLINK | PATH_REP;
> >       }
> > +  else if (!remote && rp->ReparseTag =3D=3D IO_REPARSE_TAG_APPEXECLIN=
K)
> > +    {
> > +      /* App execution aliases are commonly used by Windows Store app=
s. */
> > +      WCHAR *buf =3D (WCHAR *)(rp->GenericReparseBuffer.DataBuffer + =
4);
> > +      DWORD size =3D rp->ReparseDataLength / sizeof(WCHAR), n;
> > +
> > +      /*
> > +         It seems that app execution aliases have a payload of four
> > +	 NUL-separated wide string: package id, entry point, executable
> > +	 and application type. We're interested in the executable. */
> > +      for (int i =3D 0; i < 3 && size > 0; i++)
> > +        {
> > +	  n =3D wcsnlen (buf, size - 1);
> > +	  if (i =3D=3D 2 && n > 0 && n < size)
> > +	    {
> > +	      RtlInitCountedUnicodeString (psymbuf, buf, n * sizeof(WCHAR));
> > +	      return PATH_SYMLINK | PATH_REP;
> > +	    }
> > +	  if (i =3D=3D 2)
> > +	    break;
> > +	  buf +=3D n + 1;
> > +	  size -=3D n + 1;
> > +	}
> > +    }
> >     else if (rp->ReparseTag =3D=3D IO_REPARSE_TAG_LX_SYMLINK)
> >       {
> >         /* WSL symlink.  Problem: We have to convert the path to UTF-1=
6 for
> > --
> > 2.30.2
> >
>
>
