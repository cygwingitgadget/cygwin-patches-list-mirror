From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: `ls A:/foo' can succeed incorrectly.
Date: Thu, 05 Apr 2001 13:45:00 -0000
Message-id: <20010405224504.U956@cygbert.vinschen.de>
References: <s1sn19vqgtv.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00009.html

On Fri, Apr 06, 2001 at 04:36:44AM +0900, Kazuhiro Fujieda wrote:
> `ls A:/foo' can succeed even when the floppy drive has no medium
> on Windows NT/2000.
> 
> 2001-04-06  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
> 
> 	* syscalls.cc (stat_worker): Return error if it fails in the case
> 	specific to NT.
> 
> Index: syscalls.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
> retrieving revision 1.100
> diff -u -p -r1.100 syscalls.cc
> --- syscalls.cc	2001/04/03 02:53:24	1.100
> +++ syscalls.cc	2001/04/05 19:29:00
> @@ -1081,8 +1081,8 @@ stat_worker (const char *caller, const c
>  	    buf->st_nlink = (dtype == DRIVE_REMOTE
>  			     ? 1
>  			     : num_entries (real_path.get_win32 ()));
> -	  goto done;
>  	}
> +      goto done;
>      }
>    if (atts != -1 || (!oret && get_errno () != ENOENT
>  			   && get_errno () != ENOSHARE))

Sorry, but that's not ok. The goto at that point would disallow
falling through when the open fails. I have changed the `if' two
lines below instead:

Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.100
diff -u -p -r1.100 syscalls.cc
--- syscalls.cc 2001/04/03 02:53:24     1.100
+++ syscalls.cc 2001/04/05 20:38:08
@@ -1084,8 +1084,8 @@ stat_worker (const char *caller, const c
          goto done;
        }
     }
-  if (atts != -1 || (!oret && get_errno () != ENOENT
-                          && get_errno () != ENOSHARE))
+  if (atts != -1 && (oret || (!oret && get_errno () != ENOENT
+                                   && get_errno () != ENOSHARE)))
     {
       /* Unfortunately, the above open may fail if the file exists, though.
         So we have to care for this case here, too. */


BTW: That was a funny coincidence. 10 minutes before your mail
arrived in my mailbox I found the same problem with net shares
when my permissions are not sufficient to access that drive. The
above change fixes your and my problem in one go :-)

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
