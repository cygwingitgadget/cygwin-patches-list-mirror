From: DJ Delorie <dj@delorie.com>
To: Jason.Tishler@dothill.com
Cc: cygwin-patches@sourceware.cygnus.com
Subject: Re: [Jason.Tishler@dothill.com: Strange Cygwin 1.1.1 mv Behavior]
Date: Tue, 23 May 2000 12:23:00 -0000
Message-id: <200005231923.PAA24195@envy.delorie.com>
References: <20000523143453.B22579@cygnus.com>
X-SW-Source: 2000-q2/msg00077.html

> After upgrading from 1.1.0 to 1.1.1, I started to experience problems
> using relative pathnames with mv when in my home directory:
> 
>     $ pwd
>     /home/jt
>     $ ls .foo 
>     .foo
>     $ mv .foo .foo2 
>     mv: cannot move `.foo' to `.foo2': No such file or directory

Try this, which I'll check in in a moment (i.e. it will be in the next
snapshot also):

2000-05-23  DJ Delorie  <dj@cygnus.com>

	* dir.cc (writable_directory): handle root directories

Index: dir.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
retrieving revision 1.2
diff -p -3 -r1.2 dir.cc
*** dir.cc	2000/05/22 17:15:47	1.2
--- dir.cc	2000/05/23 19:20:25
*************** writable_directory (const char *file)
*** 31,36 ****
--- 31,40 ----
    char *slash = strrchr (dir, '\\');
    if (slash == NULL)
      usedir = ".";
+   else if (slash == dir)
+     {
+       usedir = "\\";
+     }
    else
      {
        *slash = '\0';
