Return-Path: <cygwin-patches-return-5404-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23568 invoked by alias); 6 Apr 2005 05:37:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23542 invoked from network); 6 Apr 2005 05:37:18 -0000
Received: from unknown (HELO dessent.net) (66.17.244.20)
  by sourceware.org with SMTP; 6 Apr 2005 05:37:18 -0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.44)
	id 1DJ3AG-0007qo-VP
	for cygwin-patches@cygwin.com; Wed, 06 Apr 2005 05:33:21 +0000
Message-ID: <4253768A.8711D94@dessent.net>
Date: Wed, 06 Apr 2005 05:37:00 -0000
From: Brian Dessent <brian@dessent.net>
Organization: My own little world...
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [patch] dup_ent does not set dst when src is NULL
Content-Type: multipart/mixed;
 boundary="------------107F8164F734E1B6409DCB71"
X-SW-Source: 2005-q2/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.
--------------107F8164F734E1B6409DCB71
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1880


In net.cc, there are several cases where dup_ent() is used as follows:

dup_ent (servent_buf, getservbyname (name, proto), t_servent);
syscall_printf ("%p = getservbyname (%s, %s)",
    _my_tls.locals.servent_buf, name, proto);
return _my_tls.locals.servent_buf;

This presents a problem if getservbyname() returns NULL, because
dup_ent just returns NULL, it does not modify 'dst'.  This results in
the function returning the previous successful value if the
get_foo_by_bar() function returned NULL.  This seems to be applicable to
getservbyname(), getservbyport(), gethostbyaddr(), and gethostbyname().  

In the case of gethostbyname() there's also another bug in that there
will be a spurious debug_printf() about dup_ent failing if the address
simply didn't resolve.  That should probably be fixed too but I wanted
to be sure the patch stayed "trivial".

A simple testcase that demonstrates the problem:

#include <stdio.h>
#include <string.h>
#include <netdb.h>
#include <sys/socket.h>
#include <netinet/in.h>

void mygetservbyname(char *serv, char *proto)
{
  struct servent *p;

  if((p = getservbyname(serv, proto)))
    printf("getservbyname(\"%s\", \"%s\") success, port = %u\n", 
       serv, proto, (unsigned int)ntohs (p->s_port));
  else
    printf("getservbyname(\"%s\", \"%s\") returns NULL\n", serv, proto);
}  

int main(int argc, char **argv)
{
  mygetservbyname("25", "tcp");
  mygetservbyname("auth", "tcp");
  mygetservbyname("25", "tcp");
  return 0;
}

$ ./getservbyname 
getservbyname("25", "tcp") returns NULL
getservbyname("auth", "tcp") success, port = 113
getservbyname("25", "tcp") success, port = 113


Brian

===================================================================
2005-04-05  Brian Dessent  <brian@dessent.net>

	* net.cc (__dup_ent): Make dst point to NULL if src is NULL.
	Free dst if it was previously allocated to not leak memory.
--------------107F8164F734E1B6409DCB71
Content-Type: text/plain; charset=us-ascii;
 name="dup_ent_null_check.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dup_ent_null_check.patch"
Content-length: 455

Index: net.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.186
diff -u -p -r1.186 net.cc
--- net.cc	24 Mar 2005 14:04:06 -0000	1.186
+++ net.cc	6 Apr 2005 05:17:50 -0000
@@ -387,6 +387,9 @@ __dup_ent (unionent *&dst, unionent *src
   if (!src)
     {
       set_winsock_errno ();
+      if(dst)
+        free(dst);
+      dst = NULL;
       return NULL;
     }
 


--------------107F8164F734E1B6409DCB71--
