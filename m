Return-Path: <cygwin-patches-return-8250-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40007 invoked by alias); 20 Oct 2015 11:47:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39985 invoked by uid 89); 20 Oct 2015 11:47:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.0 required=5.0 tests=AWL,BAYES_50,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=no version=3.3.2
X-Spam-User: qpsmtpd, 2 recipients
X-HELO: mout.gmx.net
Received: from mout.gmx.net (HELO mout.gmx.net) (212.227.17.20) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 20 Oct 2015 11:47:12 +0000
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0LorB9-1aUAqm40mR-00glkA; Tue, 20 Oct 2015 13:47:07 +0200
Date: Tue, 20 Oct 2015 11:47:00 -0000
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Introduce the 'usertemp' filesystem type
In-Reply-To: <20151020093741.GA17374@calimero.vinschen.de>
Message-ID: <alpine.DEB.1.00.1510201251140.31610@s15462909.onlinehome-server.info>
References: <0MIuft-1ZZdDB2IaP-002Y2r@mail.gmx.com> <20151020093741.GA17374@calimero.vinschen.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UI-Out-Filterresults: notjunk:1;V01:K0:2Z7r6Has2AY=:BGeTpFpeWGx3ttQ0EWXoVL vLF2MvaBjA1WXVtooA5b9xrB6KNsQDDM3pnqZnpuuXG+oIRhMu6jNV5VQUDYaYPs4lYDjYQYN mWApt68EclYANHWUj160ZkKfJsaGEB1HhPtAuTLDNsOjETNqGnLxWOjHgnwlb0tkW9a3064Cf 6HJXJgyOKErkDatbDO5YyxIQCPyG5LCICKhd7PG4HLd27RLElHoHPflN5EEdtOFLu97CLbRVv WqpFPN04kNEORp8l5jnYmdCJqtKaeqSleaOhTjAAV7Pgtxl3HrX3S4FYhjTdqmZtQIT7ppolt ios9hrW7x0/7UByp0X6IEgy/t/e4g0WLbdVIPyb9wW+tOOczNzQIW7NKwV+N8t8TTAlWYc5T7 9W3kugl/F/Gzel4H0Bbk+F6IK+VHOlgFNC8UjrE+mC6txIBLJdg4Poygq1hbamJ0uy5IP4pdK 9DhSMoOwr0sMSPItK8EgMuZFxX4q3fOQ8ApfKMyuUSdGgUCalRtDB34rTZ1kN1QR2C6HyjNYw +uiF/7LNkuiHE7VaZ1p2/Bn2+SnzbVDig+QusfLnho5BpGpLj2YSKoGPVF2DPNtz8u/801VYt FeYMlU/PAy2Onanx0tC4evYB42rU5OfyD/vel6wht3bW4t0kqWx+wUiCQePAfFmWmWZ0bsnGE H16oY4vi4QF5G6zLKkHpEav2SyDhf/4N/jEqLn8+xw3Pw0NwTgPwF6WWbyf95XeQdd/DhnKDY 9cX6qPmjPChD2FaJBlnB/w26mCFf+71bPieQF+Zi2AERyPGSzr2qXOKQRmB3KmD1aknpRMBSS BMCeuHS
X-IsSubscribed: yes
X-SW-Source: 2015-q4/txt/msg00003.txt.bz2

Hi Corinna,

On Tue, 20 Oct 2015, Corinna Vinschen wrote:

> Preliminaries: we need a copyright assignment from you before being able
> to include your patches.  Please see https://cygwin.com/assign.txt.

Thanks for pointing that out. It is in the works.

> On Sep 16 09:35, Johannes Schindelin wrote:
> > 	* mount.cc (mount_info::from_fstab_line): support mounting the
> > 	current user's temp folder as /tmp/. This is particularly
> > 	useful a feature when Cygwin's own files are write-protected.
> > 
> > 	* pathnames.xml: document the new usertemp file system type

BTW I thought this would be the preferred form of the ChangeLog entry: as
part of the commit message. At least that is how I interpreted this part:

	ChangeLogs should not be sent as "diffs". Just send the complete
	ChangeLog entry, which is ideally part of the output of
	`git format-patch' anyway.

of https://cygwin.com/contrib.html

> > By specifying
> > 
> > 	none /tmp usertemp binary,posix=0 0 0
> > 
> > in /etc/fstab, the /tmp/ directory gets auto-mounted to the directory
> > specified by the %TEMP% variable.
> 
> In theory you could also utilize /etc/fstab.d/$USER, without the need to
> implement a usertemp mount type.

This is unfortunately not possible. The use case that triggered this patch
is Git for Windows (which does not use Cygwin directly, but the MSys2
runtime which is derived from Cygwin). In that case, we really want to
install the program either into C:\Program Files or onto a USB stick and
the /tmp/ directory needs to refer to $TEMP no matter what, even if a
previously unseen user starts it (which of course precludes the use of
/etc/fstab.d/$USER).

> > This feature comes handy in particularly in scenarios where the
> > administrator might want to write-protect the entire Cygwin directory
> > yet still needs to allow users to write into the /tmp/ directory.
> > This is the case in the context of Git for Windows, where the
> > Cygwin (MSys2) root directory lives inside C:\Program Files and hence
> > /tmp/ would not be writable otherwise.
> 
> You are aware that this breaks interoperability in some cases where
> files are shared in /tmp, right?

Yes. These cases do not occur in the context of Git for Windows.

Please also note that I took pains to make this an opt-in feature. It
should not be used by default in any Cygwin installation, but I think it
would be nice for power users to have the *option* to use it.

The thing is: Cygwin's /tmp/ might be reused by processes running as
different users, but the user temp can be reused by processes of the
*same* user, whether the processes are Cygwin or not. Which is another
nice thing to have in some scenarios.

> It's very important to stress the fact that one user's /tmp is not the
> same as another user's /tmp when working on the same machine in this
> scenario, e.g. via terminal services.

Indeed. In Git for Windows' case, this is actually a feature. That way,
different users' files are encapsulated from each other.

> X server sockets won't be in the expected place, etc.  Also, what about
> /var/tmp, /var/log, /var/run, /dev/mqueue, /dev/shm?

Git for Windows is intended to be used as an individual application,
without any daemons. So the idea that programs started by the user need to
write into the pseudo root file system does not apply here.

> Creating this kind of mount type only solves part of the problem in this
> scenario.  If the Admins insist to install the Cygwin directory
> structure in an unexpected way, a full solution appears to be much more
> extensive.

Git for Windows comes with its own installer that already takes care of
the configuration. If any admin insists to do things differently, they are
on their own.

> Wouldn't it be simpler to install a generic, writable temp dir and just
> point to it via standard mount point?

As I said, in a multi-user setting, or even worse: in a portable
application, this is simply not possible other than via the strategy
implemented by this patch.

> - The ChangeLog entry is missing.

See above. Do you want me to include the diff to winsup/cygwin/ChangeLog?

> > diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
> > index 6cf3ddf..0b3dbdc 100644
> > --- a/winsup/cygwin/mount.cc
> > +++ b/winsup/cygwin/mount.cc
> > @@ -1163,6 +1165,21 @@ mount_info::from_fstab_line (char *line, bool user)
> >        slashify (posix_path, cygdrive, 1);
> >        cygdrive_len = strlen (cygdrive);
> >      }
> > +  else if (!strcmp (fs_type, "usertemp"))
> > +    {
> > +      WCHAR tmp[MAX_PATH];
> > +
> > +      if (GetEnvironmentVariableW (L"TEMP", tmp, sizeof(tmp)) && *tmp)
> 
> - Maybe using GetTempPathW instead?  It always returns a path.

Good idea! It *does* respect the TMP variable, falling back to TEMP and
then USERPROFILE. I was worried for a moment that the user could no longer
override the behavior by setting an environment variable explicitly.

> > +	{
> > +          DWORD len;
> > +          char mb_tmp[len = sys_wcstombs (NULL, 0, tmp)];
> 
> - len = sys_wcstombs() + 1

Whoops. I always get that wrong.

But... actually... Did you know that `sys_wcstombs()` returns something
different than advertised? The documentation says:

	- dst == NULL; len is ignored, the return value is the number
	  of bytes required for the string without the trailing NUL, just
	  like the return value of the wcstombs function.

But when I call

	small_printf("len of 1: %d\n", sys_wcstombs(NULL, 0, L"1"));

it prints "len of 1: 2", i.e. the number of bytes requires for the string
*with* the trailing NUL, disagreeing with the comment in strfuncs.cc.

So that is why this patch works.

BTW I realized that the 3-parameter version of sys_wcstombs() does
something different than advertised when working on a fix for the other
patch I submitted to cygwin-patches:

	https://github.com/git-for-windows/msys2-runtime/commit/e87aaa7d5

How do you want to proceed from here? Should I fix sys_wcstombs() when the
fourth parameter is -1? Or is this not a fix, but I would rather break
things?

>   Alternatively, use tmp_pathbuf:
> 
>   tmp_pathbuf tp;
>   char mb_tmp = tp.c_get ();

Sure, that would work, too.

> > +          sys_wcstombs (mb_tmp, len, tmp);
> > +
> > +	  int res = mount_table->add_item (mb_tmp, posix_path, mount_flags);
> > +	  if (res && get_errno () == EMFILE)
> > +	    return false;
> > +	}
> > +    }
> >    else
> >      {
> >        int res = mount_table->add_item (native_path, posix_path, mount_flags);
> 
> - What about adding a mount flags to allow fillout_mntent to print out
>   the mount type?  This isn't essential, I'm just wondering if there
>   might be a good reason to see the type in mount(1) output.

You mean something like this?

-- snip --
diff --git a/winsup/cygwin/include/sys/mount.h
b/winsup/cygwin/include/sys/mount.h
index 458cf80..ec92794 100644
--- a/winsup/cygwin/include/sys/mount.h
+++ b/winsup/cygwin/include/sys/mount.h
@@ -44,7 +44,8 @@ enum
   MOUNT_DOS =		0x40000,	/* convert leading spaces and
trailing
 					   dots and spaces to private use
area */
   MOUNT_IHASH =		0x80000,	/* Enforce hash values for
inode numbers */
-  MOUNT_BIND =		0x100000	/* Allows bind syntax in fstab
   file. */
+  MOUNT_BIND =		0x100000,	/* Allows bind syntax in fstab
file. */
+  MOUNT_USER_TEMP =	0x200000	/* Mount the user's $TMP. */
 };
 
 int mount (const char *, const char *, unsigned __flags);
diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
index e37ad16..4340cc4 100644
--- a/winsup/cygwin/mount.cc
+++ b/winsup/cygwin/mount.cc
@@ -1184,6 +1184,7 @@ mount_info::from_fstab_line (char *line, bool user)
           char mb_tmp[len = sys_wcstombs (NULL, 0, tmp)];
           sys_wcstombs (mb_tmp, len, tmp);
 
+	  mount_flags |= MOUNT_USER_TEMP;
 	  int res = mount_table->add_item (mb_tmp, posix_path,
mount_flags);
 	  if (res && get_errno () == EMFILE)
 	    return false;
@@ -1771,6 +1772,9 @@ fillout_mntent (const char *native_path, const char
*posix_path, unsigned flags)
   if (flags & (MOUNT_BIND))
     strcat (_my_tls.locals.mnt_opts, (char *) ",bind");
 
+  if (flags & (MOUNT_USER_TEMP))
+    strcat (_my_tls.locals.mnt_opts, (char *) ",usertemp");
+
   ret.mnt_opts = _my_tls.locals.mnt_opts;
 
   ret.mnt_freq = 1;
-- snap --

Yep, good idea!

Thank you,
Johannes
