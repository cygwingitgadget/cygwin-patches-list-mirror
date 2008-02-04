Return-Path: <cygwin-patches-return-6242-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3758 invoked by alias); 4 Feb 2008 03:38:06 -0000
Received: (qmail 3747 invoked by uid 22791); 4 Feb 2008 03:38:06 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 04 Feb 2008 03:37:51 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JLs9V-0002tt-9a 	for cygwin-patches@cygwin.com; Mon, 04 Feb 2008 03:37:49 +0000
Message-ID: <47A6888D.5CF73D29@dessent.net>
Date: Mon, 04 Feb 2008 03:38:00 -0000
From: Brian Dessent <brian@dessent.net>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
CC: cygwin-patches@cygwin.com
Subject: [patch] fix strfuncs-related breakage of cygserver
Content-Type: multipart/mixed;  boundary="------------CA9BA13C08F7509439678CB5"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00016.txt.bz2

This is a multi-part message in MIME format.
--------------CA9BA13C08F7509439678CB5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 936


The recent addition of the sys_{wcstombs,mbstowcs}_alloc() functions to
strfuncs.cc causes cygserver to no longer build.  The problem is simply
that we can't call ccalloc() from within cygserver, but cygserver needs
__small_vsprintf() which in turn calls sys_wcstombs_alloc(), which in
turn wants to call ccalloc().  To get around this, I just
conditionalized the foo_alloc() functions to always use plain calloc()
when inside cygserver, and changed cygserver's Makefile to rebuild
strfuncs.cc again instead of sharing the .o from the DLL.

There is also a small additional buglet in that the call to
sys_wcstombs_alloc() in __small_vsprintf() was passing PATH_MAX as the
heap type, and that is not a valid cygheap_types.  I changed it to
HEAP_NOTHEAP as that is the only value that makes sense here since this
pointer is subsequently free()'d and not cfree()'d.

Attached are two patches, one for cygwin/ and one in cygserver/.

Brian
--------------CA9BA13C08F7509439678CB5
Content-Type: text/plain; charset=us-ascii;
 name="strfuncs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="strfuncs.patch"
Content-length: 2709

2008-02-03  Brian Dessent  <brian@dessent.net>

	* smallprint.cc (__small_vsprintf): Use HEAP_NOTHEAP for type.
	* strfuncs.cc (sys_wcstombs_alloc): Guard use of ccalloc
	to !__OUTSIDE_CYGWIN__ for use in cygserver.
	(sys_mbstowcs_alloc): Ditto.


Index: smallprint.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/smallprint.cc,v
retrieving revision 1.4
diff -u -p -r1.4 smallprint.cc
--- smallprint.cc	31 Jan 2008 20:26:01 -0000	1.4
+++ smallprint.cc	4 Feb 2008 03:18:45 -0000
@@ -197,7 +197,7 @@ __small_vsprintf (char *dst, const char 
 		  {
 		    char *tmp;
 
-		    if (!sys_wcstombs_alloc (&tmp, PATH_MAX, us->Buffer,
+		    if (!sys_wcstombs_alloc (&tmp, HEAP_NOTHEAP, us->Buffer,
 					     us->Length / sizeof (WCHAR)))
 		      {
 			s = "invalid UNICODE_STRING";
Index: strfuncs.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/strfuncs.cc,v
retrieving revision 1.4
diff -u -p -r1.4 strfuncs.cc
--- strfuncs.cc	31 Jan 2008 20:26:01 -0000	1.4
+++ strfuncs.cc	4 Feb 2008 03:18:45 -0000
@@ -60,7 +60,11 @@ sys_wcstombs (char *tgt, int tlen, const
    value is the number of bytes written to the buffer, as usual.
    The "type" argument determines where the resulting buffer is stored.
    It's either one of the cygheap_types values, or it's "HEAP_NOTHEAP".
-   In the latter case the allocation uses simple calloc. */
+   In the latter case the allocation uses simple calloc.
+   
+   Note that this code is shared by cygserver (which requires it via
+   __small_vsprintf) and so when built there plain calloc is the 
+   only choice.  */
 int __stdcall
 sys_wcstombs_alloc (char **tgt_p, int type, const PWCHAR src, int slen)
 {
@@ -71,10 +75,14 @@ sys_wcstombs_alloc (char **tgt_p, int ty
     {
       size_t tlen = (slen == -1 ? ret : ret + 1);
 
+#ifndef __OUTSIDE_CYGWIN__
       if (type == HEAP_NOTHEAP)
+#endif
         *tgt_p = (char *) calloc (tlen, sizeof (char));
+#ifndef __OUTSIDE_CYGWIN__
       else
       	*tgt_p = (char *) ccalloc ((cygheap_types) type, tlen, sizeof (char));
+#endif
       if (!*tgt_p)
         return 0;
       ret = sys_wcstombs (*tgt_p, tlen, src, slen);
@@ -98,10 +106,14 @@ sys_mbstowcs_alloc (PWCHAR *tgt_p, int t
   ret = MultiByteToWideChar (get_cp (), 0, src, -1, NULL, 0);
   if (ret)
     {
+#ifndef __OUTSIDE_CYGWIN__
       if (type == HEAP_NOTHEAP)
+#endif
         *tgt_p = (PWCHAR) calloc (ret, sizeof (WCHAR));
+#ifndef __OUTSIDE_CYGWIN__
       else
       	*tgt_p = (PWCHAR) ccalloc ((cygheap_types) type, ret, sizeof (WCHAR));
+#endif
       if (!*tgt_p)
         return 0;
       ret = sys_mbstowcs (*tgt_p, src, ret);

--------------CA9BA13C08F7509439678CB5
Content-Type: text/plain; charset=us-ascii;
 name="cygserver-strfuncs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygserver-strfuncs.patch"
Content-length: 1396

2008-02-03  Brian Dessent  <brian@dessent.net>

	* Makefile.in: Don't link strfuncs.o from the Cygwin build dir.
	Build it again with __OUTSIDE_CYGWIN__ defined.

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygserver/Makefile.in,v
retrieving revision 1.16
diff -u -p -r1.16 Makefile.in
--- Makefile.in	2 Aug 2007 14:23:22 -0000	1.16
+++ Makefile.in	4 Feb 2008 03:22:32 -0000
@@ -43,7 +43,7 @@ OBJS:=	cygserver.o client.o process.o ms
 	sysv_msg.o sysv_sem.o sysv_shm.o
 LIBOBJS:=${patsubst %.o,lib%.o,$(OBJS)}
 
-CYGWIN_OBJS:=$(cygwin_build)/smallprint.o $(cygwin_build)/strfuncs.o $(cygwin_build)/version.o
+CYGWIN_OBJS:=$(cygwin_build)/smallprint.o $(cygwin_build)/version.o
 
 CYGWIN_LIB:=$(cygwin_build)/libcygwin.a
 
@@ -67,7 +67,7 @@ libclean:
 
 fullclean: clean libclean
 
-cygserver.exe: $(CYGWIN_LIB) $(OBJS) $(CYGWIN_OBJS)
+cygserver.exe: $(CYGWIN_LIB) $(OBJS) $(CYGWIN_OBJS) strfuncs.o
 	$(CXX) -o $@ ${wordlist 2,999,$^} -L$(cygwin_build) -lntdll
 
 $(cygwin_build)/%.o: $(cygwin_source)/%.cc
@@ -81,6 +81,9 @@ Makefile: Makefile.in configure
 lib%.o: %.cc
 	${filter-out -D__OUTSIDE_CYGWIN__, $(COMPILE_CXX)} -I$(updir)/cygwin -o $(@D)/${basename $(@F)}$o $<
 
+strfuncs.o: $(cygwin_source)/strfuncs.cc
+	$(COMPILE_CXX) -I$(updir)/cygwin -o $(@D)/$(*F)$o $<
+
 libcygserver.a: $(LIBOBJS)
 	$(AR) crus $@ $?
 

--------------CA9BA13C08F7509439678CB5--
