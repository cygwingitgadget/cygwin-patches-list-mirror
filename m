Return-Path: <cygwin-patches-return-1924-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15754 invoked by alias); 27 Feb 2002 22:27:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15725 invoked from network); 27 Feb 2002 22:27:17 -0000
Message-ID: <002c01c1bfde$36552840$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
References: <008901c1b1be$80b36e70$0100a8c0@advent02> <20020210043745.GA5128@redhat.com> <006401c1b998$c106f230$0100a8c0@advent02> <20020219230649.GC4626@redhat.com> <024601c1b9a3$2f8fb700$0100a8c0@advent02> <20020220003104.GD22591@redhat.com> <20020225164230.GA17325@redhat.com> <001301c1be40$647220b0$0100a8c0@advent02> <20020225214630.GD22795@redhat.com> <00b501c1bec2$ae997530$0100a8c0@advent02> <20020227170138.GA2380@redhat.com>
Subject: Re: /proc and /proc/registry
Date: Wed, 27 Feb 2002 15:55:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00281.txt.bz2

> >> 1) The copyrights still need to be changed.
> >Done.
> >> 2) The code formatting still is not correct.
> >Now piped through indent with a few touch-ups.
> >> 3) You have a lot of calls to normalize_posix_path.  Is that really
> >>    necessary?  It seems to be called a lot.  If it is really necessary,
> >>    I'd prefer that it just be called in dtable::build_fhandler and made
> >>    the standard "unix_path_name".
> >Done.
> >> 4) Could you generate the diff using 'cvs diff -up"
> >Done. The new files are diff'ed against /dev/null and are appended to the
> >output of cvs diff.

<--snip-->

> >+  if (*path == 0)
> >+    return FH_PROC;
>
> How could this happen?
This occurs when the path is actually just /proc. Compare with
fhandler_proc::exists which does the same thing.

> >+  int pid = atoi (path);
> >+  winpids pids;
> >+  for (unsigned i = 0; i < pids.npids; i++)
> >+    {
> >+      _pinfo *p = pids[i];
> >+
> >+      if (!proc_exists (p))
> >+        continue;
> >+
> >+      if (p->pid == pid)
> >+        return FH_PROCESS;
> >+    }
> >+  return FH_PROC;
> >+}
>
> Is this right?  If I type /proc/qwerty this returns FH_PROC?
Yes, this is by design. Any path in /proc should be handled by a sub-class
of fhandler_virtual. This way path.cc (chdir/path_conv::check) can call
fhandler_virtual::exists on the path to check whether it actually exists or
not. Arguably FH_BAD could be returned here instead. It's an arbitary
decision so I accept anyone else's opinion.

> >--- /dev/null Tue Feb 26 12:31:06 2002
> >+++ fhandler_virtual.cc Tue Feb 26 11:14:04 2002
> >@@ -0,0 +1,228 @@
> >+DIR *
> >+fhandler_virtual::opendir (path_conv & real_name)
> >+{
> >+  return opendir (get_name());
> >+}
>
> I don't see how this can be right.  Won't this induce infinite recursion?
No - opendir is overloaded in fhandler_virtual. The idea is that virtual
fhandler (i.e. classes that derive from fhandler_virtual) methods
consistently get passed a unix path instead of a reference to a path_conv
instance.

Regards
Chris

