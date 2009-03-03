Return-Path: <cygwin-patches-return-6422-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18167 invoked by alias); 3 Mar 2009 12:01:57 -0000
Received: (qmail 17431 invoked by uid 22791); 3 Mar 2009 12:01:54 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 03 Mar 2009 12:01:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id B53616D418D; Tue,  3 Mar 2009 13:01:34 +0100 (CET)
Date: Tue, 03 Mar 2009 12:01:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] gethostbyname2  again
Message-ID: <20090303120134.GR10046@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0KFW0072QPTQUMJ2@vms173001.mailsrvcs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0KFW0072QPTQUMJ2@vms173001.mailsrvcs.net>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2009-q1/txt/msg00020.txt.bz2

[Chris, can you have a look into Pierre's dup_ent changes?  Thanks.]


Hi Pierre,

On Mar  2 20:36, Pierre A. Humblet wrote:
> Corinna,
>
> OK, here we go again.
>
> This version calls res_query and all the work is done in net.cc.

First of all, thanks for doing that.

> - Because of the above, asm/byteorder.h doesn't get pulled in either,  
> and I couldn't use
>   some ntoh macros (see memcpy4to6).
> - I could have included asm/byteorder separately but that causes  
> conflicts with the local ntoh
>   definitions in net.cc.

I fixed that by moving the definitions of ntohl and friends to the end
of the file and by defining them according to the definitions in
asm/byteorder.h.  That's what POSIX demands anyway.

> - Because arpa/nameser.h is now pulled in,  IN6ADDRSZ etc are now  
> defined, but in a way different
>   from done in the snippet of code cut & pasted from bind. I didn't want 
> to change that piece (in
>   case you want to keep in intact for some reason) and I ended up  
> undefining  IN6ADDRSZ etc .

I removed thatto use the definitions from nameser_compat.h.  They are
equivalent anyway.

> -  There is a new helper function dn_length1 which logically belongs in 
> minires.c, although it shouldn't
>    be exported by the dll.  However if I place it in minires.c, then the 
> linker doesn't find it.

You missed to define it as a `extern "C" function.

>    Fixing that probably involves some Makefile magic.

No, it's sufficent to define it as extern "C".  I changed your patch
so that dn_length1 is now declared in the `extern "C" declaration
block at the start of net.cc and I moved the function into minires.c.

> - I structured the code with a helper function gethostby_helper. That  
> will make it very easy to support
>    a gethostbyaddress some day, if needed.
> - The helper function avoids using dup_ent (there is enough copying  
> already). I created a new
>    realloc_ent function, and call it from both dup_ent and the helper. 
> That caused minor
>    changes in the 4 versions of dup_ent, and I don't know exactly what 
> format to use in the ChangeLog

The patch looks good to me.  I only changed the definition of realloc_ent
to be a static function.

> - This  is much more complex than the first way of doing things. Needs testing!
> - The patch is long, see the attachment. There is also a test program attached.

All my usual network applications are still working fine.

I attached the entire patch again with my changes.  I had to change the
gethostby_helper function to define some of the variables at the start
of the function, othewise gcc complained about jumps to a label crossing
variable initializations.  The bump of the API minor number in
include/cygwin/version.h was missing.  I also tweaked the formatting a bit.

The ChangeLog entry is the same as in the OP, except for the additional
reference to include/cygwin/version.h.  Please have a look.

Chris, the dup_ent code is yours.  Can you have a look if the realloc_ent
changes are ok with you?


Thanks,
Corinna


 	* net.cc: define _CYGWIN_IN_H and include resolv.h.
 	(realloc_ent): New function.
 	(dup_ent): Remove dst argument and call realloc_ent.
 	(memcpy4to6): New function.
 	(dn_length1): New function.
 	(gethostby_helper): New function.
 	(gethostbyname2): New function.
 	* cygwin.din: Export gethostbyname2.
 	* libc/minires.c (get_options): Look for "inet6" and apply bounds
 	to "retry" and "retrans".
 	(res_ninit): Set the default options at the beginning.
 	(dn_expand): Fix "off by one".
	* include/cygwin/version.h: Bump API minor number.


Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.202
diff -u -p -r1.202 cygwin.din
--- cygwin.din	19 Feb 2009 09:22:51 -0000	1.202
+++ cygwin.din	3 Mar 2009 11:54:11 -0000
@@ -635,6 +635,7 @@ _getgroups = getgroups SIGFE
 _getgroups32 = getgroups32 SIGFE
 gethostbyaddr = cygwin_gethostbyaddr SIGFE
 gethostbyname = cygwin_gethostbyname SIGFE
+gethostbyname2 SIGFE
 gethostid SIGFE
 gethostname = cygwin_gethostname SIGFE
 _gethostname = cygwin_gethostname SIGFE
Index: net.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.249
diff -u -p -r1.249 net.cc
--- net.cc	3 Mar 2009 11:44:17 -0000	1.249
+++ net.cc	3 Mar 2009 11:54:12 -0000
@@ -1,7 +1,7 @@
 /* net.cc: network-related routines.
 
    Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,
-   2005, 2006, 2007 Red Hat, Inc.
+   2005, 2006, 2007, 2008, 2009 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -43,6 +43,8 @@ details. */
 #include "cygwin/in6.h"
 #include "ifaddrs.h"
 #include "tls_pbuf.h"
+#define _CYGWIN_IN_H 
+#include <resolv.h>
 
 extern "C"
 {
@@ -53,6 +55,9 @@ extern "C"
   int sscanf (const char *, const char *, ...);
   int cygwin_inet_aton(const char *, struct in_addr *);
   const char *cygwin_inet_ntop (int, const void *, char *, socklen_t);
+  int dn_length1(const unsigned char *, const unsigned char *,
+		 const unsigned char *);
+  
 }				/* End of "C" section */
 
 const struct in6_addr in6addr_any = {{IN6ADDR_ANY_INIT}};
@@ -264,6 +269,34 @@ struct pservent
 
 static const char *entnames[] = {"host", "proto", "serv"};
 
+static unionent *
+realloc_ent (int sz, unionent::struct_type type)
+{
+  /* Allocate the storage needed.  Allocate a rounded size to attempt to force
+     reuse of this buffer so that a poorly-written caller will not be using
+     a freed buffer. */
+  unsigned rsz = 256 * ((sz + 255) / 256);
+  unionent * dst, * ptr;
+  switch (type)
+    {
+    case unionent::t_hostent:
+      dst = _my_tls.locals.hostent_buf;
+      break;
+    case unionent::t_protoent:
+      dst =_my_tls.locals.protoent_buf;
+      break;
+    case unionent::t_servent:
+      dst =_my_tls.locals.servent_buf;
+      break;
+    default:
+      return NULL;
+    }
+  ptr = (unionent *) realloc (dst, rsz);
+  if (ptr)
+    dst = ptr;
+  return ptr;
+}
+
 /* Generic "dup a {host,proto,serv}ent structure" function.
    This is complicated because we need to be able to free the
    structure at any point and we can't rely on the pointer contents
@@ -278,12 +311,8 @@ static void *
 #else
 static inline void *
 #endif
-dup_ent (unionent *&dst, unionent *src, unionent::struct_type type)
+dup_ent (unionent *src, unionent::struct_type type)
 {
-  if (dst)
-    debug_printf ("old %sent structure \"%s\" %p\n", entnames[type],
-		  dst->name, dst);
-
   if (!src)
     {
       set_winsock_errno ();
@@ -310,7 +339,7 @@ dup_ent (unionent *&dst, unionent *src, 
       break;
     }
 
-  /* Every *ent begins with a name.  Calculate it's length. */
+  /* Every *ent begins with a name.  Calculate its length. */
   int namelen = strlen_round (src->name);
   sz = struct_sz + namelen;
 
@@ -355,11 +384,7 @@ dup_ent (unionent *&dst, unionent *src, 
 	}
     }
 
-  /* Allocate the storage needed.  Allocate a rounded size to attempt to force
-     reuse of this buffer so that a poorly-written caller will not be using
-     a freed buffer. */
-  unsigned rsz = 256 * ((sz + 255) / 256);
-  dst = (unionent *) realloc (dst, rsz);
+  unionent *dst = realloc_ent (sz, type);
 
   if (dst)
     {
@@ -425,19 +450,19 @@ dup_ent (unionent *&dst, unionent *src, 
 static inline hostent *
 dup_ent (hostent *src)
 {
-  return (hostent *) dup_ent (_my_tls.locals.hostent_buf, (unionent *) src, unionent::t_hostent);
+  return (hostent *) dup_ent ((unionent *) src, unionent::t_hostent);
 }
 
 static inline protoent *
 dup_ent (protoent *src)
 {
-  return (protoent *) dup_ent (_my_tls.locals.protoent_buf, (unionent *) src, unionent::t_protoent);
+  return (protoent *) dup_ent ((unionent *) src, unionent::t_protoent);
 }
 
 static inline servent *
 dup_ent (servent *src)
 {
-  return (servent *) dup_ent (_my_tls.locals.servent_buf, (unionent *) src, unionent::t_servent);
+  return (servent *) dup_ent ((unionent *) src, unionent::t_servent);
 }
 
 /* exported as getprotobyname: standards? */
@@ -857,6 +882,287 @@ cygwin_gethostbyaddr (const char *addr, 
   return res;
 }
 
+static void 
+memcpy4to6 (char *dst, const u_char *src)
+{
+  const unsigned int h[] = {0, 0, htonl (0xFFFF)};
+  memcpy (dst, h, 12);
+  memcpy (dst + 12, src, NS_INADDRSZ);
+}
+
+static hostent * 
+gethostby_helper (const char *name, const int af, const int type,
+		  const int addrsize_in, const int addrsize_out)
+{
+  /* Get the data from the name server */
+  const int maxcount = 3;
+  int old_errno, ancount = 0, anlen = 1024, msgsize = 0;
+  u_char *ptr, *msg = NULL;
+  int sz;
+  hostent *ret;
+  char *string_ptr;
+
+  while ((anlen > msgsize) && (ancount++ < maxcount))
+    {
+      msgsize = anlen;
+      ptr = (u_char *) realloc (msg, msgsize);
+      if (ptr == NULL )
+	{
+	  old_errno = errno;
+	  free (msg);
+	  set_errno (old_errno);
+	  h_errno = NETDB_INTERNAL;
+	  return NULL;
+	}
+      msg = ptr;
+      anlen = res_search (name, ns_c_in, type, msg, msgsize);
+    } 
+
+  if (ancount >= maxcount)
+    {
+      free (msg);
+      h_errno = NO_RECOVERY;
+      return NULL;
+    }
+  if (anlen < 0) /* errno and h_errno are set */
+    {
+      old_errno = errno;
+      free (msg);
+      set_errno (old_errno);
+      return NULL; 
+    }
+  u_char *eomsg = msg + anlen - 1;
+
+
+  /* We scan the answer records to determine the required memory size. 
+     They can be corrupted and we don't fully trust that the message
+     follows the standard exactly. glibc applies some checks that
+     we emulate.
+     The answers are copied in the hostent structure in a second scan.
+     To simplify the second scan we store information as follows:
+     - "class" is replaced by the compressed name size
+     - the first 16 bits of the "ttl" store the expanded name size + 1 
+     - the last 16 bits of the "ttl" store the offset to the next valid record.
+     Note that "type" is rewritten in host byte order. */
+  
+  class record {
+  public:
+    unsigned type: 16;		// type
+    unsigned complen: 16;       // class or compressed length
+    unsigned namelen1: 16;      // expanded length (with final 0)
+    unsigned next_o: 16;        // offset to next valid
+    unsigned size: 16;          // data size
+    u_char data[];              // data
+    record * next () { return (record *) (((char *) this) + next_o); }
+    void set_next ( record * nxt) { next_o = ((char *) nxt) - ((char *) this); }
+    u_char * name () { return (u_char *) (((char *) this) - complen); }
+  };
+
+  record * anptr = NULL, * prevptr = NULL, * curptr;
+  int i, alias_count = 0, string_size = 0, address_count = 0;
+  int complen, namelen1 = 0, address_len = 0, antype, anclass, ansize;
+
+  /* Get the count of answers */
+  ancount = ntohs (((HEADER *) msg)->ancount);
+
+  /* Skip the question, it was verified by res_send */
+  ptr = msg + sizeof (HEADER);
+  if ((complen = dn_skipname (ptr, eomsg)) < 0)
+    goto corrupted;    
+  /* Point to the beginning of the answer section */
+  ptr += complen + NS_QFIXEDSZ;
+  
+  /* Scan the answer records to determine the sizes */
+  for (i = 0; i < ancount; i++, ptr = curptr->data + ansize)
+    {
+      if ((complen = dn_skipname (ptr, eomsg)) < 0)
+	goto corrupted;
+
+      curptr = (record *) (ptr + complen);
+      antype = ntohs (curptr->type);
+      anclass = ntohs (curptr->complen);
+      ansize = ntohs (curptr->size);
+      /* Class must be internet */
+      if (anclass != ns_c_in)
+	continue;
+
+      curptr->complen = complen;
+      if ((namelen1 = dn_length1 (msg, eomsg, curptr-> name())) <= 0)
+	goto corrupted;
+
+      if (antype == ns_t_cname) 
+	{
+	  alias_count++;
+	  string_size += namelen1;
+	}
+      else if (antype == type)
+	{
+	  ansize = ntohs (curptr->size);
+	  if (ansize != addrsize_in)
+	    continue;
+	  if (address_count == 0)
+	    {
+	      address_len = namelen1;
+	      string_size += namelen1;
+	    }
+	  else if (address_len != namelen1)
+	    continue;
+	  address_count++;
+	}
+      /* Update the records */
+      curptr->type = antype; /* Host byte order */
+      curptr->namelen1 = namelen1;
+      if (! anptr)
+	anptr = prevptr = curptr;
+      else
+	{
+	  prevptr->set_next (curptr);
+	  prevptr = curptr;
+	}
+    }
+
+  /* If there is no address, quit */
+  if (address_count == 0)
+    {
+      free (msg);
+      h_errno = NO_DATA;
+      return NULL;
+    }
+  
+  /* Determine the total size */
+  sz = DWORD_round (sizeof(hostent))
+       + sizeof (char *) * (alias_count + address_count + 2)
+       + string_size
+       + address_count * addrsize_out;
+
+  ret = (hostent *) realloc_ent (sz, unionent::t_hostent);
+  if (! ret) 
+    {
+      old_errno = errno;
+      free (msg);
+      set_errno (old_errno);
+      h_errno = NETDB_INTERNAL;
+      return NULL;
+    }
+
+  ret->h_addrtype = af;
+  ret->h_length = addrsize_out;
+  ret->h_aliases = (char **) (((char *) ret) + DWORD_round (sizeof(hostent)));
+  ret->h_addr_list = ret->h_aliases + alias_count + 1;
+  string_ptr = (char *) (ret->h_addr_list + address_count + 1);
+ 
+  /* Rescan the answers */
+  ancount = alias_count + address_count; /* Valid records */
+  alias_count = address_count = 0;
+
+  for (i = 0, curptr = anptr; i < ancount; i++, curptr = curptr->next ())
+    {
+      antype = curptr->type;
+      if (antype == ns_t_cname) 
+	{
+	  complen = dn_expand (msg, eomsg, curptr->name (), string_ptr, string_size);
+#ifdef DEBUGGING
+	  if (complen != curptr->complen)  
+	    go to debugging;
+#endif
+	  ret->h_aliases[alias_count++] = string_ptr;
+	  namelen1 = curptr->namelen1;
+	  string_ptr += namelen1;
+	  string_size -= namelen1;	  
+	  continue;
+	}
+      if (antype == type)
+	    {
+	      if (address_count == 0)
+		{
+		  complen = dn_expand (msg, eomsg, curptr->name(), string_ptr, string_size);
+#ifdef DEBUGGING
+		  if (complen != curptr->complen)  
+		    go to debugging;
+#endif
+		  ret->h_name = string_ptr;
+		  namelen1 = curptr->namelen1;
+		  string_ptr += namelen1;
+		  string_size -= namelen1;	  
+		}
+	      ret->h_addr_list[address_count++] = string_ptr;
+	      if (addrsize_in != addrsize_out)
+		memcpy4to6 (string_ptr, curptr->data);
+	      else
+		memcpy (string_ptr, curptr->data, addrsize_in);
+	      string_ptr += addrsize_out;
+	      string_size -= addrsize_out;
+	      continue;
+	    }
+#ifdef DEBUGGING
+      /* Should not get here */
+      go to debugging;
+#endif
+    }
+#ifdef DEBUGGING
+  if (string_size < 0)  
+    go to debugging;
+#endif      
+  
+  free (msg);
+
+  ret->h_aliases[alias_count] = NULL;
+  ret->h_addr_list[address_count] = NULL;
+ 
+  return ret;
+
+ corrupted:
+  free (msg);
+  /* Hopefully message corruption errors are temporary.
+     Should it be NO_RECOVERY ? */
+  h_errno = TRY_AGAIN;
+  return NULL;
+
+
+#ifdef DEBUGGING
+ debugging:
+   system_printf ("Please debug.");
+   free (msg);
+   free (ret);
+   h_errno = NO_RECOVERY;
+   return NULL;
+#endif
+}
+
+/* gethostbyname2: standards? */
+extern "C" struct hostent *
+gethostbyname2 (const char *name, int af)
+{
+  sig_dispatch_pending ();
+  myfault efault;
+  if (efault.faulted (EFAULT))
+    return NULL;
+
+  if (!(_res.options & RES_INIT))
+      res_init();
+  bool v4to6 = _res.options & RES_USE_INET6;
+
+  int type, addrsize_in, addrsize_out;
+  switch (af) 
+    {
+    case AF_INET:
+      addrsize_in = NS_INADDRSZ;
+      addrsize_out = (v4to6) ? NS_IN6ADDRSZ : NS_INADDRSZ;
+      type = ns_t_a;
+      break;
+    case AF_INET6:
+      addrsize_in = addrsize_out = NS_IN6ADDRSZ;
+      type = ns_t_aaaa;
+      break;
+    default:
+      set_errno (EAFNOSUPPORT);
+      h_errno = NETDB_INTERNAL;
+      return NULL;
+    }
+  
+  return gethostby_helper (name, af, type, addrsize_in, addrsize_out);
+}
+
 /* exported as accept: standards? */
 extern "C" int
 cygwin_accept (int fd, struct sockaddr *peer, socklen_t *len)
@@ -2486,10 +2792,6 @@ cygwin_sendmsg (int fd, const struct msg
  * SOFTWARE.
  */
 
-#define	IN6ADDRSZ	16
-#define	INADDRSZ	 4
-#define	INT16SZ		 2
-
 /* int
  * inet_pton4(src, dst)
  *	like inet_aton() but without all the hexadecimal and shorthand.
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.284
diff -u -p -r1.284 version.h
--- include/cygwin/version.h	19 Feb 2009 09:22:51 -0000	1.284
+++ include/cygwin/version.h	3 Mar 2009 11:54:12 -0000
@@ -349,12 +349,13 @@ details. */
       198: Export reallocf.
       199: Export open_wmemstream.
       200: Export mbsnrtowcs, wcsnrtombs.
+      201: Export gethostbyname2.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 200
+#define CYGWIN_VERSION_API_MINOR 201
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
Index: libc/minires.c
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/libc/minires.c,v
retrieving revision 1.5
diff -u -p -r1.5 minires.c
--- libc/minires.c	3 Dec 2008 16:37:53 -0000	1.5
+++ libc/minires.c	3 Mar 2009 11:54:12 -0000
@@ -1,6 +1,6 @@
 /* minires.c.  Stub synchronous resolver for Cygwin.
 
-   Copyright 2006, 2008 Red Hat, Inc.
+   Copyright 2006, 2008, 2009 Red Hat, Inc.
 
    Written by Pierre A. Humblet <Pierre.Humblet@ieee.org>
 
@@ -99,6 +99,11 @@ static void get_options(res_state statp,
       DPRINTF(statp->options & RES_DEBUG, "%s: 1\n", words[i]);
       continue;
     }
+    if (!strcasecmp("inet6", words[i])) {
+      statp->options |= RES_USE_INET6;
+      DPRINTF(statp->options & RES_DEBUG, "%s: 1\n", words[i]);
+      continue;
+    }
     if (!strcasecmp("osquery", words[i])) {
       statp->use_os = 1;
       DPRINTF(statp->options & RES_DEBUG, "%s: 1\n", words[i]);
@@ -114,16 +119,22 @@ static void get_options(res_state statp,
 	 continue;
 	 }
       */
-      if (!strcasecmp("retry", words[i])) {
+      if (!strcasecmp("retry", words[i])
+	  || !strcasecmp("attempts", words[i])) {
 	if (value < 1)
 	  value = 1;
+	else if (value > RES_MAXRETRY)
+	  value = RES_MAXRETRY;
 	statp->retry = value;
 	DPRINTF(statp->options & RES_DEBUG, "%s: %d\n", words[i], value);
 	continue;
       }
-      if (!strcasecmp("retrans", words[i])) {
+      if (!strcasecmp("retrans", words[i])
+	  || !strcasecmp("timeout", words[i])) {
 	if (value < 1)
 	  value = 1;
+	else if (value > RES_MAXRETRANS)
+	  value = RES_MAXRETRANS;
 	statp->retrans = value;
 	DPRINTF(statp->options & RES_DEBUG, "%s: %d\n", words[i], value);
 	continue;
@@ -270,6 +281,9 @@ int res_ninit(res_state statp)
   int i;
 
   statp->res_h_errno = NETDB_SUCCESS;
+   /* Only debug may be set before calling init */
+  statp->options &= RES_DEBUG;
+  statp->options |= RES_INIT | RES_DEFAULT;
   statp->nscount = 0;
   statp->os_query = NULL;
   statp->retrans = RES_TIMEOUT; /* timeout in seconds */
@@ -299,9 +313,6 @@ int res_ninit(res_state statp)
     statp->nsaddr_list[i].sin_port = htons(NAMESERVER_PORT);
     bzero(statp->nsaddr_list[i].sin_zero, sizeof(statp->nsaddr_list[i].sin_zero));
   }
-  /* Only debug may be set before calling init */
-  statp->options &= RES_DEBUG;
-  statp->options |= RES_INIT | RES_DEFAULT;
   return 0;
 }
 
@@ -806,7 +817,7 @@ int dn_expand(const unsigned char *msg, 
     exp_dn++;
   else do {
     if (len <= MAXLABEL) {
-      if ((length -= (len + 1)) > 0 /* Need space for final . */
+      if ((length -= (len + 1)) >= 0 /* Need space for final . */
 	  && comp_dn + len <= eomorig) {
 	do { *exp_dn++ = *comp_dn++; } while (--len != 0);
 	*exp_dn++ = '.';
@@ -836,7 +847,6 @@ expand_fail:
   return -1;
 }
 
-
 /*****************************************************************
  *
  dn_comp
@@ -926,8 +936,7 @@ int dn_comp(const char * exp_dn, u_char 
 }
 
 /*****************************************************************
- *
- dn_skipname
+ * dn_skipname
 
  Measures the compressed domain name length and returns it.
  *****************************************************************/
@@ -949,3 +958,38 @@ int dn_skipname(const unsigned char *com
 
   return comp_dn - comp_dn_orig;
 }
+
+/*****************************************************************
+ * dn_length1    For internal use
+
+ Return length of uncompressesed name incl final 0.
+ *****************************************************************/
+
+int dn_length1(const unsigned char *msg, const unsigned char *eomorig,
+	       const unsigned char *comp_dn)
+{
+  unsigned int len, length = 0;
+
+  errno = EINVAL;
+  if (comp_dn >= eomorig)
+    goto expand_fail;
+  else while ((len = *comp_dn++) != 0) {
+    if (len <= MAXLABEL) {
+      if ((comp_dn += len) <= eomorig)
+	length += len + 1;
+      else
+	goto expand_fail;
+    }
+    else if (len >= (128+64)) {
+      comp_dn = msg + (((len & ~(128+64)) << 8) + *comp_dn);
+      if (comp_dn >= eomorig)
+	goto expand_fail;
+    }
+    else
+      goto expand_fail;
+  }
+  return length;
+
+expand_fail:
+  return -1;
+}

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
