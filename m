Return-Path: <cygwin-patches-return-3253-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11557 invoked by alias); 1 Dec 2002 22:46:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11543 invoked from network); 1 Dec 2002 22:46:47 -0000
From: "Ralf Habacker" <Ralf.Habacker@freenet.de>
To: "Cygwin-Patches" <cygwin-patches@cygwin.com>
Subject: [patch] fixes segfault while mutexattr initialisation 
Date: Sun, 01 Dec 2002 14:46:00 -0000
Message-ID: <006c01c2998b$82e736d0$0a1c440a@BRAMSCHE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
X-SW-Source: 2002-q4/txt/msg00204.txt.bz2

Hi,

while porting the threaded qt-3 release to cygwin, it seems to me, that there is
a bug in the current cygwin pthread implementation.

The problem:

Parts of the qt-3 thread initialisation code (which works under linux) look like
below:

	<snip>
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
	<snip>

which lets attr undefined. The specification of this functions in
http://www.opengroup.org/onlinepubs/007904975/functions/pthread_mutexattr_init.h
tml tells me, that pthread_mutexattr_init() should initialise attr.

In the example I found with gcc (2.59.3-5)/ld the (stack-)content is 0xc, which
lets pthread_mutexattr_init() crash.

A look into the code shows:

__pthread_mutexattr_init (pthread_mutexattr_t *attr)
{
[1]  if (pthread_mutexattr::isGoodObject (attr))
	// calls -> verifyable_object_isvalid ->
check_valid_pointer ->IsBadWritePtr(*attr) -> segfault!!
[1]   return EBUSY;

  *attr = new pthread_mutexattr ();
  if (!pthread_mutexattr::isGoodObject (attr))
    {
      delete (*attr);
      *attr = NULL;
      return ENOMEM;
    }
  return 0;
}

If pthread_mutexattr_init() should initialise attr, but how should attr be a
good object [1], when pthread_mutexattr_init hasn't done any initialisation.
This seems to me as a violation of the definition.

further details

verifyable_object_state
verifyable_object_isvalid (void const * objectptr, long magic, void *static_ptr)
{
  verifyable_object **object = (verifyable_object **)objectptr;
  if (check_valid_pointer (object))
    return INVALID_OBJECT;
  if (static_ptr && *object == static_ptr)
    return VALID_STATIC_OBJECT;
  if (!*object)
    return INVALID_OBJECT;
  if (check_valid_pointer (*object))
    return INVALID_OBJECT;
^^^^^^ here it crashes

  if ((*object)->magic != magic)
    return INVALID_OBJECT;
  return VALID_OBJECT;
}

A patch to this is to call only check_valid_pointer for the attr address not the
content. The following patch seems to fix this, but I'm not sure, if I have
overseen something, so my question is if there is anyone who can confirm this.

$ cvs diff -p thread.cc
Index: thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.106
diff -u -3 -p -B -p -r1.106 thread.cc
--- thread.cc   24 Nov 2002 13:54:14 -0000      1.106
+++ thread.cc   30 Nov 2002 01:24:04 -0000
@@ -2416,8 +2416,8 @@ __pthread_mutexattr_init (pthread_mu
 int
 __pthread_mutexattr_init (pthread_mutexattr_t *attr)
 {
-  if (pthread_mutexattr::isGoodObject (attr))
-    return EBUSY;
+  if (check_valid_pointer (attr))
+    return EINVAL;

   *attr = new pthread_mutexattr ();
   if (!pthread_mutexattr::isGoodObject (attr))

---------------------------------------------------------------------

2002-11-30  Ralf Habacker  <ralf.habacker@freenet.de>

      * thread.cc (__pthread_mutexattr_init ): fixed seg fault
      if parameter content is undefined.



Hops that help

Ralf
