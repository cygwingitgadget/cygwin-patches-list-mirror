From: Christopher Faylor <cgf@redhat.com>
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Subject: Re: getsockopt() SO_ERROR optval mapping
Date: Mon, 02 Apr 2001 13:19:00 -0000
Message-id: <20010402162019.A5358@redhat.com>
References: <20010402150827.G798@dothill.com>
X-SW-Source: 2001-q2/msg00004.html

On Mon, Apr 02, 2001 at 03:08:27PM -0400, Jason Tishler wrote:
>This patch maps getsockopt() SO_ERROR optval's from their Winsock versions to
>their corresponding errno versions.  This prevents strerror(optval) from
>generating cryptic messages like:
>
>    error 10061
>
>instead of:
>
>    Connection refused
>
>Mon Apr  2 14:58:53 2001  Jason Tishler <jt@dothill.com>
>
>	* net.cc (cygwin_getsockopt): Add SO_ERROR support -- specifically,
>	the mapping of Winsock optval's to their corresponding errno versions.

Thanks for the patch.  I'd rather keep the errno processing localized,
though.

Does this patch accomplish the same thing?

cgf

Index: net.cc
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/net.cc,v
retrieving revision 1.43
diff -u -p -r1.43 net.cc
--- net.cc	2001/03/20 19:50:28	1.43
+++ net.cc	2001/04/02 19:53:26
@@ -247,26 +247,24 @@ static struct tl errmap[] =
  {0, NULL, 0}
 };
 
+static int
+find_winsock_errno (int why)
+{
+  for (int i = 0; errmap[i].w != 0; ++i)
+    if (why == errmap[i].w)
+      return errmap[i].e;
+
+  return EPERM;
+}
+
 /* Cygwin internal */
 void
 __set_winsock_errno (const char *fn, int ln)
 {
-  int i;
-  int why = WSAGetLastError ();
-  for (i = 0; errmap[i].w != 0; ++i)
-    if (why == errmap[i].w)
-      break;
-
-  if (errmap[i].w != 0)
-    {
-      syscall_printf ("%s:%d - %d (%s) -> %d", fn, ln, why, errmap[i].s, errmap[i].e);
-      set_errno (errmap[i].e);
-    }
-  else
-    {
-      syscall_printf ("%s:%d - unknown error %d", fn, ln, why);
-      set_errno (EPERM);
-    }
+  DWORD werr = WSAGetLastError ();
+  int err = find_winsock_errno (werr);
+  set_errno (err);
+  syscall_printf ("%s:%d - winsock error %d -> errno %d", fn, ln, werr, err);
 }
 
 /*
@@ -524,6 +522,9 @@ cygwin_setsockopt (int fd,
 	case SO_OOBINLINE:
 	  name="SO_OOBINLINE";
 	  break;
+	case SO_ERROR:
+	  name="SO_ERROR";
+	  break;
 	}
 
       res = setsockopt (h->get_socket (), level, optname,
@@ -584,10 +585,19 @@ cygwin_getsockopt (int fd,
 	case SO_OOBINLINE:
 	  name="SO_OOBINLINE";
 	  break;
+	case SO_ERROR:
+	  name="SO_ERROR";
+	  break;
 	}
 
       res = getsockopt (h->get_socket (), level, optname,
 				       (char *) optval, (int *) optlen);
+
+      if (optname == SO_ERROR)
+	{
+	  int *e = (int *) optval;
+	  *e = find_winsock_errno (*e);
+	}
 
       if (res)
 	set_winsock_errno ();
