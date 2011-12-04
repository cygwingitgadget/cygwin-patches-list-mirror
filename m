Return-Path: <cygwin-patches-return-7550-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5102 invoked by alias); 4 Dec 2011 20:17:34 -0000
Received: (qmail 5092 invoked by uid 22791); 4 Dec 2011 20:17:32 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_MK
X-Spam-Check-By: sourceware.org
Received: from mail-pz0-f43.google.com (HELO mail-pz0-f43.google.com) (209.85.210.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 04 Dec 2011 20:17:18 +0000
Received: by dadz13 with SMTP id z13so4483815dad.2        for <cygwin-patches@cygwin.com>; Sun, 04 Dec 2011 12:17:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.68.33.163 with SMTP id s3mr17028160pbi.64.1323029837751; Sun, 04 Dec 2011 12:17:17 -0800 (PST)
Received: by 10.68.50.66 with HTTP; Sun, 4 Dec 2011 12:17:17 -0800 (PST)
In-Reply-To: <CAL-4N9uVjoqNTXPQGvsjnT+q=KJx9_QNzT-m8U_K=46+zOyheQ@mail.gmail.com>
References: <CAL-4N9uVjoqNTXPQGvsjnT+q=KJx9_QNzT-m8U_K=46+zOyheQ@mail.gmail.com>
Date: Sun, 04 Dec 2011 20:17:00 -0000
Message-ID: <CAHWeT-a0uH9_qvE9jPWVq7GJ_g2gm8_-JDeQRZ2Nhp3C5iSpAA@mail.gmail.com>
Subject: Re: Add support for creating native windows symlinks
From: Andy Koppe <andy.koppe@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q4/txt/msg00040.txt.bz2

On 4 December 2011 07:07, Russell Davis wrote:
> This was discussed before here:
> http://cygwin.com/ml/cygwin/2008-03/msg00277.html
>
> These were the reasons given for not using native symlinks to create
> cygwin symlinks, along with my responses:
>
> - By default, only administrators have the right to create native
> =C2=A0 symlinks.=C2=A0 Admins running with restricted permissions under U=
AC don't
> =C2=A0 have this right.
>
> This is true, however the feature can be made optional through the
> CYGWIN environment variable (just like winsymlinks). For users that
> can add the permission or disable UAC, the use of native symlinks is a
> huge step towards making cygwin more unified with the rest of Windows.
>
> - When creating a native symlink, you have to define if this symlink
> =C2=A0 points to a file or a directory.=C2=A0 This makes no sense given t=
hat
> =C2=A0 symlinks often are created before the target they point to.
>
> Also true. However, the type only matters for Windows' usage of the
> symlink -- cygwin already treats both the types the same. For example,
> if a native symlink of type `file` actually points to a directory, it
> will still work fine inside cygwin. It won't work for Win32 programs
> that try to access it, but that's still no worse than the status quo
> -- Win32 programs already can't use cygwin symlinks.
>
> Since cygwin already supports reading of native symlinks, I was able
> to add support for this with a fairly small change. Some edge cases
> probably still need to be handled (disabling for older versions of
> windows and unsupported file systems), but I wanted to get this out
> there for review. The patch is attached.

Those aren't all the issues with using native symlinks as Cygwin
symlinks. POSIX symlinks of course are supposed to point to POSIX
paths, whereas native links point to Windows paths, with the following
consequences:

- Native links can't point to special Cygwin paths such as /proc and
/dev, although I guess that could be fudged.
- If the meaning of the POSIX path changes due to Cygwin mount point
changes, native symlinks won't reflect that and point to the wrong
thing.
- Native relative links can't cross drive boundaries, whereas relative
POSIX paths can reach the whole filesystem.

I think the better approach here is to have an ln-like utility that
creates Windows symlinks, as proposed by Daniel Colascione at
http://cygwin.com/ml/cygwin/2011-04/msg00059.html. Perhaps it could be
added to cygutils if it was knocked into appropriate shape. (The main
advantage over using Windows facilities, in particular cmd.exe's
mklink builtin, would be an ln-like interface and Cygwin charset
support.)

Andy
